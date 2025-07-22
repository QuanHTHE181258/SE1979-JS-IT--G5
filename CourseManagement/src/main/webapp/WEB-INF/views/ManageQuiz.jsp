<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="project.demo.coursemanagement.entities.*" %>
<%
    List<Cours> courses = (List<Cours>) request.getAttribute("courses");
    List<Lesson> lessons = (List<Lesson>) request.getAttribute("lessons");
    List<Quiz> quizzes = (List<Quiz>) request.getAttribute("quizzes");
    Map<Integer, List<Question>> questionsMap = (Map<Integer, List<Question>>) request.getAttribute("questions");
    Map<Integer, List<Answer>> answersMap = (Map<Integer, List<Answer>>) request.getAttribute("answers");

    String lessonIdStr = request.getParameter("lessonId");
    String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quiz Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">

<h2 class="mb-4">Quiz Management</h2>

<% if ("success".equals(message)) { %>
<script>
    window.onload = function () {
        alert("Saved successfully!");
    }
</script>
<% } %>

<% if (quizzes == null || quizzes.isEmpty()) { %>
<!-- Create New Quiz Form -->
<div class="card mb-4">
    <div class="card-body">
        <h5 class="card-title">Create New Quiz</h5>
        <form method="post" action="QuizController" class="row g-3">
            <input type="hidden" name="action" value="createQuiz"/>
            <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>

            <div class="col-md-6">
                <label class="form-label">Quiz Title</label>
                <input type="text" name="title" class="form-control" required/>
            </div>

            <div class="col-md-6">
                <label class="form-label">Duration (minutes)</label>
                <input type="number" name="duration" class="form-control" min="1" required/>
            </div>

            <div class="col-12">
                <button type="submit" class="btn btn-success">Add New Quiz</button>
            </div>
        </form>
    </div>
</div>

<% } else {
    Quiz quizToEdit = quizzes.get(0);
%>
<!-- Edit Quiz Form -->
<div class="card mb-4">
    <div class="card-body">
        <h5 class="card-title">Edit Quiz</h5>
        <form method="post" action="QuizController" class="row g-3">
            <input type="hidden" name="action" value="editQuiz"/>
            <input type="hidden" name="quizId" value="<%= quizToEdit.getId() %>"/>
            <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>

            <div class="col-md-6">
                <label class="form-label">Quiz Title</label>
                <input type="text" name="title" class="form-control" value="<%= quizToEdit.getTitle() %>" required/>
            </div>

            <div class="col-md-6">
                <label class="form-label">Duration (minutes)</label>
                <input type="number" name="duration" class="form-control" min="1"
                       value="<%= quizToEdit.getDurationMinutes() %>" required/>
            </div>

            <div class="col-12 d-flex gap-2">
                <button type="submit" class="btn btn-primary">Save Changes</button>
            </div>
        </form>
        <form method="post" action="QuizController"
              onsubmit="return confirm('Are you sure you want to delete this quiz?');">
            <input type="hidden" name="action" value="deleteQuiz"/>
            <input type="hidden" name="quizId" value="<%= quizToEdit.getId() %>"/>
            <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>
            <button type="submit" class="btn btn-danger">Delete Quiz</button>
        </form>
    </div>
</div>
<% } %>

