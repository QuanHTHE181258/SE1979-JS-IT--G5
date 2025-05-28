<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- Đảm bảo import JSTL core taglib --%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Course</title>
    <link rel="stylesheet" href="css/create_course_style.css"> <%-- Đảm bảo đường dẫn CSS đúng --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<nav>
    <a href="home.jsp"><i class="fas fa-home"></i> Home</a>
</nav>

<div class="container">
    <%-- Hiển thị thông báo lỗi từ Servlet --%>
    <c:if test="${not empty errors}">
        <div class="message error">
            <i class="fas fa-exclamation-circle"></i>
            <ul>
                <c:forEach var="err" items="${errors}">
                    <li>${err}</li>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <%-- Hiển thị thông báo thành công từ Servlet (nếu có) --%>
    <c:if test="${not empty message}">
        <div class="message success">
            <i class="fas fa-check-circle"></i>
                ${message}
        </div>
    </c:if>

    <div class="create-button">
        <button id="createBtn" onclick="showForm()">
            <i class="fas fa-plus-circle"></i> Create New Course
        </button>
    </div>

    <div class="course-form" id="courseForm" style="${not empty errors || not empty formData ? 'display: block;' : 'display: none;'}">
        <h2><i class="fas fa-graduation-cap"></i> Create New Course</h2>
        <form action="createcourse" method="post"> <%-- Đã bỏ onsubmit="return validateForm()" --%>
            <div class="form-group">
                <label for="courseCode"><i class="fas fa-hashtag"></i> Course Code:</label>
                <input type="text" id="courseCode" name="courseCode" required maxlength="20"
                       placeholder="Enter course code" value="${formData.courseCode[0]}">
            </div>

            <div class="form-group">
                <label for="title"><i class="fas fa-heading"></i> Title:</label>
                <input type="text" id="title" name="title" required maxlength="255"
                       placeholder="Enter course title" value="${formData.title[0]}">
            </div>

            <div class="form-group">
                <label for="shortDescription"><i class="fas fa-align-left"></i> Short Description:</label>
                <textarea id="shortDescription" name="shortDescription" maxlength="500"
                          placeholder="Enter a brief description of the course">${formData.shortDescription[0]}</textarea>
            </div>

            <div class="form-group">
                <label for="description"><i class="fas fa-file-alt"></i> Detailed Description:</label>
                <textarea id="description" name="description"
                          placeholder="Enter detailed course description">${formData.description[0]}</textarea>
            </div>

            <div class="form-group">
                <label for="price"><i class="fas fa-dollar-sign"></i> Price:</label>
                <input type="number" id="price" name="price" step="0.01" min="0" required
                       placeholder="Enter course price" value="${formData.price[0]}">
            </div>

            <div class="form-group">
                <label for="durationHours"><i class="fas fa-clock"></i> Duration (hours):</label>
                <input type="number" id="durationHours" name="durationHours" min="1" required
                       placeholder="Enter course duration" value="${formData.durationHours[0]}">
            </div>

            <div class="form-group">
                <label for="level"><i class="fas fa-signal"></i> Level:</label>
                <select id="level" name="level" required>
                    <option value="" <c:if test="${empty formData.level[0]}">selected</c:if>>-- Select level --</option>
                    <option value="Beginner" <c:if test="${formData.level[0] == 'Beginner'}">selected</c:if>>Beginner</option>
                    <option value="Intermediate" <c:if test="${formData.level[0] == 'Intermediate'}">selected</c:if>>Intermediate</option>
                    <option value="Advanced" <c:if test="${formData.level[0] == 'Advanced'}">selected</c:if>>Advanced</option>
                </select>
            </div>

            <div class="form-group">
                <label for="imageUrl"><i class="fas fa-image"></i> Course Image (URL):</label>
                <input type="url" id="imageUrl" name="imageUrl" maxlength="255"
                       placeholder="Enter image URL" value="${formData.imageUrl[0]}">
            </div>

            <div class="form-group">
                <label for="maxStudents"><i class="fas fa-users"></i> Max Students:</label>
                <input type="number" id="maxStudents" name="maxStudents" min="1" required
                       placeholder="Enter maximum number of students" value="${formData.maxStudents[0]}">
            </div>

            <div class="form-group">
                <label for="teacherId"><i class="fas fa-chalkboard-teacher"></i> Instructor:</label>
                <select id="teacherId" name="teacherId" required>
                    <option value="" <c:if test="${empty formData.teacherId[0]}">selected</c:if>>-- Select instructor --</option>
                    <c:choose>
                        <c:when test="${not empty instructors}">
                            <c:forEach var="instructor" items="${instructors}">
                                <option value="${instructor.id}"
                                        <c:if test="${formData.teacherId[0] == instructor.id}">selected</c:if>>
                                        ${instructor.firstName} ${instructor.lastName}
                                </option>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <option value="" disabled>-- No instructors available --</option>
                        </c:otherwise>
                    </c:choose>
                </select>
            </div>

            <div class="form-group">
                <label for="categoryId"><i class="fas fa-tags"></i> Category:</label>
                <select id="categoryId" name="categoryId" required>
                    <option value="" <c:if test="${empty formData.categoryId[0]}">selected</c:if>>-- Select category --</option>
                    <c:choose>
                        <c:when test="${not empty categories}"> <%-- Bạn cần đảm bảo Servlet truyền list "categories" --%>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.id}"
                                        <c:if test="${formData.categoryId[0] == category.id}">selected</c:if>>
                                        ${category.categoryName}
                                </option>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <option value="" disabled>-- No categories available --</option>
                        </c:otherwise>
                    </c:choose>
                </select>
            </div>

            <div class="form-group checkbox-group">
                <input type="checkbox" id="isPublished" name="isPublished"
                       <c:if test="${formData.isPublished[0] == 'on'}">checked</c:if>>
                <label for="isPublished">Publish Course</label>
            </div>

            <div class="form-group checkbox-group">
                <input type="checkbox" id="isActive" name="isActive"
                       <c:if test="${formData.isActive[0] == 'on'}">checked</c:if>>
                <label for="isActive">Course Active</label>
            </div>

            <div class="form-group">
                <label for="enrollmentStartDate"><i class="fas fa-calendar-plus"></i> Enrollment Start Date:</label>
                <input type="date" id="enrollmentStartDate" name="enrollmentStartDate" required value="${formData.enrollmentStartDate[0]}">
            </div>

            <div class="form-group">
                <label for="enrollmentEndDate"><i class="fas fa-calendar-minus"></i> Enrollment End Date:</label>
                <input type="date" id="enrollmentEndDate" name="enrollmentEndDate" required value="${formData.enrollmentEndDate[0]}">
            </div>

            <div class="form-group">
                <label for="startDate"><i class="fas fa-calendar-check"></i> Course Start Date:</label>
                <input type="date" id="startDate" name="startDate" required value="${formData.startDate[0]}">
            </div>

            <div class="form-group">
                <label for="endDate"><i class="fas fa-calendar-times"></i> Course End Date:</label>
                <input type="date" id="endDate" name="endDate" required value="${formData.endDate[0]}">
            </div>

            <div class="form-group">
                <input type="submit" value="Create Course">
            </div>
        </form>
    </div>
