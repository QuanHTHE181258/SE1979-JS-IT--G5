<%--
  Created by IntelliJ IDEA.
  User: ducmi
  Date: 25/05/2025
  Time: 4:34 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Course</title>
    <link rel="stylesheet" href="css/create_course_style.css">
    <style>
        nav {
            background: linear-gradient(90deg, #f76b1c, #fad961);
            width: 100%;
            height: 75px;
            display: flex;
            align-items: center;
            padding-left: 32px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 0 0 12px 12px;
        }

        nav a {
            color: white;
            text-decoration: none;
            padding: 12px 20px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            font-weight: bold;
            font-size: 16px;
            transition: background 0.3s, transform 0.2s;
        }

        nav a:hover {
            background-color: rgba(255, 255, 255, 0.25);
            transform: scale(1.05);
        }

        .create-button {
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }

        #courseForm {
            display: none;
        }
    </style>

    <script>
        function showForm() {
            document.getElementById("courseForm").style.display = "block";
            document.getElementById("createBtn").style.display = "none";
        }
    </script>
</head>
<body>

<nav>
    <a href="home.jsp">Home</a>
</nav>

<div class="container">


    <div class="create-button">
        <button id="createBtn" onclick="showForm()" style="
        padding: 12px 24px;
        background-color: #f76b1c;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
    ">Create New Course</button>
    </div>

    <div class="course-form" id="courseForm" style="display:none;">
        <h2>Create New Course</h2>
        <form action="create-course" method="post">
            <label for="courseCode">Course Code:</label>
            <input type="text" id="courseCode" name="courseCode" required maxlength="20">

            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required maxlength="255">

            <label for="shortDescription">Short Description:</label>
            <textarea id="shortDescription" name="shortDescription" maxlength="500"></textarea>

            <label for="description">Detailed Description:</label>
            <textarea id="description" name="description"></textarea>

            <label for="price">Price:</label>
            <input type="number" id="price" name="price" step="0.01" min="0">

            <label for="durationHours">Duration (hours):</label>
            <input type="number" id="durationHours" name="durationHours" min="0">

            <label for="level">Level:</label>
            <select id="level" name="level">
                <option value="Beginner">Beginner</option>
                <option value="Intermediate">Intermediate</option>
                <option value="Advanced">Advanced</option>
            </select>

            <label for="imageUrl">Course Image (URL):</label>
            <input type="text" id="imageUrl" name="imageUrl" maxlength="255">

            <label for="maxStudents">Max Students:</label>
            <input type="number" id="maxStudents" name="maxStudents" min="0">

            <label for="teacherId">Instructor:</label>
            <select id="teacherId" name="teacherId">
                <option value="">-- Select instructor --</option>
            </select>

            <label for="categoryId">Category:</label>
            <select id="categoryId" name="categoryId">
                <option value="">-- Select category --</option>
            </select>

            <label for="enrollmentStartDate">Enrollment Start Date:</label>
            <input type="date" id="enrollmentStartDate" name="enrollmentStartDate">

            <label for="enrollmentEndDate">Enrollment End Date:</label>
            <input type="date" id="enrollmentEndDate" name="enrollmentEndDate">

            <label for="startDate">Course Start Date:</label>
            <input type="date" id="startDate" name="startDate">

            <label for="endDate">Course End Date:</label>
            <input type="date" id="endDate" name="endDate">

            <input type="submit" value="Create Course">
        </form>
    </div>

</div>


<nav class="footer-navbar">
    <div style="text-align: center; width: 100%;">
        <h3 style="margin-bottom: 4px;">Courses Learning Web</h3>
        <p style="margin: 2px;">Email: example@gmail.com | Phone: 000-000-0000</p>
        <p style="margin: 2px;">Address: 123 Learning Street, Education City</p>
        <p style="margin: 8px 0;">&copy; 2025 Courses Learning Web. All rights reserved.</p>
    </div>
</nav>

</body>




</html>






