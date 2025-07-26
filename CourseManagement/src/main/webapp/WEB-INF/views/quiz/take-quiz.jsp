<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take Quiz - ${quiz.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4f46e5;
            --primary-light: #818cf8;
            --primary-dark: #3730a3;
            --success-color: #10b981;
            --success-light: #d1fae5;
            --warning-color: #f59e0b;
            --warning-light: #fef3c7;
            --danger-color: #ef4444;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-400: #9ca3af;
            --gray-500: #6b7280;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --gray-900: #111827;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            line-height: 1.6;
            color: var(--gray-800);
        }

        .quiz-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .quiz-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 24px;
            padding: 3rem 2rem;
            margin-bottom: 2rem;
            text-align: center;
            box-shadow: var(--shadow-xl);
            position: relative;
            overflow: hidden;
        }

        .quiz-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .quiz-header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .quiz-header .subtitle {
            color: var(--gray-600);
            font-size: 1.125rem;
            font-weight: 500;
            position: relative;
            z-index: 1;
        }

        .quiz-progress {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
            position: sticky;
            top: 2rem;
            z-index: 100;
        }

        .progress-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .progress-title {
            font-size: 1.125rem;
            font-weight: 700;
            color: var(--gray-800);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .progress-badge {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.875rem;
            box-shadow: 0 4px 6px rgba(79, 70, 229, 0.3);
        }

        .progress {
            height: 12px;
            background: var(--gray-200);
            border-radius: 50px;
            overflow: hidden;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .progress-bar {
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-light) 100%);
            height: 100%;
            border-radius: 50px;
            transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }

        .progress-bar::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            animation: progressShine 2s infinite;
        }

        @keyframes progressShine {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        .question-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 24px;
            margin-bottom: 2rem;
            overflow: hidden;
            box-shadow: var(--shadow-xl);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            opacity: 0;
            transform: translateY(30px);
            animation: slideUp 0.6s ease-out forwards;
        }

        .question-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-xl), 0 25px 50px rgba(0, 0, 0, 0.1);
        }

        @keyframes slideUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .question-header {
            background: linear-gradient(135deg, var(--gray-100) 0%, var(--gray-50) 100%);
            padding: 2rem;
            border-bottom: 1px solid var(--gray-200);
            position: relative;
        }

        .question-number {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            color: white;
            padding: 0.75rem 1.25rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1rem;
            box-shadow: 0 4px 6px rgba(79, 70, 229, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .question-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--gray-800);
            margin: 0;
            margin-left: 1rem;
            display: inline;
        }

        .question-body {
            padding: 2rem;
        }

        .question-text {
            font-size: 1.25rem;
            color: var(--gray-700);
            margin-bottom: 2rem;
            line-height: 1.7;
            font-weight: 500;
        }

        .answer-option {
            border: 3px solid var(--gray-200);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            background: var(--gray-50);
            position: relative;
            overflow: hidden;
        }

        .answer-option::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(79, 70, 229, 0.1), transparent);
            transition: left 0.6s ease;
        }

        .answer-option:hover {
            border-color: var(--primary-light);
            background: rgba(79, 70, 229, 0.05);
            transform: translateX(8px);
        }

        .answer-option:hover::before {
            left: 100%;
        }

        .answer-option.selected {
            border-color: var(--primary-color);
            background: linear-gradient(135deg, rgba(79, 70, 229, 0.1) 0%, rgba(129, 140, 248, 0.1) 100%);
            transform: translateX(8px);
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.2);
        }

        .answer-option input[type="radio"] {
            width: 24px;
            height: 24px;
            margin-right: 1rem;
            accent-color: var(--primary-color);
            transform: scale(1.2);
            cursor: pointer;
        }

        .answer-label {
            flex: 1;
            font-size: 1rem;
            color: var(--gray-700);
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
        }

        .answer-prefix {
            background: var(--gray-300);
            color: var(--gray-700);
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            margin-right: 1rem;
            transition: all 0.3s ease;
        }

        .answer-option.selected .answer-prefix {
            background: var(--primary-color);
            color: white;
            transform: scale(1.1);
        }

        .timer {
            position: fixed;
            top: 2rem;
            right: 2rem;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 1.5rem 2rem;
            border-radius: 16px;
            box-shadow: var(--shadow-lg);
            z-index: 1000;
            font-weight: 600;
            color: var(--gray-800);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .timer-icon {
            color: var(--primary-color);
            font-size: 1.25rem;
        }

        .submit-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 24px;
            padding: 3rem 2rem;
            text-align: center;
            box-shadow: var(--shadow-xl);
            margin-top: 3rem;
            position: relative;
            overflow: hidden;
        }

        .submit-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 50% 50%, rgba(79, 70, 229, 0.1) 0%, transparent 70%);
            pointer-events: none;
        }

        .submit-info {
            color: var(--gray-600);
            font-size: 1.125rem;
            margin-bottom: 2rem;
            position: relative;
            z-index: 1;
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            border: none;
            padding: 1.25rem 3rem;
            font-size: 1.125rem;
            font-weight: 700;
            border-radius: 50px;
            color: white;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.3);
            position: relative;
            z-index: 1;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(79, 70, 229, 0.4);
            color: white;
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        /* Modal Enhancements */
        .modal-content {
            border-radius: 20px;
            border: none;
            box-shadow: var(--shadow-xl);
            backdrop-filter: blur(20px);
        }

        .modal-header {
            background: linear-gradient(135deg, var(--warning-light) 0%, #fef9c3 100%);
            border-bottom: 1px solid var(--gray-200);
            border-radius: 20px 20px 0 0;
            padding: 2rem;
        }

        .modal-title {
            font-weight: 700;
            color: var(--gray-800);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .modal-body {
            padding: 2rem;
            font-size: 1.125rem;
        }

        .modal-footer {
            padding: 2rem;
            border-top: 1px solid var(--gray-200);
            gap: 1rem;
        }

        .alert-warning {
            background: linear-gradient(135deg, var(--warning-light) 0%, #fef3c7 100%);
            border: 1px solid var(--warning-color);
            border-radius: 12px;
            color: var(--gray-800);
        }

        /* Additional CSS animations */
        @keyframes confetti {
            0% {
                transform: translate(0, 0) rotate(0deg);
                opacity: 1;
            }
            50% {
                transform: translate(var(--x, 100px), var(--y, -100px)) rotate(180deg);
                opacity: 1;
            }
            100% {
                transform: translate(var(--x, 200px), var(--y, 200px)) rotate(360deg);
                opacity: 0;
            }
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        .question-card.answered {
            border-left: 4px solid var(--success-color);
        }

        .question-card.answered .question-number {
            background: linear-gradient(135deg, var(--success-color) 0%, #34d399 100%);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .quiz-container {
                padding: 1rem;
            }

            .quiz-header {
                padding: 2rem 1.5rem;
            }

            .quiz-header h1 {
                font-size: 2rem;
            }

            .question-card,
            .quiz-progress,
            .submit-section {
                padding: 1.5rem;
            }

            .timer {
                position: static;
                margin-bottom: 1rem;
                justify-content: center;
            }

            .answer-option {
                padding: 1.25rem;
            }

            .btn-submit {
                width: 100%;
                max-width: 300px;
            }

            .progress-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
        }

        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Auto-save indicator */
        .auto-save-indicator {
            position: fixed;
            top: 50%;
            right: 2rem;
            transform: translateY(-50%);
            background: var(--success-color);
            color: white;
            padding: 0.75rem 1rem;
            border-radius: 50px;
            font-size: 0.875rem;
            font-weight: 600;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 1001;
        }

        .auto-save-indicator.show {
            opacity: 1;
        }
    </style>
</head>
<body>
<div class="quiz-container">
    <!-- Quiz Header -->
    <div class="quiz-header fade-in">
        <h1>
            <i class="fas fa-brain me-3"></i>
            ${quiz.title}
        </h1>
        <p class="subtitle">Test Your Knowledge - Take Your Time</p>
    </div>

    <!-- Timer (Mobile) -->
    <div class="timer d-md-none">
        <i class="fas fa-clock timer-icon"></i>
        <span>00:00</span>
    </div>

    <!-- Quiz Progress -->
    <div class="quiz-progress fade-in">
        <div class="progress-header">
            <div class="progress-title">
                <i class="fas fa-chart-line"></i>
                Quiz Progress
            </div>
            <div class="progress-badge">
                <span id="answered">0</span>/<c:out value="${quiz.questions.size()}"/> completed
            </div>
        </div>
        <div class="progress">
            <div class="progress-bar" id="progress" role="progressbar" style="width: 0%"></div>
        </div>
    </div>

    <!-- Timer (Desktop) -->
    <div class="timer d-none d-md-flex">
        <i class="fas fa-clock timer-icon"></i>
        <span id="timer-display">00:00</span>
    </div>

    <!-- Auto-save indicator -->
    <div class="auto-save-indicator" id="autoSaveIndicator">
        <i class="fas fa-check me-2"></i>
        Progress Saved
    </div>

    <!-- Quiz Form -->
    <form action="take-quiz" method="post" id="quizForm">
        <input type="hidden" name="action" value="submit">
        <input type="hidden" name="lessonId" value="${param.lessonId}">

        <!-- Questions Section -->
        <c:forEach items="${quiz.questions}" var="question" varStatus="status">
            <div class="question-card fade-in">
                <div class="question-header">
                    <span class="question-number">
                        <i class="fas fa-question-circle"></i>
                        Question ${status.index + 1}
                    </span>
                    <h2 class="question-title">${question.questionText}</h2>
                </div>
                <div class="question-body">
                    <div class="answers-list">
                        <c:forEach items="${question.answers}" var="answer" varStatus="answerStatus">
                            <div class="answer-option">
                                <input type="radio"
                                       id="q${question.id}a${answer.id}"
                                       name="question_${question.id}"
                                       value="${answer.id}"
                                       class="answer-input">
                                <label class="answer-label" for="q${question.id}a${answer.id}">
                                    <span class="answer-prefix">${answerStatus.index + 1}</span>
                                        ${answer.answerText}
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Submit Section -->
        <div class="submit-section fade-in">
            <p class="submit-info">Make sure to review all your answers before submitting</p>
            <button type="submit" class="btn btn-submit">
                <i class="fas fa-paper-plane"></i>
                Submit Quiz
            </button>
        </div>
    </form>
</div>

<!-- Confirmation Modal -->
<div class="modal fade" id="submitConfirmModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle text-warning"></i>
                    Confirm Submission
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="alert alert-warning">
                    <i class="fas fa-info-circle"></i>
                    Are you sure you want to submit? You cannot change your answers after submission.
                </div>
                <p>Please review your answers before confirming.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times"></i> Review Again
                </button>
                <button type="button" class="btn btn-primary" id="confirmSubmit">
                    <i class="fas fa-check"></i> Yes, Submit
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('quizForm');
        const submitBtn = document.querySelector('.btn-submit');
        const confirmBtn = document.getElementById('confirmSubmit');
        const modal = new bootstrap.Modal(document.getElementById('submitConfirmModal'));

        // Prevent direct form submission
        form.onsubmit = function(e) {
            e.preventDefault();
            modal.show();
        };

        // Handle confirmation
        confirmBtn.onclick = function() {
            form.submit();
        };

        // Progress tracking
        const radioButtons = document.querySelectorAll('input[type="radio"]');
        const progressBar = document.getElementById('progress');
        const answeredSpan = document.getElementById('answered');
        const totalQuestions = ${quiz.questions.size()};

        function updateProgress() {
            const answered = document.querySelectorAll('input[type="radio"]:checked').length;
            const percentage = (answered / totalQuestions) * 100;
            progressBar.style.width = percentage + '%';
            answeredSpan.textContent = answered;

            // Add visual feedback
            document.querySelectorAll('.question-card').forEach(card => {
                const questionInputs = card.querySelectorAll('input[type="radio"]');
                const isAnswered = Array.from(questionInputs).some(input => input.checked);
                card.classList.toggle('answered', isAnswered);
            });
        }

        radioButtons.forEach(radio => {
            radio.addEventListener('change', updateProgress);
        });

        // Initialize progress
        updateProgress();
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>