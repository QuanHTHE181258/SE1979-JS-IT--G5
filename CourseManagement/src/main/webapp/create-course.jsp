<%--
  Created by IntelliJ IDEA.
  User: ducmi
  Date: 25/05/2025
  Time: 4:34 CH
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Course</title>
    <link rel="stylesheet" href="css/create_course_style.css">
</head>
<body>
<div class="container">
    <h2>Create New Course</h2>
    <form action="#" method="post">
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
            <option>-- Select instructor --</option>
        </select>

        <label for="categoryId">Category:</label>
        <select id="categoryId" name="categoryId">
            <option>-- Select category --</option>
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
</body>
</html>





