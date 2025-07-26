<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quiz Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            /* Purple Gradient Theme - Synchronized with Profile */
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

        body {
            background: var(--primary-gradient);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .quiz-header {
            background: var(--primary-gradient);
            color: var(--text-white);
            border-radius: 20px 20px 0 0;
            padding: 2.5rem 2rem;
            text-align: center;
            box-shadow: var(--shadow-medium);
        }

        .quiz-title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .quiz-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            font-weight: 400;
        }

        .content-wrapper {
            background: var(--bg-primary);
            border-radius: 0 0 20px 20px;
            box-shadow: var(--shadow-medium);
            overflow: hidden;
        }

        /* Custom Tabs */
        .custom-tabs {
            background: var(--gray-50);
            border-bottom: 1px solid var(--gray-200);
            padding: 0;
        }

        .custom-tabs .nav-link {
            background: transparent;
            border: none;
            color: var(--gray-800);
            font-weight: 600;
            padding: 1.25rem 2rem;
            margin: 0;
            border-radius: 0;
            position: relative;
            transition: all 0.3s ease;
        }

        .custom-tabs .nav-link:hover {
            background: rgba(102, 126, 234, 0.05);
            color: var(--primary-color);
        }

        .custom-tabs .nav-link.active {
            background: var(--bg-primary);
            color: var(--primary-color);
            border-bottom: 3px solid var(--primary-color);
        }

        .custom-tabs .badge {
            background: var(--primary-color) !important;
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
        }

        .tab-content {
            padding: 2.5rem;
        }

        /* Question Cards */
        .question-card {
            background: white;
            border: 1px solid var(--gray-200);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .question-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--primary-gradient);
        }

        .question-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        .question-number {
            background: var(--primary-gradient);
            color: var(--text-white);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .question-text {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--gray-900);
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .answers-section {
            background: var(--gray-50);
            border-radius: 12px;
            padding: 1.5rem;
            margin-top: 1rem;
        }

        .answers-title {
            font-size: 1rem;
            font-weight: 600;
            color: var(--gray-800);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
        }

        .answer-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            margin-bottom: 0.5rem;
            background: white;
            border-radius: 8px;
            border: 1px solid var(--gray-200);
            transition: all 0.2s ease;
        }

        .answer-item:last-child {
            margin-bottom: 0;
        }

        .answer-item.correct {
            border-color: var(--success-color);
            background: rgba(16, 185, 129, 0.05);
        }

        .answer-item.incorrect {
            border-color: var(--gray-300);
        }

        .answer-icon {
            margin-right: 0.75rem;
            font-size: 1rem;
        }

        .answer-text {
            flex: 1;
            font-weight: 500;
            color: var(--gray-800);
        }

        .correct-badge {
            background: var(--success-color) !important;
            font-size: 0.75rem;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
        }

        /* Attempts Table */
        .attempts-table {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        .attempts-table .table {
            margin-bottom: 0;
        }

        .attempts-table thead th {
            background: var(--gray-50);
            border: none;
            color: var(--gray-800);
            font-weight: 600;
            padding: 1.25rem 1.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .attempts-table tbody td {
            padding: 1.25rem 1.5rem;
            border: none;
            border-bottom: 1px solid var(--gray-100);
            font-weight: 500;
            color: var(--gray-800);
        }

        .attempts-table tbody tr:hover {
            background: var(--gray-50);
        }

        .score-badge {
            background: var(--success-color) !important;
            font-size: 0.9rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
        }

        /* Action Buttons */
        .action-buttons {
            background: var(--gray-50);
            padding: 2rem;
            border-top: 1px solid var(--gray-200);
        }

        .btn-custom {
            padding: 0.75rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-custom:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .btn-back {
            background: var(--gray-300);
            color: var(--text-primary);
        }

        .btn-back:hover {
            background: var(--gray-400);
            color: var(--text-primary);
        }

        .btn-edit {
            background: var(--primary-gradient);
            color: var(--text-white);
        }

        .btn-edit:hover {
            background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
            color: var(--text-white);
        }

        /* Empty States */
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            background: var(--primary-50);
            border-radius: 12px;
            border: 2px dashed var(--primary-color);
        }

        .empty-state-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
            opacity: 0.6;
        }

        .empty-state-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .empty-state-text {
            color: var(--text-secondary);
            font-size: 0.95rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                margin: 1rem auto;
                padding: 0 0.5rem;
            }

            .quiz-header {
                padding: 2rem 1.5rem;
                border-radius: 16px 16px 0 0;
            }

            .quiz-title {
                font-size: 2rem;
            }

            .tab-content {
                padding: 1.5rem;
            }

            .question-card {
                padding: 1.5rem;
            }

            .custom-tabs .nav-link {
                padding: 1rem 1.5rem;
                font-size: 0.9rem;
            }

            .action-buttons {
                padding: 1.5rem;
            }

            .btn-custom {
                padding: 0.625rem 1.5rem;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
<div class="main-container">
    <!-- Quiz Header -->
    <div class="quiz-header">
        <div class="quiz-title">
            <i class="fas fa-quiz me-3"></i>${quiz.title}
        </div>
        <div class="quiz-subtitle">
            Explore questions and review quiz attempts
        </div>
    </div>

    <!-- Content Wrapper -->
    <div class="content-wrapper">
        <!-- Custom Tabs -->
        <nav>
            <div class="nav nav-tabs custom-tabs" id="nav-tab" role="tablist">
                <button class="nav-link active" id="questions-tab" data-bs-toggle="tab" data-bs-target="#questions" type="button">
                    <i class="fas fa-question-circle me-2"></i>Questions
                    <span class="badge ms-2">${questions.size()}</span>
                </button>
                <button class="nav-link" id="attempts-tab" data-bs-toggle="tab" data-bs-target="#attempts" type="button">
                    <i class="fas fa-chart-line me-2"></i>Attempts
                    <span class="badge ms-2">${attempts.size()}</span>
                </button>
            </div>
        </nav>

        <div class="tab-content" id="nav-tabContent">
            <!-- Questions Tab -->
            <div class="tab-pane fade show active" id="questions">
                <c:choose>
                    <c:when test="${not empty questions}">
                        <c:forEach var="question" items="${questions}" varStatus="status">
                            <div class="question-card">
                                <div class="question-number">
                                        ${status.index + 1}
                                </div>

                                <div class="question-text">
                                        ${question.questionText}
                                </div>

                                <!-- Display answers -->
                                <div class="answers-section">
                                    <div class="answers-title">
                                        <i class="fas fa-list-ul me-2"></i>Answer Options
                                    </div>
                                    <c:forEach var="answer" items="${questionAnswers[question.id]}">
                                        <div class="answer-item ${answer.isCorrect ? 'correct' : 'incorrect'}">
                                            <i class="answer-icon fas ${answer.isCorrect ? 'fa-check-circle text-success' : 'fa-circle text-muted'}"></i>
                                            <div class="answer-text">${answer.answerText}</div>
                                            <c:if test="${answer.isCorrect}">
                                                <span class="badge correct-badge ms-2">Correct</span>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-question-circle"></i>
                            </div>
                            <div class="empty-state-title">No Questions Yet</div>
                            <div class="empty-state-text">
                                This quiz doesn't have any questions yet. Add some questions to get started!
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Attempts Tab -->
            <div class="tab-pane fade" id="attempts">
                <c:choose>
                    <c:when test="${not empty attempts}">
                        <div class="attempts-table">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th><i class="fas fa-hashtag me-1"></i>Attempt ID</th>
                                    <th><i class="fas fa-user me-1"></i>User ID</th>
                                    <th><i class="fas fa-play me-1"></i>Start Time</th>
                                    <th><i class="fas fa-stop me-1"></i>End Time</th>
                                    <th><i class="fas fa-trophy me-1"></i>Score</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="attempt" items="${attempts}">
                                    <tr>
                                        <td><strong>${attempt.id}</strong></td>
                                        <td>${attempt.user.id}</td>
                                        <td>
                                            <fmt:formatDate value="${attempt.startTime}" pattern="MMM dd, yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${attempt.endTime}" pattern="MMM dd, yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <span class="badge score-badge">${attempt.score}%</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-state-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <div class="empty-state-title">No Attempts Yet</div>
                            <div class="empty-state-text">
                                No one has attempted this quiz yet. Share it with students to see results here!
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons d-flex justify-content-between align-items-center">
            <a href="lesson-details?id=${quiz.lessonID.id}" class="btn-custom btn-back">
                <i class="fas fa-arrow-left"></i>Back to Lesson
            </a>
            <a href="edit-quiz?quizId=${quiz.id}" class="btn-custom btn-edit">
                <i class="fas fa-edit"></i>Edit Quiz
            </a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>