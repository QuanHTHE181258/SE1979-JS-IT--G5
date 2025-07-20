<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Xem lại quiz - ${quiz.title}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    .review-container {
      max-width: 1000px;
      margin: 0 auto;
      padding: 20px;
    }
    .review-header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 30px;
      text-align: center;
    }
    .score-summary {
      background: white;
      border-radius: 15px;
      padding: 20px;
      margin-bottom: 30px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .question-review {
      background: white;
      border-radius: 15px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      margin-bottom: 25px;
      overflow: hidden;
      border-left: 5px solid #e9ecef;
    }
    .question-review.correct {
      border-left-color: #28a745;
    }
    .question-review.incorrect {
      border-left-color: #dc3545;
    }
    .question-header-review {
      padding: 20px;
      border-bottom: 1px solid #dee2e6;
      background: #f8f9fa;
    }
    .question-body-review {
      padding: 25px;
    }
    .answer-review {
      border: 2px solid #e9ecef;
      border-radius: 10px;
      padding: 15px 20px;
      margin-bottom: 12px;
      display: flex;
      align-items: center;
      position: relative;
    }
    .answer-review.correct-answer {
      border-color: #28a745;
      background-color: #d4edda;
      color: #155724;
    }
    .answer-review.user-answer {
      border-color: #6f42c1;
      background-color: #f8f6ff;
    }
    .answer-review.user-answer.incorrect {
      border-color: #dc3545;
      background-color: #f8d7da;
      color: #721c24;
    }
    .answer-review.user-answer.correct {
      border-color: #28a745;
      background-color: #d4edda;
      color: #155724;
    }
    .answer-icon {
      margin-left: auto;
      font-size: 18px;
    }
    .question-stats {
      display: flex;
      align-items: center;
      gap: 20px;
      flex-wrap: wrap;
    }
    .stat-badge {
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 600;
    }
    .badge-correct {
      background-color: #d4edda;
      color: #155724;
    }
    .badge-incorrect {
      background-color: #f8d7da;
      color: #721c24;
    }
    .navigation-bar {
      position: sticky;
      top: 20px;
      background: white;
      border-radius: 10px;
      padding: 15px 20px;
      margin-bottom: 20px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      z-index: 100;
    }
    .nav-pills .nav-link {
      border-radius: 20px;
      margin-right: 5px;
      font-size: 12px;
      padding: 8px 12px;
      min-width: 40px;
      text-align: center;
    }
    .nav-pills .nav-link.correct {
      background-color: #28a745;
      color: white;
    }
    .nav-pills .nav-link.incorrect {
      background-color: #dc3545;
      color: white;
    }
    .nav-pills .nav-link.active {
      transform: scale(1.1);
      box-shadow: 0 3px 10px rgba(0,0,0,0.2);
    }
    .back-to-top {
      position: fixed;
      bottom: 30px;
      right: 30px;
      background: #667eea;
      color: white;
      width: 50px;
      height: 50px;
      border-radius: 50%;
      border: none;
      font-size: 18px;
      opacity: 0;
      transition: all 0.3s;
      z-index: 1000;
    }
    .back-to-top.show {
      opacity: 1;
    }
    .back-to-top:hover {
      background: #5a67d8;
      transform: scale(1.1);
    }
    .action-buttons {
      background: white;
      border-radius: 15px;
      padding: 30px;
      text-align: center;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      margin-top: 30px;
    }
    .btn-custom {
      padding: 12px 30px;
      margin: 0 10px;
      border-radius: 25px;
      font-weight: 600;
      transition: all 0.3s;
    }
    .explanation-box {
      background: #fff3cd;
      border: 1px solid #ffeaa7;
      border-radius: 8px;
      padding: 15px;
      margin-top: 15px;
    }
    .legend {
      display: flex;
      gap: 20px;
      flex-wrap: wrap;
      align-items: center;
      margin-bottom: 15px;
    }
    .legend-item {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 14px;
    }
    .legend-color {
      width: 16px;
      height: 16px;
      border-radius: 4px;
    }
  </style>
</head>
<body class="bg-light">
<!-- Back to top button -->
<button class="back-to-top" id="backToTop" onclick="scrollToTop()">
  <i class="fas fa-arrow-up"></i>
</button>

<div class="container-fluid">
  <div class="review-container">
    <!-- Review Header -->
    <div class="review-header">
      <h1><i class="fas fa-search me-3"></i>Xem lại Quiz</h1>
      <h3 class="mb-0">${quiz.title}</h3>
    </div>

    <!-- Score Summary -->
    <div class="score-summary">
      <div class="row align-items-center">
        <div class="col-md-3 text-center">
          <div class="display-4 fw-bold
                            <c:choose>
                                <c:when test="${attempt.score >= 70}">text-success</c:when>
                                <c:when test="${attempt.score >= 50}">text-warning</c:when>
                                <c:otherwise>text-danger</c:otherwise>
                            </c:choose>">
            <fmt:formatNumber value="${attempt.score}" maxFractionDigits="0"/>%
          </div>
          <div class="text-muted">Điểm số</div>
        </div>
        <div class="col-md-9">
          <div class="row text-center">
            <div class="col-6 col-md-3">
              <div class="h4 text-success">
                <c:set var="correctCount" value="0" />
                <c:forEach var="qa" items="${questionAttempts}">
                  <c:if test="${qa.isCorrect}">
                    <c:set var="correctCount" value="${correctCount + 1}" />
                  </c:if>
                </c:forEach>
                ${correctCount}
              </div>
              <div class="text-muted small">Đúng</div>
            </div>
            <div class="col-6 col-md-3">
              <div class="h4 text-danger">
                ${questionAttempts.size() - correctCount}
              </div>
              <div class="text-muted small">Sai</div>
            </div>
            <div class="col-6 col-md-3">
              <div class="h4 text-info">
                ${questionAttempts.size()}
              </div>
              <div class="text-muted small">Tổng</div>
            </div>
            <div class="col-6 col-md-3">
              <div class="h4 text-warning">
                ${attempt.completionTimeMinutes}
              </div>
              <div class="text-muted small">Phút</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Navigation Bar -->
    <div class="navigation-bar">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h6 class="mb-0">Điều hướng nhanh:</h6>
        <div class="legend">
          <div class="legend-item">
            <div class="legend-color" style="background-color: #28a745;"></div>
            <span>Đúng</span>
          </div>
          <div class="legend-item">
            <div class="legend-color" style="background-color: #dc3545;"></div>
            <span>Sai</span>
          </div>
          <div class="legend-item">
            <div class="legend-color" style="background-color: #6f42c1;"></div>
            <span>Câu trả lời của bạn</span>
          </div>
        </div>
      </div>
      <ul class="nav nav-pills">
        <c:forEach var="qa" items="${questionAttempts}" varStatus="status">
          <li class="nav-item">
            <a class="nav-link ${qa.isCorrect ? 'correct' : 'incorrect'}"
               href="#question${status.index + 1}">
                ${status.index + 1}
            </a>
          </li>
        </c:forEach>
      </ul>
    </div>

    <!-- Questions Review -->
    <c:forEach var="question" items="${quiz.questions}" varStatus="questionStatus">
      <c:set var="userAnswer" value="${null}" />
      <c:set var="isCorrectAnswer" value="false" />

      <!-- Find user's answer for this question -->
      <c:forEach var="qa" items="${questionAttempts}">
        <c:if test="${qa.question.id == question.id}">
          <c:set var="userAnswer" value="${qa}" />
          <c:set var="isCorrectAnswer" value="${qa.isCorrect}" />
        </c:if>
      </c:forEach>

      <div class="question-review ${isCorrectAnswer ? 'correct' : 'incorrect'}"
           id="question${questionStatus.index + 1}">
        <div class="question-header-review">
          <div class="question-stats">
            <h5 class="mb-0">
              <span class="badge bg-primary me-2">${questionStatus.index + 1}</span>
              Câu hỏi ${questionStatus.index + 1}
            </h5>
            <c:choose>
              <c:when test="${isCorrectAnswer}">
                                    <span class="stat-badge badge-correct">
                                        <i class="fas fa-check me-1"></i>Đúng
                                    </span>
              </c:when>
              <c:otherwise>
                                    <span class="stat-badge badge-incorrect">
                                        <i class="fas fa-times me-1"></i>Sai
                                    </span>
              </c:otherwise>
            </c:choose>
            <span class="text-muted">
                                <c:choose>
                                  <c:when test="${question.type == 'MULTIPLE_CHOICE'}">
                                    <i class="fas fa-list-ul me-1"></i>Trắc nghiệm
                                  </c:when>
                                  <c:when test="${question.type == 'TRUE_FALSE'}">
                                    <i class="fas fa-check-double me-1"></i>Đúng/Sai
                                  </c:when>
                                </c:choose>
                            </span>
          </div>
        </div>

        <div class="question-body-review">
          <h6 class="question-text mb-4">${question.questionText}</h6>

          <div class="answers">
            <c:forEach var="answer" items="${question.answers}" varStatus="answerStatus">
              <div class="answer-review
                                    <c:if test="${answer.isCorrect}">correct-answer</c:if>
                                    <c:if test="${userAnswer != null && userAnswer.selectedAnswer.id == answer.id}">
                                        user-answer ${userAnswer.isCorrect ? 'correct' : 'incorrect'}
                                    </c:if>">

                                    <span class="fw-semibold me-3">
                                        ${answerStatus.index == 0 ? 'A' : answerStatus.index == 1 ? 'B' : answerStatus.index == 2 ? 'C' : 'D'}.
                                    </span>
                <span class="flex-grow-1">${answer.answerText}</span>

                <div class="answer-icon">
                  <c:choose>
                    <c:when test="${answer.isCorrect}">
                      <i class="fas fa-check-circle text-success" title="Đáp án đúng"></i>
                    </c:when>
                    <c:when test="${userAnswer != null && userAnswer.selectedAnswer.id == answer.id && !userAnswer.isCorrect}">
                      <i class="fas fa-times-circle text-danger" title="Câu trả lời của bạn"></i>
                    </c:when>
                    <c:when test="${userAnswer != null && userAnswer.selectedAnswer.id == answer.id && userAnswer.isCorrect}">
                      <i class="fas fa-user-check text-success" title="Câu trả lời đúng của bạn"></i>
                    </c:when>
                  </c:choose>
                </div>
              </div>
            </c:forEach>
          </div>

          <!-- Explanation (if available) -->
          <c:if test="${not empty question.explanation}">
            <div class="explanation-box">
              <h6 class="text-warning">
                <i class="fas fa-lightbulb me-2"></i>Giải thích:
              </h6>
              <p class="mb-0">${question.explanation}</p>
            </div>
          </c:if>
        </div>
      </div>
    </c:forEach>

    <!-- Action Buttons -->
    <div class="action-buttons">
      <div class="mb-3">
        <i class="fas fa-info-circle text-info me-2"></i>
        Bạn có thể xem kết quả tổng quan hoặc tiếp tục học tập
      </div>

      <a href="take-quiz?action=result&attemptId=${attempt.id}"
         class="btn btn-outline-primary btn-custom">
        <i class="fas fa-chart-bar me-2"></i>Xem kết quả
      </a>

      <a href="learning-page" class="btn btn-success btn-custom">
        <i class="fas fa-arrow-right me-2"></i>Tiếp tục học
      </a>

      <c:if test="${attempt.score < 70}">
        <a href="take-quiz?action=start&lessonId=${quiz.lesson.id}"
           class="btn btn-warning btn-custom">
          <i class="fas fa-redo me-2"></i>Làm lại
        </a>
      </c:if>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Smooth scrolling for navigation links
  document.querySelectorAll('.nav-pills .nav-link').forEach(link => {
    link.addEventListener('click', function(e) {
      e.preventDefault();
      const targetId = this.getAttribute('href');
      const targetElement = document.querySelector(targetId);

      if (targetElement) {
        targetElement.scrollIntoView({
          behavior: 'smooth',
          block: 'center'
        });

        // Update active nav item
        document.querySelectorAll('.nav-pills .nav-link').forEach(navLink => {
          navLink.classList.remove('active');
        });
        this.classList.add('active');
      }
    });
  });

  // Back to top button functionality
  window.addEventListener('scroll', function() {
    const backToTop = document.getElementById('backToTop');
    if (window.pageYOffset > 300) {
      backToTop.classList.add('show');
    } else {
      backToTop.classList.remove('show');
    }
  });

  function scrollToTop() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  }

  // Highlight current question in navigation while scrolling
  window.addEventListener('scroll', function() {
    const questions = document.querySelectorAll('.question-review');
    const navLinks = document.querySelectorAll('.nav-pills .nav-link');

    let currentQuestion = 0;
    questions.forEach((question, index) => {
      const rect = question.getBoundingClientRect();
      if (rect.top <= window.innerHeight / 2 && rect.bottom >= window.innerHeight / 2) {
        currentQuestion = index;
      }
    });

    navLinks.forEach((link, index) => {
      if (index === currentQuestion) {
        link.classList.add('active');
      } else {
        link.classList.remove('active');
      }
    });
  });

  // Auto-highlight first question on load
  document.addEventListener('DOMContentLoaded', function() {
    const firstNavLink = document.querySelector('.nav-pills .nav-link');
    if (firstNavLink) {
      firstNavLink.classList.add('active');
    }
  });
</script>
</body>
</html>
