var questions = [];
var deleteQuestions = [];
var curActive = 'core';
var no_toggle = false;
var valid = null;

var openImage = 'modules/SurveyManager/images/open_arrow.gif';
var closedImage = 'modules/SurveyManager/images/closed_arrow.gif';

function initWizard ()
{
    $$('a.surveymanager_wizard_toggle').each(function (elem) {
        elem.observe('click', function (evt) {
            evt.preventDefault();
            var section = this.id.replace('toggle_', '');
            toggleActiveSection(section);
        });
    });

    $('name').observe('keyup', updateSurveyName)
             .observe('blur', updateSurveyName);

    $('addQuestionLink').observe('click', addQuestion).removeClassName('z-hide');

    $$('a.question_delete').each(function (elem) {
        elem.observe('click', function (evt) {
            evt.preventDefault();
            var section = this.id.replace('question_', '').replace('_delete', '');
            deleteQuestion(section);
        });
    });

    $$('input.questionname').each(function (elem) {
        elem.observe('keyup', updateQuestionName)
            .observe('blur', updateQuestionName);
    });

    Position.includeScrollOffsets = true;
    Sortable.create('question_list', {
        onUpdate: function (sortable) {
            updateQuestionOrder(sortable);
        }
    });
}

/**
 * Toggles a question block or the core survey block open or closed.
 */
function toggleActiveSection (new_active)
{
    if (no_toggle) {
        no_toggle = false;
        return;
    }

    // New active may be a DOM element instead of a string.
    // In that case, we need to extract the new active ID from its ID

    if (new_active == 'core') {
        if (curActive == 'core') {
            curActive = 'none';
            $('surveymanager_wizard_core_details').addClassName('z-hide');
            $('surveymanager_wizard_core_image').src = closedImage;
        } else {
            curActive = 'core';
            $('surveymanager_wizard_core_details').removeClassName('z-hide');
            $('surveymanager_wizard_core_image').src = openImage;
        }
        
        for (var qid in questions) {
            var thisQuestion = questions[qid];
            if (typeof thisQuestion == 'function') {
                continue;
            }

            $('question_' + qid + '_details').addClassName('z-hide');
            $('surveymanager_wizard_' + qid + '_image').src = closedImage;
        }
    } else {
        if (curActive == 'core') {
            $('surveymanager_wizard_core_details').addClassName('z-hide');
            $('surveymanager_wizard_core_image').src = closedImage;
        } else if (curActive != 'none') {
            $('question_' + curActive + '_details').addClassName('z-hide');
            $('surveymanager_wizard_' + curActive + '_image').src = closedImage;
        }
        
        if (curActive != new_active || curActive == 'none' || curActive == '') {
            curActive = new_active;
        
            $('question_' + curActive + '_details').removeClassName('z-hide');
            $('surveymanager_wizard_' + curActive + '_image').src = openImage;
        } else {
            curActive = 'none';
        }
    }
}

/**
 * Updates the survey name as the user types.
 */
function updateSurveyName (evt)
{
    evt.preventDefault();
    $('survey_title').update($F('name'));
}

function updateQuestionOrder (sortable)
{
    curActive = 'none';
    no_toggle = true;

    $('surveymanager_wizard_core_details').addClassName('z-hide');
    $('surveymanager_wizard_core_image').src = closedImage;

    for (var qid in questions) {
        var thisQuestion = questions[qid];
        if (typeof thisQuestion == 'function') {
            continue;
        }

        $('question_' + qid + '_details').addClassName('z-hide');
        $('surveymanager_wizard_' + qid + '_image').src = closedImage;
    }
}

