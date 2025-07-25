package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import project.demo.coursemanagement.entities.Material;
import project.demo.coursemanagement.entities.Lesson;
import project.demo.coursemanagement.service.MaterialService;

import java.io.File;
import java.io.IOException;

@WebServlet(name = "AddMaterialServlet", urlPatterns = {"/add-material"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 10 * 1024 * 1024,  // 10MB
        maxRequestSize = 20 * 1024 * 1024 // 20MB
)
public class AddMaterialServlet extends HttpServlet {

    // Hiển thị form add material
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy lessonId từ parameter
        String lessonIdParam = request.getParameter("lessonId");
        if (lessonIdParam != null && !lessonIdParam.trim().isEmpty()) {
            try {
                int lessonId = Integer.parseInt(lessonIdParam);
                // Tạo lesson object để truyền vào form
                Lesson lesson = new Lesson();
                lesson.setId(lessonId);
                request.setAttribute("lesson", lesson);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid lesson ID!");
            }
        }

        // Hiển thị form
        request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
    }

    // Xử lý upload file
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra content type trước khi xử lý
        String contentType = request.getContentType();
        if (contentType == null || !contentType.toLowerCase().startsWith("multipart/")) {
            request.setAttribute("errorMessage", "Invalid request format. Please use the upload form.");
            request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
            return;
        }

        String title = request.getParameter("title");
        String lessonIdStr = request.getParameter("lessonId");
        Part filePart = request.getPart("file");

        // Validate input
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Title is required!");
            request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
            return;
        }

        if (lessonIdStr == null || lessonIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Lesson ID is required!");
            request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
            return;
        }

        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("errorMessage", "Please select a file to upload!");
            request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
            return;
        }

        try {
            int lessonId = Integer.parseInt(lessonIdStr);

            // Tạo thư mục upload nếu chưa có
            String uploadPath = getServletContext().getRealPath("/assets/materials/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Tạo tên file unique
            String originalFileName = filePart.getSubmittedFileName();
            String fileName = System.currentTimeMillis() + "_" + originalFileName;
            String filePath = uploadPath + File.separator + fileName;

            // Lưu file
            filePart.write(filePath);

            // Tạo material object
            Material material = new Material();
            material.setTitle(title.trim());
            material.setFileURL("assets/materials/" + fileName);

            Lesson lesson = new Lesson();
            lesson.setId(lessonId);
            material.setLessonID(lesson);

            // Lưu vào database
            boolean success = new MaterialService().addMaterial(material);

            if (success) {
                // Redirect với success message
                response.sendRedirect(request.getContextPath() + "/lesson-details?id=" + lessonId + "&success=material_added");
            } else {
                // Xóa file đã upload nếu lưu DB thất bại
                File uploadedFile = new File(filePath);
                if (uploadedFile.exists()) {
                    uploadedFile.delete();
                }
                request.setAttribute("errorMessage", "Failed to save material to database!");
                request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid lesson ID format!");
            request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
        }
    }
}