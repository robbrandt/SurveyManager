
/**
 * Examine the control elements for all required questions.
 * If a required question does not have at least one checked control element,
 * return false. Else return true.
 */
function checkRequiredQuestions ()
{
    // Examine every required question in this page
    for (var i in requiredQuestions) {
        if (typeof(requiredQuestions[i]) == 'function') {
            continue;
        }

        var questionId = requiredQuestions[i];
        var foundSelection = true;

        // We do only need "single_selection" and "multi_selection" fields;
        // Prototype can handle the rest more efficiently.
        if (questionTypes[questionId] == 'single_selection') {
            foundSelection = false;

            // In the case of required single_selection questions, the value may not be -1.
            if ($F('responses_' + questionId) != -1) {
                foundSelection = true;
            }
        } else if(questionTypes[questionId] == 'multi_selection') {
            foundSelection = false;

            for (var valuekey in questionValues[questionId]) {
                if (typeof(questionValues[questionId][valuekey]) == 'function') {
                    continue;
                }

                var controlElem = $('responses_' + questionId + '_' + valuekey);

                if (controlElem.checked && controlElem.checked != 'false') {
                    foundSelection = true;
                }
            }            
        }
        if (!foundSelection) {
            Zikula.UI.Alert = function(Zikula.__('Please enter a response for the question:', 'module_SurveyManager') + ' "' + questionNames[questionId] + '"', Zikula.__('Missing value', 'module_SurveyManager'));
            return false;
        }
    }

    // Got here? No required question was without a valid value. Return success.
    return true;
}
