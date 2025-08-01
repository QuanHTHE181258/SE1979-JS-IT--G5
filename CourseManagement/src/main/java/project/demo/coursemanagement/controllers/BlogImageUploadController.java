package project.demo.coursemanagement.controllers;

import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/admin/blog/upload-image")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,  // 1 MB
        maxFileSize = 1024 * 1024 * 10,   // 10 MB
        maxRequestSize = 1024 * 1024 * 15  // 15 MB
)
public class BlogImageUploadController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        JsonObject json = new JsonObject();

        try {
            Part filePart = request.getPart("upload"); // 'upload' is the CKEditor default file param name
            String fileName = UUID.randomUUID().toString() + "_" + getFileName(filePart);

            // Đường dẫn lưu file
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "blog";
            new File(uploadPath).mkdirs();

            // Lưu file
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // URL để truy cập ảnh
            String fileUrl = request.getContextPath() + "/uploads/blog/" + fileName;

            // Trả về response theo format CKEditor yêu cầu
            json.addProperty("uploaded", 1);
            json.addProperty("fileName", fileName);
            json.addProperty("url", fileUrl);

        } catch (Exception e) {
            JsonObject error = new JsonObject();
            error.addProperty("message", "Could not upload file: " + e.getMessage());

            json.addProperty("uploaded", 0);
            json.add("error", error);  // Sử dụng add() thay vì addProperty() cho object
        }

        response.getWriter().print(json.toString());
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
