<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Lesson</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
    <style>
        body { background: #f8fafc; }
        .container { max-width: 800px; margin: 40px auto; background: #fff; border-radius: 16px; box-shadow: 0 8px 32px 0 rgba(31,38,135,0.10); padding: 2.5rem 2rem; }
        .title { font-size: 2rem; font-weight: 700; color: #185a9d; margin-bottom: 2rem; text-align: center; }
        .ck-editor__editable[role="textbox"] {
            min-height: 300px;
            max-height: 500px;
            overflow-y: auto;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="title">
        <i class="fas fa-edit me-2"></i>Edit Lesson
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
            ${error}
        </div>
    </c:if>

    <form action="edit-lesson" method="post">
        <input type="hidden" name="id" value="${lesson.id}">
        <input type="hidden" name="courseId" value="${lesson.courseID.id}">

        <div class="mb-3">
            <label for="title" class="form-label">Lesson Title</label>
            <input type="text" class="form-control" id="title" name="title" value="${lesson.title}" required>
        </div>

        <div class="mb-3">
            <label for="editor" class="form-label">Content</label>
            <textarea id="editor" name="content" required>${lesson.content}</textarea>
        </div>

        <div class="mb-3">
            <label for="status" class="form-label">Status</label>
            <select class="form-select" id="status" name="status" required>
                <option value="draft" ${lesson.status == 'draft' ? 'selected' : ''}>Draft</option>
                <option value="published" ${lesson.status == 'published' ? 'selected' : ''}>Published</option>
            </select>
        </div>

        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="isFreePreview" name="isFreePreview" ${lesson.isFreePreview ? 'checked' : ''}>
            <label class="form-check-label" for="isFreePreview">Free Preview</label>
        </div>

        <div class="d-flex justify-content-end gap-2">
            <a href="course-lessons?id=${lesson.courseID.id}" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="btn btn-primary">Save Changes</button>
        </div>
    </form>
</div>

<!-- FontAwesome for icons -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>

<!-- Initialize CKEditor -->
<script>
    ClassicEditor
        .create(document.querySelector('#editor'))
        .catch(error => {
            console.error(error);
        });
</script>
</body>
</html>