<% if (quizzes != null && !quizzes.isEmpty()) {
    for (Quiz q : quizzes) {
%>
<div class="card mb-4">
    <div class="card-header bg-primary text-white">
        <strong><%= q.getTitle() %>
        </strong> (Duration: <%= q.getDurationMinutes() %> minutes)
    </div>

    <div class="card-body">
        <%
            List<Question> questions = (questionsMap != null) ? questionsMap.get(q.getId()) : null;
            if (questions != null) {
                for (Question ques : questions) {
        %>
        <div class="mb-4 p-3 border rounded">
            <div class="d-flex justify-content-between align-items-start">
                <h6><strong>Question:</strong> <%= ques.getQuestionText() %>
                </h6>
                <form method="post" action="QuizController"
                      onsubmit="return confirm('Are you sure you want to delete this question?');">
                    <input type="hidden" name="action" value="deleteQuestion"/>
                    <input type="hidden" name="questionId" value="<%= ques.getId() %>"/>
                    <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>
                    <button type="submit" class="btn btn-danger btn-sm">Delete Question</button>
                </form>
            </div>

            <%
                List<Answer> answerOptions = (answersMap != null) ? answersMap.get(ques.getId()) : null;
                if (answerOptions != null) {
            %>
            <!-- Edit Answer Options Form -->
            <form method="post" action="QuizController" class="mt-3">
                <input type="hidden" name="action" value="editAnswersBulk"/>
                <input type="hidden" name="questionId" value="<%= ques.getId() %>"/>
                <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>

                <% for (Answer ao : answerOptions) { %>
                <div class="d-flex align-items-center gap-2 mb-2">
                    <input type="hidden" name="answerIds" value="<%= ao.getId() %>"/>
                    <input type="text" name="answerTexts" value="<%= ao.getAnswerText() %>"
                           class="form-control form-control-sm flex-grow-1" required/>

                    <div class="form-check form-check-inline mb-0">
                        <input class="form-check-input" type="checkbox" name="correctAnswers" value="<%= ao.getId() %>"
                               id="correct_<%= ao.getId() %>" <%= ao.getIsCorrect() ? "checked" : "" %>
                                <% if (answerOptions.stream().filter(a -> a.getIsCorrect()).count() > 0 && !ao.getIsCorrect()) { %>
                               disabled <% } %> />
                        <label class="form-check-label" for="correct_<%= ao.getId() %>">Correct</label>
                    </div>

                    <!-- Button for Deleting Answer -->
                    <button type="button" class="btn btn-danger btn-sm" onclick="confirmDelete('<%= ao.getId() %>')">
                        Delete
                    </button>
                </div>
                <% } %>

                <button type="submit" class="btn btn-primary btn-sm mt-2">Save Answer Changes</button>
            </form>

            <!-- Delete Answer Confirmation Modal (if needed) -->
            <script>
                function confirmDelete(optionId) {
                    if (confirm('Are you sure you want to delete this answer?')) {
                        var form = document.createElement('form');
                        form.method = 'post';
                        form.action = 'QuizController';

                        var actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        actionInput.value = 'deleteAnswer';
                        form.appendChild(actionInput);

                        var answerIdInput = document.createElement('input');
                        answerIdInput.type = 'hidden';
                        answerIdInput.name = 'answerId';
                        answerIdInput.value = optionId;
                        form.appendChild(answerIdInput);

                        var lessonIdInput = document.createElement('input');
                        lessonIdInput.type = 'hidden';
                        lessonIdInput.name = 'lessonId';
                        lessonIdInput.value = '<%= lessonIdStr != null ? lessonIdStr : "" %>';
                        form.appendChild(lessonIdInput);

                        document.body.appendChild(form);
                        form.submit();
                    }
                }
            </script>

            <% } %>


            <!-- Add New Answer Form -->
            <form method="post" action="QuizController" class="row g-2 align-items-center mt-3">
                <input type="hidden" name="action" value="addAnswer"/>
                <input type="hidden" name="questionId" value="<%= ques.getId() %>"/>
                <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>

                <div class="col-md-6">
                    <input type="text" name="answerText" class="form-control" placeholder="New Answer" required/>
                </div>

                <div class="col-md-3">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" name="isCorrect" value="1"
                               id="newCorrect_<%= ques.getId() %>">
                        <label class="form-check-label" for="newCorrect_<%= ques.getId() %>">Correct</label>
                    </div>
                </div>

                <div class="col-md-3">
                    <button class="btn btn-success" type="submit">Add Answer</button>
                </div>
            </form>
        </div>
        <% }
        } %>

        <!-- Add New Question Form -->
        <form method="post" action="QuizController" class="row g-2 mt-4">
            <input type="hidden" name="action" value="addQuestion"/>
            <input type="hidden" name="quizId" value="<%= q.getId() %>"/>
            <input type="hidden" name="lessonId" value="<%= lessonIdStr != null ? lessonIdStr : "" %>"/>

            <div class="col-md-8">
                <input type="text" name="questionText" class="form-control" placeholder="New Question" required/>
            </div>

            <div class="col-md-4">
                <button class="btn btn-success" type="submit">Add Question</button>
            </div>
        </form>
    </div>
</div>
<% }
} else { %>
<div class="alert alert-warning">No quizzes have been created for this lesson yet.</div>
<% } %>

<a href="LessonController?action=manageLesson" class="btn btn-secondary mt-4">Back to Lesson List</a>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
