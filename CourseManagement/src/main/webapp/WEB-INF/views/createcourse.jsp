<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create Course</title>
    <link rel="stylesheet" href="css/create_course_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script>
        function showForm() {
            document.getElementById("courseForm").style.display = "block";
            document.getElementById("createBtn").style.display = "none";
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function validateForm() {
            const form = document.getElementById("courseForm");
            const enrollmentStart = new Date(document.getElementById("enrollmentStartDate").value);
            const enrollmentEnd = new Date(document.getElementById("enrollmentEndDate").value);
            const startDate = new Date(document.getElementById("startDate").value);
            const endDate = new Date(document.getElementById("endDate").value);
            const price = parseFloat(document.getElementById("price").value);
            const durationHours = parseInt(document.getElementById("durationHours").value);
            const maxStudents = parseInt(document.getElementById("maxStudents").value);

            let isValid = true;
            let errorMessage = "";

            // Validate dates
            if (enrollmentStart > enrollmentEnd) {
                errorMessage += "Enrollment start date must be before end date\n";
                isValid = false;
            }

            if (startDate > endDate) {
                errorMessage += "Course start date must be before end date\n";
                isValid = false;
            }

            if (enrollmentEnd > startDate) {
                errorMessage += "Enrollment end date must be before course start date\n";
                isValid = false;
            }

            // Validate numbers
            if (price < 0) {
                errorMessage += "Price cannot be negative\n";
                isValid = false;
            }

            if (durationHours <= 0) {
                errorMessage += "Duration must be positive\n";
                isValid = false;
            }

            if (maxStudents <= 0) {
                errorMessage += "Max students must be positive\n";
                isValid = false;
            }

            // Validate required fields
            const requiredFields = ["courseCode", "title", "level", "teacherId", "categoryId"];
            requiredFields.forEach(field => {
                const input = document.getElementById(field);
                if (!input.value.trim()) {
                    input.classList.add("invalid");
                    isValid = false;
                } else {
                    input.classList.remove("invalid");
                }
            });

            if (!isValid) {
                alert(errorMessage || "Please fill in all required fields correctly");
                return false;
            }

            return true;
        }

        // Add input validation on blur
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input, select, textarea');
            inputs.forEach(input => {
                input.addEventListener('blur', function() {
                    if (this.hasAttribute('required') && !this.value.trim()) {
                        this.classList.add('invalid');
                    } else {
                        this.classList.remove('invalid');
                    }
                });
            });
        });
    </script>
</head>
<body>
<nav>
    <a href="home.jsp"><i class="fas fa-home"></i> Home</a>
</nav>

<div class="container">
    <% if (request.getAttribute("error") != null) { %>
    <div class="message error">
        <i class="fas fa-exclamation-circle"></i>
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <% if (request.getAttribute("message") != null) { %>
    <div class="message success">
        <i class="fas fa-check-circle"></i>
        <%= request.getAttribute("message") %>
    </div>
    <% } %>

    <div class="create-button">
        <button id="createBtn" onclick="showForm()">
            <i class="fas fa-plus-circle"></i> Create New Course
        </button>
    </div>

    <div class="course-form" id="courseForm">
        <h2><i class="fas fa-graduation-cap"></i> Create New Course</h2>
        <form action="createcourse" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="courseCode"><i class="fas fa-hashtag"></i> Course Code:</label>
                <input type="text" id="courseCode" name="courseCode" required maxlength="20"
                       placeholder="Enter course code">
            </div>

            <div class="form-group">
                <label for="title"><i class="fas fa-heading"></i> Title:</label>
                <input type="text" id="title" name="title" required maxlength="255"
                       placeholder="Enter course title">
            </div>

            <div class="form-group">
                <label for="shortDescription"><i class="fas fa-align-left"></i> Short Description:</label>
                <textarea id="shortDescription" name="shortDescription" maxlength="500"
                          placeholder="Enter a brief description of the course"></textarea>
            </div>

            <div class="form-group">
                <label for="description"><i class="fas fa-file-alt"></i> Detailed Description:</label>
                <textarea id="description" name="description"
                          placeholder="Enter detailed course description"></textarea>
            </div>

            <div class="form-group">
                <label for="price"><i class="fas fa-dollar-sign"></i> Price:</label>
                <input type="number" id="price" name="price" step="0.01" min="0" required
                       placeholder="Enter course price">
            </div>

            <div class="form-group">
                <label for="durationHours"><i class="fas fa-clock"></i> Duration (hours):</label>
                <input type="number" id="durationHours" name="durationHours" min="1" required
                       placeholder="Enter course duration">
            </div>

            <div class="form-group">
                <label for="level"><i class="fas fa-signal"></i> Level:</label>
                <select id="level" name="level" required>
                    <option value="">-- Select level --</option>
                    <option value="Beginner">Beginner</option>
                    <option value="Intermediate">Intermediate</option>
                    <option value="Advanced">Advanced</option>
                </select>
            </div>

            <div class="form-group">
                <label for="imageUrl"><i class="fas fa-image"></i> Course Image (URL):</label>
                <input type="url" id="imageUrl" name="imageUrl" maxlength="255"
                       placeholder="Enter image URL">
            </div>

            <div class="form-group">
                <label for="maxStudents"><i class="fas fa-users"></i> Max Students:</label>
                <input type="number" id="maxStudents" name="maxStudents" min="1" required
                       placeholder="Enter maximum number of students">
            </div>

            <div class="form-group">
                <label for="teacherId"><i class="fas fa-chalkboard-teacher"></i> Instructor:</label>
                <select id="teacherId" name="teacherId" required>
                    <option value="">-- Select instructor --</option>
                    <!-- Load instructor nếu có -->
                </select>
            </div>

            <div class="form-group">
                <label for="categoryId"><i class="fas fa-tags"></i> Category:</label>
                <select id="categoryId" name="categoryId" required>
                    <option value="">-- Select category --</option>
                    <!-- Load categories nếu có -->
                </select>
            </div>

            <div class="form-group">
                <label for="enrollmentStartDate"><i class="fas fa-calendar-plus"></i> Enrollment Start Date:</label>
                <input type="date" id="enrollmentStartDate" name="enrollmentStartDate" required>
            </div>

            <div class="form-group">
                <label for="enrollmentEndDate"><i class="fas fa-calendar-minus"></i> Enrollment End Date:</label>
                <input type="date" id="enrollmentEndDate" name="enrollmentEndDate" required>
            </div>

            <div class="form-group">
                <label for="startDate"><i class="fas fa-calendar-check"></i> Course Start Date:</label>
                <input type="date" id="startDate" name="startDate" required>
            </div>

            <div class="form-group">
                <label for="endDate"><i class="fas fa-calendar-times"></i> Course End Date:</label>
                <input type="date" id="endDate" name="endDate" required>
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
</body>
</html>