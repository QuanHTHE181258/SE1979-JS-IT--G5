package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dao.OrderDAO;
import project.demo.coursemanagement.dao.OrderDAOImpl;
import project.demo.coursemanagement.dto.OrderDTO;
import project.demo.coursemanagement.dto.OrderAnalyticsDTO;
import project.demo.coursemanagement.service.OrderService;
import project.demo.coursemanagement.service.impl.OrderServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderController", urlPatterns = {
    "/admin/orders", 
    "/admin/orders/update-status",
    "/admin/orders/export",
    "/admin/orders/analytics"
})
public class OrderController extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAOImpl();
    private final OrderService orderService = new OrderServiceImpl();
    private static final int PAGE_SIZE = 8;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/orders".equals(path)) {
            handleOrdersList(request, response);
        } else if ("/admin/orders/export".equals(path)) {
            handleExportOrders(request, response);
        } else if ("/admin/orders/analytics".equals(path)) {
            handleOrderAnalytics(request, response);
        }
    }

    private void handleOrdersList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pageParam = request.getParameter("page");
        String status = request.getParameter("status");
        String searchKeyword = request.getParameter("search");

        int page = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int offset = (page - 1) * PAGE_SIZE;
        List<OrderDTO> orders;
        int totalOrders;
        int totalPages;

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // Search functionality
            orders = orderDAO.searchOrders(searchKeyword, offset, PAGE_SIZE);
            totalOrders = orderDAO.countSearchResults(searchKeyword);
            request.setAttribute("searchKeyword", searchKeyword);
        } else if (status != null && !status.isEmpty()) {
            // Filter by status
            orders = orderDAO.getOrdersByStatus(status);
            totalOrders = orders.size(); // For status filtering, we already have all orders
        } else {
            // Default pagination
            orders = orderDAO.getOrdersWithPagination(offset, PAGE_SIZE);
            totalOrders = orderDAO.countOrders();
        }

        totalPages = (int) Math.ceil((double) totalOrders / PAGE_SIZE);

        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentStatus", status);

        request.getRequestDispatcher("/WEB-INF/views/admin_orders.jsp").forward(request, response);
    }

    // Function 1: Export Orders (3 transactions: Controller → Service → DAO)
    private void handleExportOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String format = request.getParameter("format");
        String status = request.getParameter("status");
        
        // Get orders based on filter
        List<OrderDTO> orders;
        if (status != null && !status.isEmpty()) {
            orders = orderDAO.getOrdersByStatus(status);
        } else {
            orders = orderDAO.getAllOrders();
        }
        
        // Export using service (Transaction 1: Controller → Service)
        byte[] exportData;
        String filename;
        
        if ("excel".equalsIgnoreCase(format)) {
            exportData = orderService.exportOrdersToExcel(orders);
            filename = "orders_export.xlsx";
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        } else {
            exportData = orderService.exportOrdersToCSV(orders);
            filename = "orders_export.csv";
            response.setContentType("text/csv");
        }
        
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        response.getOutputStream().write(exportData);
        response.getOutputStream().flush();
    }

    // Function 2: Order Analytics Dashboard (4 transactions: Controller → DTO → Service → DAO)
    private void handleOrderAnalytics(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get analytics data (Transaction 1: Controller → Service)
        OrderAnalyticsDTO analytics = orderService.getOrderAnalytics();
        
        // Set analytics data to request (Transaction 2: Service → DTO)
        request.setAttribute("analytics", analytics);
        
        // Forward to analytics view
        request.getRequestDispatcher("/WEB-INF/views/admin_order_analytics.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/orders/update-status".equals(path)) {
            String orderIdParam = request.getParameter("orderId");
            String newStatus = request.getParameter("status");

            if (orderIdParam != null && newStatus != null) {
                try {
                    int orderId = Integer.parseInt(orderIdParam);
                    boolean success = orderDAO.updateOrderStatus(orderId, newStatus);

                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/admin/orders");
                    } else {
                        request.setAttribute("error", "Failed to update order status");
                        request.getRequestDispatcher("/WEB-INF/views/admin_orders.jsp").forward(request, response);
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid order ID");
                    request.getRequestDispatcher("/WEB-INF/views/admin_orders.jsp").forward(request, response);
                }
            }
        }
    }
}
