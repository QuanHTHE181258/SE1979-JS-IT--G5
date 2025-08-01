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
    <script src="https://cdn.ckeditor.com/ckeditor5/40.0.0/classic/ckeditor.js"></script>
    <style>
        .ck-editor__editable_inline {
            min-height: 400px;
        }
        .image-preview {
            max-width: 200px;
            margin-top: 10px;
            border-radius: 4px;
            display: none;
        }
        .custom-file-upload {
            border: 1px solid #ccc;
            display: inline-block;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 4px;
            background: #f8f9fa;
        }
        input[type="file"] {
            display: none;
        }
    </style>
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

                <form action="${pageContext.request.contextPath}/admin/blog/edit" method="post" id="blogEditForm"
                      class="needs-validation" novalidate enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${blog.id}">

                    <div style="margin-bottom:24px;">
                        <label for="title" style="display:block; margin-bottom:8px; font-weight:500; color:#2c3e50;">Title</label>
                        <input type="text" id="title" name="title" value="${blog.title}" required
                               minlength="10" maxlength="200"
                               style="width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:1em;">
                        <div class="invalid-feedback">Title must be between 10 and 200 characters</div>
                    </div>

                    <div style="margin-bottom:24px;">
                        <label for="content" style="display:block; margin-bottom:8px; font-weight:500; color:#2c3e50;">Content</label>
                        <textarea id="content" name="content" required>${blog.content}</textarea>
                        <div class="invalid-feedback">Content is required</div>
                    </div>

                    <div style="margin-bottom:24px;">
                        <label style="display:block; margin-bottom:8px; font-weight:500; color:#2c3e50;">Blog Image</label>
                        <label for="imageFile" class="custom-file-upload">
                            <i class="fas fa-upload"></i> Choose Image
                        </label>
                        <input type="file" id="imageFile" name="imageFile" accept="image/*"
                               onchange="previewImage(this);">
                        <img id="imagePreview" src="${blog.imageURL}" alt="Preview"
                             class="image-preview" style="${not empty blog.imageURL ? 'display: block;' : ''}">
                    </div>

                    <div style="margin-bottom:32px;">
                        <label for="status" style="display:block; margin-bottom:8px; font-weight:500; color:#2c3e50;">Status</label>
                        <select id="status" name="status" required
                                style="width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:1em;">
                            <option value="">Select a status</option>
                            <option value="draft" ${blog.status == 'draft' ? 'selected' : ''}>Draft</option>
                            <option value="published" ${blog.status == 'published' ? 'selected' : ''}>Published</option>
                        </select>
                        <div class="invalid-feedback">Please select a status</div>
                    </div>

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
                    ClassicEditor
                        .create(document.querySelector('#content'), {
                            toolbar: ['heading', '|', 'bold', 'italic', 'link', 'bulletedList', 'numberedList', 'blockQuote', '|', 'insertImage', '|', 'undo', 'redo'],
                            simpleUpload: {
                                uploadUrl: '${pageContext.request.contextPath}/admin/blog/upload-image'
                            }
                        })
                        .catch(error => {
                            console.error(error);
                        });

                    function previewImage(input) {
                        const preview = document.getElementById('imagePreview');
                        if (input.files && input.files[0]) {
                            const reader = new FileReader();
                            reader.onload = function(e) {
                                preview.src = e.target.result;
                                preview.style.display = 'block';
                            }
                            reader.readAsDataURL(input.files[0]);
                        }
                    }

                    (function() {
                        'use strict';
                        const form = document.getElementById('blogEditForm');

                        form.addEventListener('submit', function(event) {
                            if (!form.checkValidity()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    })();
                </script>
            </div>
        </div>
    </div>
</div>
</body>
</html>
