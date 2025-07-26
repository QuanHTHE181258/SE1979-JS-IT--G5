<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<html>
<head>
    <title>Add Quiz</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            /* Purple Gradient Theme - Synchronized */
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --primary-color: #667eea;
            --primary-light: #764ba2;
            --primary-dark: #5a69d4;
            --primary-50: #f3f1ff;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --info-color: #17a2b8;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-800: #1f2937;
            --gray-900: #111827;
            --bg-primary: #ffffff;
            --bg-secondary: #f8f9fa;
            --text-primary: #2c3e50;
            --text-secondary: #6c757d;
            --text-white: #ffffff;
            --border-light: #e9ecef;
            --shadow-light: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-medium: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --transition-medium: all 0.3s ease-in-out;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background: var(--primary-gradient);
            min-height: 100vh;
        }

        .main-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 15px;
        }

        .quiz-header {
            background: var(--bg-primary);
            padding: 2.5rem 2rem;
            border-radius: 20px 20px 0 0;
            text-align: center;
            box-shadow: var(--shadow-medium);
            border-bottom: 4px solid var(--primary-color);
        }

        .quiz-header h2 {
            color: var(--text-primary);
            margin: 0;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .quiz-subtitle {
            color: var(--text-secondary);
            font-size: 1.1rem;
            margin: 0;
        }

        .form-container {
            background: var(--bg-primary);
            border-radius: 0 0 20px 20px;
            box-shadow: var(--shadow-medium);
            overflow: hidden;
        }

        .form-content {
            padding: 2.5rem;
        }

        .section {
            margin-bottom: 2.5rem;
        }

        .section-header {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--gray-200);
        }

        .section-icon {
            background: var(--primary-gradient);
            color: var(--text-white);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.1rem;
        }

        .section-title {
            color: var(--text-primary);
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0;
        }

        .quiz-title-section {
            background: var(--primary-50);
            padding: 2rem;
            border-radius: 16px;
            border: 2px solid var(--primary-color);
            margin-bottom: 2.5rem;
            position: relative;
            overflow: hidden;
        }

        .quiz-title-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--primary-gradient);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: flex;
            align-items: center;
            margin-bottom: 0.75rem;
            font-weight: 600;
            color: var(--text-primary);
            font-size: 1rem;
        }

        .form-label i {
            margin-right: 0.5rem;
            color: var(--primary-color);
        }

        .form-input {
            width: 100%;
            padding: 1rem 1.25rem;
            border: 2px solid var(--gray-300);
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition-medium);
            background-color: var(--bg-primary);
            color: var(--text-primary);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-1px);
        }

        .form-input::placeholder {
            color: var(--text-secondary);
        }

        .question-container {
            background: var(--bg-primary);
            padding: 2rem;
            margin-bottom: 2rem;
            border-radius: 16px;
            border: 2px solid var(--gray-200);
            box-shadow: var(--shadow-light);
            transition: var(--transition-medium);
            position: relative;
            overflow: hidden;
        }

        .question-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--primary-gradient);
        }

        .question-container:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
            border-color: var(--primary-color);
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-200);
        }

        .question-title {
            display: flex;
            align-items: center;
            color: var(--text-primary);
            margin: 0;
            font-size: 1.25rem;
            font-weight: 600;
        }

        .question-number {
            background: var(--primary-gradient);
            color: var(--text-white);
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 0.75rem;
            font-weight: 700;
            font-size: 0.9rem;
        }

        .answer-group {
            background: var(--gray-50);
            padding: 1.5rem;
            margin-bottom: 1rem;
            border-radius: 12px;
            border: 1px solid var(--gray-200);
            transition: var(--transition-medium);
        }

        .answer-group:hover {
            border-color: var(--primary-color);
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.1);
        }

        .answer-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .answer-label {
            display: flex;
            align-items: center;
            font-weight: 600;
            color: var(--text-primary);
            margin: 0;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-top: 1rem;
            padding: 0.75rem;
            background: var(--bg-primary);
            border-radius: 8px;
            border: 1px solid var(--gray-200);
        }

        .checkbox-container input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: var(--primary-color);
        }

        .checkbox-container label {
            color: var(--text-primary);
            font-weight: 500;
            margin: 0;
            cursor: pointer;
            display: inline;
        }

        .error-message {
            color: var(--danger-color);
            font-size: 0.875rem;
            margin-top: 0.5rem;
            display: none;
            padding: 0.5rem 0.75rem;
            background: rgba(220, 53, 69, 0.1);
            border-radius: 6px;
            border-left: 3px solid var(--danger-color);
        }

        /* Button Styles */
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: var(--transition-medium);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: var(--shadow-light);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: var(--text-white);
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success-color), #34ce57);
            color: var(--text-white);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger-color), #e74c3c);
            color: var(--text-white);
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
        }

        .btn-info {
            background: var(--primary-gradient);
            color: var(--text-white);
            width: 100%;
            padding: 1.25rem;
            font-size: 1.125rem;
            margin-top: 2rem;
            border-radius: 12px;
        }

        .btn-info:hover {
            background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin: 2rem 0;
            flex-wrap: wrap;
        }

        .divider {
            margin: 2.5rem 0;
            height: 2px;
            background: var(--primary-gradient);
            border: none;
            border-radius: 1px;
        }

        /* Animations */
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

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .question-container {
            animation: slideIn 0.3s ease-out;
        }

        /* Success State */
        .form-input.valid {
            border-color: var(--success-color);
            background: rgba(40, 167, 69, 0.05);
        }

        .form-input.invalid {
            border-color: var(--danger-color);
            background: rgba(220, 53, 69, 0.05);
        }

        /* Loading State */
        .btn-loading {
            opacity: 0.7;
            pointer-events: none;
        }

        .btn-loading::after {
            content: '';
            width: 16px;
            height: 16px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-left: 0.5rem;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .quiz-header {
                padding: 2rem 1.5rem;
                border-radius: 16px 16px 0 0;
            }

            .quiz-header h2 {
                font-size: 2rem;
            }

            .form-content {
                padding: 1.5rem;
            }

            .question-container {
                padding: 1.5rem;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .question-header {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }

            .answer-header {
                flex-direction: column;
                gap: 0.5rem;
                align-items: flex-start;
            }
        }

        /* Focus states for accessibility */
        .btn:focus {
            outline: 2px solid var(--primary-color);
            outline-offset: 2px;
        }

        /* Enhanced visual feedback */
        .question-container.removing {
            animation: slideOut 0.3s ease-out;
        }

        .answer-group.removing {
            animation: slideOut 0.3s ease-out;
        }
    </style>
    <script>
        function removeAnswer(questionIdx, answerElement) {
            const answerList = document.getElementById('answers_' + questionIdx);
            if (answerList.getElementsByClassName('answer-group').length <= 2) {
                showNotification('Each question must have at least 2 answers', 'warning');
                return;
            }

            const answerGroup = answerElement.closest('.answer-group');
            if (answerGroup) {
                answerGroup.classList.add('removing');
                setTimeout(() => {
                    answerGroup.remove();
                    renumberAnswers(questionIdx);
                    showNotification('Answer removed successfully', 'success');
                }, 300);
            }
        }

        function removeQuestion(questionElement) {
            const questionsDiv = document.getElementById('questions');
            if (questionsDiv.getElementsByClassName('question-container').length <= 1) {
                showNotification('Quiz must have at least 1 question', 'warning');
                return;
            }

            questionElement.classList.add('removing');
            setTimeout(() => {
                questionElement.remove();
                renumberQuestions();
                showNotification('Question removed successfully', 'success');
            }, 300);
        }

        function renumberAnswers(questionIdx) {
            const answerList = document.getElementById('answers_' + questionIdx);
            const answers = answerList.getElementsByClassName('answer-group');
            for (let i = 0; i < answers.length; i++) {
                const label = answers[i].querySelector('.answer-label');
                if (label) {
                    label.innerHTML = '<i class="fas fa-list-ul"></i>Answer ' + (i + 1) + ':';
                }
            }
        }

        function renumberQuestions() {
            const questionsDiv = document.getElementById('questions');
            const questions = questionsDiv.getElementsByClassName('question-container');
            for (let i = 0; i < questions.length; i++) {
                const questionTitle = questions[i].querySelector('.question-title');
                const questionNumber = questions[i].querySelector('.question-number');
                if (questionNumber) {
                    questionNumber.textContent = i + 1;
                }
            }
        }

        function validateInput(input, errorId) {
            const value = input.value.trim();
            const errorElement = document.getElementById(errorId);

            if (value == '') {
                showError(errorElement, 'This field is required');
                input.classList.add('invalid');
                input.classList.remove('valid');
                return false;
            }

            // Check for duplicates
            const inputType = input.name.startsWith('questionText') ? 'question' : 'answer';
            const questionIdx = input.name.includes('_') ? input.name.split('_')[1].replace('[]','') : '';

            if (inputType == 'question') {
                const questions = document.querySelectorAll('input[name="questionText[]"]');
                for (let q of questions) {
                    if (q !== input && q.value.trim().toLowerCase() == value.toLowerCase()) {
                        showError(errorElement, 'This question already exists');
                        input.classList.add('invalid');
                        input.classList.remove('valid');
                        return false;
                    }
                }
            } else {
                const answers = document.querySelectorAll(`input[name="answerText_${questionIdx}[]"]`);
                for (let a of answers) {
                    if (a !== input && a.value.trim().toLowerCase() == value.toLowerCase()) {
                        showError(errorElement, 'This answer already exists for this question');
                        input.classList.add('invalid');
                        input.classList.remove('valid');
                        return false;
                    }
                }
            }

            hideError(errorElement);
            input.classList.add('valid');
            input.classList.remove('invalid');
            return true;
        }

        function showError(errorElement, message) {
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }

        function hideError(errorElement) {
            errorElement.style.display = 'none';
        }

        function showNotification(message, type) {
            // Create notification element
            const notification = document.createElement('div');
            notification.className = `notification notification-${type}`;
            notification.innerHTML = `
                <i class="fas ${type == 'success' ? 'fa-check-circle' : type == 'warning' ? 'fa-exclamation-triangle' : 'fa-info-circle'}"></i>
                ${message}
            `;

            // Add notification styles
            notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 1rem 1.5rem;
                border-radius: 8px;
                color: white;
                font-weight: 500;
                z-index: 9999;
                animation: slideIn 0.3s ease-out;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                ${type == 'success' ? 'background: linear-gradient(135deg, #28a745, #34ce57);' :
                  type == 'warning' ? 'background: linear-gradient(135deg, #ffc107, #ffca2c);' :
                  'background: linear-gradient(135deg, #17a2b8, #20c997);'}
            `;

            document.body.appendChild(notification);

            // Remove notification after 3 seconds
            setTimeout(() => {
                notification.style.animation = 'slideOut 0.3s ease-out';
                setTimeout(() => {
                    document.body.removeChild(notification);
                }, 300);
            }, 3000);
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
            answerHtml += '<label class="answer-label"><i class="fas fa-list-ul"></i>Answer ' + (answerCount + 1) + ':</label>';
            answerHtml += '<button type="button" class="btn btn-danger" onclick="removeAnswer(' + questionIdx + ', this)"><i class="fas fa-times"></i> Remove</button>';
            answerHtml += '</div>';
            answerHtml += '<input type="text" class="form-input" name="answerText_' + questionIdx + '[]" id="' + answerId + '" required ';
            answerHtml += 'placeholder="Enter answer content..." ';
            answerHtml += 'oninput="validateInput(this, \'' + answerId + '_error\')" ';
            answerHtml += 'onblur="validateInput(this, \'' + answerId + '_error\')">';
            answerHtml += '<div class="error-message" id="' + answerId + '_error"></div>';
            answerHtml += '<input type="hidden" name="isCorrect_' + questionIdx + '[]" value="false">';
            answerHtml += '<div class="checkbox-container">';
            answerHtml += '<input type="checkbox" id="correct_' + answerId + '" name="isCorrect_' + questionIdx + '[]" value="true">';
            answerHtml += '<label for="correct_' + answerId + '"><i class="fas fa-check"></i> Correct Answer</label>';
            answerHtml += '</div>';
            answerHtml += '</div>';

            div.innerHTML = answerHtml;
            div.style.animation = 'slideIn 0.3s ease-out';
            answerList.appendChild(div);

            showNotification('Answer added successfully', 'success');
        }

        function addQuestion() {
            var questionsDiv = document.getElementById('questions');
            var questionIdx = questionsDiv.getElementsByClassName('question-container').length;

            var div = document.createElement('div');
            div.className = 'question-container';

            const questionId = 'question_' + questionIdx;
            var html = '<div class="question-header">';
            html += '<h3 class="question-title">';
            html += '<span class="question-number">' + (questionIdx + 1) + '</span>';
            html += 'Question ' + (questionIdx + 1);
            html += '</h3>';
            html += '<button type="button" class="btn btn-danger" onclick="removeQuestion(this.parentElement.parentElement)"><i class="fas fa-trash"></i> Remove Question</button>';
            html += '</div>';
            html += '<div class="form-group">';
            html += '<label class="form-label"><i class="fas fa-question-circle"></i>Question Content</label>';
            html += '<input type="text" class="form-input" name="questionText[]" id="' + questionId + '" placeholder="Enter question content..." required ';
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
                html += '<label class="answer-label"><i class="fas fa-list-ul"></i>Answer ' + (i + 1) + ':</label>';
                html += '<button type="button" class="btn btn-danger" onclick="removeAnswer(' + questionIdx + ', this)"><i class="fas fa-times"></i> Remove</button>';
                html += '</div>';
                html += '<input type="text" class="form-input" name="answerText_' + questionIdx + '[]" ';
                html += 'id="answer_' + questionIdx + '_' + i + '" placeholder="Enter answer content..." required ';
                html += 'oninput="validateInput(this, \'answer_' + questionIdx + '_' + i + '_error\')" ';
                html += 'onblur="validateInput(this, \'answer_' + questionIdx + '_' + i + '_error\')">';
                html += '<div class="error-message" id="answer_' + questionIdx + '_' + i + '_error"></div>';
                html += '<input type="hidden" name="isCorrect_' + questionIdx + '[]" value="false">';
                html += '<div class="checkbox-container">';
                html += '<input type="checkbox" id="correct_answer_' + questionIdx + '_' + i + '" name="isCorrect_' + questionIdx + '[]" value="true">';
                html += '<label for="correct_answer_' + questionIdx + '_' + i + '"><i class="fas fa-check"></i> Correct Answer</label>';
                html += '</div>';
                html += '</div></div>';
            }

            html += '</div>';
            html += '<div style="text-align: center; margin-top: 1.5rem;">';
            html += '<button type="button" class="btn btn-success" onclick="addAnswer(' + questionIdx + ')"><i class="fas fa-plus"></i> Add Answer</button>';
            html += '</div>';

            div.innerHTML = html;
            questionsDiv.appendChild(div);

            showNotification('Question added successfully', 'success');
        }

        function validateForm() {
            let isValid = true;

            // Validate quiz title
            const titleInput = document.querySelector('input[name="quizTitle"]');
            isValid = validateInput(titleInput, 'quizTitle_error') && isValid;

            // Validate all questions
            const questions = document.querySelectorAll('input[name="questionText[]"]');
            if (questions.length == 0) {
                showNotification('Quiz must have at least 1 question', 'warning');
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
                    showError(errorDiv, 'Each question must have at least 2 answers');
                    isValid = false;
                }

                // Validate each answer
                answers.forEach(answer => {
                    isValid = validateInput(answer, answer.id + '_error') && isValid;
                });

                // Check if at least one correct answer
                const correctAnswers = container.querySelectorAll('input[type="checkbox"]:checked');
                const errorDiv = document.getElementById('question_' + idx + '_error');
                if (correctAnswers.length == 0) {
                    showError(errorDiv, 'Please select at least one correct answer');
                    isValid = false;
                }
            });

            if (isValid) {
                // Show loading state
                const submitBtn = document.querySelector('.btn-info');
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creating Quiz...';
                submitBtn.classList.add('btn-loading');
                submitBtn.disabled = true;

                showNotification('Creating quiz...', 'info');
            }

            return isValid;
        }

        // Initialize first question on page load
        window.onload = function() {
            addQuestion();
        }
    </script>
</head>
<body>
<div class="main-container">
    <!-- Quiz Header -->
    <div class="quiz-header">
        <h2><i class="fas fa-plus-circle me-2"></i>Create Quiz</h2>
        <p class="quiz-subtitle">Build an engaging quiz for your lesson</p>
    </div>

    <!-- Form Container -->
    <div class="form-container">
        <div class="form-content">
            <form action="addQuiz" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="lessonId" value="${lessonId}">

                <!-- Quiz Title Section -->
                <div class="quiz-title-section">
                    <div class="form-group">
                        <label class="form-label">
                            <i class="fas fa-heading"></i>Quiz Title
                        </label>
                        <input type="text" class="form-input" name="quizTitle" id="quizTitle"
                               placeholder="Enter an engaging quiz title..." required
                               oninput="validateInput(this, 'quizTitle_error')"
                               onblur="validateInput(this, 'quizTitle_error')">
                        <div class="error-message" id="quizTitle_error"></div>
                    </div>
                </div>

                <!-- Questions Section -->
                <div class="section">
                    <div class="section-header">
                        <div class="section-icon">
                            <i class="fas fa-list-ol"></i>
                        </div>
                        <h3 class="section-title">Quiz Questions</h3>
                    </div>

                    <div id="questions"></div>

                    <div class="action-buttons">
                        <button type="button" class="btn btn-primary" onclick="addQuestion()">
                            <i class="fas fa-plus"></i> Add New Question
                        </button>
                    </div>
                </div>

                <hr class="divider">

                <!-- Submit Button -->
                <button type="submit" class="btn btn-info">
                    <i class="fas fa-rocket"></i> Create Quiz
                </button>
            </form>
        </div>
    </div>
</div>
</body>
</html>