<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Material</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #6a5acd;
            --secondary-color: #7b68ee;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --warning-color: #f1c40f;
            --info-color: #3498db;
        }

        .add-material-container {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(60,60,100,0.15);
            padding: 40px;
        }

        .add-material-title {
            color: var(--primary-color);
            font-weight: 800;
            text-align: center;
            margin-bottom: 32px;
            font-size: 2.2rem;
            letter-spacing: -0.5px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 12px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(106, 90, 205, 0.15);
        }

        .file-upload-wrapper {
            position: relative;
            border: 2px dashed var(--primary-color);
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            background: #f8f9fa;
            transition: all 0.3s ease;
        }

        .file-upload-wrapper:hover {
            background: #eef1f7;
        }

        .file-upload-icon {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 10px;
        }

        .file-types-info {
            margin-top: 16px;
            padding: 12px;
            background: #e8f4fd;
            border-radius: 6px;
            font-size: 0.9rem;
            color: #2980b9;
        }

        .btn-submit {
            background: var(--primary-color);
            color: white;
            padding: 12px 32px;
            border-radius: 8px;
            border: none;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
        }

        .invalid-feedback {
            font-size: 0.85rem;
            color: var(--danger-color);
            margin-top: 4px;
        }

        .alert {
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 24px;
        }

        .alert-info {
            background-color: #e8f4fd;
            border: 1px solid #bde0fe;
            color: #0c63e4;
        }
    </style>
</head>
<body>
<div class="add-material-container">
    <h1 class="add-material-title">Add Course Material</h1>

    <div class="alert alert-info" role="alert">
        <i class="fas fa-info-circle me-2"></i>
        Add learning materials for your course. Supported file types: PDF, DOC, DOCX, PPT, PPTX, ZIP, RAR, MP4, MP3
    </div>

    <form id="materialForm" action="${pageContext.request.contextPath}/course/material/add"
          method="POST" enctype="multipart/form-data" class="needs-validation" novalidate>

        <input type="hidden" name="lessonId" value="${lesson.id}">

        <div class="form-group">
            <label for="title" class="form-label">Title</label>
            <input type="text" class="form-control" id="title" name="title" required
                   minlength="5" maxlength="255"
                   placeholder="Enter material title">
            <div class="invalid-feedback">
                Please enter a title (5-255 characters)
            </div>
        </div>

        <div class="form-group">
            <label class="form-label">Material File</label>
            <div class="file-upload-wrapper">
                <i class="fas fa-cloud-upload-alt file-upload-icon"></i>
                <input type="file" class="form-control" id="file" name="file" required
                       accept=".pdf,.doc,.docx,.ppt,.pptx,.zip,.rar,.mp4,.mp3">
                <p class="mt-2 mb-0">Drag and drop your file here or click to browse</p>
            </div>
            <div class="invalid-feedback">
                Please select a valid file
            </div>
            <div class="file-types-info">
                <i class="fas fa-file-alt me-2"></i>
                Supported formats:
                <span class="badge bg-primary me-1">PDF</span>
                <span class="badge bg-primary me-1">DOC/DOCX</span>
                <span class="badge bg-primary me-1">PPT/PPTX</span>
                <span class="badge bg-primary me-1">ZIP/RAR</span>
                <span class="badge bg-primary">MP4/MP3</span>
                <br>
                <i class="fas fa-exclamation-circle me-2 mt-2"></i>
                Maximum file size: 100MB
            </div>
        </div>

        <div class="text-end">
            <a href="${pageContext.request.contextPath}/lesson/view?id=${lesson.id}"
               class="btn btn-secondary me-2">Cancel</a>
            <button type="submit" class="btn-submit">
                <i class="fas fa-plus me-2"></i>Add Material
            </button>
        </div>
    </form>
</div>

<script>
    (function () {
        'use strict'
        const form = document.getElementById('materialForm')
        const fileInput = document.getElementById('file')
        const maxSize = 100 * 1024 * 1024; // 100MB in bytes

        // Drag and drop functionality
        const dropZone = document.querySelector('.file-upload-wrapper')

        dropZone.addEventListener('dragover', (e) => {
            e.preventDefault()
            dropZone.style.borderColor = '#6a5acd'
            dropZone.style.backgroundColor = '#f0f0ff'
        })

        dropZone.addEventListener('dragleave', (e) => {
            e.preventDefault()
            dropZone.style.borderColor = ''
            dropZone.style.backgroundColor = ''
        })

        dropZone.addEventListener('drop', (e) => {
            e.preventDefault()
            dropZone.style.borderColor = ''
            dropZone.style.backgroundColor = ''

            if (e.dataTransfer.files.length) {
                fileInput.files = e.dataTransfer.files
                validateFile(fileInput.files[0])
            }
        })

        // File validation
        function validateFile(file) {
            const validTypes = [
                'application/pdf',
                'application/msword',
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                'application/vnd.ms-powerpoint',
                'application/vnd.openxmlformats-officedocument.presentationml.presentation',
                'application/zip',
                'application/x-rar-compressed',
                'video/mp4',
                'audio/mpeg'
            ]

            if (!validTypes.includes(file.type)) {
                fileInput.setCustomValidity('Please select a supported file type')
                return false
            }

            if (file.size > maxSize) {
                fileInput.setCustomValidity('File size must be less than 100MB')
                return false
            }

            fileInput.setCustomValidity('')
            return true
        }

        fileInput.addEventListener('change', function(e) {
            if (this.files.length) {
                validateFile(this.files[0])
            }
        })

        form.addEventListener('submit', function (event) {
            if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
            }

            if (fileInput.files.length) {
                if (!validateFile(fileInput.files[0])) {
                    event.preventDefault()
                    event.stopPropagation()
                }
            }

            form.classList.add('was-validated')
        }, false)
    })()
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