function addQuestion (evt)
{
    evt.preventDefault();

    var templateElem = $('question_template');
    var formElem = $('wizardform');
    var max_qid = parseInt($F('max_qid'));
    var qid = ++max_qid;
    $('max_qid').value = qid;
    
    var newQuestion = templateElem.cloneNode(true);
    newQuestion.id = newQuestion.id.replace(/template/, qid);
    
    var questionForm;
    
    // Run through the hierarchy descended from newQuestion, and change IDs
    for (var a = 0; a < newQuestion.childNodes.length; a++) {
        var aNode = newQuestion.childNodes[a];

        if (aNode.nodeName == '#text') {
            continue;
        }

        switch (aNode.id) {
            case 'toggle_template':
                // Update toggle_template
                aNode.id = aNode.id.replace(/template/, qid);
                aNode.href = aNode.href.replace(/template/, qid);

                // Also change the ID of the image within this toggle element
                aNode.firstChild.id = aNode.firstChild.id.replace(/template/, qid);
                break;
            case 'question_template_title':
                // Update question_template_title
                aNode.id = aNode.id.replace(/template/, qid);
                setText(aNode, '[' + Zikula.__('New Question', 'module_SurveyManager') + ']');
                break;
            case 'question_template_details':
                // Update question_template_details
                aNode.id = aNode.id.replace(/template/, qid);
                questionForm = aNode;
                break;
            case 'question_template_delete':
                // Update question_template_delete
                aNode.id = aNode.id.replace(/template/, qid);
                aNode.href = aNode.href.replace(/template/, qid);
                break;
        }
    }

    // Run through the hierarchy descended from questionForm, and change IDs and names
    for (var a = 0; a < questionForm.childNodes.length; a++) {
        var aNode = questionForm.childNodes[a];
        if (aNode.nodeName == '#text') {
            continue;
        }
   
        // We have identified a form_row
        if (aNode.className == 'z-formrow') {
            for (var b = 0; b < aNode.childNodes.length; b++) {
                var bNode = aNode.childNodes[b];
                if (bNode.nodeName == '#text') {
                    continue;
                }

                switch (bNode.nodeName) {
                    case 'LABEL':
                        // Label: replace "template" with qid in the 'for' property
                        var curFor = bNode.htmlFor;
                        curFor = curFor.replace(/template/, qid);
                        bNode.htmlFor = curFor;
                        break;
                    case 'DIV':
                        // We have identified a form_data_element.
                        // Replace "template" with qid in all input, select and textarea elements within this DIV.
                        for (var c = 0; c < bNode.childNodes.length; c++) {
                            var cNode = bNode.childNodes[c];
                            if (cNode.nodeName == '#text') {
                                continue;
                            }

                            switch (cNode.nodeName) {
                                case 'INPUT':
                                case 'SELECT':
                                case 'TEXTAREA':
                                    if (cNode.name == 'question_template_name') {
                                        cNode.value = '[New Question]';
                                    }

                                    cNode.id = cNode.id.replace(/template/, qid);
                                    cNode.name = cNode.name.replace(/template/, qid);
                                    formElem.elements[formElem.elements.length] = cNode;
                                    break;
                            }
                        }
                        break;                        
                    case 'P':
                        if (bNode.id == 'advice-required-question_template_name') {
                            bNode.id = bNode.id.replace(/template/, qid);
                        }
                        break;
                }
            }
        }
    }

    questions[qid] = [];
    questions[qid]['name'] = '[' + Zikula.__('New Question', 'module_SurveyManager') +  ']';

    $('question_list').appendChild(newQuestion);
    Sortable.create('question_list', {
        onUpdate: function (sortable) {
            updateQuestionOrder(sortable);
        }
    });

    toggleActiveSection(qid);
}

function deleteQuestion (qid)
{
    if (!confirm('Are you sure you want to delete this question?')) {
        return;
    }

    $('question_' + qid).remove();
    questions[qid] = null;
    deleteQuestions[deleteQuestions.length] = qid;
}

/**
 * Updates the display name of a question as the user types.
 */
function updateQuestionName (evt)
{
    evt.preventDefault();

    var matches = this.id.match(/question_([0-9]+)_name/);
    if (!matches.length) {
        return;
    }
   
    var qid = matches[1];

    var newName = $F('question_' + qid + '_name');
    setTextById('question_' + qid + '_title', newName);

    questions[qid]['name'] = newName;
}

/**
 * Processes the Sortable and delete arrays for transmission via hidden inputs.
 */
