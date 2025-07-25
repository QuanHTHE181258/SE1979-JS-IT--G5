package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.impl.OrderDAOImpl;
import project.demo.coursemanagement.dao.impl.EnrollmentDAOImpl;
import project.demo.coursemanagement.dto.OrderDTO;
import project.demo.coursemanagement.dto.OrderDetailDTO;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "PaymentResultController", urlPatterns = {"/vnpay"})
public class PaymentResultController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");
        String vnp_TxnRef = req.getParameter("vnp_TxnRef");
        // Sửa lại: lấy orderId từ vnp_TxnRef (VNPAY trả về)
        int orderId = 0;
        if (vnp_TxnRef != null) {
            try {
                orderId = Integer.parseInt(vnp_TxnRef);
            } catch (NumberFormatException e) {
                System.out.println("[DEBUG] vnp_TxnRef không phải số, chuyển hướng failed");
                req.getRequestDispatcher("/WEB-INF/views/paymentFailed.jsp").forward(req, resp);
                return;
            }
        }
        System.out.println("[DEBUG] vnp_ResponseCode: " + vnp_ResponseCode);
        System.out.println("[DEBUG] vnp_TxnRef: " + vnp_TxnRef);
        System.out.println("[DEBUG] orderId: " + orderId);
        OrderDAOImpl orderDAO = new OrderDAOImpl();
        OrderDTO order = orderDAO.getOrderById(orderId);
        System.out.println("[DEBUG] order: " + (order != null ? order.toString() : "null"));
        if (order == null) {
            System.out.println("[DEBUG] Order not found, redirecting to paymentFailed.jsp");
            req.getRequestDispatcher("/WEB-INF/views/paymentFailed.jsp").forward(req, resp);
            return;
        }
        if ("00".equals(vnp_ResponseCode)) {
            System.out.println("[DEBUG] Payment success, updating order status and creating enrollments");
            orderDAO.updateOrderStatus(orderId, "paid");
            List<OrderDetailDTO> details = order.getOrderDetails();
            EnrollmentDAOImpl enrollmentDAO = new EnrollmentDAOImpl();
            for (OrderDetailDTO detail : details) {
                boolean enrollResult = enrollmentDAO.createEnrollment(order.getUserId(), detail.getCourseId(), new Timestamp(System.currentTimeMillis()));
                System.out.println("[DEBUG] Created enrollment for courseId " + detail.getCourseId() + ": " + enrollResult);
            }
            req.getRequestDispatcher("/WEB-INF/views/paymentSuccess.jsp").forward(req, resp);
        } else {
            System.out.println("[DEBUG] Payment failed, updating order status to cancelled");
            orderDAO.updateOrderStatus(orderId, "cancelled");
            req.getRequestDispatcher("/WEB-INF/views/paymentFailed.jsp").forward(req, resp);
        }
    }
}
