<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Result - ${quiz.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --success: #10b981;
            --success-dark: #059669;
            --warning: #f59e0b;
            --warning-dark: #d97706;
            --danger: #ef4444;
            --danger-dark: #dc2626;
            --info: #3b82f6;
            --info-dark: #2563eb;
            --dark: #1f2937;
            --light: #f8fafc;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-success: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            --gradient-warning: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --gradient-danger: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
            --gradient-glass: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0.05) 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #1f2937;
            overflow-x: hidden;
            position: relative;
        }

        /* Animated Background */
        .animated-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .animated-bg::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.03'%3E%3Ccircle cx='30' cy='30' r='2'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            animation: bgFloat 20s ease-in-out infinite;
        }

        @keyframes bgFloat {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(30px, -30px) rotate(120deg); }
            66% { transform: translate(-20px, 20px) rotate(240deg); }
        }

        /* Floating particles */
        .particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .particle:nth-child(1) { top: 20%; left: 20%; animation-delay: 0s; }
        .particle:nth-child(2) { top: 40%; left: 80%; animation-delay: 2s; }
        .particle:nth-child(3) { top: 80%; left: 40%; animation-delay: 4s; }
        .particle:nth-child(4) { top: 60%; left: 10%; animation-delay: 1s; }
        .particle:nth-child(5) { top: 10%; left: 60%; animation-delay: 3s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.6; }
            50% { transform: translateY(-20px) rotate(180deg); opacity: 1; }
        }

        .container-custom {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1rem;
            position: relative;
            z-index: 1;
        }

        /* Glass morphism card */
        .glass-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: var(--shadow-xl);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .glass-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 32px 64px -12px rgba(0, 0, 0, 0.25);
        }

        /* Header Section */
        .result-header {
            text-align: center;
            padding: 3rem 2rem;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .result-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--gradient-glass);
            z-index: -1;
        }

        .result-title {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #fff, #e2e8f0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .quiz-title {
            font-size: 1.5rem;
            font-weight: 600;
            opacity: 0.9;
            margin-bottom: 2rem;
        }

        /* Advanced Score Circle */
        .score-circle {
            width: 200px;
            height: 200px;
            margin: 2rem auto;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .score-svg {
            position: absolute;
            width: 100%;
            height: 100%;
            transform: rotate(-90deg);
        }

        .score-circle-bg {
            fill: none;
            stroke: rgba(255, 255, 255, 0.2);
            stroke-width: 8;
        }

        .score-circle-progress {
            fill: none;
            stroke-width: 8;
            stroke-linecap: round;
            stroke-dasharray: 565.48;
            stroke-dashoffset: 565.48;
            transition: stroke-dashoffset 2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .score-text {
            font-size: 3rem;
            font-weight: 800;
            color: white;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            z-index: 10;
        }

        .score-label {
            position: absolute;
            bottom: -40px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 1.1rem;
            font-weight: 600;
            color: rgba(255, 255, 255, 0.9);
        }

        /* Performance Badge */
        .performance-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            margin-top: 1rem;
            animation: bounceIn 1s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            box-shadow: var(--shadow-lg);
        }

        /* Statistics Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .stat-card:hover::before {
            transform: scaleX(1);
        }

        .stat-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: white;
            opacity: 0.9;
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 800;
            color: white;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .stat-label {
            font-size: 1rem;
            font-weight: 600;
            color: rgba(255, 255, 255, 0.8);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Content Cards */
        .content-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            box-shadow: var(--shadow-xl);
            margin-bottom: 2rem;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .card-header {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0.05));
            padding: 1.5rem 2rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        /* Question Items */
        .question-item {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all 0.2s ease;
        }

        .question-item:hover {
            background: rgba(0, 0, 0, 0.02);
            transform: translateX(4px);
        }

        .question-item:last-child {
            border-bottom: none;
        }

        .question-number {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: white;
            font-size: 1.1rem;
            box-shadow: var(--shadow-sm);
        }

        .question-content {
            flex: 1;
        }

        .question-title {
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .question-text {
            color: #6b7280;
            line-height: 1.5;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Action Buttons */
        .action-section {
            text-align: center;
            padding: 3rem 2rem;
        }

        .btn-modern {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            margin: 0.5rem;
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .btn-modern::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-modern:hover::before {
            left: 100%;
        }

        .btn-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: white;
        }

        .btn-success {
            background: var(--gradient-success);
            color: white;
        }

        .btn-warning {
            background: var(--gradient-warning);
            color: white;
        }

        /* Motivational Message */
        .motivational-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeInUp 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .motivational-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            animation: bounce 2s infinite;
        }

        .motivational-text {
            font-size: 1.2rem;
            font-weight: 600;
            line-height: 1.6;
        }

        /* Animations */
        @keyframes bounceIn {
            0% { opacity: 0; transform: scale(0.3); }
            50% { opacity: 1; transform: scale(1.05); }
            100% { opacity: 1; transform: scale(1); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes bounce {
            0%, 20%, 53%, 80%, 100% { transform: translateY(0); }
            40%, 43% { transform: translateY(-20px); }
            70% { transform: translateY(-10px); }
            90% { transform: translateY(-4px); }
        }

        /* Confetti Styles */
        .confetti-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 9999;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container-custom {
                padding: 1rem;
            }

            .result-title {
                font-size: 2rem;
            }

            .score-circle {
                width: 150px;
                height: 150px;
            }

            .score-text {
                font-size: 2rem;
            }

            .stats-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .btn-modern {
                display: block;
                width: 100%;
                margin: 0.5rem 0;
            }

            .question-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }
        }

        /* Color variants for scores */
        .score-excellent { --color: var(--success); }
        .score-good { --color: var(--info); }
        .score-average { --color: var(--warning); }
        .score-poor { --color: var(--danger); }

        .bg-excellent { background: var(--gradient-success); }
        .bg-good { background: linear-gradient(135deg, var(--info), var(--info-dark)); }
        .bg-average { background: linear-gradient(135deg, var(--warning), var(--warning-dark)); }
        .bg-poor { background: linear-gradient(135deg, var(--danger), var(--danger-dark)); }

        .text-excellent { color: var(--success); }
        .text-good { color: var(--info); }
        .text-average { color: var(--warning); }
        .text-poor { color: var(--danger); }

        /* Loading animation for score circle */
        .loading-animation {
            animation: spin 2s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(-90deg); }
            to { transform: rotate(270deg); }
        }
    </style>
