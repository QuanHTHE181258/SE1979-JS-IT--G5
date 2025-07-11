<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Blog</title>
    <style>
        body { background: #f8f9fa; font-family: Arial, sans-serif; }
        .container { margin: 40px auto; max-width: 700px; background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.07); padding: 32px 24px; }
        h1 { font-size: 2rem; margin-bottom: 24px; }
        .form-group { margin-bottom: 18px; }
        label { font-weight: bold; display: block; margin-bottom: 6px; }
        input[type="text"], textarea, select { width: 100%; padding: 8px 10px; border: 1px solid #ccc; border-radius: 4px; font-size: 1rem; }
        textarea { min-height: 120px; }
        .btn { padding: 8px 24px; border-radius: 4px; border: none; background: #6a5acd; color: #fff; font-size: 1rem; cursor: pointer; transition: background 0.2s; }
        .btn:hover { background: #4a3a9a; }
    </style>
</head>
<body>
<div class="container">
    <h1>Edit Blog</h1>
    <form method="post" action="edit?id=${blog.id}">
        <div class="form-group">
            <label for="title">Title</label>
            <input type="text" id="title" name="title" value="${blog.title}" required>
        </div>
        <div class="form-group">
            <label for="content">Content</label>
            <textarea id="content" name="content" required>${blog.content}</textarea>
        </div>
        <div class="form-group">
            <label for="imageURL">Image URL</label>
            <input type="text" id="imageURL" name="imageURL" value="${blog.imageURL}">
        </div>
        <div class="form-group">
            <label for="status">Status</label>
            <select id="status" name="status">
                <option value="published" ${blog.status == 'published' ? 'selected' : ''}>Published</option>
                <option value="draft" ${blog.status == 'draft' ? 'selected' : ''}>Draft</option>
                <option value="hidden" ${blog.status == 'hidden' ? 'selected' : ''}>Hidden</option>
            </select>
        </div>
        <button type="submit" class="btn">Update</button>
    </form>
</div>
</body>
</html> 