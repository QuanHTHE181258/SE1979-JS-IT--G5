<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="project.demo.coursemanagement.entities.Cours" %>
<%@ page import="project.demo.coursemanagement.utils.SessionUtil" %>
<%@ page import="java.util.Objects" %>
<%
    // Get user from request scope (must be set in servlet)
    Integer userID = SessionUtil.getUserId(request);
    List<Cours> courses = (List<Cours>) request.getAttribute("courses"); // get from servlet
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Lesson</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                padding-top: 50px;
                padding-bottom: 50px;
            }
            .container {
                max-width: 800px;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2 class="text-center mb-4">Add New Lesson</h2>

            <%
                String success = request.getParameter("success");
                String error = request.getParameter("error");
                if (success != null) {
            %>
            <div class="alert alert-success">
                Lesson added successfully!
            </div>
            <%
                } else if (error != null) {
            %>
            <div class="alert alert-danger">
                Failed to add lesson!
            </div>
            <%
                }
            %>

            <!-- Add Lesson Form -->
            <form action="LessonController" method="post">
                <input type="hidden" name="action" value="addLesson"/>

                <div class="mb-3">
                    <label for="courseId" class="form-label">Select Course:</label>
                    <select name="courseId" id="courseId" class="form-select" required>
                        <option value="">-- Select a course --</option>
                        <%
                            if (courses != null && !courses.isEmpty()) {
                                for (Cours course : courses) {
                                    if (Objects.equals(course.getInstructorID().getId(), userID)) {
                        %>
                        <option value="<%= course.getId() %>"><%= course.getTitle() %></option>
                        <%
                                    }
                                }
                            } else {
                        %>
                        <option disabled>No courses available.</option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="title" class="form-label">Lesson Title:</label>
                    <input type="text" class="form-control" id="title" name="title" required/>
                </div>

                <div class="mb-3">
                    <label for="content" class="form-label">Lesson Content:</label>
                    <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="videoUrl" class="form-label">Video URL:</label>
                    <input type="text" class="form-control" id="videoUrl" name="videoUrl"/>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Add Lesson</button>
                </div>
            </form>

            <a href="LessonController?action=manageLesson" class="d-block mt-3">Back to Lesson List</a>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>