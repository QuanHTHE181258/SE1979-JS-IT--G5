package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import project.demo.coursemanagement.dao.OrderDAO;
import project.demo.coursemanagement.dao.impl.OrderDAOImpl;
import project.demo.coursemanagement.dto.OrderDetailsViewDTO;
import project.demo.coursemanagement.entities.User;

import java.io.IOException;

@WebServlet(name = "OrderDetailsController", urlPatterns = {"/order-details"})
public class OrderDetailsController extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        // Check if user is logged in
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            // Get order ID from request parameter
            String orderIdParam = request.getParameter("orderId");
            if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID is required");
                return;
            }

            int orderId = Integer.parseInt(orderIdParam);

            // Get order details using the new DTO
            OrderDetailsViewDTO orderDetails = orderDAO.getOrderDetailView(orderId);

            if (orderDetails == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
                return;
            }

            // Set attributes for JSP
            request.setAttribute("orderDetails", orderDetails);

            // Forward to JSP page
            request.getRequestDispatcher("/WEB-INF/views/order/order-details.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
