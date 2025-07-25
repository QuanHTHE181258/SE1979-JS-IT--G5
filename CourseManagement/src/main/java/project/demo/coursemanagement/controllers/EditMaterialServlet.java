package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dto.MaterialDTO;
import project.demo.coursemanagement.service.MaterialService;

import java.io.IOException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.nio.file.Paths;
import java.io.File;

@WebServlet("/edit-material")
@MultipartConfig
public class EditMaterialServlet extends HttpServlet {
    private final MaterialService materialService = new MaterialService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        if ("delete".equals(action) && idStr != null) {
            int id = Integer.parseInt(idStr);
            MaterialDTO material = materialService.getMaterialById(id);
            boolean deleted = materialService.deleteMaterial(id);
            if (deleted && material != null) {
                response.sendRedirect(request.getContextPath() + "/lesson-details?id=" + material.getLessonId() + "&delete=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/lesson-details?error=delete");
            }
            return;
        }
        if (idStr == null) {
            response.sendRedirect("/CourseManagement_war_exploded/error.jsp");
            return;
        }
        int id = Integer.parseInt(idStr);
        MaterialDTO material = materialService.getMaterialById(id);
        if (material == null) {
            response.sendRedirect("/CourseManagement_war_exploded/error.jsp");
            return;
        }
        request.setAttribute("material", material);
        request.getRequestDispatcher("/WEB-INF/views/edit_material.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        String title = request.getParameter("title");
        String fileUrl = request.getParameter("fileUrl");

        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("/uploads/materials");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            fileUrl = "uploads/materials/" + fileName;
        }

        MaterialDTO material = new MaterialDTO();
        material.setId(id);
        material.setLessonId(lessonId);
        material.setTitle(title);
        material.setFileURL(fileUrl);
        boolean updated = materialService.updateMaterial(material);
        if (updated) {
            response.sendRedirect(request.getContextPath() + "/lesson-details?id=" + lessonId + "&success=1");
        } else {
            request.setAttribute("error", "Cập nhật thất bại!");
            request.setAttribute("material", material);
            request.getRequestDispatcher("/WEB-INF/views/edit_material.jsp").forward(request, response);
        }
    }
} 