<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Lesson</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #667eea;
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-color: #f093fb;
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-color: #4ecdc4;
            --warning-color: #ffe066;
            --danger-color: #ff6b6b;
            --dark-color: #2c3e50;
            --light-color: #ecf0f1;
            --shadow-light: 0 8px 32px 0 rgba(31, 38, 135, 0.15);
            --shadow-medium: 0 12px 40px 0 rgba(31, 38, 135, 0.25);
            --border-radius: 16px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 2rem 1rem;
        }

        .main-container {
            max-width: 900px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-medium);
            overflow: hidden;
            position: relative;
        }

        .main-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: var(--primary-gradient);
            z-index: 1;
        }

        .header-section {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            padding: 2.5rem 2rem 2rem;
            text-align: center;
            position: relative;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
            position: relative;
        }

        .page-subtitle {
            color: #6c757d;
            font-size: 1.1rem;
            font-weight: 400;
            margin-bottom: 0;
        }

        .form-container {
            padding: 2.5rem 2rem;
        }

        .form-group {
            margin-bottom: 2rem;
            position: relative;
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.75rem;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label i {
            color: var(--primary-color);
            width: 16px;
        }

        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 0.875rem 1rem;
            font-size: 1rem;
            transition: var(--transition);
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.15);
            transform: translateY(-2px);
        }

        .form-control:hover, .form-select:hover {
            border-color: var(--primary-color);
            transform: translateY(-1px);
        }

        .ck-editor__editable[role="textbox"] {
            min-height: 350px;
            max-height: 600px;
            border-radius: 12px;
            border: 2px solid #e9ecef;
            transition: var(--transition);
        }

        .ck-editor__editable:focus {
            border-color: var(--primary-color);
        }

        .form-check {
            background: rgba(102, 126, 234, 0.05);
            border-radius: 12px;
            padding: 1rem 1.25rem;
            border: 2px solid transparent;
            transition: var(--transition);
        }

        .form-check:hover {
            background: rgba(102, 126, 234, 0.1);
            border-color: rgba(102, 126, 234, 0.2);
        }

        .form-check-input {
            width: 1.25rem;
            height: 1.25rem;
            margin-right: 0.75rem;
            border: 2px solid var(--primary-color);
        }

        .form-check-input:checked {
            background: var(--primary-gradient);
            border-color: var(--primary-color);
        }

        .form-check-label {
            font-weight: 500;
            color: var(--dark-color);
            font-size: 1rem;
            cursor: pointer;
        }

        .btn {
            border-radius: 12px;
            padding: 0.875rem 2rem;
            font-weight: 600;
            font-size: 1rem;
            transition: var(--transition);
            border: none;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #95a5a6 0%, #7f8c8d 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(149, 165, 166, 0.3);
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(149, 165, 166, 0.4);
        }

        .button-group {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            padding-top: 1.5rem;
            border-top: 2px solid rgba(102, 126, 234, 0.1);
            margin-top: 2rem;
        }

        .alert {
            border: none;
            border-radius: 12px;
            padding: 1rem 1.25rem;
            margin-bottom: 2rem;
            font-weight: 500;
            position: relative;
            overflow: hidden;
        }

        .alert-danger {
            background: linear-gradient(135deg, rgba(255, 107, 107, 0.1) 0%, rgba(255, 107, 107, 0.05) 100%);
            color: #c0392b;
            border-left: 4px solid var(--danger-color);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            margin-top: 0.5rem;
        }

        .status-draft {
            background: linear-gradient(135deg, rgba(255, 224, 102, 0.2) 0%, rgba(255, 224, 102, 0.1) 100%);
            color: #f39c12;
        }

        .status-published {
            background: linear-gradient(135deg, rgba(78, 205, 196, 0.2) 0%, rgba(78, 205, 196, 0.1) 100%);
            color: #27ae60;
        }

        .floating-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
        }

        .floating-elements::before,
        .floating-elements::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            background: rgba(102, 126, 234, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        .floating-elements::before {
            width: 100px;
            height: 100px;
            top: 10%;
            right: 10%;
            animation-delay: -2s;
        }

        .floating-elements::after {
            width: 60px;
            height: 60px;
            bottom: 20%;
            left: 15%;
            animation-delay: -4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem 0.5rem;
            }

            .header-section {
                padding: 2rem 1.5rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .form-container {
                padding: 2rem 1.5rem;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* Smooth loading animation */
        .main-container {
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Enhanced form focus states */
        .form-group:focus-within .form-label {
            color: var(--primary-color);
            transform: translateX(5px);
        }

        /* Custom scrollbar for content editor */
        .ck-editor__editable::-webkit-scrollbar {
            width: 8px;
        }

        .ck-editor__editable::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 4px;
        }

        .ck-editor__editable::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 4px;
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="floating-elements"></div>

    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-edit"></i>
            Edit Lesson
        </h1>
        <p class="page-subtitle">Enhance your course content with rich editing tools</p>
    </div>

    <div class="form-container">
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                    ${error}
            </div>
        </c:if>

        <form action="edit-lesson" method="post">
            <input type="hidden" name="id" value="${lesson.id}">
            <input type="hidden" name="courseId" value="${lesson.courseID.id}">

            <div class="form-group">
                <label for="title" class="form-label">
                    <i class="fas fa-heading"></i>
                    Lesson Title
                </label>
                <input type="text"
                       class="form-control"
                       id="title"
                       name="title"
                       value="${lesson.title}"
                       placeholder="Enter a compelling lesson title..."
                       required>
            </div>

            <div class="form-group">
                <label for="editor" class="form-label">
                    <i class="fas fa-file-alt"></i>
                    Lesson Content
                </label>
                <textarea id="editor"
                          name="content"
                          placeholder="Write your lesson content here..."
                          required>${lesson.content}</textarea>
            </div>

            <div class="form-group">
                <label for="status" class="form-label">
                    <i class="fas fa-toggle-on"></i>
                    Publication Status
                </label>
                <select class="form-select" id="status" name="status" required>
                    <option value="draft" ${lesson.status == 'draft' ? 'selected' : ''}>
                        📝 Draft - Work in progress
                    </option>
                    <option value="published" ${lesson.status == 'published' ? 'selected' : ''}>
                        🚀 Published - Live for students
                    </option>
                </select>
                <div class="status-badge ${lesson.status == 'draft' ? 'status-draft' : 'status-published'}" id="statusBadge">
                    <i class="fas ${lesson.status == 'draft' ? 'fa-clock' : 'fa-check-circle'}"></i>
                    Current: ${lesson.status == 'draft' ? 'Draft' : 'Published'}
                </div>
            </div>

            <div class="form-group">
                <div class="form-check">
                    <input type="checkbox"
                           class="form-check-input"
                           id="isFreePreview"
                           name="isFreePreview"
                    ${lesson.isFreePreview ? 'checked' : ''}>
                    <label class="form-check-label" for="isFreePreview">
                        <i class="fas fa-eye me-2"></i>
                        Make this lesson available as a free preview
                        <small class="d-block text-muted mt-1">
                            Students can access this lesson without enrolling in the course
                        </small>
                    </label>
                </div>
            </div>

            <div class="button-group">
                <a href="course-lessons?id=${lesson.courseID.id}" class="btn btn-secondary">
                    <i class="fas fa-times me-2"></i>
                    Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-2"></i>
                    Save Changes
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize CKEditor with enhanced configuration
    ClassicEditor
        .create(document.querySelector('#editor'), {
            toolbar: {
                items: [
                    'heading', '|',
                    'bold', 'italic', 'underline', 'strikethrough', '|',
                    'fontSize', 'fontColor', 'fontBackgroundColor', '|',
                    'bulletedList', 'numberedList', '|',
                    'outdent', 'indent', '|',
                    'alignment', '|',
                    'link', 'blockQuote', 'insertTable', '|',
                    'undo', 'redo', '|',
                    'sourceEditing'
                ]
            },
            fontSize: {
                options: [9, 11, 13, 'default', 17, 19, 21, 23, 25, 27]
            },
            fontColor: {
                colors: [
                    {color: 'hsl(0, 0%, 0%)', label: 'Black'},
                    {color: 'hsl(0, 0%, 30%)', label: 'Dim grey'},
                    {color: 'hsl(0, 0%, 60%)', label: 'Grey'},
                    {color: 'hsl(0, 0%, 90%)', label: 'Light grey'},
                    {color: 'hsl(0, 0%, 100%)', label: 'White', hasBorder: true},
                    {color: 'hsl(0, 75%, 60%)', label: 'Red'},
                    {color: 'hsl(30, 75%, 60%)', label: 'Orange'},
                    {color: 'hsl(60, 75%, 60%)', label: 'Yellow'},
                    {color: 'hsl(90, 75%, 60%)', label: 'Light green'},
                    {color: 'hsl(120, 75%, 60%)', label: 'Green'},
                    {color: 'hsl(150, 75%, 60%)', label: 'Aquamarine'},
                    {color: 'hsl(180, 75%, 60%)', label: 'Turquoise'},
                    {color: 'hsl(210, 75%, 60%)', label: 'Light blue'},
                    {color: 'hsl(240, 75%, 60%)', label: 'Blue'},
                    {color: 'hsl(270, 75%, 60%)', label: 'Purple'}
                ]
            },
            table: {
                contentToolbar: ['tableColumn', 'tableRow', 'mergeTableCells']
            }
        })
        .then(editor => {
            window.editor = editor;

            // Add custom styling to editor
            const editorElement = editor.ui.getEditableElement();
            editorElement.style.fontFamily = "'Segoe UI', Tahoma, Geneva, Verdana, sans-serif";
            editorElement.style.fontSize = '16px';
            editorElement.style.lineHeight = '1.6';
        })
        .catch(error => {
            console.error('Error initializing CKEditor:', error);
        });

    // Dynamic status badge update
    const statusSelect = document.getElementById('status');
    const statusBadge = document.getElementById('statusBadge');

    statusSelect.addEventListener('change', function() {
        const isDraft = this.value === 'draft';
        statusBadge.className = `status-badge ${isDraft ? 'status-draft' : 'status-published'}`;
        statusBadge.innerHTML = `
                <i class="fas ${isDraft ? 'fa-clock' : 'fa-check-circle'}"></i>
                Current: ${isDraft ? 'Draft' : 'Published'}
            `;
    });

    // Form validation enhancement
    const form = document.querySelector('form');
    const titleInput = document.getElementById('title');

    form.addEventListener('submit', function(e) {
        if (titleInput.value.trim().length < 3) {
            e.preventDefault();
            titleInput.focus();
            titleInput.classList.add('is-invalid');

            // Remove invalid class after user starts typing
            titleInput.addEventListener('input', function() {
                if (this.value.trim().length >= 3) {
                    this.classList.remove('is-invalid');
                }
            });
        }
    });

    // Auto-save functionality (optional - stores in memory only)
    let autoSaveInterval;

    function startAutoSave() {
        autoSaveInterval = setInterval(() => {
            if (window.editor) {
                const content = window.editor.getData();
                const title = titleInput.value;

                // Store in memory (session-based)
                window.lessonDraft = {
                    title: title,
                    content: content,
                    timestamp: new Date().toLocaleString()
                };

                console.log('Draft auto-saved:', window.lessonDraft.timestamp);
            }
        }, 30000); // Auto-save every 30 seconds
    }

    // Start auto-save when editor is ready
    setTimeout(startAutoSave, 2000);

    // Clean up on page unload
    window.addEventListener('beforeunload', () => {
        if (autoSaveInterval) {
            clearInterval(autoSaveInterval);
        }
    });

    // Enhanced form interactions
    const formControls = document.querySelectorAll('.form-control, .form-select');

    formControls.forEach(control => {
        control.addEventListener('focus', function() {
            this.closest('.form-group').classList.add('focused');
        });

        control.addEventListener('blur', function() {
            this.closest('.form-group').classList.remove('focused');
        });
    });
</script>
</body>
</html>