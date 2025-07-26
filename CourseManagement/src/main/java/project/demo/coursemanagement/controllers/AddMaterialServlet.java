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
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet(name = "AddMaterialServlet", urlPatterns = {"/course/material/add"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,    // 1MB
        maxFileSize = 100 * 1024 * 1024,    // 100MB
        maxRequestSize = 100 * 1024 * 1024   // 100MB
)
public class AddMaterialServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AddMaterialServlet.class.getName());
    private final MaterialService materialService = new MaterialService();

    private static final Set<String> ALLOWED_TYPES = new HashSet<>(Arrays.asList(
            "application/pdf",
            "application/msword",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "application/vnd.ms-powerpoint",
            "application/vnd.openxmlformats-officedocument.presentationml.presentation",
            "application/zip",
            "application/x-rar-compressed",
            "video/mp4",
            "audio/mpeg"
    ));

    // Hiển thị form add material
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy lessonId từ parameter
        String lessonIdParam = request.getParameter("lessonId");
        if (lessonIdParam != null && !lessonIdParam.trim().isEmpty()) {
            try {
                int lessonId = Integer.parseInt(lessonIdParam);
                // Tạo lesson object đ��� truyền vào form
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
        try {
            LOGGER.info("Starting material upload process...");

            // Validate content type
            String contentType = request.getContentType();
            LOGGER.info("Request content type: " + contentType);

            if (contentType == null || !contentType.toLowerCase().startsWith("multipart/")) {
                LOGGER.warning("Invalid content type: " + contentType);
                sendError(request, response, "Invalid request format. Please use the upload form.");
                return;
            }

            // Get form data
            String title = request.getParameter("title");
            String lessonIdStr = request.getParameter("lessonId");
            Part filePart = request.getPart("file");

            LOGGER.info("Received form data - Title: " + title +
                    ", LessonId: " + lessonIdStr);

            // Validate required fields
            if (title == null || title.trim().isEmpty()) {
                LOGGER.warning("Title is empty or null");
                sendError(request, response, "Title is required!");
                return;
            }

            if (lessonIdStr == null || lessonIdStr.trim().isEmpty()) {
                LOGGER.warning("LessonId is empty or null");
                sendError(request, response, "Lesson ID is required!");
                return;
            }

            if (filePart == null || filePart.getSize() == 0) {
                LOGGER.warning("No file uploaded");
                sendError(request, response, "Please select a file to upload!");
                return;
            }

            // Log file details
            String fileName = filePart.getSubmittedFileName();
            long fileSize = filePart.getSize();
            String fileType = filePart.getContentType();

            LOGGER.info("File details - Name: " + fileName +
                    ", Size: " + fileSize + " bytes" +
                    ", Type: " + fileType);

            // Validate file type
            if (!ALLOWED_TYPES.contains(fileType)) {
                LOGGER.warning("Invalid file type: " + fileType);
                sendError(request, response, "Invalid file type. Allowed types: PDF, DOC, DOCX, PPT, PPTX, ZIP, RAR, MP4, MP3");
                return;
            }

            // Validate file size
            if (fileSize > 100 * 1024 * 1024) {
                LOGGER.warning("File too large: " + fileSize + " bytes");
                sendError(request, response, "File size must be less than 100MB");
                return;
            }

            // Create upload directory
            String uploadPath = getServletContext().getRealPath("/assets/materials/");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                LOGGER.info("Creating upload directory: " + uploadPath);
                boolean created = uploadDir.mkdirs();
                if (!created) {
                    LOGGER.severe("Failed to create upload directory");
                    sendError(request, response, "Server error: Failed to create upload directory");
                    return;
                }
            }

            // Generate unique filename
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = System.currentTimeMillis() + "_" + title.replaceAll("\\s+", "_") + fileExtension;
            String filePath = uploadPath + File.separator + newFileName;

            LOGGER.info("Saving file to: " + filePath);

            try {
                // Save file
                filePart.write(filePath);
                LOGGER.info("File saved successfully");
            } catch (IOException e) {
                LOGGER.log(Level.SEVERE, "Error saving file", e);
                sendError(request, response, "Failed to save file: " + e.getMessage());
                return;
            }

            // Create Material object
            Material material = new Material();
            material.setTitle(title);
            material.setFileURL("/assets/materials/" + newFileName);
            material.setLessonId(Integer.parseInt(lessonIdStr));

            // Save to database
            LOGGER.info("Saving material to database");
            boolean success = materialService.addMaterial(material);

            if (success) {
                LOGGER.info("Material saved successfully");
                response.sendRedirect(request.getContextPath() + "/lesson-details?id=" + lessonIdStr + "&message=Material added successfully");
            } else {
                LOGGER.warning("Failed to save material to database");
                // Delete uploaded file if database save fails
                new File(filePath).delete();
                LOGGER.info("Deleted uploaded file due to database save failure");
                sendError(request, response, "Failed to save material information");
            }

        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid lesson ID format", e);
            sendError(request, response, "Invalid lesson ID format");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error during file upload", e);
            sendError(request, response, "Error occurred while uploading file: " + e.getMessage());
        }
    }

    private void sendError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        LOGGER.warning("Sending error message to user: " + message);
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
    }
}
