<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Quiz</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background: #f5f7fa;
            min-height: 100vh;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
            position: relative;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 2px;
            background: #e0e0e0;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
            font-size: 14px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
            background-color: #fff;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: #999;
            box-shadow: 0 0 0 2px rgba(0,0,0,0.05);
        }

        .question-container {
            background: #ffffff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 4px;
            border: 1px solid #e0e0e0;
        }

        .answer-group {
            margin: 15px 0;
            padding: 15px;
            background-color: #f8f9fa;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
        }

        .error-message {
            color: #dc3545;
            font-size: 12px;
            margin-top: 5px;
            display: none;
            padding: 5px 0;
        }

        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: #666;
            color: white;
        }

        .btn-primary:hover {
            background: #555;
        }

        .btn-success {
            background: #777;
            color: white;
        }

        .btn-success:hover {
            background: #666;
        }

        .btn-danger {
            background: #999;
            color: white;
            padding: 6px 12px;
            font-size: 12px;
        }

        .btn-danger:hover {
            background: #888;
        }

        .btn-info {
            background: #555;
            color: white;
            width: 100%;
            padding: 12px;
            font-size: 16px;
            margin-top: 20px;
        }

        .btn-info:hover {
            background: #444;
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e0e0e0;
        }

        .question-header h3 {
            color: #444;
            margin: 0;
            font-size: 16px;
            font-weight: 500;
        }

        .answer-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 10px;
        }

        .checkbox-container input[type="checkbox"] {
            width: 16px;
            height: 16px;
        }

        .checkbox-container label {
            color: #555;
            font-weight: normal;
            margin: 0;
            cursor: pointer;
            display: inline;
        }

        .divider {
            margin: 25px 0;
            height: 1px;
            background: #e0e0e0;
            border: none;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin: 20px 0;
        }

        .quiz-title-section {
            background: #fff;
            padding: 20px;
            border-radius: 4px;
            border: 1px solid #e0e0e0;
            margin-bottom: 25px;
        }

        .questions-section {
            margin: 25px 0;
        }

        .section-title {
            color: #444;
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e0e0e0;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
                margin: 10px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
    <script>
        function removeAnswer(questionIdx, answerElement) {
            const answerList = document.getElementById('answers_' + questionIdx);
            if (answerList.getElementsByClassName('answer-group').length <= 2) {
                alert('Each question must have at least 2 answers');
                return;
            }
            // Remove the specific answer-group with animation
            const answerGroup = answerElement.closest('.answer-group');
            if (answerGroup) {
                answerGroup.style.animation = 'slideOut 0.3s ease-out';
                setTimeout(() => {
                    answerGroup.remove();
                    // Renumber remaining answers
                    const answers = answerList.getElementsByClassName('answer-group');
                    for (let i = 0; i < answers.length; i++) {
                        const label = answers[i].querySelector('label');
                        if (label) {
                            label.textContent = 'Answer ' + (i + 1) + ':';
                        }
                    }
                }, 300);
            }
        }

        function removeQuestion(questionElement) {
            const questionsDiv = document.getElementById('questions');
            if (questionsDiv.getElementsByClassName('question-container').length <= 1) {
                alert('Quiz must have at least 1 question');
                return;
            }
            questionElement.style.animation = 'slideOut 0.3s ease-out';
            setTimeout(() => {
                questionElement.remove();
                // Renumber remaining questions
                const questions = questionsDiv.getElementsByClassName('question-container');
                for (let i = 0; i < questions.length; i++) {
                    const h3 = questions[i].querySelector('h3');
                    h3.textContent = 'Question ' + (i + 1);
                }
            }, 300);
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
            if (!answerList) {
                console.error('Answer list container not found');
                return;
            }
            var answerCount = answerList.getElementsByClassName('answer-group').length;

            var div = document.createElement('div');
            div.className = 'answer-group';

            const answerId = 'answer_' + questionIdx + '_' + answerCount;
            var answerHtml = '<div class="form-group">';
            answerHtml += '<div class="answer-header">';
            answerHtml += '<label>Answer ' + (answerCount + 1) + ':</label>';
            answerHtml += '<button type="button" class="btn btn-danger" onclick="removeAnswer(' + questionIdx + ', this)">✕ Remove</button>';
            answerHtml += '</div>';
            answerHtml += '<input type="text" name="answerText_' + questionIdx + '[]" id="' + answerId + '" required ';
            answerHtml += 'placeholder="Enter answer content..." ';
            answerHtml += 'oninput="validateInput(this, \'' + answerId + '_error\')" ';
            answerHtml += 'onblur="validateInput(this, \'' + answerId + '_error\')">';
            answerHtml += '<div class="error-message" id="' + answerId + '_error"></div>';
            answerHtml += '<input type="hidden" name="isCorrect_' + questionIdx + '[]" value="false">';
            answerHtml += '<div class="checkbox-container">';
            answerHtml += '<input type="checkbox" id="correct_' + answerId + '" name="isCorrect_' + questionIdx + '[]" value="true">';
            answerHtml += '<label for="correct_' + answerId + '">✓ Correct Answer</label>';
            answerHtml += '</div>';
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
            html += '<button type="button" class="btn btn-danger" onclick="removeQuestion(this.parentElement.parentElement)">✕ Remove Question</button>';
            html += '</div>';
            html += '<div class="form-group">';
            html += '<input type="text" name="questionText[]" id="' + questionId + '" placeholder="Enter question content..." required ';
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
                html += '<button type="button" class="btn btn-danger" onclick="removeAnswer(' + questionIdx + ', this)">✕ Remove</button>';
                html += '</div>';
                html += '<input type="text" name="answerText_' + questionIdx + '[]" ';
                html += 'id="answer_' + questionIdx + '_' + i + '" placeholder="Enter answer content..." required ';
                html += 'oninput="validateInput(this, \'answer_' + questionIdx + '_' + i + '_error\')" ';
                html += 'onblur="validateInput(this, \'answer_' + questionIdx + '_' + i + '_error\')">';
                html += '<div class="error-message" id="answer_' + questionIdx + '_' + i + '_error"></div>';
                html += '<input type="hidden" name="isCorrect_' + questionIdx + '[]" value="false">';
                html += '<div class="checkbox-container">';
                html += '<input type="checkbox" id="correct_answer_' + questionIdx + '_' + i + '" name="isCorrect_' + questionIdx + '[]" value="true">';
                html += '<label for="correct_answer_' + questionIdx + '_' + i + '">✓ Correct Answer</label>';
                html += '</div>';
                html += '</div></div>';
            }

            html += '</div>';
            html += '<div style="text-align: center; margin-top: 15px;">';
            html += '<button type="button" class="btn btn-success" onclick="addAnswer(' + questionIdx + ')">+ Add Answer</button>';
            html += '</div>';

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

            if (isValid) {
                // Show loading state
                const submitBtn = document.querySelector('.btn-info');
                submitBtn.innerHTML = '⏳ Creating Quiz...';
                submitBtn.disabled = true;
            }

            return isValid;
        }

        // Add CSS for slide out animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideOut {
                from {
                    opacity: 1;
                    transform: translateY(0);
                }
                to {
                    opacity: 0;
                    transform: translateY(-20px);
                }
            }
        `;
        document.head.appendChild(style);

        window.onload = function() {
            addQuestion();
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Create Quiz</h2>
    <form action="addQuiz" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="lessonId" value="${lessonId}">

        <div class="quiz-title-section">
            <div class="form-group">
                <label>Quiz Title</label>
                <input type="text" name="quizTitle" id="quizTitle" placeholder="Enter quiz title..." required
                       oninput="validateInput(this, 'quizTitle_error')"
                       onblur="validateInput(this, 'quizTitle_error')">
                <div class="error-message" id="quizTitle_error"></div>
            </div>
        </div>

        <div class="questions-section">
            <div class="section-title">Questions List</div>
            <div id="questions"></div>

            <div class="action-buttons">
                <button type="button" class="btn btn-primary" onclick="addQuestion()">
                    Add New Question
                </button>
            </div>
        </div>

        <hr class="divider">
        <input type="submit" value="Create Quiz" class="btn btn-info">
    </form>
</div>
</body>
</html>