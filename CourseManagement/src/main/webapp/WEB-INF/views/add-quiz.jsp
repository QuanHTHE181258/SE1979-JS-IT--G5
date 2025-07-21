<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Quiz</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .question-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 20px;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .answer-group {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #e9ecef;
            border-radius: 5px;
            background-color: white;
        }
        .btn-remove-question {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .question-card {
            position: relative;
        }
        .correct-answer-label {
            color: #28a745;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4><i class="fas fa-plus-circle me-2"></i>Add New Quiz</h4>
                    <a href="lesson-details?id=${lessonId}" class="btn btn-secondary btn-sm">
                        <i class="fas fa-arrow-left me-1"></i>Back to Lesson
                    </a>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        </div>
                    </c:if>

                    <form id="addQuizForm" method="post" action="add-quiz">
                        <input type="hidden" name="lessonId" value="${lessonId}">

                        <!-- Quiz Title -->
                        <div class="mb-3">
                            <label for="title" class="form-label">Quiz Title <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="title" name="title" required
                                   placeholder="Enter quiz title">
                        </div>

                        <!-- Questions Container -->
                        <div id="questionsContainer">
                            <h5 class="mb-3">Questions</h5>
                            <!-- Initial question will be added by JavaScript -->
                        </div>

                        <!-- Add Question Button -->
                        <div class="mb-3">
                            <button type="button" class="btn btn-outline-primary" id="addQuestionBtn">
                                <i class="fas fa-plus me-1"></i>Add Question
                            </button>
                        </div>

                        <!-- Submit Buttons -->
                        <div class="d-flex justify-content-end gap-2">
                            <a href="lesson-details?id=${lessonId}" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save me-1"></i>Create Quiz
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let questionCount = 0;

    function addQuestion() {
        const questionHtml = `
                <div class="question-card" id="question_${questionCount}">
                    <button type="button" class="btn btn-sm btn-outline-danger btn-remove-question" onclick="removeQuestion(${questionCount})">
                        <i class="fas fa-times"></i>
                    </button>

                    <div class="mb-3">
                        <label class="form-label">Question ${questionCount + 1} <span class="text-danger">*</span></label>
                        <textarea class="form-control" name="questionText" rows="2" required
                                  placeholder="Enter your question here"></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Answer Options <span class="text-danger">*</span></label>
                        <div id="answersContainer_${questionCount}">
                            <!-- Answers will be added here -->
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary mt-2" onclick="addAnswer(${questionCount})">
                            <i class="fas fa-plus me-1"></i>Add Answer Option
                        </button>
                    </div>

                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Instructions:</strong> Add at least 2 answer options and check the box next to the correct answer(s).
                    </div>
                </div>
            `;

        document.getElementById('questionsContainer').insertAdjacentHTML('beforeend', questionHtml);

        // Add initial 2 answers
        addAnswer(questionCount);
        addAnswer(questionCount);

        questionCount++;
        updateQuestionNumbers();
    }

    function removeQuestion(questionIndex) {
        const questionElement = document.getElementById(`question_${questionIndex}`);
        questionElement.remove();
        updateQuestionNumbers();
    }

    function addAnswer(questionIndex) {
        const answersContainer = document.getElementById(`answersContainer_${questionIndex}`);
        const answerCount = answersContainer.children.length;

        const answerHtml = `
                <div class="answer-group" id="answer_${questionIndex}_${answerCount}">
                    <div class="row align-items-center">
                        <div class="col-md-1">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="correctAnswer_${questionIndex}"
                                       value="${answerCount}" id="correct_${questionIndex}_${answerCount}">
                                <label class="form-check-label correct-answer-label" for="correct_${questionIndex}_${answerCount}">
                                    <i class="fas fa-check"></i>
                                </label>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="answers_${questionIndex}"
                                   placeholder="Enter answer option" required>
                        </div>
                        <div class="col-md-2">
                            <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeAnswer(${questionIndex}, ${answerCount})">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </div>
                </div>
            `;

        answersContainer.insertAdjacentHTML('beforeend', answerHtml);
    }

    function removeAnswer(questionIndex, answerIndex) {
        const answerElement = document.getElementById(`answer_${questionIndex}_${answerIndex}`);
        const answersContainer = document.getElementById(`answersContainer_${questionIndex}`);

        // Don't allow removing if there are only 2 answers left
        if (answersContainer.children.length <= 2) {
            alert('A question must have at least 2 answer options.');
            return;
        }

        answerElement.remove();
    }

    function updateQuestionNumbers() {
        const questions = document.querySelectorAll('.question-card');
        questions.forEach((question, index) => {
            const label = question.querySelector('label');
            label.innerHTML = `Question ${index + 1} <span class="text-danger">*</span>`;
        });
    }

    // Form validation
    document.getElementById('addQuizForm').addEventListener('submit', function(e) {
        const questions = document.querySelectorAll('.question-card');

        if (questions.length === 0) {
            e.preventDefault();
            alert('Please add at least one question.');
            return;
        }

        let isValid = true;
        questions.forEach((question, index) => {
            const answers = question.querySelectorAll('input[type="text"]');
            const correctAnswers = question.querySelectorAll('input[type="checkbox"]:checked');

            if (answers.length < 2) {
                isValid = false;
                alert(`Question ${index + 1} must have at least 2 answer options.`);
                return;
            }

            if (correctAnswers.length === 0) {
                isValid = false;
                alert(`Question ${index + 1} must have at least one correct answer selected.`);
                return;
            }
        });

        if (!isValid) {
            e.preventDefault();
        }
    });

    // Event listeners
    document.getElementById('addQuestionBtn').addEventListener('click', addQuestion);

    // Add initial question when page loads
    document.addEventListener('DOMContentLoaded', function() {
        addQuestion();
    });
</script>
</body>
</html>