</head>
<body>
<!-- Animated Background -->
<div class="animated-bg">
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
</div>

<div class="container-custom">
    <!-- Result Header -->
    <div class="glass-card result-header">
        <div class="result-title animate__animated animate__fadeInDown">
            <i class="fas fa-trophy me-3"></i>Quiz Complete!
        </div>
        <div class="quiz-title">${quiz.title}</div>

        <!-- Advanced Score Circle -->
        <div class="score-circle">
            <svg class="score-svg" viewBox="0 0 200 200">
                <circle class="score-circle-bg" cx="100" cy="100" r="90"></circle>
                <circle class="score-circle-progress" cx="100" cy="100" r="90"
                        id="progress-circle"
                        stroke="${attempt.score >= 90 ? '#10b981' : attempt.score >= 70 ? '#3b82f6' : attempt.score >= 50 ? '#f59e0b' : '#ef4444'}">
                </circle>
            </svg>
            <div class="score-text" id="score-counter">0%</div>
            <div class="score-label">Your Score</div>
        </div>

        <!-- Performance Badge -->
        <div class="performance-badge ${attempt.score >= 90 ? 'bg-excellent' : attempt.score >= 70 ? 'bg-good' : attempt.score >= 50 ? 'bg-average' : 'bg-poor'}">
            <c:choose>
                <c:when test="${attempt.score >= 90}">
                    <i class="fas fa-crown"></i>Excellent Performance!
                </c:when>
                <c:when test="${attempt.score >= 70}">
                    <i class="fas fa-star"></i>Great Job!
                </c:when>
                <c:when test="${attempt.score >= 50}">
                    <i class="fas fa-thumbs-up"></i>Good Effort!
                </c:when>
                <c:otherwise>
                    <i class="fas fa-heart"></i>Keep Trying!
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Statistics Grid -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon text-success">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-value" data-target="${correctCount}">0</div>
            <div class="stat-label">Correct Answers</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon text-danger">
                <i class="fas fa-times-circle"></i>
            </div>
            <div class="stat-value" data-target="${questionAttempts.size() - correctCount}">0</div>
            <div class="stat-label">Incorrect Answers</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon text-info">
                <i class="fas fa-question-circle"></i>
            </div>
            <div class="stat-value" data-target="${questionAttempts.size()}">0</div>
            <div class="stat-label">Total Questions</div>
        </div>

        <div class="stat-card">
            <div class="stat-icon text-warning">
                <i class="fas fa-clock"></i>
            </div>
            <div class="stat-value" data-target="${completionTimeMinutes}">0</div>
            <div class="stat-label">Minutes Taken</div>
        </div>
    </div>

    <!-- Time Analysis Card -->
    <div class="content-card">
        <div class="card-header">
            <h5 class="card-title">
                <i class="fas fa-chart-line"></i>
                Performance Analysis
            </h5>
        </div>
        <div class="p-4">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="text-center p-3 rounded-3" style="background: rgba(16, 185, 129, 0.1);">
                        <div class="h4 text-success mb-1">
                            <fmt:formatNumber value="${(correctCount * 100.0) / questionAttempts.size()}" maxFractionDigits="1"/>%
                        </div>
                        <div class="text-muted">Accuracy Rate</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center p-3 rounded-3" style="background: rgba(59, 130, 246, 0.1);">
                        <div class="h4 text-info mb-1">
                            <fmt:formatNumber value="${completionTimeMinutes * 60 / questionAttempts.size()}" maxFractionDigits="0"/>s
                        </div>
                        <div class="text-muted">Avg. per Question</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center p-3 rounded-3" style="background: rgba(245, 158, 11, 0.1);">
                        <div class="h4 text-warning mb-1">
                            <c:choose>
                                <c:when test="${completionTimeMinutes <= 5}">Fast</c:when>
                                <c:when test="${completionTimeMinutes <= 10}">Normal</c:when>
                                <c:otherwise>Careful</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="text-muted">Quiz Speed</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Questions Review -->
    <div class="content-card">
        <div class="card-header">
            <h5 class="card-title">
                <i class="fas fa-list-check"></i>
                Question Review
                <span class="badge bg-secondary ms-2">${questionAttempts.size()} questions</span>
            </h5>
        </div>
        <div>
            <c:forEach var="qa" items="${questionAttempts}" varStatus="status">
                <div class="question-item">
                    <div class="question-number ${qa.isCorrect ? 'bg-success' : 'bg-danger'}">
                            ${status.index + 1}
                    </div>
                    <div class="question-content">
                        <div class="question-title">Question ${status.index + 1}</div>
                        <div class="question-text">${qa.questionID.questionText}</div>
                    </div>
                    <div class="status-badge ${qa.isCorrect ? 'bg-success' : 'bg-danger'} text-white">
                        <i class="fas fa-${qa.isCorrect ? 'check' : 'times'}"></i>
                            ${qa.isCorrect ? 'Correct' : 'Incorrect'}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="glass-card action-section">
        <div class="mb-4">
            <i class="fas fa-lightbulb text-warning me-2"></i>
            <strong>What's next?</strong> Choose your next step to continue your learning journey
        </div>

        <div class="d-flex flex-wrap justify-content-center">
            <a href="take-quiz?action=review&attemptId=${attempt.id}" class="btn-modern btn-primary">
                <i class="fas fa-search"></i>Review Answers
            </a>

            <a href="take-quiz?action=start&lessonId=${lessonId}" class="btn-modern btn-warning">
                <i class="fas fa-redo"></i>Retake Quiz
            </a>

            <a href="learning?lessonId=${lessonId}" class="btn-modern btn-success">
                <i class="fas fa-graduation-cap"></i>Continue Learning
            </a>
        </div>
    </div>

    <!-- Motivational Message -->
    <div class="motivational-card">
        <div class="motivational-icon">
            <c:choose>
                <c:when test="${attempt.score >= 90}">🏆</c:when>
                <c:when test="${attempt.score >= 70}">⭐</c:when>
                <c:when test="${attempt.score >= 50}">👍</c:when>
                <c:otherwise>💪</c:otherwise>
            </c:choose>
        </div>
        <div class="motivational-text">
            <c:choose>
                <c:when test="${attempt.score >= 90}">
                    <strong>Outstanding!</strong> You've mastered this topic with flying colors! Your dedication to learning is truly inspiring.
                </c:when>
                <c:when test="${attempt.score >= 70}">
                    <strong>Well done!</strong> You have a solid understanding of the material. Keep up the excellent work!
                </c:when>
                <c:when test="${attempt.score >= 50}">
                    <strong>Good progress!</strong> You're on the right track. A little more practice and you'll excel at this!
                </c:when>
                <c:otherwise>
                    <strong>Every expert was once a beginner!</strong> Don't get discouraged. Review the material and try again - you've got this!
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Confetti Container -->
<c:if test="${attempt.score >= 90}">
    <div class="confetti-container" id="confetti"></div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Animate score circle
        animateScoreCircle();

        // Animate counters
        animateCounters();

        // Initialize confetti for excellent scores
        <c:if test="${attempt.score >= 90}">
        initConfetti();
        </c:if>

        // Add scroll animations
        initScrollAnimations();
    });

    function animateScoreCircle() {
        const score = ${attempt.score};
        const circle = document.getElementById('progress-circle');
        const counter = document.getElementById('score-counter');

        // Calculate stroke-dashoffset based on score
        const circumference = 2 * Math.PI * 90; // radius = 90
        const offset = circumference - (score / 100) * circumference;

        // Animate the circle
        setTimeout(() => {
            circle.style.strokeDashoffset = offset;
        }, 500);

        // Animate the counter
        let currentScore = 0;
        const increment = score / 100;
        const timer = setInterval(() => {
            currentScore += increment;
            if (currentScore >= score) {
                currentScore = score;
                clearInterval(timer);
            }
            counter.textContent = Math.round(currentScore) + '%';
        }, 20);
    }

    function animateCounters() {
        const counters = document.querySelectorAll('.stat-value[data-target]');

        const observerOptions = {
            threshold: 0.5,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const counter = entry.target;
                    const target = parseInt(counter.getAttribute('data-target'));

                    let current = 0;
                    const increment = target / 60; // 60 frames for 1 second at 60fps

                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= target) {
                            current = target;
                            clearInterval(timer);
                        }
                        counter.textContent = Math.round(current);
                    }, 16); // ~60fps

                    observer.unobserve(counter);
                }
            });
        }, observerOptions);

        counters.forEach(counter => observer.observe(counter));
    }

    function initScrollAnimations() {
        const animatedElements = document.querySelectorAll('.stat-card, .content-card, .glass-card');

        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -100px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach((entry, index) => {
                if (entry.isIntersecting) {
                    setTimeout(() => {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }, index * 150);
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);

        animatedElements.forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(50px)';
            el.style.transition = 'all 0.8s cubic-bezier(0.4, 0, 0.2, 1)';
            observer.observe(el);
        });
    }

    // Confetti animation for excellent scores
    function initConfetti() {
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        const confettiContainer = document.getElementById('confetti');

        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
        confettiContainer.appendChild(canvas);

        const confettiPieces = [];
        const colors = [
            '#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4',
            '#FECA57', '#FF9FF3', '#54A0FF', '#5F27CD',
            '#00D2D3', '#FF9F43', '#FF6348', '#2ED573'
        ];

        // Create confetti pieces
        for (let i = 0; i < 150; i++) {
            confettiPieces.push({
                x: Math.random() * canvas.width,
                y: -10,
                vx: Math.random() * 6 - 3,
                vy: Math.random() * 3 + 2,
                color: colors[Math.floor(Math.random() * colors.length)],
                size: Math.random() * 8 + 4,
                rotation: Math.random() * 360,
                rotationSpeed: Math.random() * 10 - 5,
                gravity: 0.1,
                bounce: 0.7,
                opacity: 1,
                shape: Math.random() > 0.5 ? 'circle' : 'square'
            });
        }

        function drawConfetti() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            confettiPieces.forEach((piece, index) => {
                ctx.save();
                ctx.globalAlpha = piece.opacity;
                ctx.translate(piece.x + piece.size / 2, piece.y + piece.size / 2);
                ctx.rotate(piece.rotation * Math.PI / 180);

                // Create gradient
                const gradient = ctx.createRadialGradient(0, 0, 0, 0, 0, piece.size);
                gradient.addColorStop(0, piece.color);
                gradient.addColorStop(1, piece.color + '80');
                ctx.fillStyle = gradient;

                // Draw shape
                if (piece.shape == 'circle') {
                    ctx.beginPath();
                    ctx.arc(0, 0, piece.size / 2, 0, Math.PI * 2);
                    ctx.fill();
                } else {
                    ctx.fillRect(-piece.size / 2, -piece.size / 2, piece.size, piece.size);
                }

                ctx.restore();

                // Update physics
                piece.x += piece.vx;
                piece.y += piece.vy;
                piece.vy += piece.gravity;
                piece.rotation += piece.rotationSpeed;

                // Bounce off walls
                if (piece.x <= 0 || piece.x >= canvas.width) {
                    piece.vx *= -piece.bounce;
                    piece.x = Math.max(0, Math.min(canvas.width, piece.x));
                }

                // Remove pieces that are off screen
                if (piece.y > canvas.height + 100) {
                    piece.y = -10;
                    piece.x = Math.random() * canvas.width;
                    piece.vx = Math.random() * 6 - 3;
                    piece.vy = Math.random() * 3 + 2;
                    piece.opacity = 1;
                }

                // Fade out over time
                if (piece.y > canvas.height * 0.8) {
                    piece.opacity = Math.max(0, piece.opacity - 0.01);
                }
            });

            requestAnimationFrame(drawConfetti);
        }

        drawConfetti();

        // Stop confetti after 10 seconds
        setTimeout(() => {
            confettiPieces.forEach(piece => {
                piece.vy = Math.max(piece.vy, 5); // Make them fall faster
            });

            setTimeout(() => {
                canvas.style.opacity = '0';
                canvas.style.transition = 'opacity 2s ease';
                setTimeout(() => {
                    confettiContainer.removeChild(canvas);
                }, 2000);
            }, 5000);
        }, 10000);

        // Resize handler
        window.addEventListener('resize', () => {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
        });
    }

    // Add ripple effect to buttons
    document.querySelectorAll('.btn-modern').forEach(button => {
        button.addEventListener('click', function(e) {
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    left: ${x}px;
                    top: ${y}px;
                    background: rgba(255, 255, 255, 0.5);
                    border-radius: 50%;
                    transform: scale(0);
                    animation: ripple 0.6s linear;
                    pointer-events: none;
                `;

            this.appendChild(ripple);

            setTimeout(() => ripple.remove(), 600);
        });
    });

    // Add ripple animation to CSS
    const style = document.createElement('style');
    style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
            .btn-modern {
                position: relative;
                overflow: hidden;
            }
        `;
    document.head.appendChild(style);

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey || e.metaKey) {
            switch(e.key) {
                case 'r':
                    e.preventDefault();
                    window.location.href = 'take-quiz?action=review&attemptId=${attempt.id}';
                    break;
                case 'Enter':
                    e.preventDefault();
                    window.location.href = 'learning?lessonId=${lessonId}';
                    break;
                case 't':
                    e.preventDefault();
                    window.location.href = 'take-quiz?action=start&lessonId=${lessonId}';
                    break;
            }
        }
    });

    // Share result function
    function shareResult() {
        const score = Math.round(${attempt.score});
        const quizTitle = '${quiz.title}';
        const text = `I just completed the quiz "${quizTitle}" with a score of ${score}%! 🎉`;

        if (navigator.share) {
            navigator.share({
                title: 'Quiz Result',
                text: text,
                url: window.location.href
            }).catch(err => console.log('Error sharing:', err));
        } else if (navigator.clipboard) {
            navigator.clipboard.writeText(text + ' ' + window.location.href).then(() => {
                showNotification('Result copied to clipboard!', 'success');
            }).catch(() => {
                showNotification('Unable to copy result', 'error');
            });
        }
    }

    // Notification system
    function showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        const icon = type == 'success' ? 'check-circle' : type == 'error' ? 'exclamation-triangle' : 'info-circle';
        const bgColor = type == 'success' ? 'var(--success)' : type == 'error' ? 'var(--danger)' : 'var(--info)';

        notification.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                background: ${bgColor};
                color: white;
                padding: 1rem 1.5rem;
                border-radius: 12px;
                box-shadow: var(--shadow-xl);
                z-index: 10000;
                display: flex;
                align-items: center;
                gap: 0.5rem;
                font-weight: 600;
                animation: slideInRight 0.3s ease;
                max-width: 300px;
            `;

        notification.innerHTML = `
                <i class="fas fa-${icon}"></i>
                ${message}
                <button onclick="this.parentElement.remove()" style="
                    background: none;
                    border: none;
                    color: white;
                    margin-left: 1rem;
                    cursor: pointer;
                    font-size: 1.2rem;
                ">×</button>
            `;

        // Add slide animation
        const slideStyle = document.createElement('style');
        slideStyle.textContent = `
                @keyframes slideInRight {
                    from { transform: translateX(100%); opacity: 0; }
                    to { transform: translateX(0); opacity: 1; }
                }
            `;
        document.head.appendChild(slideStyle);

        document.body.appendChild(notification);

        // Auto remove after 4 seconds
        setTimeout(() => {
            if (notification.parentElement) {
                notification.style.animation = 'slideInRight 0.3s ease reverse';
                setTimeout(() => notification.remove(), 300);
            }
        }, 4000);
    }

    // Performance analytics (optional)
    function trackQuizCompletion() {
        if (typeof gtag !== 'undefined') {
            gtag('event', 'quiz_completed', {
                'quiz_id': '${quiz.id}',
                'score': ${attempt.score},
                'completion_time': ${completionTimeMinutes},
                'total_questions': ${questionAttempts.size()},
                'correct_answers': ${correctCount}
            });
        }
    }

    // Initialize tracking
    trackQuizCompletion();

    // Add parallax effect to floating particles
    document.addEventListener('mousemove', function(e) {
        const particles = document.querySelectorAll('.particle');
        const mouseX = e.clientX / window.innerWidth;
        const mouseY = e.clientY / window.innerHeight;

        particles.forEach((particle, index) => {
            const speed = (index + 1) * 0.5;
            const x = (mouseX - 0.5) * speed * 50;
            const y = (mouseY - 0.5) * speed * 50;

            particle.style.transform = `translate(${x}px, ${y}px)`;
        });
    });

    // Add touch support for mobile devices
    if ('ontouchstart' in window) {
        document.querySelectorAll('.stat-card, .glass-card').forEach(card => {
            card.addEventListener('touchstart', function() {
                this.style.transform = 'translateY(-8px) scale(1.02)';
            });

            card.addEventListener('touchend', function() {
                this.style.transform = '';
            });
        });
    }

    // Preload animations
    const animationStyle = document.createElement('style');
    animationStyle.textContent = `
            @keyframes pulse {
                0%, 100% { transform: scale(1); }
                50% { transform: scale(1.05); }
            }

            @keyframes glow {
                0%, 100% { box-shadow: 0 0 20px rgba(99, 102, 241, 0.3); }
                50% { box-shadow: 0 0 40px rgba(99, 102, 241, 0.6); }
            }

            .score-circle {
                animation: pulse 3s ease-in-out infinite;
            }

            .performance-badge {
                animation: glow 2s ease-in-out infinite;
            }
        `;
    document.head.appendChild(animationStyle);
</script>
</body>
</html>

