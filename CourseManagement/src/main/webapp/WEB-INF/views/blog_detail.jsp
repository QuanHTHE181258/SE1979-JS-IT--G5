<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog Detail</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .blog-content {
            margin-top: 2rem;
            line-height: 1.6;
            color: #2c3e50;
        }
        .blog-meta {
            color: #6c757d;
            margin: 1rem 0;
            font-size: 0.9em;
        }
        .blog-image {
            max-width: 100%;
            margin: 1.5rem 0;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .action-buttons {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-size: 0.9em;
            font-weight: 500;
        }
        .status-published {
            background: #e1f7e1;
            color: #2d862d;
        }
        .status-draft {
            background: #fff3cd;
            color: #856404;
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

            <!-- Blog Detail Card -->
            <div style="background:white; border-radius:12px; box-shadow:0 4px 16px rgba(0,0,0,0.1); padding:32px;">
                <!-- Blog Header -->
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:24px;">
                    <h1 style="font-size:2rem; color:#2c2c54; margin:0;">${blog.title}</h1>
                    <span class="status-badge ${blog.status == 'published' ? 'status-published' : 'status-draft'}">
                        ${blog.status}
                    </span>
                </div>

                <!-- Blog Metadata -->
                <div class="blog-meta">
                    <span><i class="far fa-calendar"></i> Created: ${blog.createdAt}</span>
                    <c:if test="${not empty blog.updatedAt}">
                        <span style="margin-left:16px;">
                            <i class="far fa-edit"></i> Updated: ${blog.updatedAt}
                        </span>
                    </c:if>
                </div>

                <!-- Blog Image -->
                <c:if test="${not empty blog.imageURL}">
                    <img src="${blog.imageURL}" alt="${blog.title}" class="blog-image">
                </c:if>

                <!-- Blog Content -->
                <div class="blog-content">
                    ${blog.content}
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/admin/blog/edit?id=${blog.id}"
                       class="btn btn-primary"
                       style="background:#3498db; color:white; padding:10px 20px; border-radius:6px; text-decoration:none;">
                        <i class="fas fa-edit"></i> Edit Blog
                    </a>
                    <button onclick="deleteBlog(${blog.id})"
                            style="background:#e74c3c; color:white; padding:10px 20px; border-radius:6px; border:none; cursor:pointer;">
                        <i class="fas fa-trash"></i> Delete Blog
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function deleteBlog(blogId) {
        if (confirm('Are you sure you want to delete this blog?')) {
            window.location.href = '${pageContext.request.contextPath}/admin/blog/delete?id=' + blogId;
        }
    }
</script>
</body>
</html>
