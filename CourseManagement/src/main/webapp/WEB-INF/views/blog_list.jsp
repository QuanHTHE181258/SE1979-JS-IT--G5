<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog List</title>
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
        <div style="max-width:1200px; margin:auto; padding:0 24px;">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:32px;">
                <h1 style="font-size:2rem; color:#2c2c54; margin:0;">Blog Management</h1>
                <a href="${pageContext.request.contextPath}/admin/blog/create"
                   class="btn btn-primary"
                   style="background:#3498db; color:white; padding:10px 20px; border-radius:6px; text-decoration:none;">
                    <i class="fas fa-plus"></i> Create New Blog
                </a>
            </div>

            <!-- Blog List Table -->
            <div style="background:white; border-radius:12px; box-shadow:0 4px 16px rgba(0,0,0,0.1); overflow:hidden;">
                <table style="width:100%; border-collapse:collapse;">
                    <thead>
                    <tr style="background:#f8f9fa;">
                        <th style="padding:16px; text-align:left;">Title</th>
                        <th style="padding:16px; text-align:left;">Status</th>
                        <th style="padding:16px; text-align:left;">Created Date</th>
                        <th style="padding:16px; text-align:center;">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="blog" items="${blogList}">
                        <tr style="border-top:1px solid #eee;">
                            <td style="padding:16px;">${blog.title}</td>
                            <td style="padding:16px;">
                                    <span style="padding:4px 8px; border-radius:4px; font-size:0.85em;
                                        ${blog.status == 'published' ? 'background:#e1f7e1; color:#2d862d;' : 'background:#fff3cd; color:#856404;'}">
                                            ${blog.status}
                                    </span>
                            </td>
                            <td style="padding:16px;">${blog.createdAt}</td>
                            <td style="padding:16px; text-align:center;">
                                <a href="${pageContext.request.contextPath}/blog/edit?id=${blog.id}"
                                   style="color:#3498db; margin:0 8px; text-decoration:none;">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/blog/detail?id=${blog.id}"
                                   style="color:#2ecc71; margin:0 8px; text-decoration:none;">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="#" onclick="deleteBlog(${blog.id})"
                                   style="color:#e74c3c; margin:0 8px; text-decoration:none;">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
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
