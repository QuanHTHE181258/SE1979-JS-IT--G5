tôi <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: inline-block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #34495e;
        }

        input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .question-container {
            background-color: #f8f9fa;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            border: 1px solid #e9ecef;
        }

        .answer-group {
            margin: 10px 0;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #e9ecef;
            border-radius: 4px;
        }

        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        button {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 5px;
        }

        button:hover {
            background-color: #0056b3;
        }

        button.add-answer {
            background-color: #28a745;
        }

        button.add-answer:hover {
            background-color: #218838;
        }

        .submit-btn {
            background-color: #17a2b8;
            display: block;
            width: 100%;
            margin-top: 20px;
        }

        .submit-btn:hover {
            background-color: #138496;
        }

        hr {
            margin: 20px 0;
            border: 0;
            border-top: 1px solid #ddd;
        }

        .remove-btn {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            float: right;
        }

        .remove-btn:hover {
            background-color: #c82333;
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .answer-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
    <script>
        function removeAnswer(questionIdx, answerElement) {
            const answerList = document.getElementById('answers_' + questionIdx);
            if (answerList.getElementsByClassName('answer-group').length <= 2) {
                alert('Each question must have at least 2 answers');
                return;
            }
            answerElement.parentElement.remove();
            // Renumber remaining answers
            const answers = answerList.getElementsByClassName('answer-group');
            for (let i = 0; i < answers.length; i++) {
                const label = answers[i].querySelector('label');
                label.textContent = 'Answer ' + (i + 1) + ':';
            }
        }

        function removeQuestion(questionElement) {
            const questionsDiv = document.getElementById('questions');
            if (questionsDiv.getElementsByClassName('question-container').length <= 1) {
                alert('Quiz must have at least 1 question');
                return;
            }
            questionElement.remove();
            // Renumber remaining questions
            const questions = questionsDiv.getElementsByClassName('question-container');
            for (let i = 0; i < questions.length; i++) {
                const h3 = questions[i].querySelector('h3');
                h3.textContent = 'Question ' + (i + 1);
            }
        }

        function validateInput(input, errorId) {
            const value = input.value.trim();
            const errorElement = document.getElementById(errorId);

            if (value === '') {
                errorElement.style.display = 'block';
                errorElement.textContent = 'This field is required';
                return false;
            }

            // Check for duplicates
            const inputType = input.name.startsWith('questionText') ? 'question' : 'answer';
            const questionIdx = input.name.includes('_') ? input.name.split('_')[1].replace('[]','') : '';

            if (inputType === 'question') {
                const questions = document.querySelectorAll('input[name="questionText[]"]');
                for (let q of questions) {
                    if (q !== input && q.value.trim().toLowerCase() === value.toLowerCase()) {
                        errorElement.style.display = 'block';
                        errorElement.textContent = 'This question already exists';
                        return false;
                    }
                }
            } else {
                const answers = document.querySelectorAll(`input[name="answerText_${questionIdx}[]"]`);
                for (let a of answers) {
                    if (a !== input && a.value.trim().toLowerCase() === value.toLowerCase()) {
                        errorElement.style.display = 'block';
                        errorElement.textContent = 'This answer already exists for this question';
                        return false;
                    }
                }
            }

            errorElement.style.display = 'none';
            return true;
        }

        function addAnswer(questionIdx) {
            var answerList = document.getElementById('answers_' + questionIdx);
            var answerCount = answerList.getElementsByClassName('answer-group').length;

            var div = document.createElement('div');
            div.className = 'answer-group';

            const answerId = 'answer_' + questionIdx + '_' + answerCount;
            var answerHtml = '<div class="form-group">';
            answerHtml += '<div class="answer-header">';
            answerHtml += '<label>Answer ' + (answerCount + 1) + ':</label>';
            answerHtml += '<button type="button" class="remove-btn" onclick="removeAnswer(' + questionIdx + ', this.parentElement.parentElement.parentElement)">Remove</button>';
            answerHtml += '</div>';
            answerHtml += '<input type="text" name="answerText_' + questionIdx + '[]" id="' + answerId + '" required ';
            answerHtml += 'oninput="validateInput(this, \'' + answerId + '_error\')" ';
            answerHtml += 'onblur="validateInput(this, \'' + answerId + '_error\')">';
            answerHtml += '<div class="error-message" id="' + answerId + '_error"></div>';
            answerHtml += '<input type="hidden" name="isCorrect_' + questionIdx + '[]" value="false">';
            answerHtml += '<input type="checkbox" name="isCorrect_' + questionIdx + '[]" value="true"> Correct';
            answerHtml += '</div>';

            div.innerHTML = answerHtml;
            answerList.appendChild(div);
        }

        function addQuestion() {
            var questionsDiv = document.getElementById('questions');
            var questionIdx = questionsDiv.getElementsByClassName('question-container').length;

            var div = document.createElement('div');
            div.className = 'question-container';

            const questionId = 'question_' + questionIdx;
            var html = '<div class="question-header">';
            html += '<h3>Question ' + (questionIdx + 1) + '</h3>';
            html += '<button type="button" class="remove-btn" onclick="removeQuestion(this.parentElement.parentElement)">Remove Question</button>';
            html += '</div>';
            html += '<div class="form-group">';
            html += '<input type="text" name="questionText[]" id="' + questionId + '" placeholder="Question text" required ';
            html += 'oninput="validateInput(this, \'' + questionId + '_error\')" ';
            html += 'onblur="validateInput(this, \'' + questionId + '_error\')">';
            html += '<div class="error-message" id="' + questionId + '_error"></div>';
            html += '</div>';
            html += '<div id="answers_' + questionIdx + '" class="answers-container">';

            // Add two default answers
            for (let i = 0; i < 2; i++) {
                html += '<div class="answer-group">';
                html += '<div class="form-group">';
                html += '<div class="answer-header">';
                html += '<label>Answer ' + (i + 1) + ':</label>';
                html += '<button type="button" class="remove-btn" onclick="removeAnswer(' + questionIdx + ', this.parentElement.parentElement.parentElement)">Remove</button>';
                html += '</div>';
                html += '<input type="text" name="answerText_' + questionIdx + '[]" ';
                html += 'id="answer_' + questionIdx + '_' + i + '" required ';
                html += 'oninput="validateInput(this, \'answer_' + questionIdx + '_' + i + '_error\')" ';
                html += 'onblur="validateInput(this, \'answer_' + questionIdx + '_' + i + '_error\')">';
                html += '<div class="error-message" id="answer_' + questionIdx + '_' + i + '_error"></div>';
                html += '<input type="hidden" name="isCorrect_' + questionIdx + '[]" value="false">';
                html += '<input type="checkbox" name="isCorrect_' + questionIdx + '[]" value="true"> Correct';
                html += '</div></div>';
            }

            html += '</div>';
            html += '<button type="button" class="add-answer" onclick="addAnswer(' + questionIdx + ')">Add Answer</button>';
            html += '<hr>';

            div.innerHTML = html;
            questionsDiv.appendChild(div);
        }

        function validateForm() {
            let isValid = true;

            // Validate quiz title
            const titleInput = document.querySelector('input[name="quizTitle"]');
            isValid = validateInput(titleInput, 'quizTitle_error') && isValid;

            // Validate all questions
            const questions = document.querySelectorAll('input[name="questionText[]"]');
            if (questions.length === 0) {
                alert('Quiz must have at least 1 question');
                return false;
            }

            questions.forEach(question => {
                isValid = validateInput(question, question.id + '_error') && isValid;
            });

            // Validate answers for each question
            const questionContainers = document.querySelectorAll('.question-container');
            questionContainers.forEach((container, idx) => {
                // Check minimum 2 answers
                const answers = container.querySelectorAll('input[name^="answerText_"]');
                if (answers.length < 2) {
                    const errorDiv = document.getElementById('question_' + idx + '_error');
                    errorDiv.style.display = 'block';
                    errorDiv.textContent = 'Each question must have at least 2 answers';
                    isValid = false;
                }

                // Validate each answer
                answers.forEach(answer => {
                    isValid = validateInput(answer, answer.id + '_error') && isValid;
                });

                // Check if at least one correct answer
                const correctAnswers = container.querySelectorAll('input[type="checkbox"]:checked');
                const errorDiv = document.getElementById('question_' + idx + '_error');
                if (correctAnswers.length === 0) {
                    errorDiv.style.display = 'block';
                    errorDiv.textContent = 'Please select at least one correct answer';
                    isValid = false;
                }
            });

            return isValid;
        }

        window.onload = function() {
            addQuestion();
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Add Quiz</h2>
    <form action="addQuiz" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="lessonId" value="${lessonId}">
        <div class="form-group">
            <label>Quiz Title:</label>
            <input type="text" name="quizTitle" id="quizTitle" required
                   oninput="validateInput(this, 'quizTitle_error')"
                   onblur="validateInput(this, 'quizTitle_error')">
            <div class="error-message" id="quizTitle_error"></div>
        </div>
        <hr>
        <div id="questions"></div>
        <button type="button" onclick="addQuestion()">Add Question</button>
        <hr>
        <input type="submit" value="Add Quiz" class="submit-btn">
    </form>
</div>
</body>
</html>
