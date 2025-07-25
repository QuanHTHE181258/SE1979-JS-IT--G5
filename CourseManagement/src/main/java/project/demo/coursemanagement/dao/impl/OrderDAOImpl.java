package project.demo.coursemanagement.dao.impl;

import project.demo.coursemanagement.dao.OrderDAO;
import project.demo.coursemanagement.dto.*;
import project.demo.coursemanagement.utils.DatabaseConnection;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDAOImpl implements OrderDAO {
    private final DatabaseConnection dbConn = DatabaseConnection.getInstance();

    @Override
    public List<OrderDTO> getAllOrders() {
        return getOrdersWithPagination(0, Integer.MAX_VALUE);
    }

    @Override
    public List<OrderDTO> getOrdersByStatus(String status) {
        List<OrderDTO> orders = new ArrayList<>();
        String sql = """
            SELECT o.OrderID, u.Username, o.Status, o.PaymentMethod, o.TotalAmount, 
                   o.CreatedAt, u.FirstName, u.LastName, u.Email
            FROM orders o
            JOIN users u ON o.UserID = u.UserID
            WHERE o.Status = ?
            ORDER BY o.CreatedAt DESC
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = mapResultSetToOrder(rs);
                    order.setOrderDetails(getOrderDetails(order.getOrderId()));
                    order.calculateTotalAmount(); // Calculate total amount based on order details
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting orders by status: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public OrderDTO getOrderById(Integer orderId) {
        String sql = """
            SELECT o.OrderID, o.UserID, u.Username, o.Status, o.PaymentMethod, o.TotalAmount, 
                   o.CreatedAt, u.FirstName, u.LastName, u.Email
            FROM orders o
            JOIN users u ON o.UserID = u.UserID
            WHERE o.OrderID = ?
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    OrderDTO order = mapResultSetToOrder(rs);
                    order.setOrderDetails(getOrderDetails(orderId));
                    order.calculateTotalAmount(); // Calculate total amount based on order details
                    return order;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting order by ID: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean updateOrderStatus(Integer orderId, String status) {
        String sql = "UPDATE orders SET Status = ? WHERE OrderID = ?";

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, orderId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating order status: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int countOrders() {
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error counting orders: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<OrderDTO> getOrdersWithPagination(int offset, int limit) {
        List<OrderDTO> orders = new ArrayList<>();
        String sql = """
            SELECT o.OrderID, u.Username, o.Status, o.PaymentMethod, o.TotalAmount, 
                   o.CreatedAt, u.FirstName, u.LastName, u.Email
            FROM orders o
            JOIN users u ON o.UserID = u.UserID
            ORDER BY o.CreatedAt DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, offset);
            stmt.setInt(2, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = mapResultSetToOrder(rs);
                    order.setOrderDetails(getOrderDetails(order.getOrderId()));
                    order.calculateTotalAmount(); // Calculate total amount based on order details
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting orders with pagination: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    private List<OrderDetailDTO> getOrderDetails(Integer orderId) {
        List<OrderDetailDTO> details = new ArrayList<>();
        String sql = """
            SELECT od.OrderDetailID, od.OrderID, od.CourseID, c.Title as CourseTitle, od.Price,
                   c.Description, c.Rating, c.CreatedAt, c.ImageURL, c.Status
            FROM orderdetails od
            JOIN courses c ON od.CourseID = c.CourseID
            WHERE od.OrderID = ?
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderDetailDTO detail = new OrderDetailDTO();
                    detail.setOrderDetailId(rs.getInt("OrderDetailID"));
                    detail.setOrderId(rs.getInt("OrderID"));
                    detail.setCourseId(rs.getInt("CourseID"));
                    detail.setCourseTitle(rs.getString("CourseTitle"));
                    detail.setPrice(rs.getBigDecimal("Price"));
                    // Set thêm các trường course vào CourseDTO
                    project.demo.coursemanagement.dto.CourseDTO course = new project.demo.coursemanagement.dto.CourseDTO();
                    course.setCourseCode(String.valueOf(rs.getInt("CourseID")));
                    course.setTitle(rs.getString("CourseTitle"));
                    course.setDescription(rs.getString("Description"));
                    course.setRating(rs.getDouble("Rating"));
                    java.sql.Timestamp createdAt = rs.getTimestamp("CreatedAt");
                    if (createdAt != null) {
                        course.setCreatedAt(createdAt.toInstant());
                        course.setCreatedAtDate(new java.util.Date(createdAt.getTime()));
                    }
                    course.setImageUrl(rs.getString("ImageURL"));
                    course.setStatus(rs.getString("Status"));
                    detail.setCourse(course);
                    details.add(detail);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting order details: " + e.getMessage());
            e.printStackTrace();
        }
        return details;
    }

    private OrderDTO mapResultSetToOrder(ResultSet rs) throws SQLException {
        OrderDTO order = new OrderDTO();
        order.setOrderId(rs.getInt("OrderID"));
        order.setUsername(rs.getString("Username"));
        order.setStatus(rs.getString("Status"));
        order.setPaymentMethod(rs.getString("PaymentMethod"));
        order.setTotalAmount(rs.getBigDecimal("TotalAmount"));
        order.setCreatedAt(rs.getTimestamp("CreatedAt").toInstant());
        order.setCustomerName(rs.getString("FirstName") + " " + rs.getString("LastName"));
        order.setCustomerEmail(rs.getString("Email"));
        order.setUserId(rs.getInt("UserID"));
        return order;
    }

    @Override
    public List<OrderDTO> searchOrders(String keyword, int offset, int limit) {
        List<OrderDTO> orders = new ArrayList<>();
        String sql = """
            SELECT o.OrderID, u.Username, o.Status, o.PaymentMethod, o.TotalAmount, 
                   o.CreatedAt, u.FirstName, u.LastName, u.Email
            FROM orders o
            JOIN users u ON o.UserID = u.UserID
            WHERE CAST(o.OrderID AS VARCHAR) LIKE ? 
               OR u.FirstName LIKE ? 
               OR u.LastName LIKE ? 
               OR u.Email LIKE ?
               OR (u.FirstName + ' ' + u.LastName) LIKE ?
            ORDER BY o.CreatedAt DESC
            OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setString(5, searchPattern);
            stmt.setInt(6, offset);
            stmt.setInt(7, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = mapResultSetToOrder(rs);
                    order.setOrderDetails(getOrderDetails(order.getOrderId()));
                    order.calculateTotalAmount(); // Calculate total amount based on order details
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error searching orders: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public int countSearchResults(String keyword) {
        String sql = """
            SELECT COUNT(*) 
            FROM orders o
            JOIN users u ON o.UserID = u.UserID
            WHERE CAST(o.OrderID AS VARCHAR) LIKE ? 
               OR u.FirstName LIKE ? 
               OR u.LastName LIKE ? 
               OR u.Email LIKE ?
               OR (u.FirstName + ' ' + u.LastName) LIKE ?
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setString(5, searchPattern);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error counting search results: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // New methods for analytics
    @Override
    public OrderAnalyticsDTO getOrderAnalytics() {
        int totalOrders = countOrders();
        BigDecimal totalRevenue = getTotalRevenue();
        Map<String, Integer> ordersByStatus = getOrdersCountByStatus();
        Map<String, BigDecimal> revenueByMonth = getRevenueByMonth();

        int pendingOrders = ordersByStatus.getOrDefault("pending", 0);
        int completedOrders = ordersByStatus.getOrDefault("paid", 0);
        int cancelledOrders = ordersByStatus.getOrDefault("cancelled", 0);

        BigDecimal averageOrderValue = BigDecimal.ZERO;
        if (completedOrders > 0) {
            averageOrderValue = totalRevenue.divide(BigDecimal.valueOf(completedOrders), 2, BigDecimal.ROUND_HALF_UP);
        }

        return new OrderAnalyticsDTO(
                totalOrders, totalRevenue, ordersByStatus, revenueByMonth,
                pendingOrders, completedOrders, cancelledOrders, averageOrderValue
        );
    }

    @Override
    public List<OrderDTO> getOrdersByDateRange(String startDate, String endDate) {
        List<OrderDTO> orders = new ArrayList<>();
        String sql = """
            SELECT o.OrderID, u.Username, o.Status, o.PaymentMethod, o.TotalAmount, 
                   o.CreatedAt, u.FirstName, u.LastName, u.Email
            FROM orders o
            JOIN users u ON o.UserID = u.UserID
            WHERE o.CreatedAt BETWEEN ? AND ?
            ORDER BY o.CreatedAt DESC
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, startDate);
            stmt.setString(2, endDate);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = mapResultSetToOrder(rs);
                    order.setOrderDetails(getOrderDetails(order.getOrderId()));
                    order.calculateTotalAmount();
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting orders by date range: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public BigDecimal getTotalRevenue() {
        String sql = "SELECT SUM(TotalAmount) FROM orders WHERE Status = 'paid'";
        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                BigDecimal revenue = rs.getBigDecimal(1);
                return revenue != null ? revenue : BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            System.err.println("Error getting total revenue: " + e.getMessage());
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    @Override
    public Map<String, Integer> getOrdersCountByStatus() {
        Map<String, Integer> statusCount = new HashMap<>();
        String sql = "SELECT Status, COUNT(*) as count FROM orders GROUP BY Status";

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String status = rs.getString("Status");
                int count = rs.getInt("count");
                statusCount.put(status, count);
            }
        } catch (SQLException e) {
            System.err.println("Error getting orders count by status: " + e.getMessage());
            e.printStackTrace();
        }
        return statusCount;
    }

    @Override
    public Map<String, BigDecimal> getRevenueByMonth() {
        Map<String, BigDecimal> revenueByMonth = new HashMap<>();
        String sql = """
            SELECT DATE_FORMAT(CreatedAt, '%Y-%m') as month, SUM(TotalAmount) as revenue
            FROM orders 
            WHERE Status = 'paid'
            GROUP BY DATE_FORMAT(CreatedAt, '%Y-%m')
            ORDER BY month
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String month = rs.getString("month");
                BigDecimal revenue = rs.getBigDecimal("revenue");
                if (revenue != null) {
                    revenueByMonth.put(month, revenue);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting revenue by month: " + e.getMessage());
            e.printStackTrace();
        }
        return revenueByMonth;
    }

    @Override
    public List<OrderDTO> getOrdersByUserId(Integer userId) {
        List<OrderDTO> orders = new ArrayList<>();
        String sql = """
            SELECT o.OrderID, u.Username, o.Status, o.PaymentMethod, o.TotalAmount, 
                   o.CreatedAt, u.FirstName, u.LastName, u.Email
            FROM orders o
            JOIN users u ON o.UserID = u.UserID
            WHERE o.UserID = ?
            ORDER BY o.CreatedAt DESC
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = mapResultSetToOrder(rs);
                    order.setOrderDetails(getOrderDetails(order.getOrderId()));
                    order.calculateTotalAmount(); // Calculate total amount based on order details
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting orders by user ID: " + e.getMessage());
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<project.demo.coursemanagement.dto.RevenueDetailDTO> getRevenueDetails() {
        List<project.demo.coursemanagement.dto.RevenueDetailDTO> details = new ArrayList<>();
        String sql = """
            SELECT o.OrderID, o.CreatedAt, o.Status, o.TotalAmount,
                   c.Title AS CourseTitle, od.Price AS CoursePrice,
                   u.FirstName, u.LastName, u.Email
            FROM orders o
            JOIN orderdetails od ON o.OrderID = od.OrderID
            JOIN courses c ON od.CourseID = c.CourseID
            JOIN users u ON o.UserID = u.UserID
            WHERE o.Status = 'paid'
            ORDER BY o.CreatedAt DESC
        """;
        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                project.demo.coursemanagement.dto.RevenueDetailDTO dto = new project.demo.coursemanagement.dto.RevenueDetailDTO();
                dto.setOrderId(rs.getInt("OrderID"));
                dto.setOrderDate(rs.getTimestamp("CreatedAt"));
                dto.setStatus(rs.getString("Status"));
                dto.setTotalAmount(rs.getBigDecimal("TotalAmount"));
                dto.setCourseTitle(rs.getString("CourseTitle"));
                dto.setCoursePrice(rs.getBigDecimal("CoursePrice"));
                dto.setCustomerName(rs.getString("FirstName") + " " + rs.getString("LastName"));
                dto.setCustomerEmail(rs.getString("Email"));
                details.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
    }

    @Override
    public OrderDetailsViewDTO getOrderDetailView(int orderId) {
        String sql = """
            SELECT o.OrderID, o.Status, o.PaymentMethod, o.TotalAmount, o.CreatedAt,
                   c.CourseID, c.Title as CourseName, od.Price
            FROM orders o
            JOIN orderdetails od ON o.OrderID = od.OrderID
            JOIN courses c ON od.CourseID = c.CourseID
            WHERE o.OrderID = ?
        """;

        try (Connection conn = dbConn.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            OrderDetailsViewDTO orderView = null;
            List<OrderCourseDetailDTO> courseDetails = new ArrayList<>();

            while (rs.next()) {
                if (orderView == null) {
                    orderView = OrderDetailsViewDTO.builder()
                            .orderId(rs.getInt("OrderID"))
                            .status(rs.getString("Status"))
                            .paymentMethod(rs.getString("PaymentMethod"))
                            .totalAmount(rs.getBigDecimal("TotalAmount"))
                            .createdAt(rs.getTimestamp("CreatedAt"))
                            .courseDetails(new ArrayList<>())
                            .build();
                }

                OrderCourseDetailDTO courseDetail = OrderCourseDetailDTO.builder()
                        .courseId(rs.getInt("CourseID"))
                        .courseName(rs.getString("CourseName"))
                        .price(rs.getBigDecimal("Price"))
                        .build();

                courseDetails.add(courseDetail);
            }

            if (orderView != null) {
                orderView.setCourseDetails(courseDetails);
            }

            return orderView;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public int createOrderWithDetails(Integer userId, project.demo.coursemanagement.dto.OrderDTO orderDTO) {
        int orderId = -1;
        String insertOrder = "INSERT INTO orders (UserID, Status, PaymentMethod, TotalAmount, CreatedAt) VALUES (?, ?, ?, ?, ?)";
        String insertDetail = "INSERT INTO orderdetails (OrderID, CourseID, Price) VALUES (?, ?, ?)";
        try (Connection conn = dbConn.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement psOrder = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, userId);
                psOrder.setString(2, orderDTO.getStatus());
                psOrder.setString(3, orderDTO.getPaymentMethod());
                psOrder.setBigDecimal(4, orderDTO.getTotalAmount());
                psOrder.setTimestamp(5, java.sql.Timestamp.from(orderDTO.getCreatedAt()));
                psOrder.executeUpdate();
                try (ResultSet rs = psOrder.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }
            if (orderId > 0 && orderDTO.getOrderDetails() != null) {
                try (PreparedStatement psDetail = conn.prepareStatement(insertDetail)) {
                    for (project.demo.coursemanagement.dto.OrderDetailDTO detail : orderDTO.getOrderDetails()) {
                        psDetail.setInt(1, orderId);
                        psDetail.setInt(2, detail.getCourseId());
                        psDetail.setBigDecimal(3, detail.getPrice());
                        psDetail.addBatch();
                    }
                    psDetail.executeBatch();
                }
            }
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            orderId = -1;
        }
        return orderId;
    }
}
