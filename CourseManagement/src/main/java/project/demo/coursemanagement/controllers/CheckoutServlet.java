package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import project.demo.coursemanagement.dao.CartDAO;
import project.demo.coursemanagement.dao.impl.CartDAOImpl;
import project.demo.coursemanagement.dao.impl.OrderDAOImpl;
import project.demo.coursemanagement.dto.OrderDTO;
import project.demo.coursemanagement.dto.OrderDetailDTO;
import project.demo.coursemanagement.entities.Cartitem;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private final OrderDAOImpl orderDAO = new OrderDAOImpl();
    private final CartDAO cartDAO = new CartDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        List<Cartitem> cartItems = (List<Cartitem>) session.getAttribute("cartItems");
        BigDecimal totalPrice = (BigDecimal) session.getAttribute("totalPrice");
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect("CartServlet");
            return;
        }
        System.out.println("[DEBUG] userId: " + userId);
        System.out.println("[DEBUG] cartItems: " + cartItems);
        System.out.println("[DEBUG] totalPrice: " + totalPrice);
        // Tạo order mới
        OrderDTO order = new OrderDTO();
        order.setUsername(""); // Có thể lấy username từ session nếu cần
        order.setStatus("pending");
        order.setPaymentMethod(null);
        order.setTotalAmount(totalPrice);
        order.setCreatedAt(Instant.now());
        order.setOrderDetails(new ArrayList<>());
        // Tạo order details từ cartItems
        for (Cartitem item : cartItems) {
            OrderDetailDTO detail = new OrderDetailDTO();
            detail.setCourseId(item.getCourseID().getId());
            detail.setCourseTitle(item.getCourseID().getTitle());
            detail.setPrice(item.getPrice());
            order.getOrderDetails().add(detail);
        }
        System.out.println("[DEBUG] orderDTO: " + order);
        // Lưu order và orderdetails vào DB
        int orderId = orderDAO.createOrderWithDetails(userId, order);
        System.out.println("[DEBUG] orderId (saved): " + orderId);
        System.out.println("[DEBUG] orderDTO after save: " + order);
        // Xóa cart khỏi database
        cartDAO.deleteCartAndItemsByUserId(userId);
        System.out.println("[DEBUG] Cart and cart items deleted from DB for userId: " + userId);
        // Xóa cart khỏi session
        session.removeAttribute("cartItems");
        System.out.println("[DEBUG] cartItems after remove: " + session.getAttribute("cartItems"));
        // Lưu orderId vào session để checkout.jsp sử dụng
        session.setAttribute("currentOrderId", orderId);
        // Chuyển hướng đến trang hóa đơn
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }
}
