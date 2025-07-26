package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.utils.AuthorizationUtil;
import project.demo.coursemanagement.utils.SessionUtil;

import java.io.IOException;

@WebServlet("/secure-example")
public class ExampleSecureController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Cách 1: Sử dụng AuthorizationUtil
        if (!AuthorizationUtil.checkAndRedirect(request, response, "5", "3")) {
            return; // Đã redirect trong checkAndRedirect
        }

        // Cách 2: Kiểm tra thủ công
        if (!SessionUtil.isAdmin(request) && !SessionUtil.isCourseManager(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        // Logic xử lý khi có quyền
        request.setAttribute("message", "Welcome to secure area!");
        request.getRequestDispatcher("/WEB-INF/views/secure-example.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra quyền cho resource cụ thể
        String resourceOwnerIdStr = request.getParameter("resourceOwnerId");
        if (resourceOwnerIdStr != null) {
            try {
                Integer resourceOwnerId = Integer.parseInt(resourceOwnerIdStr);
                if (!AuthorizationUtil.canAccessResource(request, resourceOwnerId)) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "You can only modify your own resources");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid resource owner ID");
                return;
            }
        }

        // Xử lý logic khi có quyền
        // ...

        response.sendRedirect(request.getContextPath() + "/success");
    }
} 