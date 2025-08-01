package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import project.demo.coursemanagement.entities.Blog;
import project.demo.coursemanagement.service.BlogService;
import project.demo.coursemanagement.utils.SessionUtil;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/blog/edit/*")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class BlogEditController extends HttpServlet {
    private BlogService blogService;
    private String uploadPath;
    private static final Logger logger = Logger.getLogger(BlogEditController.class.getName());

    @Override
    public void init() throws ServletException {
        super.init();
        blogService = new BlogService();
        uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "blog";
        new File(uploadPath).mkdirs();
        logger.info("BlogEditController initialized. Upload path: " + uploadPath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        logger.info("Received GET request for blog edit. Blog ID: " + idParam);

        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                Blog blog = blogService.getBlogById(id);
                if (blog != null) {
                    project.demo.coursemanagement.entities.User currentUser = SessionUtil.getUserFromSession(request);
                    if (currentUser != null && currentUser.getId() == blog.getAuthorID().getId()) {
                        request.setAttribute("blog", blog);
                        request.getRequestDispatcher("/WEB-INF/views/blog_edit.jsp").forward(request, response);
                        logger.info("Authorized user. Forwarding to blog_edit.jsp for blog ID: " + id);
                        return;
                    } else {
                        logger.warning("Unauthorized access to edit blog ID: " + id + " by user ID: " + (currentUser != null ? currentUser.getId() : "null"));
                    }
                } else {
                    logger.warning("Blog not found with ID: " + id);
                }
            } catch (NumberFormatException e) {
                logger.log(Level.SEVERE, "Invalid blog ID format: " + idParam, e);
            }
        }
        response.sendRedirect("list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String status = request.getParameter("status");

        logger.info("Received POST request to update blog. ID: " + idParam + ", Title: " + title);

        try {
            int id = Integer.parseInt(idParam);
            Blog blog = blogService.getBlogById(id);

            if (blog != null) {
                project.demo.coursemanagement.entities.User currentUser = SessionUtil.getUserFromSession(request);
                if (currentUser == null || currentUser.getId() != blog.getAuthorID().getId()) {
                    logger.warning("Unauthorized blog update attempt. User ID: " + (currentUser != null ? currentUser.getId() : "null") + ", Blog ID: " + id);
                    response.sendRedirect("list");
                    return;
                }

                // Handle image upload
                Part filePart = request.getPart("imageFile");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);
                    String filePath = uploadPath + File.separator + fileName;

                    if (blog.getImageURL() != null && !blog.getImageURL().isEmpty()) {
                        String oldImagePath = getServletContext().getRealPath("") +
                                blog.getImageURL().replace(request.getContextPath(), "");
                        Files.deleteIfExists(Paths.get(oldImagePath));
                        logger.info("Deleted old blog image: " + oldImagePath);
                    }

                    filePart.write(filePath);
                    blog.setImageURL(request.getContextPath() + "/uploads/blog/" + fileName);
                    logger.info("Uploaded new blog image: " + filePath);
                }

                // Update blog
                blog.setTitle(title);
                blog.setContent(content);
                blog.setStatus(status);

                blogService.updateBlog(blog);
                logger.info("Blog updated successfully. ID: " + id);
                response.sendRedirect(request.getContextPath() + "/admin/blog/list?message=Blog updated successfully");
            } else {
                logger.warning("Blog not found during update. ID: " + id);
                request.setAttribute("error", "Blog not found");
                doGet(request, response);
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error updating blog: " + idParam, e);
            request.setAttribute("error", "Error updating blog: " + e.getMessage());
            doGet(request, response);
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
