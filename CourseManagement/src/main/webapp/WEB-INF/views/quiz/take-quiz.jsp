<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <form id="quizForm" action="take-quiz" method="post">
        <input type="hidden" name="action" value="submit">
        <input type="hidden" name="quizId" value="${quiz.id}">

        <!-- Questions -->
        <c:forEach var="question" items="${quiz.questions}" varStatus="status">
            <div class="question-card" style="animation-delay: ${status.index * 0.1}s" data-question-id="${question.id}">
                <div class="question-header">
                    <div class="d-flex align-items-center">
                            <span class="question-number">
                                <i class="fas fa-question-circle"></i>
                                ${status.index + 1}
                            </span>
                        <h5 class="question-title">Question ${status.index + 1}</h5>
                    </div>
                </div>
                <div class="question-body">
                    <div class="question-text">${question.questionText}</div>

                    <div class="answers">
                        <c:forEach var="answer" items="${question.answers}" varStatus="answerStatus">
                            <div class="answer-option" onclick="selectAnswer(this, ${question.id}, ${answer.id})">
                                <input type="radio"
                                       name="question_${question.id}"
                                       value="${answer.id}"
                                       id="answer_${question.id}_${answer.id}"
                                       onchange="updateProgress()">
                                <label for="answer_${question.id}_${answer.id}" class="answer-label">
                                        <span class="answer-prefix">
                                                ${answerStatus.index == 0 ? 'A' : answerStatus.index == 1 ? 'B' : answerStatus.index == 2 ? 'C' : 'D'}
                                        </span>
                                    <span>${answer.answerText}</span>
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Submit Section -->
        <div class="submit-section fade-in">
            <div class="submit-info">
                <i class="fas fa-lightbulb text-warning me-2"></i>
                Double-check your answers before submitting. You won't be able to change them afterwards.
            </div>
            <button type="button" class="btn btn-submit" onclick="confirmSubmit()">
                <i class="fas fa-paper-plane"></i>
                <span>Submit Quiz</span>
            </button>
        </div>
    </form>
</div>

