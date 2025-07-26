<%@ page import="project.demo.coursemanagement.entities.Lesson" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Lesson lesson = (Lesson) request.getAttribute("lesson");
%>
<html>
<head>
    <title>Edit Lesson</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">Edit Lesson</h1>

    <% if (lesson == null) { %>
    <div class="alert alert-danger" role="alert">
        Không tìm thấy bài học.
    </div>
    <% }
        assert lesson != null;%>

    <form method="post" action="LessonController">
        <input type="hidden" name="action" value="updateLesson">
        <input type="hidden" name="lessonId" value="<%= lesson.getId() %>">

        <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" id="title" name="title"
                   value="<%= lesson.getTitle() != null ? lesson.getTitle() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="content" class="form-label">Content</label>
            <textarea class="form-control" id="content" name="content" rows="5" required><%= lesson.getContent() != null ? lesson.getContent() : "" %></textarea>
        </div>

        <%--                <div class="mb-3">--%>
        <%--                    <label for="videoUrl" class="form-label">Video URL</label>--%>
        <%--                    <input type="text" class="form-control" id="videoUrl" name="videoUrl"--%>
        <%--                           value="<%= lesson.getVidURL() != null ? lesson.getVidURL() : "" %>">--%>
        <%--                </div>--%>

        <button type="submit" class="btn btn-primary">Update Lesson</button>
        <a href="LessonController?action=manageLesson" class="btn btn-secondary">Cancel</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
