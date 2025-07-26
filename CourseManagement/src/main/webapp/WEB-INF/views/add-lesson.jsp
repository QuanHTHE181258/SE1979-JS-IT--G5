<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add New Lesson</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
      --warning-gradient: linear-gradient(135deg, #ffd89b 0%, #19547b 100%);
      --danger-gradient: linear-gradient(135deg, #fc4a1a 0%, #f7b733 100%);
      --info-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      --card-shadow: 0 10px 30px rgba(0,0,0,0.1);
      --hover-shadow: 0 15px 40px rgba(0,0,0,0.15);
      --border-radius: 15px;
      --editor-border: 2px solid rgba(102, 126, 234, 0.2);
    }

    body {
      background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .main-container {
      max-width: 1000px;
      margin: 2rem auto;
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: var(--border-radius);
      box-shadow: var(--card-shadow);
      padding: 3rem 2.5rem;
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .page-title {
      font-size: 2.5rem;
      font-weight: 800;
      background: var(--primary-gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      margin-bottom: 3rem;
      text-align: center;
      position: relative;
    }

    .page-title::after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 50%;
      transform: translateX(-50%);
      width: 100px;
      height: 4px;
      background: var(--primary-gradient);
      border-radius: 2px;
    }

    .form-section {
      background: rgba(255, 255, 255, 0.8);
      border-radius: 12px;
      padding: 2rem;
      margin-bottom: 2rem;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      border: 1px solid rgba(255, 255, 255, 0.3);
    }

    .section-title {
      font-size: 1.3rem;
      font-weight: 700;
      color: #4a5568;
      margin-bottom: 1.5rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .form-label {
      font-weight: 600;
      color: #4a5568;
      margin-bottom: 0.8rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .form-control, .form-select {
      border: 2px solid rgba(102, 126, 234, 0.1);
      border-radius: 10px;
      padding: 0.75rem 1rem;
      transition: all 0.3s ease;
      background: rgba(255, 255, 255, 0.9);
      font-size: 1rem;
    }

    .form-control:focus, .form-select:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
      background: #fff;
      transform: translateY(-1px);
    }

    /* Rich Text Editor Styles */
    .editor-container {
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      border: var(--editor-border);
      background: #fff;
    }

    .editor-toolbar {
      background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
      padding: 1rem;
      border-bottom: 1px solid rgba(102, 126, 234, 0.1);
      display: flex;
      flex-wrap: wrap;
      gap: 0.5rem;
      align-items: center;
    }

    .toolbar-group {
      display: flex;
      gap: 0.25rem;
      padding: 0.25rem;
      background: rgba(255, 255, 255, 0.7);
      border-radius: 8px;
      border: 1px solid rgba(102, 126, 234, 0.1);
    }

    .toolbar-btn {
      border: none;
      background: transparent;
      padding: 0.5rem 0.75rem;
      border-radius: 6px;
      color: #4a5568;
      transition: all 0.3s ease;
      font-size: 0.9rem;
      font-weight: 500;
      display: flex;
      align-items: center;
      gap: 0.3rem;
    }

    .toolbar-btn:hover {
      background: var(--primary-gradient);
      color: white;
      transform: translateY(-1px);
      box-shadow: 0 3px 10px rgba(102, 126, 234, 0.3);
    }

    .toolbar-btn.active {
      background: var(--primary-gradient);
      color: white;
      box-shadow: 0 3px 10px rgba(102, 126, 234, 0.3);
    }

    .editor-content {
      min-height: 450px;
      padding: 2rem;
      font-size: 1.05rem;
      line-height: 1.7;
      background: #fff;
      border: none;
      outline: none;
      overflow-y: auto;
      color: #2d3748;
    }

    .editor-content:focus {
      outline: none;
    }

    /* Editor Content Styling */
    .editor-content h1 {
      color: #2d3748;
      font-weight: 700;
      margin: 1.5rem 0 1rem 0;
      padding-bottom: 0.5rem;
      border-bottom: 2px solid rgba(102, 126, 234, 0.2);
    }

    .editor-content h2 {
      color: #4a5568;
      font-weight: 600;
      margin: 1.2rem 0 0.8rem 0;
    }

    .editor-content h3 {
      color: #718096;
      font-weight: 600;
      margin: 1rem 0 0.6rem 0;
    }

    .editor-content p {
      margin-bottom: 1rem;
      text-align: justify;
    }

    .editor-content ul, .editor-content ol {
      margin: 1rem 0;
      padding-left: 2rem;
    }

    .editor-content li {
      margin-bottom: 0.5rem;
    }

    .editor-content table {
      width: 100%;
      border-collapse: collapse;
      margin: 1.5rem 0;
      background: #fff;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }

    .editor-content table th {
      background: var(--primary-gradient);
      color: white;
      padding: 1rem;
      font-weight: 600;
      text-align: left;
    }

    .editor-content table td {
      padding: 1rem;
      border-bottom: 1px solid rgba(0,0,0,0.05);
    }

    .editor-content table tr:hover {
      background: rgba(102, 126, 234, 0.05);
    }

    .editor-content pre {
      background: linear-gradient(135deg, #2d3748 0%, #4a5568 100%);
      color: #e2e8f0;
      padding: 1.5rem;
      border-radius: 8px;
      margin: 1.5rem 0;
      overflow-x: auto;
      position: relative;
      box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }

    .editor-content pre::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 4px;
      height: 100%;
      background: var(--success-gradient);
    }

    .editor-content code {
      font-family: 'Courier New', monospace;
      background: rgba(102, 126, 234, 0.1);
      color: #667eea;
      padding: 0.2rem 0.4rem;
      border-radius: 4px;
      font-size: 0.9em;
    }

    .editor-content blockquote {
      border-left: 4px solid #667eea;
      background: rgba(102, 126, 234, 0.05);
      padding: 1rem 1.5rem;
      margin: 1.5rem 0;
      border-radius: 0 8px 8px 0;
      font-style: italic;
    }

    /* Preview Mode */
    .preview-mode {
      background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
      border-radius: 12px;
      padding: 2rem;
      margin-top: 1rem;
      box-shadow: 0 5px 15px rgba(0,0,0,0.08);
      border: 2px solid rgba(102, 126, 234, 0.1);
    }

    .preview-title {
      color: #4a5568;
      font-weight: 600;
      margin-bottom: 1rem;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    /* Form Controls */
    .btn-modern {
      padding: 0.75rem 2rem;
      border-radius: 10px;
      border: none;
      font-weight: 600;
      transition: all 0.3s ease;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
      font-size: 1rem;
      letter-spacing: 0.3px;
    }

    .btn-primary-modern {
      background: var(--primary-gradient);
      color: white;
    }

    .btn-secondary-modern {
      background: linear-gradient(135deg, #718096 0%, #4a5568 100%);
      color: white;
    }

    .btn-success-modern {
      background: var(--success-gradient);
      color: white;
    }

    .btn-modern:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(0,0,0,0.2);
      color: white;
    }

    .form-actions {
      display: flex;
      gap: 1rem;
      justify-content: center;
      margin-top: 2rem;
      padding-top: 2rem;
      border-top: 1px solid rgba(0,0,0,0.1);
    }

    /* Character Counter */
    .char-counter {
      font-size: 0.85rem;
      color: #718096;
      text-align: right;
      margin-top: 0.5rem;
    }

    /* Auto-save Indicator */
    .autosave-indicator {
      position: fixed;
      top: 20px;
      right: 20px;
      background: rgba(17, 153, 142, 0.9);
      color: white;
      padding: 0.5rem 1rem;
      border-radius: 20px;
      font-size: 0.85rem;
      opacity: 0;
      transition: opacity 0.3s ease;
      z-index: 1000;
    }

    .autosave-indicator.show {
      opacity: 1;
    }

    /* Loading Overlay */
    .loading-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(255, 255, 255, 0.9);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 9999;
    }

    .loading-spinner {
      width: 60px;
      height: 60px;
      border: 4px solid #f3f3f3;
      border-top: 4px solid #667eea;
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    /* Progress Bar */
    .form-progress {
      height: 4px;
      background: rgba(102, 126, 234, 0.1);
      border-radius: 2px;
      margin-bottom: 2rem;
      overflow: hidden;
    }

    .form-progress-bar {
      height: 100%;
      background: var(--primary-gradient);
      width: 0%;
      transition: width 0.3s ease;
    }

    /* Mobile Responsive */
    @media (max-width: 768px) {
      .main-container {
        margin: 1rem;
        padding: 2rem 1.5rem;
      }

      .page-title {
        font-size: 2rem;
      }

      .editor-toolbar {
        padding: 0.75rem;
      }

      .toolbar-group {
        flex-wrap: wrap;
      }

      .form-actions {
        flex-direction: column;
      }

      .btn-modern {
        width: 100%;
        justify-content: center;
      }
    }

    @media (max-width: 576px) {
      .page-title {
        font-size: 1.75rem;
      }

      .form-section {
        padding: 1.5rem;
      }

      .editor-content {
        padding: 1.5rem;
        min-height: 350px;
      }
    }

    /* Animations */
    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .form-section {
      animation: fadeInUp 0.6s ease-out;
    }

    .form-section:nth-child(2) { animation-delay: 0.1s; }
    .form-section:nth-child(3) { animation-delay: 0.2s; }
    .form-section:nth-child(4) { animation-delay: 0.3s; }
  </style>
</head>
<body>
<div class="loading-overlay" id="loadingOverlay">
  <div class="loading-spinner"></div>
</div>

<div class="autosave-indicator" id="autosaveIndicator">
  <i class="fas fa-save me-1"></i>Auto-saved
</div>

<div class="main-container">
  <div class="page-title">
    <i class="fas fa-plus-circle me-3"></i>
    Add New Lesson
  </div>

  <div class="form-progress">
    <div class="form-progress-bar" id="formProgress"></div>
  </div>

  <form id="lessonForm" action="add-lesson" method="post" onsubmit="return handleSubmit()">
    <input type="hidden" name="courseId" value="${param.courseId}" />

    <!-- Basic Information Section -->
    <div class="form-section">
      <h3 class="section-title">
        <i class="fas fa-info-circle"></i>
        Basic Information
      </h3>

      <div class="mb-4">
        <label for="title" class="form-label">
          <i class="fas fa-heading"></i>
          Lesson Title
        </label>
        <input type="text" class="form-control" id="title" name="title" required
               placeholder="Enter an engaging lesson title..."
               maxlength="200">
        <div class="char-counter">
          <span id="titleCounter">0</span>/200 characters
        </div>
      </div>

      <div class="row">
        <div class="col-md-6 mb-3">
          <label for="status" class="form-label">
            <i class="fas fa-toggle-on"></i>
            Status
          </label>
          <select class="form-select" id="status" name="status" required>
            <option value="draft">Draft</option>
            <option value="published">Published</option>
            <option value="scheduled">Scheduled</option>
          </select>
        </div>

        <div class="col-md-6 mb-3">
          <label class="form-label">
            <i class="fas fa-unlock-alt"></i>
            Free Preview
          </label>
          <select class="form-select" name="isFreePreview">
            <option value="false">Premium Only</option>
            <option value="true">Free Preview Available</option>
          </select>
        </div>
      </div>
    </div>

    <!-- Content Section -->
    <div class="form-section">
      <h3 class="section-title">
        <i class="fas fa-edit"></i>
        Lesson Content
      </h3>

      <div class="mb-3">
        <label class="form-label">
          <i class="fas fa-file-alt"></i>
          Content
        </label>

        <div class="editor-container">
          <div class="editor-toolbar">
            <div class="toolbar-group">
              <button type="button" class="toolbar-btn" onclick="insertHeading(1)" title="Heading 1">
                <i class="fas fa-heading"></i>H1
              </button>
              <button type="button" class="toolbar-btn" onclick="insertHeading(2)" title="Heading 2">
                <i class="fas fa-heading"></i>H2
              </button>
              <button type="button" class="toolbar-btn" onclick="insertHeading(3)" title="Heading 3">
                <i class="fas fa-heading"></i>H3
              </button>
            </div>

            <div class="toolbar-group">
              <button type="button" class="toolbar-btn" onclick="execCommand('bold')" title="Bold">
                <i class="fas fa-bold"></i>
              </button>
              <button type="button" class="toolbar-btn" onclick="execCommand('italic')" title="Italic">
                <i class="fas fa-italic"></i>
              </button>
              <button type="button" class="toolbar-btn" onclick="execCommand('underline')" title="Underline">
                <i class="fas fa-underline"></i>
              </button>
              <button type="button" class="toolbar-btn" onclick="execCommand('strikeThrough')" title="Strikethrough">
                <i class="fas fa-strikethrough"></i>
              </button>
            </div>

            <div class="toolbar-group">
              <button type="button" class="toolbar-btn" onclick="insertList('ul')" title="Bulleted List">
                <i class="fas fa-list-ul"></i>
              </button>
              <button type="button" class="toolbar-btn" onclick="insertList('ol')" title="Numbered List">
                <i class="fas fa-list-ol"></i>
              </button>
              <button type="button" class="toolbar-btn" onclick="insertBlockquote()" title="Quote">
                <i class="fas fa-quote-right"></i>
              </button>
            </div>

            <div class="toolbar-group">
              <button type="button" class="toolbar-btn" onclick="insertTable()" title="Insert Table">
                <i class="fas fa-table"></i>
              </button>
              <button type="button" class="toolbar-btn" onclick="insertCode()" title="Code Block">
                <i class="fas fa-code"></i>
              </button>
              <button type="button" class="toolbar-btn" onclick="insertImage()" title="Insert Image">
                <i class="fas fa-image"></i>
              </button>
              <button type="button" class="toolbar-btn" onclick="insertLink()" title="Insert Link">
                <i class="fas fa-link"></i>
              </button>
            </div>

            <div class="toolbar-group">
              <button type="button" class="toolbar-btn" onclick="togglePreview()" title="Preview" id="previewBtn">
                <i class="fas fa-eye"></i>Preview
              </button>
              <button type="button" class="toolbar-btn" onclick="clearContent()" title="Clear All">
                <i class="fas fa-trash"></i>Clear
              </button>
            </div>
          </div>

          <div id="editor" class="editor-content" contenteditable="true"></div>
          <input type="hidden" id="content" name="content">
        </div>

        <div class="char-counter">
          <span id="contentCounter">0</span> characters
        </div>
      </div>
    </div>

    <!-- Preview Section -->
    <div class="form-section" id="previewSection" style="display: none;">
      <h3 class="section-title">
        <i class="fas fa-eye"></i>
        Content Preview
      </h3>
      <div class="preview-mode" id="previewContent"></div>
    </div>

    <!-- Form Actions -->
    <div class="form-actions">

      <button type="submit" class="btn-modern btn-primary-modern">
        <i class="fas fa-plus-circle"></i>Create Lesson
      </button>
    </div>
  </form>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
  let isPreviewMode = false;
  let autoSaveTimer;
  let formProgress = 0;

  // Initialize editor
  document.addEventListener('DOMContentLoaded', function() {
    initializeEditor();
    setupFormValidation();
    setupAutoSave();
    updateFormProgress();
  });

  function initializeEditor() {
    const editor = document.getElementById('editor');
    editor.innerHTML = `
                <h1>Welcome to Your New Lesson</h1>
                <p>Start writing your lesson content here. Use the toolbar above to format your text, add images, tables, and more.</p>
                <h2>Getting Started</h2>
                <p>You can:</p>
                <ul>
                    <li>Format text with <strong>bold</strong>, <em>italic</em>, and other styles</li>
                    <li>Add headings to organize your content</li>
                    <li>Insert code blocks for programming examples</li>
                    <li>Create tables for structured data</li>
                </ul>
                <p>Delete this sample content and start creating your lesson!</p>
            `;

    // Setup event listeners
    editor.addEventListener('input', handleEditorChange);
    editor.addEventListener('paste', handlePaste);

    // Character counters
    document.getElementById('title').addEventListener('input', updateTitleCounter);

    updateContentCounter();
  }

  function handleEditorChange() {
    updateContentCounter();
    autoSave();
    updateFormProgress();
  }

  function updateTitleCounter() {
    const title = document.getElementById('title');
    const counter = document.getElementById('titleCounter');
    counter.textContent = title.value.length;

    if (title.value.length > 180) {
      counter.style.color = '#fc4a1a';
    } else if (title.value.length > 150) {
      counter.style.color = '#f7b733';
    } else {
      counter.style.color = '#718096';
    }

    updateFormProgress();
  }

  function updateContentCounter() {
    const editor = document.getElementById('editor');
    const counter = document.getElementById('contentCounter');
    const text = editor.textContent || editor.innerText || '';
    counter.textContent = text.length;
  }

  function updateFormProgress() {
    const title = document.getElementById('title').value;
    const content = document.getElementById('editor').textContent || '';
    const status = document.getElementById('status').value;

    let progress = 0;
    if (title.length > 0) progress += 25;
    if (content.length > 50) progress += 50;
    if (status) progress += 25;

    const progressBar = document.getElementById('formProgress');
    progressBar.style.width = progress + '%';
    formProgress = progress;
  }

  // Rich Text Editor Functions
  function execCommand(command, value = null) {
    document.execCommand(command, false, value);
    document.getElementById('editor').focus();
  }

  function insertHeading(level) {
    const selection = window.getSelection();
    if (selection.rangeCount > 0) {
      const range = selection.getRangeAt(0);
      const heading = document.createElement(`h${level}`);

      if (selection.toString().length > 0) {
        heading.textContent = selection.toString();
      } else {
        heading.textContent = `Heading ${level}`;
      }

      range.deleteContents();
      range.insertNode(heading);
      selectElementContents(heading);
    }
  }

  function insertList(type) {
    const list = document.createElement(type);
    list.innerHTML = '<li>First item</li><li>Second item</li><li>Third item</li>';
    insertElement(list);
  }

  function insertTable() {
    const table = document.createElement('table');
    table.className = 'table table-bordered';
    table.innerHTML = `
                <thead>
                    <tr>
                        <th>Column 1</th>
                        <th>Column 2</th>
                        <th>Column 3</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Data 1</td>
                        <td>Data 2</td>
                        <td>Data 3</td>
                    </tr>
                    <tr>
                        <td>Data 4</td>
                        <td>Data 5</td>
                        <td>Data 6</td>
                    </tr>
                </tbody>
            `;
    insertElement(table);
  }

  function insertCode() {
    const pre = document.createElement('pre');
    const code = document.createElement('code');
    code.textContent = `// Add your code here
function example() {
    console.log("Hello, World!");
    return true;
}`;
    pre.appendChild(code);
    insertElement(pre);
  }

  function insertBlockquote() {
    const blockquote = document.createElement('blockquote');
    blockquote.textContent = 'Insert your quote here...';
    insertElement(blockquote);
  }

  function insertImage() {
    const url = prompt('Enter image URL:');
    if (url) {
      const img = document.createElement('img');
      img.src = url;
      img.style.maxWidth = '100%';
      img.style.height = 'auto';
      img.style.borderRadius = '8px';
      img.style.boxShadow = '0 3px 10px rgba(0,0,0,0.1)';
      insertElement(img);
    }
  }

  function insertLink() {
    const url = prompt('Enter URL:');
    if (url) {
      const text = prompt('Enter link text:') || url;
      const link = document.createElement('a');
      link.href = url;
      link.textContent = text;
      link.target = '_blank';
      link.style.color = '#667eea';
      insertElement(link);
    }
  }

  function insertElement(element) {
    const editor = document.getElementById('editor');
    const selection = window.getSelection();

    if (selection.rangeCount > 0) {
      const range = selection.getRangeAt(0);
      range.deleteContents();
      range.insertNode(element);

      // Add line break after element
      const br = document.createElement('br');
      element.parentNode.insertBefore(br, element.nextSibling);

      // Position cursor after the inserted element
      const newRange = document.createRange();
      newRange.setStartAfter(br);
      newRange.collapse(true);
      selection.removeAllRanges();
      selection.addRange(newRange);
    }

    editor.focus();
    handleEditorChange();
  }

  function selectElementContents(element) {
    const range = document.createRange();
    range.selectNodeContents(element);
    const selection = window.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);
    element.focus();
  }

  function clearContent() {
    if (confirm('Are you sure you want to clear all content? This action cannot be undone.')) {
      document.getElementById('editor').innerHTML = '';
      handleEditorChange();
    }
  }

  function togglePreview() {
    const previewSection = document.getElementById('previewSection');
    const previewBtn = document.getElementById('previewBtn');
    const previewContent = document.getElementById('previewContent');

    isPreviewMode = !isPreviewMode;

    if (isPreviewMode) {
      previewSection.style.display = 'block';
      previewContent.innerHTML = document.getElementById('editor').innerHTML;
      previewBtn.innerHTML = '<i class="fas fa-edit"></i>Edit';
      previewBtn.classList.add('active');

      // Scroll to preview
      previewSection.scrollIntoView({ behavior: 'smooth' });
    } else {
      previewSection.style.display = 'none';
      previewBtn.innerHTML = '<i class="fas fa-eye"></i>Preview';
      previewBtn.classList.remove('active');
    }
  }

  function handlePaste(e) {
    e.preventDefault();
    const text = (e.originalEvent || e).clipboardData.getData('text/plain');
    document.execCommand('insertText', false, text);
  }

  // Auto-save functionality
  function setupAutoSave() {
    const form = document.getElementById('lessonForm');
    const inputs = form.querySelectorAll('input, select, textarea');

    inputs.forEach(input => {
      input.addEventListener('change', autoSave);
    });
  }

  function autoSave() {
    clearTimeout(autoSaveTimer);
    autoSaveTimer = setTimeout(() => {
      saveDraft(true);
    }, 3000);
  }

  function saveDraft(isAutoSave = false) {
    const title = document.getElementById('title').value;
    if (!title.trim()) {
      if (!isAutoSave) {
        alert('Please enter a lesson title before saving.');
      }
      return;
    }

    prepareSubmit();

    // Show auto-save indicator
    const indicator = document.getElementById('autosaveIndicator');
    indicator.classList.add('show');

    // Simulate save operation
    setTimeout(() => {
      indicator.classList.remove('show');
      if (!isAutoSave) {
        showToast('Lesson saved as draft successfully!', 'success');
      }
    }, 1500);
  }

  function previewLesson() {
    const title = document.getElementById('title').value;
    if (!title.trim()) {
      alert('Please enter a lesson title before previewing.');
      return;
    }

    prepareSubmit();

    // Open preview in new window
    const previewWindow = window.open('', '_blank', 'width=800,height=600,scrollbars=yes');
    const content = document.getElementById('editor').innerHTML;

    previewWindow.document.write(`
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Preview: ${title}</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                    <style>
                        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; padding: 2rem; }
                        .preview-container { max-width: 800px; margin: 0 auto; }
                        h1, h2, h3 { color: #2d3748; }
                        table { margin: 1rem 0; }
                        pre { background: #2d3748; color: #e2e8f0; padding: 1rem; border-radius: 8px; }
                        blockquote { border-left: 4px solid #667eea; background: rgba(102,126,234,0.1); padding: 1rem; margin: 1rem 0; }
                    </style>
                </head>
                <body>
                    <div class="preview-container">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            This is a preview of your lesson. Close this window to continue editing.
                        </div>
                        <h1 class="mb-4">${title}</h1>
                        <div>${content}</div>
                    </div>
                </body>
                </html>
            `);
    previewWindow.document.close();
  }

  function setupFormValidation() {
    const form = document.getElementById('lessonForm');
    const title = document.getElementById('title');
    const editor = document.getElementById('editor');

    // Real-time validation
    title.addEventListener('blur', function() {
      if (this.value.trim().length < 5) {
        this.style.borderColor = '#fc4a1a';
        showToast('Title should be at least 5 characters long.', 'warning');
      } else {
        this.style.borderColor = '#11998e';
      }
    });

    editor.addEventListener('blur', function() {
      const text = this.textContent || this.innerText || '';
      if (text.trim().length < 50) {
        this.style.borderColor = '#fc4a1a';
      } else {
        this.style.borderColor = '#11998e';
      }
    });
  }

  function validateForm() {
    const title = document.getElementById('title').value.trim();
    const content = document.getElementById('editor').textContent || '';
    const errors = [];

    if (title.length < 5) {
      errors.push('Title must be at least 5 characters long.');
    }

    if (title.length > 200) {
      errors.push('Title must not exceed 200 characters.');
    }

    if (content.trim().length < 50) {
      errors.push('Content must be at least 50 characters long.');
    }

    if (errors.length > 0) {
      alert('Please fix the following errors:\n\n' + errors.join('\n'));
      return false;
    }

    return true;
  }

  function prepareSubmit() {
    const editor = document.getElementById('editor');
    const content = document.getElementById('content');
    content.value = editor.innerHTML;
    return true;
  }

  function handleSubmit() {
    if (!validateForm()) {
      return false;
    }

    if (!prepareSubmit()) {
      return false;
    }

    // Show loading
    document.getElementById('loadingOverlay').style.display = 'flex';

    // Simulate form submission delay
    setTimeout(() => {
      document.getElementById('lessonForm').submit();
    }, 1000);

    return false; // Prevent immediate submission
  }

  // Toast notification system
  function showToast(message, type = 'success') {
    const toast = document.createElement('div');
    toast.className = `alert alert-${type == 'success' ? 'success' : 'warning'} alert-dismissible fade show position-fixed`;
    toast.style.top = '20px';
    toast.style.right = '20px';
    toast.style.zIndex = '9999';
    toast.style.minWidth = '300px';

    toast.innerHTML = `
                <i class="fas fa-${type == 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            `;

    document.body.appendChild(toast);

    // Auto remove after 4 seconds
    setTimeout(() => {
      if (toast.parentNode) {
        toast.remove();
      }
    }, 4000);
  }

  // Keyboard shortcuts
  document.addEventListener('keydown', function(e) {
    if (e.ctrlKey || e.metaKey) {
      switch(e.key) {
        case 's':
          e.preventDefault();
          saveDraft();
          break;
        case 'b':
          e.preventDefault();
          execCommand('bold');
          break;
        case 'i':
          e.preventDefault();
          execCommand('italic');
          break;
        case 'u':
          e.preventDefault();
          execCommand('underline');
          break;
        case 'Enter':
          e.preventDefault();
          if (validateForm()) {
            document.getElementById('lessonForm').submit();
          }
          break;
      }
    }
  });

  // Enhanced toolbar button states
  document.addEventListener('selectionchange', function() {
    updateToolbarStates();
  });

  function updateToolbarStates() {
    const commands = ['bold', 'italic', 'underline', 'strikeThrough'];
    commands.forEach(command => {
      const isActive = document.queryCommandState(command);
      const button = document.querySelector(`[onclick="execCommand('${command}')"]`);
      if (button) {
        if (isActive) {
          button.classList.add('active');
        } else {
          button.classList.remove('active');
        }
      }
    });
  }

  // Drag and drop image upload
  document.getElementById('editor').addEventListener('dragover', function(e) {
    e.preventDefault();
    this.style.backgroundColor = 'rgba(102, 126, 234, 0.1)';
  });

  document.getElementById('editor').addEventListener('dragleave', function(e) {
    e.preventDefault();
    this.style.backgroundColor = '';
  });

  document.getElementById('editor').addEventListener('drop', function(e) {
    e.preventDefault();
    this.style.backgroundColor = '';

    const files = e.dataTransfer.files;
    if (files.length > 0) {
      const file = files[0];
      if (file.type.startsWith('image/')) {
        const reader = new FileReader();
        reader.onload = function(e) {
          const img = document.createElement('img');
          img.src = e.target.result;
          img.style.maxWidth = '100%';
          img.style.height = 'auto';
          img.style.borderRadius = '8px';
          img.style.boxShadow = '0 3px 10px rgba(0,0,0,0.1)';
          insertElement(img);
        };
        reader.readAsDataURL(file);
      } else {
        showToast('Please drop only image files.', 'warning');
      }
    }
  });

  // Word count and reading time estimation
  function updateWordCount() {
    const editor = document.getElementById('editor');
    const text = editor.textContent || editor.innerText || '';
    const words = text.trim().split(/\s+/).length;
    const readingTime = Math.ceil(words / 200); // Average reading speed: 200 words per minute

    let counter = document.querySelector('.word-counter');
    if (!counter) {
      counter = document.createElement('div');
      counter.className = 'word-counter char-counter';
      document.querySelector('.char-counter').appendChild(counter);
    }

    counter.innerHTML = `<br><i class="fas fa-book-reader me-1"></i>${words} words • ~${readingTime} min read`;
  }

  // Update word count on content change
  document.getElementById('editor').addEventListener('input', updateWordCount);

  // Initialize word count
  updateWordCount();

  // Enhanced mobile experience
  if (window.innerWidth <= 768) {
    // Simplify toolbar for mobile
    const toolbarGroups = document.querySelectorAll('.toolbar-group');
    toolbarGroups.forEach((group, index) => {
      if (index > 2) { // Hide advanced tools on mobile
        group.style.display = 'none';
      }
    });

    // Add mobile-specific styles
    const style = document.createElement('style');
    style.textContent = `
                .editor-content {
                    font-size: 16px; /* Prevent zoom on iOS */
                }
                .toolbar-btn {
                    min-width: 44px; /* Minimum touch target size */
                    min-height: 44px;
                }
            `;
    document.head.appendChild(style);
  }

  // Initialize everything when page loads
  window.addEventListener('load', function() {
    updateWordCount();
    updateFormProgress();

    // Focus on title field
    document.getElementById('title').focus();

    // Add entrance animations
    const sections = document.querySelectorAll('.form-section');
    sections.forEach((section, index) => {
      section.style.opacity = '0';
      section.style.transform = 'translateY(20px)';

      setTimeout(() => {
        section.style.transition = 'all 0.6s ease';
        section.style.opacity = '1';
        section.style.transform = 'translateY(0)';
      }, index * 200);
    });
  });
</script>
</body>
</html>