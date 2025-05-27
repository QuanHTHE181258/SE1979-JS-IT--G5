<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 5/28/2025
  Time: 4:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="project.demo.coursemanagement.dto.CourseDTO" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>

<%
    String error = request.getParameter("error");
    String updateStatus = request.getParameter("update");

    CourseDTO course = (CourseDTO) request.getAttribute("course");
    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd").withZone(ZoneId.systemDefault());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa khóa học</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        form { max-width: 600px; }
        label { display: block; margin-top: 15px; font-weight: bold; }
        input, textarea { width: 100%; padding: 8px; box-sizing: border-box; }
        button { margin-top: 20px; padding: 10px 20px; }
        .message { margin-bottom: 15px; padding: 10px; }
        .error { background-color: #f8d7da; color: #721c24; }
        .success { background-color: #d4edda; color: #155724; }
    </style>
</head>
<body>

<h2>Chỉnh sửa khóa học</h2>

<% if ("success".equals(updateStatus)) { %>
<div class="message success">Cập nhật khóa học thành công!</div>
<% } %>

<% if (error != null) { %>
<div class="message error">
    <%
        switch (error) {
            case "invalidinput": out.print("Dữ liệu nhập không hợp lệ!"); break;
            case "notfound": out.print("Khóa học không tồn tại!"); break;
            default: out.print("Lỗi không xác định, vui lòng thử lại."); break;
        }
    %>
</div>
<% } %>

<% if (course == null) { %>
<p>Không tìm thấy khóa học để chỉnh sửa.</p>
<% } else { %>

<form action="<%= request.getContextPath() %>/update-course" method="post">
    <input type="hidden" name="courseCode" value="<%= course.getCourseCode() %>">

    <label for="title">Tiêu đề:</label>
    <input type="text" id="title" name="title" required value="<%= course.getTitle() != null ? course.getTitle() : "" %>">

    <label for="shortDescription">Mô tả ngắn:</label>
    <textarea id="shortDescription" name="shortDescription" rows="4"><%= course.getShortDescription() != null ? course.getShortDescription() : "" %></textarea>

    <label for="price">Giá (VND):</label>
    <input type="number" step="0.01" id="price" name="price"
           value="<%= course.getPrice() != null ? course.getPrice() : "" %>">

    <label for="durationHours">Thời lượng (giờ):</label>
    <input type="number" id="durationHours" name="durationHours"
           value="<%= course.getDurationHours() %>">

    <label for="maxStudents">Số học viên tối đa:</label>
    <input type="number" id="maxStudents" name="maxStudents"
           value="<%= course.getMaxStudents() %>">

    <label for="startDate">Ngày bắt đầu:</label>
    <input type="date" id="startDate" name="startDate"
           value="<%= course.getStartDate() != null ? dtf.format(course.getStartDate()) : "" %>">

    <label for="endDate">Ngày kết thúc:</label>
    <input type="date" id="endDate" name="endDate"
           value="<%= course.getEndDate() != null ? dtf.format(course.getEndDate()) : "" %>">

    <button type="submit">Cập nhật khóa học</button>
</form>

<% } %>

</body>
</html>
