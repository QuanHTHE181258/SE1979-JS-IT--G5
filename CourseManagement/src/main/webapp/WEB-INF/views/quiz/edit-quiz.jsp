<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 7/21/2025
  Time: 10:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Edit Quiz</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --card-shadow: 0 10px 30px rgba(0,0,0,0.1);
            --hover-shadow: 0 15px 40px rgba(0,0,0,0.15);
            --border-radius: 15px;
        }

        * {
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            position: relative;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="50" cy="50" r="0.5" fill="rgba(255,255,255,0.03)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            pointer-events: none;
            z-index: 0;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .page-header {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            padding: 30px;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            margin-bottom: 30px;
            border: 1px solid rgba(255,255,255,0.2);
            animation: slideInDown 0.6s ease-out;
        }

        .page-header h2 {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 700;
            font-size: 2.2rem;
            text-align: center;
            margin: 0;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .quiz-info-card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255,255,255,0.2);
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out 0.2s both;
        }

        .quiz-info-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .questions-section {
            margin-top: 40px;
        }

        .questions-section h4 {
            color: white;
            text-align: center;
            font-weight: 600;
            margin-bottom: 30px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            font-size: 1.8rem;
        }

        .question-card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 30px;
            margin-bottom: 25px;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255,255,255,0.2);
            position: relative;
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out both;
        }

        .question-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--hover-shadow);
        }

        .question-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(102, 126, 234, 0.1);
        }

        .question-number {
            background: var(--primary-gradient);
            color: white;
            padding: 8px 16px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            text-shadow: 0 1px 2px rgba(0,0,0,0.2);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .answers-section {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            border-radius: 12px;
            padding: 25px;
            margin-top: 20px;
            border: 1px solid rgba(102, 126, 234, 0.1);
        }

        .answers-section h6 {
            color: #5a67d8;
            font-weight: 600;
            margin-bottom: 20px;
            font-size: 1.1rem;
        }

        .answer-card {
            background: rgba(255,255,255,0.8);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            border: 1px solid rgba(255,255,255,0.3);
            transition: all 0.3s ease;
        }

        .answer-card:hover {
            background: rgba(255,255,255,0.95);
            transform: translateX(5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .new-answer-form {
            margin-top: 25px;
            padding-top: 25px;
            border-top: 2px dashed rgba(102, 126, 234, 0.3);
            background: rgba(255,255,255,0.5);
            border-radius: 10px;
            padding: 25px;
        }

        .add-question-card {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 30px;
            margin-top: 30px;
            box-shadow: var(--card-shadow);
            border: 2px dashed rgba(102, 126, 234, 0.3);
            text-align: center;
            transition: all 0.3s ease;
            animation: fadeInUp 0.6s ease-out 0.4s both;
        }

        .add-question-card:hover {
            transform: translateY(-3px);
            border-color: rgba(102, 126, 234, 0.5);
            box-shadow: var(--hover-shadow);
        }

        .form-control {
            border: 2px solid rgba(102, 126, 234, 0.2);
            padding: 12px 18px;
            border-radius: 10px;
            transition: all 0.3s ease;
            background: rgba(255,255,255,0.9);
            backdrop-filter: blur(10px);
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 20px rgba(102, 126, 234, 0.2);
            background: rgba(255,255,255,1);
        }

        .btn {
            padding: 12px 24px;
            font-weight: 600;
            border-radius: 25px;
            border: none;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(102, 126, 234, 0.4);
        }

        .btn-success {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.3);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(79, 172, 254, 0.4);
        }

        .btn-danger {
            background: var(--danger-gradient);
            color: white;
            box-shadow: 0 8px 25px rgba(250, 112, 154, 0.3);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(250, 112, 154, 0.4);
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 0.75rem;
        }

        .form-check {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-check-input {
            width: 20px;
            height: 20px;
            border: 2px solid #667eea;
            border-radius: 4px;
        }

        .form-check-input:checked {
            background: var(--primary-gradient);
            border-color: #667eea;
        }

        .form-check-label {
            font-weight: 500;
            color: #5a67d8;
            margin: 0;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }

        .input-group {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .input-group .form-control {
            border-right: none;
            border-radius: 10px 0 0 10px;
        }

        .input-group .btn {
            border-radius: 0 10px 10px 0;
            border-left: none;
        }

        /* Animations */
        @keyframes slideInDown {
            from {
                transform: translateY(-30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
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

        .question-card:nth-child(1) { animation-delay: 0.1s; }
        .question-card:nth-child(2) { animation-delay: 0.2s; }
        .question-card:nth-child(3) { animation-delay: 0.3s; }
        .question-card:nth-child(4) { animation-delay: 0.4s; }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
            }

            .page-header {
                padding: 20px;
            }

            .page-header h2 {
                font-size: 1.8rem;
            }

            .quiz-info-card,
            .question-card,
            .add-question-card {
                padding: 20px;
            }

            .question-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .form-actions {
                width: 100%;
                justify-content: center;
            }

            .btn {
                padding: 10px 20px;
                font-size: 0.8rem;
            }
        }

        /* Loading animation for forms */
        .btn.loading {
            position: relative;
            color: transparent;
        }

        .btn.loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255,255,255,0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }

        /* Success/Error messages */
        .alert {
            border-radius: 10px;
            border: none;
            padding: 15px 20px;
            margin-bottom: 20px;
            backdrop-filter: blur(10px);
        }

        .alert-success {
            background: rgba(75, 181, 67, 0.1);
            color: #2d7738;
            border-left: 4px solid #4bb543;
        }

        .alert-danger {
            background: rgba(220, 53, 69, 0.1);
            color: #842029;
            border-left: 4px solid #dc3545;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Page Header -->
    <div class="page-header">
        <h2 class="mb-0">
            <i class="fas fa-edit me-3"></i>Edit Quiz
        </h2>
    </div>

    <!-- Quiz Info Section -->
    <div class="quiz-info-card">
        <form method="post" action="edit-quiz" class="mb-3">
            <input type="hidden" name="action" value="updateQuiz" />
            <input type="hidden" name="quizId" value="${quiz.id}" />
            <div class="mb-4">
                <label class="form-label fw-bold">
                    <i class="fas fa-pencil-alt me-2"></i>Quiz Title
                </label>
                <input type="text" class="form-control" name="title" value="${quiz.title}" required />
            </div>
            <div class="form-actions justify-content-center">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-2"></i>Save Changes
                </button>

            </div>
        </form>
    </div>

    <!-- Questions Section -->
    <div class="questions-section">
        <h4 class="mb-4">
            <i class="fas fa-question-circle me-3"></i>Questions
        </h4>

        <script>
            function deleteAnswer(answerId, totalAnswers) {
                if (totalAnswers <= 2) {
                    alert('Cannot delete answer. A question must have at least 2 answers.');
                    return;
                }

                if (confirm('Are you sure you want to delete this answer?')) {
                    $.ajax({
                        url: 'edit-quiz',
                        type: 'POST',
                        data: {
                            action: 'deleteAnswer',
                            answerId: answerId
                        },
                        success: function(response) {
                            try {
                                const jsonResponse = JSON.parse(response);
                                if (jsonResponse.success) {
                                    window.location.reload(); // Reload the page
                                } else {
                                    alert(jsonResponse.message || 'Failed to delete answer');
                                }
                            } catch (e) {
                                if (response.includes('success')) {
                                    window.location.reload(); // Reload the page
                                } else {
                                    alert('Failed to delete answer');
                                    console.error('Error parsing response:', e);
                                }
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('Error:', error);
                            console.error('Status:', status);
                            console.error('Response:', xhr.responseText);
                            alert('An error occurred while deleting the answer');
                        }
                    });
                }
            }

            function deleteQuestion(questionId, totalQuestions) {
                if (totalQuestions <= 1) {
                    alert('Cannot delete question. Quiz must have at least 1 question.');
                    return;
                }
                return confirm('Delete this question?');
            }
        </script>

        <style>
            .console-log {
                background-color: #f8f9fa;
                border: 1px solid #dee2e6;
                padding: 10px;
                margin-top: 10px;
                border-radius: 4px;
                max-height: 200px;
                overflow-y: auto;
                display: none;
            }
        </style>

        <div id="console-log" class="console-log"></div>

        <c:forEach var="question" items="${quiz.questions}" varStatus="status">
            <div class="question-card">
                <div class="question-header">
                    <span class="question-number">
                        <i class="fas fa-hashtag me-2"></i>Question ${status.index + 1}
                    </span>
                    <div class="form-actions">
                        <form method="post" action="edit-quiz" class="d-inline">
                            <input type="hidden" name="action" value="deleteQuestion" />
                            <input type="hidden" name="quizId" value="${quiz.id}" />
                            <input type="hidden" name="questionId" value="${question.id}" />
                            <button type="submit" class="btn btn-danger btn-sm"
                                    onclick="return deleteQuestion(${question.id}, ${fn:length(quiz.questions)});">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Question Text -->
                <form method="post" action="edit-quiz" class="mb-4">
                    <input type="hidden" name="action" value="updateQuestion" />
                    <input type="hidden" name="quizId" value="${quiz.id}" />
                    <input type="hidden" name="questionId" value="${question.id}" />
                    <div class="input-group">
                        <input type="text" class="form-control" name="questionText" value="${question.questionText}" required placeholder="Enter question text..." />
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-check me-2"></i>Save
                        </button>
                    </div>
                </form>

                <!-- Answers Section -->
                <div class="answers-section">
                    <h6 class="mb-3">
                        <i class="fas fa-list-ul me-2"></i>Answers
                    </h6>
                    <c:forEach var="answer" items="${question.answers}">
                        <div class="answer-card" id="answer-${answer.id}">
                            <form method="post" action="edit-quiz" class="d-flex align-items-center gap-3 flex-wrap">
                                <input type="hidden" name="action" value="updateAnswer" />
                                <input type="hidden" name="quizId" value="${quiz.id}" />
                                <input type="hidden" name="answerId" value="${answer.id}" />
                                <input type="text" class="form-control flex-grow-1" name="answerText" value="${answer.answerText}" required />
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" name="isCorrect" ${answer.isCorrect ? 'checked' : ''} />
                                    <label class="form-check-label">
                                        <i class="fas fa-check-circle me-1"></i>Correct
                                    </label>
                                </div>
                                <button type="submit" class="btn btn-success btn-sm">
                                    <i class="fas fa-save"></i>
                                </button>


                            </form>
                            <form method="post" action="edit-quiz"
                                  onsubmit="return confirm('Bạn có chắc chắn muốn xóa câu trả lời này?')"
                                  style="display: inline;">
                                <input type="hidden" name="action" value="deleteAnswer" />
                                <input type="hidden" name="quizId" value="${quiz.id}" />
                                <input type="hidden" name="answerId" value="${answer.id}" />
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </form>
                        </div>
                    </c:forEach>

                    <!-- Add New Answer Form -->
                    <div class="new-answer-form">
                        <form method="post" action="edit-quiz" class="d-flex gap-3 align-items-center flex-wrap">
                            <input type="hidden" name="action" value="addAnswer" />
                            <input type="hidden" name="quizId" value="${quiz.id}" />
                            <input type="hidden" name="questionId" value="${question.id}" />
                            <input type="text" class="form-control flex-grow-1" name="newAnswerText" placeholder="New answer text..." required />
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" name="isCorrect" />
                                <label class="form-check-label">
                                    <i class="fas fa-check-circle me-1"></i>Correct
                                </label>
                            </div>
                            <button type="submit" class="btn btn-primary btn-sm">
                                <i class="fas fa-plus me-2"></i>Add Answer
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Add New Question Card -->
        <div class="add-question-card">
            <form method="post" action="edit-quiz">
                <input type="hidden" name="action" value="addQuestion" />
                <input type="hidden" name="quizId" value="${quiz.id}" />
                <div class="input-group">
                    <input type="text" class="form-control" name="newQuestionText" placeholder="Type new question here..." required />
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>Add Question
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Add loading state to buttons
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(e) {
            const submitBtn = form.querySelector('button[type="submit"]');
            if (submitBtn && !submitBtn.classList.contains('btn-danger')) {
                submitBtn.classList.add('loading');
                submitBtn.disabled = true;

                // Re-enable after 3 seconds as fallback
                setTimeout(() => {
                    submitBtn.classList.remove('loading');
                    submitBtn.disabled = false;
                }, 3000);
            }
        });
    });

    // Add smooth scroll for form submissions
    window.addEventListener('load', function() {
        if (window.location.hash) {
            const element = document.querySelector(window.location.hash);
            if (element) {
                element.scrollIntoView({ behavior: 'smooth' });
            }
        }
    });

    // Auto-save functionality for form inputs
    let saveTimeout;
    document.querySelectorAll('input[type="text"]').forEach(input => {
        input.addEventListener('input', function() {
            clearTimeout(saveTimeout);
            this.style.borderColor = '#ffc107';

            saveTimeout = setTimeout(() => {
                this.style.borderColor = '';
            }, 1000);
        });
    });
</script>
</body>
</html>
