package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.Blog;
import project.demo.coursemanagement.service.BlogService;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/list-blog")
public class BlogListPublicController extends HttpServlet {
    private BlogService blogService;

    @Override
    public void init() throws ServletException {
        blogService = new BlogService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách các blog đã publish
            List<Blog> publishedBlogs = blogService.getPublishedBlogs();

            // Chuyển đổi createdAt thành Date cho định dạng trong JSP
            for (Blog blog : publishedBlogs) {
                if (blog.getCreatedAt() != null) {
                    blog.setCreatedAtDate(Date.from(blog.getCreatedAt()));
                }
            }

            request.setAttribute("blogs", publishedBlogs);
            request.getRequestDispatcher("/WEB-INF/views/blog_list_public.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
}
