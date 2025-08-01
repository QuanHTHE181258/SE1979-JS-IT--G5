<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Bài Viết</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        .blog-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        .blog-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .blog-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .blog-card-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .blog-card-content {
            padding: 1.5rem;
        }
        .blog-title {
            font-size: 1.25rem;
            color: #2c3e50;
            margin: 0 0 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .blog-meta {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }
        .blog-meta i {
            color: #3498db;
        }
        .blog-status {
            display: inline-block;
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
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
        .blog-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }
        .action-btn {
            flex: 1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.5rem;
            border-radius: 6px;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn-edit { background: #3498db; }
        .btn-view { background: #2ecc71; }
        .btn-delete { background: #e74c3c; }
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .create-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            background: #3498db;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .create-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(52,152,219,0.3);
        }
        @media (max-width: 768px) {
            .blog-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            .blog-actions {
                flex-direction: column;
            }
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
        <div style="max-width:1200px; margin:auto; padding:0 24px;">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <h1 style="font-size:2rem; color:#2c2c54; margin:0;">Quản Lý Bài Viết</h1>
                <a href="${pageContext.request.contextPath}/admin/blog/create" class="create-btn">
                    <i class="fas fa-plus"></i> Tạo Bài Viết Mới
                </a>
            </div>

            <!-- Blog Grid -->
            <div class="blog-grid">
                <c:forEach var="blog" items="${blogList}">
                    <div class="blog-card">
                        <c:if test="${not empty blog.imageURL}">
                            <img src="${blog.imageURL}" alt="${blog.title}" class="blog-card-image">
                        </c:if>
                        <div class="blog-card-content">
                            <h2 class="blog-title">${blog.title}</h2>
                            <div class="blog-meta">
                                <span><i class="fas fa-calendar"></i>
                                    <fmt:formatDate value="${blog.createdAtDate}" pattern="dd/MM/yyyy"/>
                                </span>
                                <span class="blog-status ${blog.status == 'published' ? 'status-published' : 'status-draft'}">
                                        ${blog.status}
                                </span>
                            </div>
                            <div class="blog-actions">
                                <a href="${pageContext.request.contextPath}/admin/blog/edit?id=${blog.id}"
                                   class="action-btn btn-edit" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </a>

                                <a href="#" onclick="deleteBlog(${blog.id})"
                                   class="action-btn btn-delete" title="Delete">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script>
    function deleteBlog(blogId) {
        if (confirm('Bạn có chắc chắn muốn xóa bài viết này không?')) {
            window.location.href = '${pageContext.request.contextPath}/admin/blog/delete?id=' + blogId;
        }
    }
</script>
</body>
</html>
