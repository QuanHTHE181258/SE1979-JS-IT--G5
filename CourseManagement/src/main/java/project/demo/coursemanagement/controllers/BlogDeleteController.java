package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.entities.Blog;
import project.demo.coursemanagement.service.BlogService;
import project.demo.coursemanagement.utils.SessionUtil;
import project.demo.coursemanagement.entities.User;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/blog/delete")
public class BlogDeleteController extends HttpServlet {
    private BlogService blogService;
    private static final Logger logger = Logger.getLogger(BlogDeleteController.class.getName());

    @Override
    public void init() throws ServletException {
        blogService = new BlogService();
        logger.info("BlogDeleteController initialized");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        User currentUser = SessionUtil.getUserFromSession(request);

        if (currentUser == null) {
            logger.warning("Unauthorized access attempt - no user in session");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        logger.info("Delete request received from user ID: " + currentUser.getId() + ", blog ID param: " + idParam);

        try {
            int id = Integer.parseInt(idParam);
            Blog blog = blogService.getBlogById(id);

            if (blog != null && (currentUser.getId() == blog.getAuthorID().getId())) {
                logger.info("Authorized to delete blog ID: " + id);

                // Delete associated image if it exists
                if (blog.getImageURL() != null && !blog.getImageURL().isEmpty()) {
                    String imagePath = getServletContext().getRealPath("") +
                            blog.getImageURL().replace(request.getContextPath(), "");
                    Files.deleteIfExists(Paths.get(imagePath));
                    logger.info("Deleted blog image: " + imagePath);
                }

                // Delete blog from database
                boolean success = blogService.deleteBlog(id);
                if (success) {
                    logger.info("Blog deleted successfully. ID: " + id);
                    response.sendRedirect(request.getContextPath() + "/admin/blog/list?message=Blog deleted successfully");
                } else {
                    logger.warning("Failed to delete blog. ID: " + id);
                    response.sendRedirect(request.getContextPath() + "/admin/blog/list?error=Failed to delete blog");
                }
            } else {
                logger.warning("Unauthorized blog delete attempt or blog not found. User ID: " + currentUser.getId() + ", Blog ID: " + idParam);
                response.sendRedirect(request.getContextPath() + "/admin/blog/list?error=Blog not found or unauthorized");
            }
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Invalid blog ID: " + idParam, e);
            response.sendRedirect(request.getContextPath() + "/admin/blog/list?error=Invalid blog ID");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Unexpected error when deleting blog ID: " + idParam, e);
            response.sendRedirect(request.getContextPath() + "/admin/blog/list?error=" + e.getMessage());
        }
    }
}