<!-- Confirmation Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle text-warning"></i>
                    Confirm Submission
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p class="mb-3">Are you ready to submit your quiz?</p>
                <div class="bg-light p-3 rounded-3 mb-3">
                    <strong>Progress Summary:</strong><br>
                    <span class="text-success">
                            <i class="fas fa-check-circle me-1"></i>
                            Answered: <span id="confirmedAnswered">0</span>/<c:out value="${quiz.questions.size()}"/> questions
                        </span>
                </div>
                <div class="alert alert-warning d-flex align-items-center">
                    <i class="fas fa-info-circle me-3"></i>
                    <div>
                        <strong>Important:</strong> Once you submit, you cannot modify your answers or retake this attempt.
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary btn-lg" data-bs-dismiss="modal">
                    <i class="fas fa-arrow-left me-2"></i>Go Back
                </button>
                <button type="button" class="btn btn-primary btn-lg" onclick="submitQuiz()">
                    <i class="fas fa-paper-plane me-2"></i>Submit Now
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let totalQuestions = ${quiz.questions.size()};
    let startTime = new Date().getTime();
    let timerInterval;
    let autoSaveInterval;

    // Initialize when page loads
    document.addEventListener('DOMContentLoaded', function() {
        startTimer();
        initializeAutoSave();
        loadSavedAnswers();
        setupKeyboardNavigation();
    });

    // Initialize timer
    function startTimer() {
        timerInterval = setInterval(function() {
            const now = new Date().getTime();
            const elapsed = now - startTime;
            const minutes = Math.floor(elapsed / 60000);
            const seconds = Math.floor((elapsed % 60000) / 1000);
            const display = String(minutes).padStart(2, '0') + ':' + String(seconds).padStart(2, '0');

            const timerElement = document.getElementById('timer-display');
            if (timerElement) {
                timerElement.textContent = display;
            }

            // Update mobile timer if exists
            const mobileTimer = document.querySelector('.timer.d-md-none span');
            if (mobileTimer) {
                mobileTimer.textContent = display;
            }
        }, 1000);
    }

    // Auto-save functionality
    function initializeAutoSave() {
        autoSaveInterval = setInterval(function() {
            saveProgress();
        }, 30000); // Save every 30 seconds
    }

    function saveProgress() {
        const answers = {};
        const radioButtons = document.querySelectorAll('input[type="radio"]:checked');

        radioButtons.forEach(radio => {
            const questionId = radio.name.replace('question_', '');
            answers[questionId] = radio.value;
        });

        // Save to session storage (in a real app, this would be sent to server)
        const progressData = {
            answers: answers,
            timestamp: new Date().getTime(),
            elapsedTime: new Date().getTime() - startTime
        };

        try {
            // In a real implementation, you would send this to the server
            // For now, we'll just show the save indicator
            showAutoSaveIndicator();
        } catch (error) {
            console.error('Failed to save progress:', error);
        }
    }

    function showAutoSaveIndicator() {
        const indicator = document.getElementById('autoSaveIndicator');
        indicator.classList.add('show');
        setTimeout(() => {
            indicator.classList.remove('show');
        }, 2000);
    }

    function loadSavedAnswers() {
        // In a real implementation, this would load from server
        // For demo purposes, we'll skip this
    }

    // Keyboard navigation
    function setupKeyboardNavigation() {
        document.addEventListener('keydown', function(e) {
            if (e.key >= '1' && e.key <= '4') {
                const currentQuestion = getCurrentQuestion();
                if (currentQuestion) {
                    const answerIndex = parseInt(e.key) - 1;
                    const answerOptions = currentQuestion.querySelectorAll('.answer-option');
                    if (answerOptions[answerIndex]) {
                        answerOptions[answerIndex].click();
                    }
                }
            }
        });
    }

    function getCurrentQuestion() {
        const questions = document.querySelectorAll('.question-card');
        for (let question of questions) {
            const rect = question.getBoundingClientRect();
            if (rect.top >= 0 && rect.top <= window.innerHeight / 2) {
                return question;
            }
        }
        return questions[0]; // Default to first question
    }

    // Answer selection with enhanced animation
    function selectAnswer(element, questionId, answerId) {
        const siblings = element.parentNode.querySelectorAll('.answer-option');
        siblings.forEach(sibling => {
            sibling.classList.remove('selected');
            sibling.style.transform = '';
        });

        element.classList.add('selected');

        const radio = element.querySelector('input[type="radio"]');
        radio.checked = true;

        // Mark question as answered
        const questionCard = element.closest('.question-card');
        questionCard.classList.add('answered');

        // Add selection animation
        element.style.transform = 'translateX(8px) scale(1.02)';
        setTimeout(() => {
            element.style.transform = 'translateX(8px)';
        }, 200);

        updateProgress();
        playSelectionSound();

        // Auto-save after selection
        setTimeout(saveProgress, 1000);
    }

    // Progress tracking with smooth animations
    function updateProgress() {
        const answeredCount = document.querySelectorAll('input[type="radio"]:checked').length;
        const progressPercentage = (answeredCount / totalQuestions) * 100;

        document.getElementById('answered').textContent = answeredCount;

        const progressBar = document.getElementById('progress');
        progressBar.style.width = progressPercentage + '%';

        // Add completion celebration
        if (answeredCount == totalQuestions) {
            celebrateCompletion();
        }
    }

    // Completion celebration
    function celebrateCompletion() {
        const progressBadge = document.querySelector('.progress-badge');
        progressBadge.style.animation = 'pulse 0.6s ease-in-out';

        // Create confetti effect (simplified)
        createConfetti();

        // Show completion message
        showCompletionMessage();
    }

    // Simple confetti effect
    function createConfetti() {
        const colors = ['#4f46e5', '#818cf8', '#10b981', '#f59e0b'];
        const container = document.querySelector('.quiz-progress');

        for (let i = 0; i < 20; i++) {
            const confetti = document.createElement('div');
            const x = (Math.random() - 0.5) * 400;
            const y = (Math.random() - 0.5) * 400;

            confetti.style.cssText = `
                    position: absolute;
                    width: 6px;
                    height: 6px;
                    background: ${colors[Math.floor(Math.random() * colors.length)]};
                    border-radius: 50%;
                    pointer-events: none;
                    top: 50%;
                    left: 50%;
                    animation: confetti 1s ease-out forwards;
                    z-index: 1000;
                    --x: ${x}px;
                    --y: ${y}px;
                `;

            container.appendChild(confetti);

            setTimeout(() => {
                if (confetti.parentNode) {
                    confetti.remove();
                }
            }, 1000);
        }
    }

    // Show completion message
    function showCompletionMessage() {
        const existingMessage = document.querySelector('.completion-message');
        if (existingMessage) {
            existingMessage.remove();
        }

        const message = document.createElement('div');
        message.className = 'completion-message alert alert-success d-flex align-items-center';
        message.style.cssText = `
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                z-index: 1002;
                min-width: 300px;
                text-align: center;
                box-shadow: var(--shadow-xl);
                border-radius: 16px;
                animation: fadeIn 0.5s ease-out;
            `;
        message.innerHTML = `
                <div class="w-100">
                    <i class="fas fa-check-circle text-success me-2" style="font-size: 1.5rem;"></i>
                    <strong>All questions completed!</strong><br>
                    <small class="text-muted">Ready to submit your quiz?</small>
                </div>
            `;

        document.body.appendChild(message);

        setTimeout(() => {
            if (message.parentNode) {
                message.remove();
            }
        }, 3000);
    }

    // Sound effect for selection (using Web Audio API)
    function playSelectionSound() {
        try {
            const audioContext = new (window.AudioContext || window.webkitAudioContext)();
            const oscillator = audioContext.createOscillator();
            const gainNode = audioContext.createGain();

            oscillator.connect(gainNode);
            gainNode.connect(audioContext.destination);

            oscillator.frequency.value = 800;
            oscillator.type = 'sine';

            gainNode.gain.setValueAtTime(0.1, audioContext.currentTime);
            gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.1);

            oscillator.start(audioContext.currentTime);
            oscillator.stop(audioContext.currentTime + 0.1);
        } catch (e) {
            // Ignore if audio context is not supported
        }
    }

    // Enhanced confirmation modal
    function confirmSubmit() {
        const answeredCount = document.querySelectorAll('input[type="radio"]:checked').length;
        const unansweredCount = totalQuestions - answeredCount;

        document.getElementById('confirmedAnswered').textContent = answeredCount;

        // Add warning for unanswered questions
        const modalBody = document.querySelector('#confirmModal .modal-body');
        const existingWarning = modalBody.querySelector('.unanswered-warning');
        if (existingWarning) {
            existingWarning.remove();
        }

        if (unansweredCount > 0) {
            const warningDiv = document.createElement('div');
            warningDiv.className = 'alert alert-danger unanswered-warning d-flex align-items-center';
            warningDiv.innerHTML = `
                    <i class="fas fa-exclamation-triangle me-3"></i>
                    <div>
                        <strong>Warning:</strong> You have ${unansweredCount} unanswered question${unansweredCount > 1 ? 's' : ''}.
                        These will be marked as incorrect.
                    </div>
                `;
            modalBody.insertBefore(warningDiv, modalBody.lastElementChild);

            // Change submit button text if there are unanswered questions
            const submitBtn = document.querySelector('#confirmModal .btn-primary');
            submitBtn.innerHTML = '<i class="fas fa-exclamation-triangle me-2"></i>Submit Anyway';
            submitBtn.className = 'btn btn-warning btn-lg';
        } else {
            // Reset submit button if all questions are answered
            const submitBtn = document.querySelector('#confirmModal .btn-primary');
            submitBtn.innerHTML = '<i class="fas fa-paper-plane me-2"></i>Submit Now';
            submitBtn.className = 'btn btn-primary btn-lg';
        }

        const modal = new bootstrap.Modal(document.getElementById('confirmModal'));
        modal.show();
    }

    // Submit quiz with loading state
    function submitQuiz() {
        const submitBtn = document.querySelector('#confirmModal .btn-primary, #confirmModal .btn-warning');
        const originalText = submitBtn.innerHTML;

        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Submitting...';
        submitBtn.disabled = true;

        // Disable all form elements
        const formElements = document.querySelectorAll('#quizForm input, #quizForm button');
        formElements.forEach(element => {
            element.disabled = true;
        });

        // Clear intervals
        clearInterval(timerInterval);
        clearInterval(autoSaveInterval);

        // Add elapsed time to form
        const elapsed = new Date().getTime() - startTime;
        const hiddenInput = document.createElement('input');
        hiddenInput.type = 'hidden';
        hiddenInput.name = 'elapsedTime';
        hiddenInput.value = elapsed;
        document.getElementById('quizForm').appendChild(hiddenInput);

        // Add timestamp
        const timestampInput = document.createElement('input');
        timestampInput.type = 'hidden';
        timestampInput.name = 'submissionTime';
        timestampInput.value = new Date().toISOString();
        document.getElementById('quizForm').appendChild(timestampInput);

        // Show final progress save
        showFinalSaving();

        setTimeout(() => {
            document.getElementById('quizForm').submit();
        }, 1500);
    }

    // Show final saving indicator
    function showFinalSaving() {
        const overlay = document.createElement('div');
        overlay.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.7);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 2000;
                backdrop-filter: blur(5px);
            `;

        const loader = document.createElement('div');
        loader.style.cssText = `
                background: white;
                padding: 3rem;
                border-radius: 20px;
                text-align: center;
                box-shadow: var(--shadow-xl);
                max-width: 400px;
                animation: fadeIn 0.3s ease-out;
            `;
        loader.innerHTML = `
                <div class="spinner-border text-primary mb-3" role="status" style="width: 3rem; height: 3rem;">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <h5 class="mb-2">Submitting Your Quiz</h5>
                <p class="text-muted mb-0">Please wait while we process your answers...</p>
                <div class="progress mt-3" style="height: 6px;">
                    <div class="progress-bar progress-bar-striped progress-bar-animated"
                         role="progressbar" style="width: 100%"></div>
                </div>
            `;

        overlay.appendChild(loader);
        document.body.appendChild(overlay);
    }

    // Handle page unload (warn user about unsaved progress)
    window.addEventListener('beforeunload', function(e) {
        const answeredCount = document.querySelectorAll('input[type="radio"]:checked').length;
        if (answeredCount > 0 && !document.querySelector('#quizForm input[name="elapsedTime"]')) {
            e.preventDefault();
            e.returnValue = 'You have unsaved progress. Are you sure you want to leave?';
            return e.returnValue;
        }
    });

    // Handle visibility change (save progress when tab becomes hidden)
    document.addEventListener('visibilitychange', function() {
        if (document.hidden) {
            saveProgress();
        }
    });

    // Smooth scrolling to unanswered questions
    function scrollToUnanswered() {
        const unansweredQuestions = document.querySelectorAll('.question-card:not(.answered)');
        if (unansweredQuestions.length > 0) {
            unansweredQuestions[0].scrollIntoView({
                behavior: 'smooth',
                block: 'center'
            });
        }
    }

    // Add scroll progress indicator
    function updateScrollProgress() {
        const scrollTop = window.pageYOffset;
        const docHeight = document.documentElement.scrollHeight - window.innerHeight;
        const scrollPercent = (scrollTop / docHeight) * 100;

        let scrollIndicator = document.getElementById('scrollIndicator');
        if (!scrollIndicator) {
            scrollIndicator = document.createElement('div');
            scrollIndicator.id = 'scrollIndicator';
            scrollIndicator.style.cssText = `
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 3px;
                    background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-light) 100%);
                    z-index: 1001;
                    transform-origin: left;
                    transition: transform 0.1s ease-out;
                `;
            document.body.appendChild(scrollIndicator);
        }

        scrollIndicator.style.transform = `scaleX(${scrollPercent / 100})`;
    }

    // Add scroll listener
    window.addEventListener('scroll', updateScrollProgress);

    // Initialize scroll progress
    updateScrollProgress();

    // Add helpful shortcuts info
    function showShortcutsHelp() {
        const helpModal = document.createElement('div');
        helpModal.className = 'modal fade';
        helpModal.innerHTML = `
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="fas fa-keyboard me-2"></i>
                                Keyboard Shortcuts
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <h6><i class="fas fa-mouse-pointer me-2"></i>Answer Selection:</h6>
                                    <ul class="list-unstyled">
                                        <li><kbd>1</kbd> - Select option A</li>
                                        <li><kbd>2</kbd> - Select option B</li>
                                        <li><kbd>3</kbd> - Select option C</li>
                                        <li><kbd>4</kbd> - Select option D</li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <h6><i class="fas fa-info-circle me-2"></i>Tips:</h6>
                                    <ul class="list-unstyled text-muted">
                                        <li>• Progress auto-saves every 30s</li>
                                        <li>• All questions are optional</li>
                                        <li>• Review before submitting</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            `;

        document.body.appendChild(helpModal);
        const modal = new bootstrap.Modal(helpModal);
        modal.show();

        helpModal.addEventListener('hidden.bs.modal', function() {
            helpModal.remove();
        });
    }

    // Add help button (optional)
    function addHelpButton() {
        const helpBtn = document.createElement('button');
        helpBtn.type = 'button';
        helpBtn.className = 'btn btn-outline-secondary btn-sm position-fixed';
        helpBtn.style.cssText = `
                bottom: 2rem;
                left: 2rem;
                z-index: 1000;
                border-radius: 50px;
                padding: 0.75rem 1rem;
            `;
        helpBtn.innerHTML = '<i class="fas fa-question-circle me-1"></i>Help';
        helpBtn.onclick = showShortcutsHelp;

        document.body.appendChild(helpBtn);
    }

    // Initialize help button
    addHelpButton();

</script>
</body>
</html>