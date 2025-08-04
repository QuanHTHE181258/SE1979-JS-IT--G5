package project.demo.coursemanagement.controllers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import project.demo.coursemanagement.dao.CartDAO;
import project.demo.coursemanagement.dao.UserRoleDAO;
import project.demo.coursemanagement.dao.impl.CartDAOImpl;
import project.demo.coursemanagement.dao.impl.UserRoleDAOImpl;
import project.demo.coursemanagement.entities.Cartitem;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAOImpl();
    private final UserRoleDAO userRoleDAO = new UserRoleDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("=== CartServlet GET Debug ===");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        System.out.println("UserId from session: " + userId);

        if (userId == null) {
            System.out.println("UserId is null, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Cartitem> cartItems = cartDAO.getCartItems(userId);
        System.out.println("Retrieved " + cartItems.size() + " cart items");

        // Debug cart items
        for (int i = 0; i < cartItems.size(); i++) {
            Cartitem item = cartItems.get(i);
        }

        BigDecimal totalPrice = cartItems.stream()
                .map(item -> item.getPrice() != null ? item.getPrice() : BigDecimal.ZERO)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        System.out.println("Total price calculated: " + totalPrice);

        session.setAttribute("cartItems", cartItems);
        session.setAttribute("totalPrice", totalPrice);

        System.out.println("Forwarding to cart.jsp");
        request.getRequestDispatcher("/WEB-INF/views/profile/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("=== CartServlet POST Debug ===");

        String action = request.getParameter("action");
        String value = request.getParameter("courseId");

        request.getParameterMap().forEach((k, v) ->
                System.out.println("  " + k + " = " + java.util.Arrays.toString(v)));

        int courseId;
        if (value == null || value.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "courseId is required.");
            return;
        }

        try {
            courseId = Integer.parseInt(value.trim());
            System.out.println("Parsed courseId: " + courseId);

            if (courseId <= 0) {
                System.err.println("ERROR: courseId is not positive: " + courseId);
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid courseId.");
                return;
            }
        } catch (NumberFormatException e) {
            System.err.println("ERROR: courseId is not a number: '" + value + "'");
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "courseId must be a number.");
            return;
        }

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        System.out.println("UserId from session: " + userId);

        if (userId == null) {
            System.out.println("UserId is null, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        System.out.println("Executing action: " + action + " for courseId: " + courseId + " and userId: " + userId);

        try {
            switch (action) {
                case "add" -> {
                    System.out.println("Adding course to cart...");

                    Integer roleId = userRoleDAO.getRoleIdByUserId(userId);
                    System.out.println("User roleId: " + roleId);

                    if (roleId == null || roleId != 1) { // 1 = Student
                        session.setAttribute("message", "Chỉ học viên mới được phép thêm khóa học vào giỏ hàng!");
                        session.setAttribute("messageType", "error");
                        response.sendRedirect("CartServlet");
                        return;
                    }

                    String result = cartDAO.addToCart(userId, courseId);

                    // Phần xử lý kết quả thêm giỏ hàng...


                    // Xử lý thông báo dựa trên kết quả
                    switch (result) {
                        case "SUCCESS" -> {
                            session.setAttribute("message", "Khóa học đã được thêm vào giỏ hàng thành công!");
                            session.setAttribute("messageType", "success");
                            System.out.println("Course added successfully");
                        }
                        case "ALREADY_ENROLLED" -> {
                            session.setAttribute("message", "Bạn đã ghi danh khóa học này rồi!");
                            session.setAttribute("messageType", "warning");
                            System.out.println("Course already enrolled");
                        }
                        case "ALREADY_IN_CART" -> {
                            session.setAttribute("message", "Khóa học này đã có trong giỏ hàng của bạn!");
                            session.setAttribute("messageType", "info");
                            System.out.println("Course already in cart");
                        }
                        case "FAILED" -> {
                            session.setAttribute("message", "Không thể thêm khóa học vào giỏ hàng. Vui lòng thử lại!");
                            session.setAttribute("messageType", "error");
                            System.out.println("Failed to add course to cart");
                        }
                    }
                }
                case "remove" -> {
                    System.out.println("Removing course from cart...");
                    cartDAO.removeFromCart(userId, courseId);
                    session.setAttribute("message", "Khóa học đã được xóa khỏi giỏ hàng!");
                    session.setAttribute("messageType", "success");
                    System.out.println("Course removed successfully");
                }
                default -> {
                    System.err.println("ERROR: Invalid action: " + action);
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
                    return;
                }
            }
        } catch (Exception e) {
            System.err.println("ERROR: Exception during DAO operation:");
            e.printStackTrace();
            session.setAttribute("message", "Đã xảy ra lỗi. Vui lòng thử lại!");
            session.setAttribute("messageType", "error");
        }

        System.out.println("Redirecting to CartServlet GET");
        response.sendRedirect("CartServlet");
    }
}