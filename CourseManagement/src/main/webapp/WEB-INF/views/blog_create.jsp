<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Blog</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="margin:0; font-family: 'Segoe UI', Arial, sans-serif; background: #f4f6fb;">
<div style="display:flex; min-height:100vh;">
    <!-- Include Admin Sidebar -->
    <jsp:include page="/WEB-INF/views/_admin_sidebar.jsp" />

    <!-- Main content -->
    <div style="flex:1; padding:48px 0; background:#f4f6fb;">
        <div style="max-width:900px; margin:auto;">
            <div style="background:#fff; border-radius:22px; box-shadow:0 4px 24px rgba(44,44,84,0.13); padding:40px 48px 48px 48px; margin-bottom:36px;">
                <h2 style="font-size:2.2rem; font-weight:800; color:#2c2c54; margin-bottom:38px; letter-spacing:1px; text-align:center;">Create Blog</h2>
                <c:if test="${not empty error}">
                    <div style="color:red; margin-bottom:20px;">${error}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/admin/blog/create" method="post" id="blogForm" class="needs-validation" novalidate>
                    <div style="margin-bottom:16px;">
                        <label for="title" style="display:block; font-weight:600; margin-bottom:8px;">Title:</label>
                        <input type="text" id="title" name="title" required
                               minlength="10" maxlength="200"
                               class="form-control"
                               style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                        <div class="invalid-feedback">
                            Title must be between 10 and 200 characters
                        </div>
                    </div>

                    <div style="margin-bottom:16px;">
                        <label for="content" style="display:block; font-weight:600; margin-bottom:8px;">Content:</label>
                        <textarea id="content" name="content" rows="5" required
                                  minlength="50"
                                  class="form-control"
                                  style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;"></textarea>
                        <div class="invalid-feedback">
                            Content must be at least 50 characters long
                        </div>
                    </div>

                    <div style="margin-bottom:16px;">
                        <label for="imageURL" style="display:block; font-weight:600; margin-bottom:8px;">Image URL:</label>
                        <input type="url" id="imageURL" name="imageURL"
                               pattern="https?://.+"
                               class="form-control"
                               style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                        <div class="invalid-feedback">
                            Please enter a valid URL starting with http:// or https://
                        </div>
                    </div>

                    <div style="margin-bottom:16px;">
                        <label for="status" style="display:block; font-weight:600; margin-bottom:8px;">Status:</label>
                        <select id="status" name="status" required class="form-control"
                                style="width:100%; padding:8px; border:1px solid #ccc; border-radius:4px;">
                            <option value="">Select a status</option>
                            <option value="draft">Draft</option>
                            <option value="published">Published</option>
                        </select>
                        <div class="invalid-feedback">
                            Please select a status
                        </div>
                    </div>

                    <div style="text-align:right;">
                        <button type="submit" class="btn btn-primary">Create Blog</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    (function() {
        'use strict';
        const form = document.getElementById('blogForm');

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
    })();
</script>
</body>
</html>