</div>

<nav class="footer-navbar">
    <div>
        <h3><i class="fas fa-graduation-cap"></i> Courses Learning Web</h3>
        <p><i class="fas fa-envelope"></i> Email: example@gmail.com</p>
        <p><i class="fas fa-phone"></i> Phone: 000-000-0000</p>
        <p><i class="fas fa-map-marker-alt"></i> Address: 123 Learning Street, Education City</p>
        <p style="margin-top: 10px;">&copy; 2025 Courses Learning Web. All rights reserved.</p>
    </div>
</nav>

<script>
    // Hàm này sẽ hiển thị form khi nhấn nút "Create New Course"
    function showForm() {
        document.getElementById("courseForm").style.display = "block";
        document.getElementById("createBtn").style.display = "none";
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    // Nếu có lỗi hoặc dữ liệu formData tồn tại (tức là form đã được submit và có lỗi), hiển thị form ngay lập tức.
    // Nếu không, form sẽ bị ẩn và chỉ hiển thị nút "Create New Course" ban đầu.
    document.addEventListener('DOMContentLoaded', function() {
        const courseForm = document.getElementById("courseForm");
        const createBtn = document.getElementById("createBtn");

        // Kiểm tra xem có lỗi hoặc formData từ servlet hay không
        const hasErrors = ${not empty errors};
        const hasFormData = ${not empty formData};

        if (hasErrors || hasFormData) {
            courseForm.style.display = "block";
            createBtn.style.display = "none";
        } else {
            courseForm.style.display = "none";
            createBtn.style.display = "block";
        }
    });

</script>
</body>
</html>