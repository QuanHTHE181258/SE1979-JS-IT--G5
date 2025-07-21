<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Làm bài quiz - ${quiz.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .quiz-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        .quiz-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            text-align: center;
        }
        .question-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 25px;
            overflow: hidden;
            transition: transform 0.2s;
        }
        .question-card:hover {
            transform: translateY(-2px);
        }
        .question-header {
            background: #f8f9fa;
            padding: 20px;
            border-bottom: 1px solid #dee2e6;
        }
        .question-body {
            padding: 25px;
        }
        .answer-option {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 12px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
        }
        .answer-option:hover {
            border-color: #667eea;
            background-color: #f8f9ff;
        }
        .answer-option input[type="radio"] {
            margin-right: 12px;
            transform: scale(1.2);
        }
        .answer-option.selected {
            border-color: #667eea;
            background-color: #f8f9ff;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.2);
        }
        .quiz-progress {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .progress-bar {
            height: 8px;
            border-radius: 4px;
        }
        .timer {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #fff;
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            z-index: 1000;
        }
        .submit-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-top: 30px;
        }
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 15px 40px;
            font-size: 18px;
            font-weight: 600;
            border-radius: 25px;
            color: white;
            transition: transform 0.2s;
        }
        .btn-submit:hover {
            transform: scale(1.05);
            color: white;
        }
    </style>
</head>
<body class="bg-light">
<div class="container-fluid">
    <div class="quiz-container">
        <!-- Quiz Header -->
        <div class="quiz-header">
            <h1><i class="fas fa-question-circle me-3"></i>${quiz.title}</h1>
        </div>

        <!-- Quiz Progress -->
        <div class="quiz-progress">
            <div class="d-flex justify-content-between align-items-center mb-2">
                <h6 class="mb-0">Tiến độ làm bài</h6>
                <span class="badge bg-primary fs-6">
                    <span id="answered">0</span>/<c:out value="${quiz.questions.size()}"/> câu hỏi
                </span>
            </div>
            <div class="progress">
                <div class="progress-bar bg-primary" id="progress" role="progressbar" style="width: 0%"></div>
            </div>
        </div>

        <!-- Quiz Form -->
        <form id="quizForm" action="take-quiz" method="post">
            <input type="hidden" name="action" value="submit">

            <!-- Questions -->
            <c:forEach var="question" items="${quiz.questions}" varStatus="status">
                <div class="question-card">
                    <div class="question-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">
                                <span class="badge bg-primary me-2">${status.index + 1}</span>
                                Câu hỏi ${status.index + 1}
                            </h5>
                        </div>
                    </div>
                    <div class="question-body">
                        <h6 class="question-text mb-4">${question.questionText}</h6>

                        <div class="answers">
                            <c:forEach var="answer" items="${question.answers}" varStatus="answerStatus">
                                <div class="answer-option" onclick="selectAnswer(this, ${question.id}, ${answer.id})">
                                    <input type="radio"
                                           name="question_${question.id}"
                                           value="${answer.id}"
                                           id="answer_${question.id}_${answer.id}"
                                           onchange="updateProgress()">
                                    <label for="answer_${question.id}_${answer.id}" class="mb-0 flex-grow-1">
                                        <span class="fw-semibold me-2">${answerStatus.index == 0 ? 'A' : answerStatus.index == 1 ? 'B' : answerStatus.index == 2 ? 'C' : 'D'}.</span>
                                            ${answer.answerText}
                                    </label>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- Submit Section -->
            <div class="submit-section">
                <div class="mb-4">
                    <i class="fas fa-info-circle text-info me-2"></i>
                    <span class="text-muted">Vui lòng kiểm tra lại các câu trả lời trước khi nộp bài</span>
                </div>
                <button type="button" class="btn btn-submit" onclick="confirmSubmit()">
                    <i class="fas fa-paper-plane me-2"></i>Nộp bài
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Confirmation Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                    Xác nhận nộp bài
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn nộp bài không?</p>
                <p class="text-muted">
                    <strong>Đã trả lời:</strong> <span id="confirmedAnswered">0</span>/<c:out value="${quiz.questions.size()}"/> câu hỏi<br>
                </p>
                <div class="alert alert-warning">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    Sau khi nộp bài, bạn không thể thay đổi câu trả lời!
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary" onclick="submitQuiz()">
                    <i class="fas fa-paper-plane me-2"></i>Nộp bài
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let totalQuestions = ${quiz.questions.size()};

    // Answer selection
    function selectAnswer(element, questionId, answerId) {
        // Remove selected class from siblings
        const siblings = element.parentNode.querySelectorAll('.answer-option');
        siblings.forEach(sibling => sibling.classList.remove('selected'));

        // Add selected class to current element
        element.classList.add('selected');

        // Check the radio button
        const radio = element.querySelector('input[type="radio"]');
        radio.checked = true;

        updateProgress();
    }

    // Progress tracking
    function updateProgress() {
        const answeredCount = document.querySelectorAll('input[type="radio"]:checked').length;
        const progressPercentage = (answeredCount / totalQuestions) * 100;

        document.getElementById('answered').textContent = answeredCount;
        document.getElementById('progress').style.width = progressPercentage + '%';
    }

    // Confirmation modal
    function confirmSubmit() {
        const answeredCount = document.querySelectorAll('input[type="radio"]:checked').length;

        document.getElementById('confirmedAnswered').textContent = answeredCount;

        const modal = new bootstrap.Modal(document.getElementById('confirmModal'));
        modal.show();
    }

    // Submit quiz
    function submitQuiz() {
        document.getElementById('quizForm').submit();
    }

    // Prevent accidental page refresh
    window.addEventListener('beforeunload', function(e) {
        e.preventDefault();
        e.returnValue = 'Bạn có chắc muốn rời khỏi trang? Dữ liệu làm bài có thể bị mất.';
    });

    // Initialize progress on page load
    updateProgress();
</script>
</body>
</html>