function processFormSubmit (event)
{
    // Extract the order from the list of options
    var questionListElement = $('question_list');
    var questionOrder = [];

    // Hide all name warnings
    for (var qid in questions) {
        var thisQuestion = questions[qid];
        if (typeof thisQuestion == 'function') {
            continue;
        }

        var requiredAdviceElem = $('advice-required-question_' + qid + '_name');
        if (requiredAdviceElem) {
            requiredAdviceElem.addClassName('z-hide');
        }
    }
    
    // Ensure that all name fields are filled out
    for (var qid in questions) {
        var thisQuestion = questions[qid];
        if (typeof thisQuestion == 'function') {
            continue;
        }
   
        var questionNameElem = $('question_' + qid + '_name');

        if (!questionNameElem) {
            continue;
        }

        if (!questionNameElem.value || questionNameElem.value == '') {
            if (curActive != qid) {
                toggleActiveSection(qid);
            }
            $('advice-required-question_' + qid + '_name').removeClassName('z-hide');
            location.href = '#question_' + qid;
            return false;
        }
    }
    
    var surveyName = $F('name');
    if (!surveyName || surveyName == '') {
        if (curActive != 'core') {
            toggleActiveSection('core');
        }
        $('advice-required-name').removeClassName('z-hide');
        location.href = '#surveymanager_wizard_core';
        return false;
    }    

    // hide form buttons to prevent double submits by accident
    $$('div.z-formbuttons input').each(function (btn) {
        btn.addClassName('z-hide');
    });

    // Derive the order of options from the child nodes on the option_list element
    for (var i = 0; i < questionListElement.childNodes.length; i++) {
        var thisNode = questionListElement.childNodes[i];            
        var nodeID = thisNode.id;
        var matches = nodeID.match(/question_([0-9]+)/);
        
        if (matches.length > 1) {
            var qid = matches[1];
            questionOrder[questionOrder.length] = qid;
        }
    }

    $('question_order').value = php_serialize(questionOrder);
    $('delete_questions').value = php_serialize(deleteQuestions);

    return true;
}

/**
 * Replaces the first child of the given element with a new text node containing new_text,
 * or adds a new text node if there are no children.
 */
function setTextById (elemId, new_text)
{
    var elem = $(elemId);

    setText(elem, new_text);
}

/**
 * Replaces the first child of the given element with a new text node containing new_text,
 * or adds a new text node if there are no children.
 */
function setText (elem, new_text)
{
    if (!elem) {
        return;
    }

    newTextNode = document.createTextNode(new_text);

    if (elem.childNodes[0]) {
        elem.replaceChild(newTextNode, elem.childNodes[0]);
    } else {
        elem.appendChild(newTextNode);
    }
}

/**
 * PHP Serialize
 * Morten Amundsen
 * mor10am@gmail.com
 * Modified by Ben Birney, bbirney@tilsontech.com, to solve scoping issues on count var
 */
var counts = new Array();
var next_count_slot = 0;

function php_serialize (obj)
{
    var string = '';
    var slot;
    
    if (typeof(obj) == 'object') {
        if (obj instanceof Array) {
            string = 'a:';
            tmpstring = '';
            slot = next_count_slot++;
            counts[slot] = 0;
            for (var key in obj) {        
                if (typeof obj[key] == 'function') {
                    continue; //Added by Ben 09/20/07
                }
                tmpstring += php_serialize(key);
                tmpstring += php_serialize(obj[key]);
                counts[slot]++;
            }
            string += counts[slot] + ':{';
            string += tmpstring;
            string += '}';
        } else if (obj instanceof Object) {
            classname = obj.toString();

            if (classname == '[object Object]') {
                classname = 'StdClass';
            }

            string = 'O:' + classname.length + ':"' + classname + '":';
            tmpstring = '';
            slot = next_count_slot++;
            counts[slot] = 0;
            for (var key in obj) {            
                if (typeof obj[key] == 'function') {
                    continue; //Added by Ben 09/20/07
                }
                tmpstring += php_serialize(key);
                if (obj[key]) {
                    tmpstring += php_serialize(obj[key]);
                } else {
                    tmpstring += php_serialize('');
                }
                counts[slot]++;
            }
            string += counts[slot] + ':{' + tmpstring + '}';
        }
    } else {
        switch (typeof(obj)) {
            case 'number':
                if (obj - Math.floor(obj) != 0) {
                    string += 'd:' + obj + ';';
                } else {
                    string += 'i:' + obj + ';';
                }
                break;
            case 'string':
                string += 's:' + obj.length + ':"' + obj + '";';
                break;
            case 'boolean':
                if (obj) {
                    string += 'b:1;';
                } else {
                    string += 'b:0;';
                }
                break;
        }
    }

    return string;
}
