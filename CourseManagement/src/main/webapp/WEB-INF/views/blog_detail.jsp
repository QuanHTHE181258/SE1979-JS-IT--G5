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
    <title>${blog.title} - Chi tiết Blog</title>
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
            padding: 40px 20px;
            text-align: center;
            margin-bottom: 30px;
        }

        .header h1 {
            font-size: 2.5rem;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .post {
            background: white;
            padding: 30px;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .post-meta {
            display: inline-flex;
            align-items: center;
            gap: 20px;
            background: white;
            padding: 12px 25px;
            border-radius: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin: 25px 0;
        }

        .post-meta span {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #4a5568;
            font-size: 1rem;
            font-weight: 500;
        }

        .post-meta i {
            color: #667eea;
            font-size: 1.1rem;
        }

        .post-image {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 8px;
            margin: 20px 0;
        }

        .post-content {
            line-height: 1.8;
            font-size: 1.1em;
        }

        .post-content img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin: 20px 0;
        }

        .post-content p {
            margin-bottom: 1.5em;
        }

        .post-content h2,
        .post-content h3,
        .post-content h4 {
            color: #667eea;
            margin: 1.5em 0 0.8em;
        }

        .post-content blockquote {
            background: #f8f9ff;
            padding: 15px 20px;
            border-left: 4px solid #667eea;
            margin: 20px 0;
        }

        .post-content pre {
            background: #f8f9ff;
            padding: 15px;
            border-radius: 5px;
            overflow-x: auto;
            border: 1px solid #eee;
        }

        .post-content code {
            background: #f8f9ff;
            padding: 2px 5px;
            border-radius: 3px;
            font-size: 0.9em;
        }

        .post-content ul,
        .post-content ol {
            margin: 1.5em 0;
            padding-left: 2em;
        }

        .post-content li {
            margin-bottom: 0.5em;
        }

        .related-posts {
            margin-top: 50px;
            padding-top: 30px;
            border-top: 1px solid #eee;
        }

        .related-posts h2 {
            color: #667eea;
            font-size: 1.5rem;
            margin-bottom: 20px;
        }

        .related-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .related-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            text-decoration: none;
            color: inherit;
        }

        .related-card:hover {
            transform: translateY(-5px);
        }

        .related-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .related-content {
            padding: 15px;
        }

        .related-title {
            color: #667eea;
            font-size: 1.1rem;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .related-excerpt {
            color: #666;
            font-size: 0.9rem;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
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
                padding: 30px 15px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .post {
                padding: 20px;
            }

            .related-grid {
                grid-template-columns: 1fr;
            }

            .post-meta {
                flex-direction: column;
                gap: 10px;
                padding: 15px;
                width: 100%;
                box-sizing: border-box;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <div class="container">
        <h1>${blog.title}</h1>
        <div class="post-meta">
            <span><i class="fas fa-user-circle"></i> ${blog.authorID.username}</span>
            <span><i class="fas fa-calendar-alt"></i> <fmt:formatDate value="${blog.createdAtDate}" pattern="dd/MM/yyyy"/></span>
        </div>
    </div>
</div>

<div class="container">
    <article class="post">
        <c:if test="${not empty blog.imageURL}">
            <img src="${blog.imageURL}" alt="${blog.title}" class="post-image">
        </c:if>
        <div class="post-content">
            ${blog.content}
        </div>
    </article>

    <section class="related-posts">
        <h2>Bài viết liên quan</h2>
        <div class="related-grid">
            <c:forEach var="relatedBlog" items="${relatedBlogs}">
                <a href="${pageContext.request.contextPath}/blog/detail?id=${relatedBlog.id}" class="related-card">
                    <c:if test="${not empty relatedBlog.imageURL}">
                        <img src="${relatedBlog.imageURL}" alt="${relatedBlog.title}" class="related-image">
                    </c:if>
                    <div class="related-content">
                        <h3 class="related-title">${relatedBlog.title}</h3>
                        <c:set var="cleanContent" value="${fn:escapeXml(relatedBlog.content)}" />
                        <c:set var="contentLength" value="${fn:length(cleanContent)}" />
                        <c:set var="excerptLength" value="${contentLength > 100 ? 100 : contentLength}" />
                        <p class="related-excerpt">${fn:substring(cleanContent, 0, excerptLength)}...</p>
                    </div>
                </a>
            </c:forEach>
        </div>
    </section>

    <div class="footer">
        <p>© 2025 Blog - Cập nhật tin tức mới nhất</p>
    </div>
</div>
</body>
</html>
