<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Blog</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="margin:0; font-family: 'Segoe UI', Arial, sans-serif; background: #f4f6fb;">
<div style="display:flex; min-height:100vh;">
    <!-- Include Admin Sidebar -->
    <jsp:include page="_admin_sidebar.jsp">
        <jsp:param name="active" value="blogs"/>
    </jsp:include>

    <!-- Main Content -->
    <div style="flex:1; padding:48px 0; margin-left: 280px;">
        <div style="max-width:900px; margin:auto; padding:0 24px;">
            <!-- Back Button -->
            <a href="${pageContext.request.contextPath}/admin/blog/list"
               style="display:inline-flex; align-items:center; text-decoration:none; color:#3498db; margin-bottom:24px;">
                <i class="fas fa-arrow-left" style="margin-right:8px;"></i> Back to Blog List
            </a>

            <!-- Edit Form Card -->
            <div style="background:white; border-radius:12px; box-shadow:0 4px 16px rgba(0,0,0,0.1); padding:32px;">
                <h1 style="font-size:2rem; color:#2c2c54; margin:0 0 32px 0;">Edit Blog</h1>

                <c:if test="${not empty error}">
                    <div style="background:#ffe5e5; color:#d63031; padding:12px 16px; border-radius:6px; margin-bottom:24px;">
                            ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/blog/edit" method="post" id="blogEditForm" class="needs-validation" novalidate>
                    <input type="hidden" name="id" value="${blog.id}">

                    <div style="margin-bottom:24px;">
                        <label for="title" style="display:block; margin-bottom:8px; font-weight:500; color:#2c3e50;">Title</label>
                        <input type="text" id="title" name="title" value="${blog.title}" required
                               minlength="10" maxlength="200"
                               style="width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:1em;">
                        <div class="invalid-feedback" style="color: #e74c3c; font-size: 0.875em; margin-top: 4px;">
                            Title must be between 10 and 200 characters
                        </div>
                    </div>

                    <div style="margin-bottom:24px;">
                        <label for="content" style="display:block; margin-bottom:8px; font-weight:500; color:#2c3e50;">Content</label>
                        <textarea id="content" name="content" rows="10" required
                                  minlength="50"
                                  style="width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:1em; resize:vertical;">${blog.content}</textarea>
                        <div class="invalid-feedback" style="color: #e74c3c; font-size: 0.875em; margin-top: 4px;">
                            Content must be at least 50 characters long
                        </div>
                    </div>

                    <div style="margin-bottom:24px;">
                        <label for="imageURL" style="display:block; margin-bottom:8px; font-weight:500; color:#2c3e50;">Image URL</label>
                        <input type="url" id="imageURL" name="imageURL" value="${blog.imageURL}"
                               pattern="https?://.+"
                               style="width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:1em;">
                        <div class="invalid-feedback" style="color: #e74c3c; font-size: 0.875em; margin-top: 4px;">
                            Please enter a valid URL starting with http:// or https://
                        </div>
                    </div>

                    <div style="margin-bottom:32px;">
                        <label for="status" style="display:block; margin-bottom:8px; font-weight:500; color:#2c3e50;">Status</label>
                        <select id="status" name="status" required
                                style="width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:1em;">
                            <option value="">Select a status</option>
                            <option value="draft" ${blog.status == 'draft' ? 'selected' : ''}>Draft</option>
                            <option value="published" ${blog.status == 'published' ? 'selected' : ''}>Published</option>
                        </select>
                        <div class="invalid-feedback" style="color: #e74c3c; font-size: 0.875em; margin-top: 4px;">
                            Please select a status
                        </div>
                    </div>

                    <!-- Preview Current Image -->
                    <c:if test="${not empty blog.imageURL}">
                        <div style="margin-bottom:24px;">
                            <p style="font-weight:500; color:#2c3e50; margin-bottom:8px;">Current Image:</p>
                            <img src="${blog.imageURL}" alt="Current blog image"
                                 style="max-width:300px; border-radius:6px; box-shadow:0 2px 8px rgba(0,0,0,0.1);">
                        </div>
                    </c:if>

                    <!-- Action Buttons -->
                    <div style="display:flex; gap:16px; justify-content:flex-end;">
                        <a href="${pageContext.request.contextPath}/admin/blog/list"
                           class="btn-cancel"
                           style="padding:10px 20px; border-radius:6px; text-decoration:none; color:#666; background:#f0f0f0;">
                            Cancel
                        </a>
                        <button type="submit"
                                style="padding:10px 20px; border-radius:6px; border:none; background:#3498db; color:white; cursor:pointer;">
                            Save Changes
                        </button>
                    </div>
                </form>

                <script>
                    (function() {
                        'use strict';
                        const form = document.getElementById('blogEditForm');

                        form.addEventListener('submit', function(event) {
                            if (!form.checkValidity()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }

                            // Custom validation for content length
                            const content = document.getElementById('content');
                            if (content.value.trim().length < 50) {
                                content.setCustomValidity('Content must be at least 50 characters long');
                                event.preventDefault();
                            } else {
                                content.setCustomValidity('');
                            }

                            // Custom validation for image URL format
                            const imageURL = document.getElementById('imageURL');
                            if (imageURL.value && !imageURL.value.match(/^https?:\/\/.+/)) {
                                imageURL.setCustomValidity('Please enter a valid URL starting with http:// or https://');
                                event.preventDefault();
                            } else {
                                imageURL.setCustomValidity('');
                            }

                            form.classList.add('was-validated');
                        }, false);

                        // Auto-resize textarea
                        const textarea = document.getElementById('content');
                        textarea.addEventListener('input', function() {
                            this.style.height = 'auto';
                            this.style.height = (this.scrollHeight + 2) + 'px';
                        });
                    })();
                </script>
            </div>
        </div>
    </div>
</div>
</body>
</html>
