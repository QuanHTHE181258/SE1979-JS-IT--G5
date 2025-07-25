<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Quiz - ${quiz.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4f46e5;
            --primary-light: #818cf8;
            --success-color: #10b981;
            --success-light: #d1fae5;
            --danger-color: #ef4444;
            --danger-light: #fee2e2;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-500: #6b7280;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
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

        .review-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem 1rem;
        }

        .back-button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-bottom: 2rem;
        }

        .back-button:hover {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            transform: translateY(-1px);
            box-shadow: var(--shadow-lg);
        }

        .quiz-header {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-xl);
            border: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
        }

        .quiz-header h2 {
            color: var(--gray-800);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .quiz-header .subtitle {
            color: var(--gray-500);
            font-size: 1.1rem;
            font-weight: 500;
        }

        .score-summary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            color: white;
            padding: 2.5rem;
            border-radius: 20px;
            margin-bottom: 2rem;
            text-align: center;
            box-shadow: var(--shadow-xl);
            position: relative;
            overflow: hidden;
        }

        .score-summary::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.05"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            pointer-events: none;
        }

        .score-summary h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
            opacity: 0.9;
        }

        .score-summary .score-number {
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .completion-time {
            font-size: 1rem;
            opacity: 0.8;
            font-weight: 500;
        }

        .question-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--gray-200);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .question-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-xl);
        }

        .question-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--gray-100);
        }

        .question-header h5 {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--gray-800);
            margin: 0;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-badge.correct {
            background: var(--success-light);
            color: var(--success-color);
        }

        .status-badge.incorrect {
            background: var(--danger-light);
            color: var(--danger-color);
        }

        .question-text {
            font-size: 1.125rem;
            color: var(--gray-700);
            margin-bottom: 2rem;
            line-height: 1.7;
            font-weight: 500;
        }

        .answer-option {
            padding: 1.25rem;
            margin: 0.75rem 0;
            border-radius: 12px;
            border: 2px solid var(--gray-200);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all 0.3s ease;
            position: relative;
            background: var(--gray-50);
        }

        .answer-option:hover {
            transform: translateX(4px);
        }

        .answer-option.correct-answer {
            background: linear-gradient(135deg, var(--success-light) 0%, #f0fdf4 100%);
            border-color: var(--success-color);
            box-shadow: 0 4px 6px rgba(16, 185, 129, 0.1);
        }

        .answer-option.incorrect-answer {
            background: linear-gradient(135deg, var(--danger-light) 0%, #fef2f2 100%);
            border-color: var(--danger-color);
            box-shadow: 0 4px 6px rgba(239, 68, 68, 0.1);
        }

        .answer-option.selected-answer {
            border-width: 3px;
            transform: translateX(4px);
        }

        .answer-icon {
            width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            color: white;
            font-size: 0.875rem;
            font-weight: 600;
            flex-shrink: 0;
        }

        .answer-icon.correct {
            background: linear-gradient(135deg, var(--success-color) 0%, #059669 100%);
            box-shadow: 0 4px 6px rgba(16, 185, 129, 0.3);
        }

        .answer-icon.incorrect {
            background: linear-gradient(135deg, var(--danger-color) 0%, #dc2626 100%);
            box-shadow: 0 4px 6px rgba(239, 68, 68, 0.3);
        }

        .answer-icon.neutral {
            background: linear-gradient(135deg, var(--gray-500) 0%, var(--gray-600) 100%);
        }

        .answer-text {
            font-size: 1rem;
            color: var(--gray-700);
            font-weight: 500;
            flex: 1;
        }

        .answer-badge {
            padding: 0.375rem 0.75rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .answer-badge.your-answer {
            background: var(--gray-200);
            color: var(--gray-600);
        }

        .answer-badge.correct-answer {
            background: var(--success-color);
            color: white;
        }

        .action-buttons {
            text-align: center;
            margin: 3rem 0;
        }

        .btn-modern {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            font-size: 1rem;
            margin: 0 0.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
            color: white;
            box-shadow: 0 4px 6px rgba(79, 70, 229, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(79, 70, 229, 0.4);
            color: white;
        }

        .btn-outline {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .btn-outline:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            color: white;
        }

        .progress-indicator {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gray-200);
            z-index: 1000;
        }

        .progress-bar {
            height: 100%;
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--primary-light) 100%);
            transition: width 0.3s ease;
        }

        @media (max-width: 768px) {
            .review-container {
                padding: 1rem;
            }

            .quiz-header,
            .score-summary,
            .question-card {
                padding: 1.5rem;
            }

            .score-summary .score-number {
                font-size: 3rem;
            }

            .answer-option {
                padding: 1rem;
            }

            .btn-modern {
                padding: 0.875rem 1.5rem;
                margin: 0.25rem;
                display: block;
                width: 100%;
                max-width: 300px;
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
    </style>
</head>
<body>
<div class="progress-indicator">
    <div class="progress-bar" style="width: 100%;"></div>
</div>

<div class="review-container">
    <!-- Back button -->
    <a href="javascript:history.back()" class="back-button">
        <i class="fas fa-arrow-left"></i>
        <span>Back to Results</span>
    </a>

    <!-- Quiz Header -->
    <div class="quiz-header fade-in">
        <h2>${quiz.title}</h2>
        <p class="subtitle">Review Mode - Detailed Analysis</p>
    </div>

    <!-- Score Summary -->
    <div class="score-summary fade-in">
        <h3>Your Final Score</h3>
        <div class="score-number">
            <fmt:formatNumber value="${attempt.score}" pattern="#,##0.0"/>%
        </div>
        <div class="completion-time">
            <i class="fas fa-clock me-2"></i>
            Completed in <fmt:formatNumber value="${completionTimeMinutes}" maxFractionDigits="1"/> minutes
        </div>
    </div>

    <!-- Questions Review -->
    <c:forEach var="qa" items="${questionAttempts}" varStatus="status">
        <div class="question-card fade-in" style="animation-delay: ${status.index * 0.1}s;">
            <div class="question-header">
                <h5>Question ${status.index + 1}</h5>
                <span class="status-badge ${qa.isCorrect ? 'correct' : 'incorrect'}">
                        <i class="fas ${qa.isCorrect ? 'fa-check' : 'fa-times'} me-1"></i>
                        ${qa.isCorrect ? 'Correct' : 'Incorrect'}
                    </span>
            </div>

            <div class="question-text">${qa.questionID.questionText}</div>

            <div class="answers">
                <c:forEach var="answer" items="${qa.questionID.answers}">
                    <div class="answer-option
                                ${answer.isCorrect ? 'correct-answer' : ''}
                                ${answer.id == qa.answer.id ? 'selected-answer' : ''}
                                ${!answer.isCorrect && answer.id == qa.answer.id ? 'incorrect-answer' : ''}">

                        <c:choose>
                            <c:when test="${answer.id == qa.answer.id && answer.isCorrect}">
                                <div class="answer-icon correct">
                                    <i class="fas fa-check"></i>
                                </div>
                            </c:when>
                            <c:when test="${answer.id == qa.answer.id && !answer.isCorrect}">
                                <div class="answer-icon incorrect">
                                    <i class="fas fa-times"></i>
                                </div>
                            </c:when>
                            <c:when test="${answer.isCorrect}">
                                <div class="answer-icon correct">
                                    <i class="fas fa-check"></i>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="answer-icon neutral">
                                    <i class="fas fa-circle" style="font-size: 0.5rem;"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <span class="answer-text">${answer.answerText}</span>

                        <div class="ms-auto d-flex gap-2">
                            <c:if test="${answer.id == qa.answer.id}">
                                <span class="answer-badge your-answer">Your answer</span>
                            </c:if>
                            <c:if test="${answer.isCorrect}">
                                <span class="answer-badge correct-answer">Correct</span>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:forEach>

    <!-- Action Buttons -->
    <div class="action-buttons fade-in">
        <a href="learning?lessonId=${lessonId}" class="btn-modern btn-primary">
            <i class="fas fa-graduation-cap"></i>
            <span>Continue Learning</span>
        </a>
        <a href="take-quiz?action=start&lessonId=${lessonId}" class="btn-modern btn-outline">
            <i class="fas fa-redo"></i>
            <span>Retake Quiz</span>
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add smooth scrolling and enhanced interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Animate elements on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Observe question cards
        document.querySelectorAll('.question-card').forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(card);
        });

        // Add hover effects to answer options
        document.querySelectorAll('.answer-option').forEach(option => {
            option.addEventListener('mouseenter', function() {
                this.style.transform = 'translateX(8px)';
            });

            option.addEventListener('mouseleave', function() {
                if (!this.classList.contains('selected-answer')) {
                    this.style.transform = 'translateX(0)';
                } else {
                    this.style.transform = 'translateX(4px)';
                }
            });
        });

        // Smooth scroll for back button
        document.querySelector('.back-button').addEventListener('click', function(e) {
            if (this.getAttribute('href') == 'javascript:history.back()') {
                e.preventDefault();
                window.history.back();
            }
        });
    });
</script>
</body>
</html>