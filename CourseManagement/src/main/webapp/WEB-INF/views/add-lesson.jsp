<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add Lesson</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    .editor-toolbar {
      padding: 10px;
      border: 1px solid #ddd;
      border-bottom: none;
      border-radius: 4px 4px 0 0;
      background: #f8f9fa;
    }
    .editor-toolbar button {
      margin-right: 5px;
    }
    #editor {
      min-height: 400px;
      border: 1px solid #ddd;
      border-radius: 0 0 4px 4px;
      padding: 20px;
      overflow-y: auto;
    }
    .preview {
      border: 1px solid #ddd;
      border-radius: 4px;
      padding: 20px;
      margin-top: 20px;
    }
    pre {
      background: #f8f9fa;
      padding: 15px;
      border-left: 4px solid #3498db;
      margin: 10px 0;
    }
    code {
      font-family: monospace;
      background: #f8f9fa;
      padding: 2px 4px;
      border-radius: 4px;
    }
  </style>
</head>
<body>
<div class="container mt-5">
  <h2 class="mb-4">Thêm bài học cho khóa học #${param.courseId}</h2>
  <form action="add-lesson" method="post" onsubmit="return prepareSubmit()">
    <input type="hidden" name="courseId" value="${param.courseId}" />
    <div class="mb-3">
      <label for="title" class="form-label">Tiêu đề bài học</label>
      <input type="text" class="form-control" id="title" name="title" required>
    </div>
    <div class="mb-3">
      <label class="form-label">Nội dung bài học</label>
      <div class="editor-toolbar btn-toolbar">
        <div class="btn-group me-2">
          <button type="button" class="btn btn-outline-primary" onclick="insertHeading(1)">H1</button>
          <button type="button" class="btn btn-outline-primary" onclick="insertHeading(2)">H2</button>
          <button type="button" class="btn btn-outline-primary" onclick="insertHeading(3)">H3</button>
        </div>
        <div class="btn-group me-2">
          <button type="button" class="btn btn-outline-secondary" onclick="insertParagraph()">
            <i class="bi bi-paragraph"></i> Paragraph
          </button>
          <button type="button" class="btn btn-outline-secondary" onclick="insertBold()">
            <i class="bi bi-type-bold"></i>
          </button>
        </div>
        <div class="btn-group me-2">
          <button type="button" class="btn btn-outline-secondary" onclick="insertList('ul')">
            <i class="bi bi-list-ul"></i>
          </button>
          <button type="button" class="btn btn-outline-secondary" onclick="insertList('ol')">
            <i class="bi bi-list-ol"></i>
          </button>
        </div>
        <div class="btn-group me-2">
          <button type="button" class="btn btn-outline-secondary" onclick="insertTable()">
            <i class="bi bi-table"></i> Table
          </button>
          <button type="button" class="btn btn-outline-secondary" onclick="insertCode()">
            <i class="bi bi-code-square"></i> Code
          </button>
        </div>
      </div>
      <div id="editor" contenteditable="true"></div>
      <input type="hidden" id="content" name="content">
    </div>
    <div class="mb-3">
      <label for="status" class="form-label">Trạng thái</label>
      <select class="form-select" id="status" name="status" required>
        <option value="draft">Nháp</option>
        <option value="published">Công khai</option>
      </select>
    </div>
    <div class="mb-3">
      <label class="form-label">Miễn phí xem trước?</label>
      <select class="form-select" name="isFreePreview">
        <option value="true">Có</option>
        <option value="false">Không</option>
      </select>
    </div>
    <button type="submit" class="btn btn-primary">Thêm bài học</button>
  </form>
</div>

<script>
  function insertHeading(level) {
    const selection = window.getSelection();
    const range = selection.getRangeAt(0);
    const heading = document.createElement(`h${level}`);
    heading.textContent = 'Tiêu đề mới';
    range.deleteContents();
    range.insertNode(heading);
    selectElementContents(heading);
  }

  function insertParagraph() {
    const p = document.createElement('p');
    p.textContent = 'Thêm nội dung của bạn ở đây...';
    insertElement(p);
  }

  function insertBold() {
    const selection = window.getSelection();
    if (selection.toString().length > 0) {
      const strong = document.createElement('strong');
      strong.textContent = selection.toString();
      selection.getRangeAt(0).deleteContents();
      selection.getRangeAt(0).insertNode(strong);
    }
  }

  function insertList(type) {
    const list = document.createElement(type);
    list.innerHTML = '<li>Mục 1</li><li>Mục 2</li><li>Mục 3</li>';
    insertElement(list);
  }

  function insertTable() {
    const table = document.createElement('table');
    table.className = 'table table-bordered';
    table.innerHTML = `
        <thead>
            <tr>
                <th>Cột 1</th>
                <th>Cột 2</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Dữ liệu 1</td>
                <td>Dữ liệu 2</td>
            </tr>
        </tbody>
    `;
    insertElement(table);
  }

  function insertCode() {
    const pre = document.createElement('pre');
    const code = document.createElement('code');
    code.className = 'language-python';
    code.textContent = '# Thêm code của bạn ở đây\nprint("Hello, World!")';
    pre.appendChild(code);
    insertElement(pre);
  }

  function insertElement(element) {
    const editor = document.getElementById('editor');
    const selection = window.getSelection();
    const range = selection.getRangeAt(0);
    range.deleteContents();
    range.insertNode(element);
    // Thêm dòng mới sau element
    const br = document.createElement('br');
    element.parentNode.insertBefore(br, element.nextSibling);
  }

  function selectElementContents(element) {
    const range = document.createRange();
    range.selectNodeContents(element);
    const selection = window.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);
    element.focus();
  }

  function prepareSubmit() {
    const editor = document.getElementById('editor');
    const content = document.getElementById('content');
    content.value = editor.innerHTML;
    return true;
  }

  // Thêm sẵn một số nội dung mẫu khi trang được tải
  window.onload = function() {
    const editor = document.getElementById('editor');
    editor.innerHTML = `<h1>Tiêu đề bài học</h1>
<p>Thêm nội dung giới thiệu ở đây...</p>`;
  }
</script>
</body>
</html>
