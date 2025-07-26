package project.demo.coursemanagement.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.demo.coursemanagement.dto.OrderDTO;
import project.demo.coursemanagement.dto.OrderAnalyticsDTO;
import project.demo.coursemanagement.service.OrderService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "OrderController", urlPatterns = {
        "/admin/orders",
        "/admin/orders/update-status",
        "/admin/orders/export",
        "/admin/orders/analytics"
})
public class OrderController extends HttpServlet {
    private final OrderService orderService = new OrderService();
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        System.out.println("OrderController - Processing path: " + path);

        switch (path) {
            case "/admin/orders":
                handleOrdersList(request, response);
                break;
            case "/admin/orders/export":
                handleExportOrders(request, response);
                break;
            case "/admin/orders/analytics":
                handleOrderAnalytics(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/admin/orders/update-status".equals(path)) {
            handleUpdateOrderStatus(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleOrdersList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pageParam = request.getParameter("page");
        String status = request.getParameter("status");
        String searchKeyword = request.getParameter("search");

        int page = 1;
        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            // Default to page 1 if invalid
        }

        int offset = (page - 1) * PAGE_SIZE;
        List<OrderDTO> orders;
        int totalOrders;

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            orders = orderService.searchOrders(searchKeyword, offset, PAGE_SIZE);
            totalOrders = orderService.countSearchResults(searchKeyword);
            request.setAttribute("searchKeyword", searchKeyword);
        } else if (status != null && !status.isEmpty()) {
            List<OrderDTO> allOrdersByStatus = orderService.getOrdersByStatus(status);
            totalOrders = allOrdersByStatus.size();
            if (offset < totalOrders) {
                int endIndex = Math.min(offset + PAGE_SIZE, totalOrders);
                orders = allOrdersByStatus.subList(offset, endIndex);
            } else {
                orders = new ArrayList<>();
            }
        } else {
            orders = orderService.getOrdersWithPagination(offset, PAGE_SIZE);
            totalOrders = orderService.countOrders();
        }

        int totalPages = (int) Math.ceil((double) totalOrders / PAGE_SIZE);
        OrderAnalyticsDTO orderStats = orderService.getOrderAnalytics();

        request.setAttribute("orders", orders);
        request.setAttribute("orderStats", orderStats);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("currentStatus", status);
        request.setAttribute("pageSize", PAGE_SIZE);

        request.getRequestDispatcher("/WEB-INF/views/admin_orders.jsp").forward(request, response);
    }

    private void handleExportOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String format = request.getParameter("format");
        String status = request.getParameter("status");

        List<OrderDTO> orders;
        if (status != null && !status.isEmpty()) {
            orders = orderService.getOrdersByStatus(status);
        } else {
            orders = orderService.getAllOrders();
        }

        byte[] exportData;
        String filename;

        if ("xlsx".equals(format)) {
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

    private void handleOrderAnalytics(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        OrderAnalyticsDTO analytics = orderService.getOrderAnalytics();
        request.setAttribute("analytics", analytics);
        request.getRequestDispatcher("/WEB-INF/views/admin_order_analytics.jsp").forward(request, response);
    }

    private void handleUpdateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String orderIdParam = request.getParameter("orderId");
        String newStatus = request.getParameter("status");

        if (orderIdParam != null && newStatus != null) {
            try {
                Integer orderId = Integer.parseInt(orderIdParam);
                boolean success = orderService.updateOrderStatus(orderId, newStatus);

                if (!success) {
                    request.setAttribute("error", "Failed to update order status");
                }
                response.sendRedirect(request.getContextPath() + "/admin/orders");
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid order ID");
                request.getRequestDispatcher("/WEB-INF/views/admin_orders.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Missing required parameters");
            request.getRequestDispatcher("/WEB-INF/views/admin_orders.jsp").forward(request, response);
        }
    }
}
