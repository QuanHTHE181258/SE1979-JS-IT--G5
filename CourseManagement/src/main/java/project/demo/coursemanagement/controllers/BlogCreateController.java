package project.demo.coursemanagement.controllers;

import project.demo.coursemanagement.service.BlogService;
import project.demo.coursemanagement.entities.Blog;
import project.demo.coursemanagement.entities.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.File;
import java.util.UUID;

@WebServlet("/admin/blog/create")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,  // 1 MB
        maxFileSize = 1024 * 1024 * 10,   // 10 MB
        maxRequestSize = 1024 * 1024 * 15  // 15 MB
)
public class BlogCreateController extends HttpServlet {
    private BlogService blogService;
    private String uploadPath;

    @Override
    public void init() throws ServletException {
        blogService = new BlogService();
        // Directory for storing blog images in webapp
        uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "blog";
        // Create directory if it doesn't exist
        new File(uploadPath).mkdirs();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form tạo blog
        request.getRequestDispatcher("/WEB-INF/views/blog_create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("BlogCreateController - doPost called");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String status = request.getParameter("status");

        System.out.println("Title: " + title);
        System.out.println("Content (shortened): " + (content != null ? content.substring(0, Math.min(100, content.length())) : "null"));
        System.out.println("Status: " + status);

        User currentUser = project.demo.coursemanagement.utils.SessionUtil.getUserFromSession(request);
        if (currentUser == null) {
            System.out.println("No user in session - redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        } else {
            System.out.println("Current user ID: " + currentUser.getId());
        }

        try {
            Blog blog = new Blog();
            blog.setTitle(title);
            blog.setContent(content);
            blog.setStatus(status);
            blog.setAuthorID(currentUser);

            // Handle image upload
            Part filePart = request.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);
                String filePath = uploadPath + File.separator + fileName;

                System.out.println("Saving image to: " + filePath);

                filePart.write(filePath);
                blog.setImageURL(request.getContextPath() + "/uploads/blog/" + fileName);
            } else {
                System.out.println("No image uploaded.");
            }

            boolean success = blogService.createBlog(blog);
            System.out.println("Blog creation result: " + success);

            if (success) {
                System.out.println("Redirecting to blog list.");
                response.sendRedirect(request.getContextPath() + "/admin/blog/list?message=Blog created successfully");
            } else {
                System.out.println("Failed to create blog. Forwarding to form with error.");
                request.setAttribute("error", "Failed to create blog");
                request.getRequestDispatcher("/WEB-INF/views/blog_create.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("Exception while creating blog: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error creating blog: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/blog_create.jsp").forward(request, response);
        }
    }


    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length()-1);
            }
        }
        return "";
    }
}
