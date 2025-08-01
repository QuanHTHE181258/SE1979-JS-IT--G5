<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin tức & Blog</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background: #f5f7fa;
            color: #333;
        }

        .header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 60px 20px;
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            font-size: 2.5rem;
            margin: 0 0 15px 0;
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .blog-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .blog-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
        }

        .blog-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }

        .blog-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .blog-content {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .blog-title {
            color: #667eea;
            font-size: 1.25rem;
            margin: 0 0 15px;
            font-weight: 600;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .blog-excerpt {
            color: #666;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.5;
        }

        .blog-meta {
            margin-top: auto;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 15px;
            background: rgba(102, 126, 234, 0.1);
            padding: 8px 12px;
            border-radius: 6px;
        }

        .blog-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #4a5568;
        }

        .blog-meta i {
            color: #667eea;
            font-size: 1rem;
        }

        .read-more {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            color: #667eea;
            font-weight: 500;
            margin-top: 15px;
            transition: color 0.3s ease;
        }

        .read-more:hover {
            color: #764ba2;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .empty-state i {
            font-size: 3rem;
            color: #667eea;
            margin-bottom: 20px;
        }

        .empty-state h2 {
            color: #667eea;
            margin-bottom: 10px;
        }

        .footer {
            text-align: center;
            padding: 30px 20px;
            color: #666;
            margin-top: 50px;
            border-top: 1px solid #eee;
        }

        @media (max-width: 768px) {
            .header {
                padding: 40px 20px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .blog-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <div class="container">
        <h1>🚀 Tin Tức & Blog</h1>
        <p>Cập nhật những thông tin mới nhất về giáo dục, công nghệ và nhiều chủ đề hữu ích khác</p>
    </div>
</div>

<div class="container">
    <c:choose>
        <c:when test="${not empty blogs}">
            <div class="blog-grid">
                <c:forEach var="blog" items="${blogs}">
                    <a href="${pageContext.request.contextPath}/blog/detail?id=${blog.id}" class="blog-card">
                        <c:if test="${not empty blog.imageURL}">
                            <img src="${blog.imageURL}" alt="${blog.title}" class="blog-image">
                        </c:if>
                        <div class="blog-content">
                            <h2 class="blog-title">${blog.title}</h2>
                            <c:set var="contentNoTags" value="${blog.content.replaceAll('<[^>]*>', '')}" />
                            <c:set var="contentLength" value="${fn:length(contentNoTags)}" />
                            <c:set var="excerptLength" value="${contentLength > 150 ? 150 : contentLength}" />
                            <p class="blog-excerpt">${fn:substring(contentNoTags, 0, excerptLength)}...</p>
                            <div class="blog-meta">
                                <span><i class="fas fa-user"></i> ${blog.authorID.username}</span>
                                <span><i class="fas fa-calendar"></i>
                                        <fmt:formatDate value="${blog.createdAtDate}" pattern="dd/MM/yyyy"/>
                                    </span>
                            </div>
                            <span class="read-more">
                                    Đọc thêm <i class="fas fa-arrow-right"></i>
                                </span>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-newspaper"></i>
                <h2>Chưa có bài viết nào</h2>
                <p>Các bài viết mới sẽ sớm được cập nhật.</p>
            </div>
        </c:otherwise>
    </c:choose>

    <div class="footer">
        <p>© 2025 Blog - Cập nhật tin tức mới nhất</p>
    </div>
</div>
</body>
</html>
