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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String lessonIdStr = request.getParameter("lessonId");
        Part filePart = request.getPart("file");

        if (title == null || title.isEmpty() || lessonIdStr == null || filePart == null || filePart.getSize() == 0) {
            request.setAttribute("errorMessage", "All fields are required!");
            request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
            return;
        }

        int lessonId = Integer.parseInt(lessonIdStr);

        // Lưu file lên server
        String uploadPath = getServletContext().getRealPath("/assets/materials/");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // Lưu vào DB
        Material material = new Material();
        material.setTitle(title);
        material.setFileURL("assets/materials/" + fileName);
        Lesson lesson = new Lesson();
        lesson.setId(lessonId);
        material.setLessonID(lesson);

        boolean success = new MaterialService().addMaterial(material);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/lesson-details?id=" + lessonId);
        } else {
            request.setAttribute("errorMessage", "Failed to add material!");
            request.getRequestDispatcher("/WEB-INF/views/add_material.jsp").forward(request, response);
        }
    }
} 