<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lesson Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8fafc; }
        .container { max-width: 100%; width: 90vw; margin: 40px auto; background: #fff; border-radius: 16px; box-shadow: 0 8px 32px 0 rgba(31,38,135,0.10); padding: 2.5rem 2rem; }
        .title { font-size: 2rem; font-weight: 700; color: #185a9d; margin-bottom: 2rem; text-align: center; }
        .label { font-weight: 600; color: #185a9d; }
        @media (max-width: 768px) {
            .container { padding: 1rem 0.5rem; }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-lg-2 col-12 border-end mt-4 mt-lg-0" style="min-height:300px;">
            <div class="fw-bold mb-3 d-flex align-items-center justify-content-between" style="color:#185a9d;font-size:1.2rem">
                <span><i class="fas fa-list me-2"></i>Lesson List</span>
            </div>
            <a href="add-lesson?courseId=${lesson.courseID.id}" class="btn btn-success btn-sm w-100 mb-3"><i class="fas fa-plus me-1"></i>Add New Lesson</a>
            <div class="list-group" style="max-height:70vh;overflow-y:auto;">
                <c:forEach var="ls" items="${lessonList}" varStatus="status">
                    <a href="lesson-details?id=${ls.id}" class="list-group-item list-group-item-action mb-2 ${ls.id == lesson.id ? 'active' : ''} d-flex align-items-center justify-content-between" style="border-radius:8px;">
                        <span class="fw-semibold text-truncate" style="max-width:120px;">${status.index + 1}. ${ls.title}</span>
                        <i class="fas fa-chevron-right small text-muted"></i>
                    </a>
                </c:forEach>
            </div>
        </div>
        <div class="col-lg-10 col-12">

            <div class="title"><i class="fas fa-book-open me-2"></i>Lesson Detail</div>
            <a href="javascript:history.back()" class="btn btn-secondary mb-3">&larr; Back</a>
            <div class="d-flex gap-2 mb-4">
                <a href="edit-lesson?id=${lesson.id}" class="btn btn-outline-warning btn-sm"><i class="fas fa-edit me-1"></i>Edit Lesson</a>
                <button class="btn btn-outline-danger btn-sm" onclick="deleteLesson(${lesson.id})"><i class="fas fa-trash me-1"></i>Delete Lesson</button>
            </div>
            <c:if test="${not empty lesson}">
                <div class="mb-3"><span class="label">Lesson ID:</span> ${lesson.id}</div>
                <div class="mb-3"><span class="label">Title:</span> ${lesson.title}</div>
                <div class="mb-3"><span class="label">Status:</span> <span class="badge bg-secondary">${lesson.status}</span></div>
                <div class="mb-3"><span class="label">Is Preview:</span> <span class="badge ${lesson.isFreePreview ? 'bg-success' : 'bg-danger'}">${lesson.isFreePreview ? 'Yes' : 'No'}</span></div>
                <div class="mb-3"><span class="label">Created At:</span> ${lesson.createdAt}</div>
                <div class="mb-3"><span class="label">Content:</span></div>
                <div class="mb-3 p-3 border rounded bg-light" style="min-height:200px;max-width:100%;overflow-x:auto;">
                    <c:out value="${lesson.content}" escapeXml="false"/>
                </div>

                <!-- Quizzes Section -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="label">Quizzes</span>
                        <a href="addQuiz?lessonId=${lesson.id}" class="btn btn-success btn-sm"><i class="fas fa-plus me-1"></i>Add Quiz</a>
                    </div>
                    <table class="table table-bordered table-sm align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="quiz" items="${quizzes}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${quiz.title}</td>
                                <td>
                                    <a href="quiz-details?id=${quiz.id}" class="btn btn-info btn-sm">
                                        <i class="fas fa-eye me-1"></i>View Details
                                    </a>
                                    <a href="edit-quiz?id=${quiz.id}" class="btn btn-outline-warning btn-sm">
                                        <i class="fas fa-edit me-1"></i>Edit
                                    </a>
                                    <button class="btn btn-outline-danger btn-sm" onclick="deleteQuiz(${quiz.id})">
                                        <i class="fas fa-trash me-1"></i>Delete
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty quizzes}">
                            <tr><td colspan="3" class="text-center text-muted">No quizzes found.</td></tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
                <!-- Materials Section -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="label">Materials</span>
                        <a href="add-material?lessonId=${lesson.id}" class="btn btn-success btn-sm"><i class="fas fa-plus me-1"></i>Add Material</a>
                    </div>
                    <table class="table table-bordered table-sm align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>File</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="material" items="${materials}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${material.title}</td>
                                <td>
                                    <c:if test="${not empty material.fileURL}">
                                        <a href="${material.fileURL}" target="_blank">Download</a>
                                    </c:if>
                                    <c:if test="${empty material.fileURL}">
                                        <span class="text-muted">No file</span>
                                    </c:if>
                                </td>
                                <td>
                                    <a href="edit-material?id=${material.id}" class="btn btn-outline-warning btn-sm"><i class="fas fa-edit me-1"></i>Edit</a>
                                    <button class="btn btn-outline-danger btn-sm" onclick="deleteMaterial(${material.id})"><i class="fas fa-trash me-1"></i>Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty materials}">
                            <tr><td colspan="4" class="text-center text-muted">No materials found.</td></tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-between mt-4">
                    <c:if test="${not empty prevLessonId}">
                        <a href="lesson-details?id=${prevLessonId}" class="btn btn-outline-primary">&larr; Back</a>
                    </c:if>
                    <div></div>
                    <c:if test="${not empty nextLessonId}">
                        <a href="lesson-details?id=${nextLessonId}" class="btn btn-outline-primary">Next &rarr;</a>
                    </c:if>
                </div>
            </c:if>
            <c:if test="${empty lesson}">
                <div class="alert alert-danger">Lesson not found.</div>
            </c:if>
        </div>
    </div>
</div>
<!-- FontAwesome for icon -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
<script>
function deleteLesson(id) {
    if(confirm('Are you sure you want to delete this lesson?')) {
        alert('Delete lesson ' + id);
    }
}
function deleteQuiz(id) {
    if(confirm('Are you sure you want to delete this quiz?')) {
        alert('Delete quiz ' + id);
    }
}
function deleteMaterial(id) {
    if(confirm('Are you sure you want to delete this material?')) {
        alert('Delete material ' + id);
    }
}
</script>
</body>
</html>
