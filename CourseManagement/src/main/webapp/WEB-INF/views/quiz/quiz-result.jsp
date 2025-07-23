<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Result - ${quiz.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #404040 0%, #2d2d2d 100%);
            --success-gradient: linear-gradient(135deg, #2d2d2d, #404040);
            --info-gradient: linear-gradient(135deg, #333333, #4d4d4d);
            --warning-gradient: linear-gradient(135deg, #404040, #333333);
            --danger-gradient: linear-gradient(135deg, #333333, #404040);
            --shadow: 0 5px 15px rgba(0,0,0,0.1);
            --shadow-hover: 0 8px 25px rgba(0,0,0,0.15);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(120deg, #ffffff 0%, #f8f9fa 100%);
            min-height: 100vh;
            color: #4a4a4a;
        }

        .result-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        .result-header {
            background: var(--primary-gradient);
            color: white;
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
        }

        .result-header h1 {
            color: white;
            font-weight: 600;
            letter-spacing: 0.5px;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.2);
        }

        .result-header h3 {
            color: rgba(255,255,255,0.9);
            font-weight: 500;
        }

        .score-circle {
            width: 160px;
            height: 160px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 30px auto;
            font-size: 38px;
            font-weight: bold;
            position: relative;
            box-shadow: var(--shadow);
            animation: pulse 2s infinite;
            border: 4px solid rgba(255,255,255,0.2);
            color: white;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .score-excellent {
            background: linear-gradient(135deg, #2d2d2d 0%, #404040 100%);
        }
        .score-good {
            background: linear-gradient(135deg, #333333 0%, #4d4d4d 100%);
        }
        .score-average {
            background: linear-gradient(135deg, #404040 0%, #595959 100%);
        }
        .score-poor {
            background: linear-gradient(135deg, #4d4d4d 0%, #666666 100%);
        }

        .stats-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow);
            padding: 30px;
            margin-bottom: 25px;
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .stat-item {
            text-align: center;
            padding: 20px;
            border-radius: 15px;
            transition: all 0.3s ease;
        }

        .stat-item:hover {
            background: #f8f9fa;
            transform: scale(1.05);
        }

        .stat-icon {
            font-size: 32px;
            margin-bottom: 15px;
            display: block;
        }

        .stat-value {
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 8px;
            display: block;
        }

        .stat-label {
            color: #6c757d;
            font-size: 16px;
            font-weight: 500;
        }

        .question-summary {
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 25px;
        }

        .question-summary-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 20px 25px;
            border-bottom: 2px solid #dee2e6;
        }

        .question-item {
            padding: 25px;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            align-items: center;
            transition: all 0.2s ease;
        }

        .question-item:hover {
            background: #f8f9fa;
        }

        .question-item:last-child {
            border-bottom: none;
        }

        .question-number {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 20px;
            flex-shrink: 0;
            font-size: 18px;
        }

        .correct {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            border: 2px solid rgba(21, 87, 36, 0.2);
        }

        .incorrect {
            background: linear-gradient(135deg, #f8d7da, #f1b0b7);
            color: #721c24;
            border: 2px solid rgba(114, 28, 36, 0.2);
        }

        .question-content {
            flex-grow: 1;
        }

        .question-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        .question-text {
            color: #666;
            margin-bottom: 0;
            line-height: 1.5;
        }

        .action-buttons {
            background: white;
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            box-shadow: var(--shadow);
            margin-top: 30px;
        }

        .btn-custom {
            padding: 15px 40px;
            margin: 0 15px 15px 0;
            border-radius: 50px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            border: none;
            text-decoration: none;
            display: inline-block;
            position: relative;
            overflow: hidden;
        }

        .btn-custom::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-custom:hover::before {
            left: 100%;
        }

        .btn-review {
            background: var(--primary-gradient);
            color: white;
        }

        .btn-review:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .btn-continue {
            background: var(--success-gradient);
            color: white;
        }

        .btn-continue:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(76, 175, 80, 0.4);
            color: white;
        }

        .btn-retake {
            background: var(--warning-gradient);
            color: white;
        }

        .btn-retake:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(255, 152, 0, 0.4);
            color: white;
        }

        .btn-share {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            color: white;
        }

        .btn-share:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.4);
            color: white;
        }

        .performance-badge {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 16px;
            margin-top: 15px;
            animation: bounceIn 1s;
        }

        .badge-excellent {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            border: 2px solid rgba(21, 87, 36, 0.3);
        }
        .badge-good {
            background: linear-gradient(135deg, #cce5ff, #b3d9ff);
            color: #004085;
            border: 2px solid rgba(0, 64, 133, 0.3);
        }
        .badge-average {
            background: linear-gradient(135deg, #fff3cd, #ffecb5);
            color: #856404;
            border: 2px solid rgba(133, 100, 4, 0.3);
        }
        .badge-poor {
            background: linear-gradient(135deg, #f8d7da, #f1b0b7);
            color: #721c24;
            border: 2px solid rgba(114, 28, 36, 0.3);
        }

        .confetti {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 9999;
        }

        .progress-bar-wrapper {
            background: rgba(255,255,255,0.2);
            border-radius: 50px;
            height: 10px;
            margin: 20px 0;
            overflow: hidden;
        }

        .progress-bar-fill {
            height: 100%;
            border-radius: 50px;
            transition: width 2s ease-in-out;
        }

        .motivational-message {
            margin-top: 25px;
            border-radius: 20px;
            border: none;
            padding: 20px;
            font-size: 16px;
            font-weight: 500;
        }

        .alert-excellent {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            color: #155724;
            border: 2px solid rgba(21, 87, 36, 0.2);
        }

        .alert-good {
            background: linear-gradient(135deg, #cce5ff, #b3d9ff);
            color: #004085;
            border: 2px solid rgba(0, 64, 133, 0.2);
        }

        .alert-average {
            background: linear-gradient(135deg, #fff3cd, #ffecb5);
            color: #856404;
            border: 2px solid rgba(133, 100, 4, 0.2);
        }

        .alert-poor {
            background: linear-gradient(135deg, #f8d7da, #f1b0b7);
            color: #721c24;
            border: 2px solid rgba(114, 28, 36, 0.2);
        }

        .time-analysis {
            background: white;
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: var(--shadow);
        }

        .difficulty-stats {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .difficulty-item {
            text-align: center;
            flex: 1;
        }

        .floating-elements {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .floating-shape {
            position: absolute;
            opacity: 0.1;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        @media (max-width: 768px) {
            .result-container {
                padding: 15px;
            }

            .result-header {
                padding: 30px 20px;
            }

            .score-circle {
                width: 120px;
                height: 120px;
                font-size: 28px;
            }

            .btn-custom {
                display: block;
                width: 100%;
                margin: 10px 0;
            }

            .stats-card .row > div {
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>
<!-- Floating background elements -->
<div class="floating-elements">
    <div class="floating-shape" style="top: 10%; left: 10%; width: 50px; height: 50px; background: #667eea; border-radius: 50%; animation-delay: 0s;"></div>
    <div class="floating-shape" style="top: 20%; right: 10%; width: 30px; height: 30px; background: #4CAF50; border-radius: 50%; animation-delay: 1s;"></div>
    <div class="floating-shape" style="bottom: 30%; left: 5%; width: 40px; height: 40px; background: #FF9800; border-radius: 50%; animation-delay: 2s;"></div>
    <div class="floating-shape" style="bottom: 10%; right: 15%; width: 35px; height: 35px; background: #2196F3; border-radius: 50%; animation-delay: 3s;"></div>
</div>

<div class="container-fluid">
    <div class="result-container">
        <!-- Result Header -->
        <div class="result-header animate__animated animate__fadeInDown">
            <h1 class="mb-4"><i class="fas fa-trophy me-3"></i>Quiz Result</h1>
            <h3 class="mb-4">${quiz.title}</h3>

            <!-- Score Display -->
            <div class="score-circle animate__animated animate__zoomIn animate__delay-1s
                    <c:choose>
                        <c:when test="${attempt.score >= 90}">score-excellent</c:when>
                        <c:when test="${attempt.score >= 70}">score-good</c:when>
                        <c:when test="${attempt.score >= 50}">score-average</c:when>
                        <c:otherwise>score-poor</c:otherwise>
                    </c:choose>">
                <fmt:formatNumber value="${attempt.score}" maxFractionDigits="0"/>%
            </div>

            <!-- Progress Bar -->
            <div class="progress-bar-wrapper">
                <div class="progress-bar-fill
                        <c:choose>
                            <c:when test="${attempt.score >= 90}">bg-success</c:when>
                            <c:when test="${attempt.score >= 70}">bg-info</c:when>
                            <c:when test="${attempt.score >= 50}">bg-warning</c:when>
                            <c:otherwise>bg-danger</c:otherwise>
                        </c:choose>"
                     style="width: 0%;"
                     data-width="${attempt.score}%">
                </div>
            </div>

            <div class="performance-badge
                    <c:choose>
                        <c:when test="${attempt.score >= 90}">badge-excellent</c:when>
                        <c:when test="${attempt.score >= 70}">badge-good</c:when>
                        <c:when test="${attempt.score >= 50}">badge-average</c:when>
                        <c:otherwise>badge-poor</c:otherwise>
                    </c:choose>">
                <c:choose>
                    <c:when test="${attempt.score >= 90}">
                        <i class="fas fa-crown me-2"></i>Excellent!
                    </c:when>
                    <c:when test="${attempt.score >= 70}">
                        <i class="fas fa-thumbs-up me-2"></i>Great!
                    </c:when>
                    <c:when test="${attempt.score >= 50}">
                        <i class="fas fa-hand-paper me-2"></i>Almost there!
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-redo me-2"></i>Don't give up!
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Statistics -->
        <div class="stats-card animate__animated animate__fadeInUp">
            <h5 class="text-center mb-4"><i class="fas fa-chart-bar me-2"></i>Detailed Statistics</h5>
            <div class="row">
                <div class="col-md-3 col-6">
                    <div class="stat-item">
                        <div class="stat-icon text-success">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-value text-success">
                            <c:set var="correctCount" value="0" />
                            <c:forEach var="qa" items="${questionAttempts}">
                                <c:if test="${qa.isCorrect}">
                                    <c:set var="correctCount" value="${correctCount + 1}" />
                                </c:if>
                            </c:forEach>
                            ${correctCount}
                        </div>
                        <div class="stat-label">Correct Answers</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-item">
                        <div class="stat-icon text-danger">
                            <i class="fas fa-times-circle"></i>
                        </div>
                        <div class="stat-value text-danger">
                            ${questionAttempts.size() - correctCount}
                        </div>
                        <div class="stat-label">Incorrect Answers</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-item">
                        <div class="stat-icon text-info">
                            <i class="fas fa-question-circle"></i>
                        </div>
                        <div class="stat-value text-info">
                            ${questionAttempts.size()}
                        </div>
                        <div class="stat-label">Total Questions</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stat-item">
                        <div class="stat-icon text-warning">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-value text-warning">
                            <c:set var="completionMins" value="${(attempt.endTime.time - attempt.startTime.time) / 60000}" />
                            <fmt:formatNumber value="${completionMins}" maxFractionDigits="1"/>
                        </div>
                        <div class="stat-label">Completion Minutes</div>
                    </div>
                </div>
            </div>

            <!-- Accuracy percentage -->
            <div class="text-center mt-4">
                <h6 class="text-muted mb-2">Accuracy Rate</h6>
                <div class="display-6 fw-bold
                        <c:choose>
                            <c:when test="${attempt.score >= 70}">text-success</c:when>
                            <c:when test="${attempt.score >= 50}">text-warning</c:when>
                            <c:otherwise>text-danger</c:otherwise>
                        </c:choose>">
                    <fmt:formatNumber value="${(correctCount * 100.0) / questionAttempts.size()}" maxFractionDigits="1"/>%
                </div>
            </div>
        </div>

        <!-- Time Analysis -->
        <div class="time-analysis bg-white rounded-3 p-4 mb-4 animate__animated animate__fadeInLeft">
            <h5 class="text-dark mb-4"><i class="fas fa-stopwatch me-2"></i>Time Analysis</h5>
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="d-flex justify-content-between align-items-center p-3 bg-light rounded">
                        <span class="fw-medium">Average time per question:</span>
                        <strong class="text-dark">
                            <fmt:formatNumber value="${completionTimeMinutes * 60 / questionAttempts.size()}" maxFractionDigits="0"/> seconds
                        </strong>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="d-flex justify-content-between align-items-center p-3 bg-light rounded">
                        <span class="fw-medium">Quiz speed:</span>
                        <strong>
                            <c:choose>
                                <c:when test="${completionTimeMinutes <= 5}">
                                    <span class="text-success">Very fast</span>
                                </c:when>
                                <c:when test="${completionTimeMinutes <= 10}">
                                    <span class="text-info">Normal</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-warning">Careful</span>
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="d-flex justify-content-between align-items-center p-3 bg-light rounded">
                        <span class="fw-medium">Total quiz time:</span>
                        <strong class="text-dark">
                            <fmt:formatNumber value="${completionTimeMinutes}" maxFractionDigits="1"/> minutes
                        </strong>
                    </div>
                </div>
            </div>
        </div>

        <!-- Question Summary -->
        <div class="question-summary bg-white rounded-3 overflow-hidden mb-4 animate__animated animate__fadeInRight">
            <div class="question-summary-header bg-light p-4 border-bottom">
                <h5 class="mb-0 text-dark">
                    <i class="fas fa-list-check me-2"></i>
                    Answer Overview
                    <span class="badge bg-secondary ms-2">${questionAttempts.size()} questions</span>
                </h5>
            </div>
            <c:forEach var="qa" items="${questionAttempts}" varStatus="status">
                <div class="question-item p-4 border-bottom">
                    <div class="d-flex align-items-center">
                        <div class="question-number rounded-circle d-flex align-items-center justify-content-center me-4 ${qa.isCorrect ? 'bg-success' : 'bg-danger'} text-white">
                                ${status.index + 1}
                        </div>
                        <div class="question-content flex-grow-1">
                            <h6 class="mb-2 text-dark">Question ${status.index + 1}</h6>
                            <p class="mb-0 text-secondary">${qa.questionID.questionText}</p>
                        </div>
                        <div class="ms-3">
                            <c:choose>
                                <c:when test="${qa.isCorrect}">
                                    <span class="badge bg-success px-3 py-2">
                                        <i class="fas fa-check me-1"></i>Correct
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger px-3 py-2">
                                        <i class="fas fa-times me-1"></i>Incorrect
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons bg-white rounded-3 p-5 text-center animate__animated animate__fadeInUp">
            <div class="mb-4">
                <i class="fas fa-lightbulb text-warning me-2"></i>
                <strong>Next step:</strong> You can review details, retake the quiz, or continue learning
            </div>

            <div class="d-flex flex-wrap justify-content-center gap-3">
                <a href="take-quiz?action=review&attemptId=${attempt.id}"
                   class="btn btn-outline-primary">
                    <i class="fas fa-search me-2"></i>Review Answers
                </a>

                <a href="take-quiz?action=start&lessonId=${lessonId}" class="btn btn-outline-warning">
                    <i class="fas fa-redo me-2"></i>Retake Quiz
                </a>

                <a href="learning?lessonId=${lessonId}" class="btn btn-outline-success">
                    <i class="fas fa-graduation-cap me-2"></i>Continue Learning
                </a>
            </div>
        </div>

        <!-- Motivational Message -->
        <div class="text-center mt-4">
            <c:choose>
                <c:when test="${attempt.score >= 90}">
                    <div class="alert alert-excellent motivational-message animate__animated animate__bounceIn">
                        <i class="fas fa-crown me-2"></i>
                        <strong>Excellent!</strong> You have demonstrated outstanding knowledge! Keep it up!
                    </div>
                </c:when>
                <c:when test="${attempt.score >= 70}">
                    <div class="alert alert-good motivational-message animate__animated animate__bounceIn">
                        <i class="fas fa-star me-2"></i>
                        <strong>Great!</strong> You've mastered the basics! Try harder quizzes!
                    </div>
                </c:when>
                <c:when test="${attempt.score >= 50}">
                    <div class="alert alert-average motivational-message animate__animated animate__bounceIn">
                        <i class="fas fa-book-open me-2"></i>
                        <strong>Almost there!</strong> Review and try again!
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-poor motivational-message animate__animated animate__bounceIn">
                        <i class="fas fa-heart me-2"></i>
                        <strong>Don't give up!</strong> Every attempt is a learning opportunity!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Confetti for excellent scores -->
<c:if test="${attempt.score >= 90}">
    <canvas class="confetti" id="confetti"></canvas>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Animate progress bar
    document.addEventListener('DOMContentLoaded', function() {
        setTimeout(() => {
            const progressBar = document.querySelector('.progress-bar-fill');
            if (progressBar) {
                const width = progressBar.getAttribute('data-width');
                progressBar.style.width = width;
            }
        }, 1000);

        // Animate stat values
        animateCounters();
    });

    // Counter animation for statistics
    function animateCounters() {
        const counters = document.querySelectorAll('.stat-value');
        counters.forEach(counter => {
            const target = parseInt(counter.textContent);
            const duration = 2000;
            const step = target / (duration / 16);
            let current = 0;

            const timer = setInterval(() => {
                current += step;
                if (current >= target) {
                    counter.textContent = target;
                    clearInterval(timer);
                } else {
                    counter.textContent = Math.floor(current);
                }
            }, 16);
        });
    }

    // Share result function
    function shareResult() {
        const score = '${attempt.score}';
        const quizTitle = '${quiz.title}';
        const text = `Tôi vừa hoàn thành quiz "${quizTitle}" với điểm số ${Math.round(score)}%! 🎉`;

        if (navigator.share) {
            navigator.share({
                title: 'Kết quả Quiz',
                text: text,
                url: window.location.href
            });
        } else {
            // Fallback to clipboard
            navigator.clipboard.writeText(text + ' ' + window.location.href).then(() => {
                showToast('Đã sao chép kết quả vào clipboard!', 'success');
            }).catch(() => {
                showToast('Không thể chia sẻ kết quả', 'error');
            });
        }
    }

    // Toast notification
    function showToast(message, type) {
        const toast = document.createElement('div');
        toast.className = `toast align-items-center text-white bg-${type == 'success' ? 'success' : 'danger'} border-0`;
        toast.style.position = 'fixed';
        toast.style.top = '20px';
        toast.style.right = '20px';
        toast.style.zIndex = '9999';

        toast.innerHTML = `
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="fas fa-${type == 'success' ? 'check' : 'exclamation-triangle'} me-2"></i>
                        ${message}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" onclick="this.parentElement.parentElement.remove()"></button>
                </div>
            `;

        document.body.appendChild(toast);

        // Auto remove after 3 seconds
        setTimeout(() => {
            if (toast.parentElement) {
                toast.remove();
            }
        }, 3000);
    }

    // Sound effects (optional - requires sound files)
    function playSound(type) {
        // Uncomment if you have sound files
        // const audio = new Audio(`/sounds/${type}.mp3`);
        // audio.play().catch(() => {});
    }

    // Confetti animation for excellent scores
    <c:if test="${attempt.score >= 90}">
    const canvas = document.getElementById('confetti');
    if (canvas) {
        const ctx = canvas.getContext('2d');
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        const confettiPieces = [];
        const colors = ['#FFD700', '#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FECA57', '#FF9FF3', '#54A0FF'];

        // Create confetti pieces
        for (let i = 0; i < 200; i++) {
            confettiPieces.push({
                x: Math.random() * canvas.width,
                y: -10,
                vx: Math.random() * 6 - 3,
                vy: Math.random() * 4 + 2,
                color: colors[Math.floor(Math.random() * colors.length)],
                size: Math.random() * 12 + 4,
                rotation: Math.random() * 360,
                rotationSpeed: Math.random() * 15 - 7.5,
                gravity: 0.1,
                bounce: 0.6
            });
        }

        function animateConfetti() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            confettiPieces.forEach((piece, index) => {
                ctx.save();
                ctx.translate(piece.x + piece.size / 2, piece.y + piece.size / 2);
                ctx.rotate(piece.rotation * Math.PI / 180);

                // Create gradient for each piece
                const gradient = ctx.createLinearGradient(-piece.size/2, -piece.size/2, piece.size/2, piece.size/2);
                gradient.addColorStop(0, piece.color);
                gradient.addColorStop(1, piece.color + '80');

                ctx.fillStyle = gradient;
                ctx.fillRect(-piece.size / 2, -piece.size / 2, piece.size, piece.size);
                ctx.restore();

                // Update physics
                piece.x += piece.vx;
                piece.y += piece.vy;
                piece.vy += piece.gravity;
                piece.rotation += piece.rotationSpeed;

                // Bounce off edges
                if (piece.x <= 0 || piece.x >= canvas.width) {
                    piece.vx *= -piece.bounce;
                    piece.x = Math.max(0, Math.min(canvas.width, piece.x));
                }

                // Reset when off screen
                if (piece.y > canvas.height + 50) {
                    piece.y = -10;
                    piece.x = Math.random() * canvas.width;
                    piece.vx = Math.random() * 6 - 3;
                    piece.vy = Math.random() * 4 + 2;
                }
            });

            requestAnimationFrame(animateConfetti);
        }

        animateConfetti();

        // Play celebration sound
        playSound('celebration');

        // Stop confetti after 15 seconds
        setTimeout(() => {
            canvas.style.opacity = '0';
            canvas.style.transition = 'opacity 2s';
            setTimeout(() => {
                canvas.style.display = 'none';
            }, 2000);
        }, 15000);
    }
    </c:if>

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
                    window.location.href = 'learning-page';
                    break;
            }
        }
    });

    // Add scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe all animated elements
    document.querySelectorAll('.stats-card, .time-analysis, .question-summary, .action-buttons').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'all 0.6s ease';
        observer.observe(el);
    });

    // Window resize handler for confetti
    window.addEventListener('resize', function() {
        const canvas = document.getElementById('confetti');
        if (canvas) {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
        }
    });

    // Performance tracking (optional)
    function trackQuizCompletion() {
        // Send analytics data if needed
        if (typeof gtag !== 'undefined') {
            gtag('event', 'quiz_completed', {
                'quiz_id': '${quiz.id}',
                'score': '${attempt.score}',
                'completion_time': '${attempt.completionTimeMinutes}'
            });
        }
    }

    // Initialize tracking
    trackQuizCompletion();

    // Add ripple effect to buttons
    document.querySelectorAll('.btn-custom').forEach(button => {
        button.addEventListener('click', function(e) {
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.style.position = 'absolute';
            ripple.style.width = ripple.style.height = size + 'px';
            ripple.style.left = x + 'px';
            ripple.style.top = y + 'px';
            ripple.style.background = 'rgba(255, 255, 255, 0.3)';
            ripple.style.borderRadius = '50%';
            ripple.style.transform = 'scale(0)';
            ripple.style.animation = 'ripple 0.6s linear';
            ripple.style.pointerEvents = 'none';

            this.appendChild(ripple);

            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    });

    // CSS for ripple animation
    const style = document.createElement('style');
    style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }

            .btn-custom {
                position: relative;
                overflow: hidden;
            }
        `;
    document.head.appendChild(style);
</script>
</body>
</html>
