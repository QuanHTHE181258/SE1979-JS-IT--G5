<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Material</title>
    <link href="${pageContext.request.contextPath}/css/admincss.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            margin: 0;
        }

        .edit-material-container {
            max-width: 600px;
            margin: 2rem auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            position: relative;
            overflow: hidden;
        }

        .edit-material-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2, #f093fb);
            border-radius: 24px 24px 0 0;
        }

        .page-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .page-title {
            color: #2d3748;
            font-weight: 700;
            font-size: 2.25rem;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .page-title i {
            color: #667eea;
            font-size: 2rem;
        }

        .page-subtitle {
            color: #718096;
            font-size: 1.1rem;
            font-weight: 400;
        }

        .form-group {
            margin-bottom: 2rem;
            position: relative;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 0.75rem;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label i {
            color: #667eea;
            font-size: 0.9rem;
        }

        .form-control {
            width: 100%;
            padding: 1rem 1.25rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #fff;
            color: #2d3748;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-1px);
        }

        .form-control:hover {
            border-color: #cbd5e0;
        }

        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
        }

        .file-input-custom {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            padding: 1.5rem;
            border: 2px dashed #cbd5e0;
            border-radius: 12px;
            background: #f7fafc;
            cursor: pointer;
            transition: all 0.3s ease;
            color: #4a5568;
            font-weight: 500;
        }

        .file-input-custom:hover {
            border-color: #667eea;
            background: #edf2f7;
            transform: translateY(-1px);
        }

        .file-input-custom i {
            font-size: 1.5rem;
            color: #667eea;
        }

        .file-input-custom input[type="file"] {
            position: absolute;
            left: -9999px;
        }

        .current-file {
            background: #e6fffa;
            border: 1px solid #81e6d9;
            border-radius: 8px;
            padding: 0.75rem 1rem;
            margin-top: 0.5rem;
            color: #234e52;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .current-file i {
            color: #38b2ac;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 3rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.875rem 2rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            min-width: 140px;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #f7fafc;
            color: #4a5568;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #edf2f7;
            border-color: #cbd5e0;
            transform: translateY(-1px);
        }

        .alert {
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
        }

        .alert-danger {
            background: #fed7d7;
            color: #742a2a;
            border: 1px solid #feb2b2;
        }

        .alert-success {
            background: #c6f6d5;
            color: #22543d;
            border: 1px solid #9ae6b4;
        }

        .input-hint {
            font-size: 0.875rem;
            color: #718096;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .input-hint i {
            font-size: 0.75rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .edit-material-container {
                margin: 1rem;
                padding: 2rem 1.5rem;
            }

            .page-title {
                font-size: 1.75rem;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        /* Loading Animation */
        .loading {
            position: relative;
            pointer-events: none;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top: 2px solid #fff;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<div class="wrapper">
    <jsp:include page="_admin_sidebar.jsp" />
    <div id="content">
        <div class="edit-material-container">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-edit"></i>
                    Edit Material
                </h1>
                <p class="page-subtitle">Update material information and content</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i>
                        ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                        ${success}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/edit-material" method="post" enctype="multipart/form-data" id="editForm">
                <input type="hidden" name="id" value="${material.id}" />
                <input type="hidden" name="lessonId" value="${material.lessonId}" />

                <div class="form-group">
                    <label for="title" class="form-label">
                        <i class="fas fa-heading"></i>
                        Material Title
                    </label>
                    <input type="text"
                           id="title"
                           name="title"
                           class="form-control"
                           required
                           value="${material.title}"
                           placeholder="Enter a descriptive title for your material..." />
                    <div class="input-hint">
                        <i class="fas fa-info-circle"></i>
                        Choose a clear, descriptive title that helps students understand the content
                    </div>
                </div>

                <div class="form-group">
                    <label for="fileUrl" class="form-label">
                        <i class="fas fa-link"></i>
                        File URL
                    </label>
                    <input type="text"
                           id="fileUrl"
                           name="fileUrl"
                           class="form-control"
                           value="${material.fileURL}"
                           placeholder="https://example.com/your-file.pdf" />
                    <div class="input-hint">
                        <i class="fas fa-info-circle"></i>
                        Enter a direct link to your material file (optional if uploading)
                    </div>
                    <c:if test="${not empty material.fileURL}">
                        <div class="current-file">
                            <i class="fas fa-file"></i>
                            Current file: <a href="${material.fileURL}" target="_blank" style="color: #38b2ac; text-decoration: none;">View current file</a>
                        </div>
                    </c:if>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <i class="fas fa-cloud-upload-alt"></i>
                        Upload New File
                    </label>
                    <div class="file-input-wrapper">
                        <label class="file-input-custom">
                            <i class="fas fa-upload"></i>
                            <span id="file-label">Choose file to upload</span>
                            <input type="file" id="file" name="file" accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.txt,.zip" />
                        </label>
                    </div>
                    <div class="input-hint">
                        <i class="fas fa-info-circle"></i>
                        Supported formats: PDF, DOC, DOCX, PPT, PPTX, XLS, XLSX, TXT, ZIP (Max: 10MB)
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary" id="saveBtn">
                        <i class="fas fa-save"></i>
                        Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/lesson-details?id=${material.lessonId}" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // File input handling
        const fileInput = document.getElementById('file');
        const fileLabel = document.getElementById('file-label');

        fileInput.addEventListener('change', function() {
            if (this.files && this.files.length > 0) {
                const fileName = this.files[0].name;
                const fileSize = (this.files[0].size / (1024 * 1024)).toFixed(2);
                fileLabel.innerHTML = `<i class="fas fa-file"></i> ${fileName} (${fileSize} MB)`;
            } else {
                fileLabel.innerHTML = '<i class="fas fa-upload"></i> Choose file to upload';
            }
        });

        // Form submission handling
        const form = document.getElementById('editForm');
        const saveBtn = document.getElementById('saveBtn');

        form.addEventListener('submit', function() {
            saveBtn.classList.add('loading');
            saveBtn.disabled = true;
            saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
        });

        // Input validation
        const titleInput = document.getElementById('title');
        titleInput.addEventListener('input', function() {
            if (this.value.trim().length < 3) {
                this.style.borderColor = '#f56565';
            } else {
                this.style.borderColor = '#48bb78';
            }
        });

        // Auto-resize and smooth interactions
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });
    });
</script>
</body>
</html>