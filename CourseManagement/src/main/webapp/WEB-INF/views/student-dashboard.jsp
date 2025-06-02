<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="project.demo.coursemanagement.dto.EnrolledCourse" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            color: #333;
        }

        .dashboard-header {
            background-color: #1e88e5;
            color: white;
            padding: 20px;
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .header-content {
            width: 100%;
            max-width: 1200px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-browse-courses {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            font-size: 1rem;
            font-weight: 500;
            color: #1e88e5;
            background-color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-browse-courses:hover {
            background-color: #f5f5f5;
            color: #1565c0;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .btn-browse-courses i {
            margin-right: 8px;
        }

        .course-container {
            max-width: 1200px;
            margin: 30px auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
            padding: 0 20px;
        }

        .course-card {
            display: flex;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.2s ease;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .course-image {
            width: 200px;
            height: 200px;
            object-fit: cover;
        }

        .course-info {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .course-title {
            margin: 0 0 15px 0;
            font-size: 1.5em;
            color: #1e88e5;
        }

        .course-meta {
            margin: 8px 0;
            font-size: 0.95em;
            color: #555;
        }

        .progress-container {
            margin-top: 15px;
        }

        .progress {
            height: 12px;
            border-radius: 6px;
            background-color: #e9ecef;
        }

        .progress-bar {
            background-color: #4caf50;
            transition: width 0.6s ease;
        }

        .progress-text {
            margin-top: 5px;
            font-size: 0.9em;
            color: #4caf50;
            font-weight: 500;
        }

        .grade-badge {
            display: inline-block;
            padding: 0.35em 0.65em;
            font-size: 0.9em;
            font-weight: 600;
            line-height: 1;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.25rem;
            margin-left: auto;
        }

        .grade-excellent {
            background-color: #28a745;
            color: white;
        }

        .grade-good {
            background-color: #17a2b8;
            color: white;
        }

        .grade-average {
            background-color: #ffc107;
            color: black;
        }

        .grade-poor {
            background-color: #dc3545;
            color: white;
        }

        .status-badge {
            display: inline-block;
            padding: 0.35em 0.65em;
            font-size: 0.75em;
            font-weight: 600;
            line-height: 1;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.25rem;
            margin-right: 10px;
        }

        .status-active {
            background-color: #28a745;
            color: white;
        }

        .status-completed {
            background-color: #007bff;
            color: white;
        }

        .status-dropped {
            background-color: #dc3545;
            color: white;
        }

        .course-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .course-status-grade {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .course-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 15px;
            gap: 10px;
        }

        .btn-course {
            display: inline-flex;
            align-items: center;
            padding: 8px 16px;
            font-size: 0.9rem;
            font-weight: 500;
            color: #fff;
            background-color: #1e88e5;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.2s ease;
        }

        .btn-course:hover {
            background-color: #1565c0;
            color: #fff;
            text-decoration: none;
        }

        .btn-course i {
            margin-right: 8px;
        }

        .no-courses {
            text-align: center;
            padding: 2rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="dashboard-header">
        <div class="header-content">
            <h1>My Enrolled Courses</h1>
            <a href="${pageContext.request.contextPath}/course" class="btn-browse-courses">
                <i class="fas fa-search"></i>
                Browse More Courses
            </a>
        </div>
    </div>

    <div class="course-container">
        <%
            List<EnrolledCourse> enrolledCourses = (List<EnrolledCourse>) request.getAttribute("enrolledCourses");
            if (enrolledCourses != null && !enrolledCourses.isEmpty()) {
                for (EnrolledCourse course : enrolledCourses) {
                    String formattedDate = course.getEnrollmentStartDate() != null ?
                            course.getEnrollmentStartDate().toLocalDate().toString() : "N/A";
                    BigDecimal progress = course.getProgressPercentage() != null ? course.getProgressPercentage() : BigDecimal.ZERO;
                    BigDecimal grade = course.getGrade() != null ? course.getGrade() : BigDecimal.ZERO;
                    String status = course.getStatus() != null ? course.getStatus() : "ACTIVE";
                    
                    // Determine grade class
                    String gradeClass = "";
                    if (grade.compareTo(new BigDecimal("8.5")) >= 0) {
                        gradeClass = "grade-excellent";
                    } else if (grade.compareTo(new BigDecimal("7.0")) >= 0) {
                        gradeClass = "grade-good";
                    } else if (grade.compareTo(new BigDecimal("5.0")) >= 0) {
                        gradeClass = "grade-average";
                    } else {
                        gradeClass = "grade-poor";
                    }
                    
                    // Determine status class
                    String statusClass = "";
                    switch(status.toUpperCase()) {
                        case "COMPLETED":
                            statusClass = "status-completed";
                            break;
                        case "ACTIVE":
                            statusClass = "status-active";
                            break;
                        case "DROPPED":
                            statusClass = "status-dropped";
                            break;
                        default:
                            statusClass = "status-active";
                    }
        %>
        <div class="course-card">
            <img src="<%= course.getImageUrl() != null ? course.getImageUrl() : "https://via.placeholder.com/200" %>" 
                 alt="<%= course.getTitle() %>" 
                 class="course-image">
            <div class="course-info">
                <div class="course-header">
                    <h2 class="course-title"><%= course.getTitle() %></h2>
                    <div class="course-status-grade">
                        <span class="status-badge <%= statusClass %>"><%= status %></span>
                        <span class="grade-badge <%= gradeClass %>">Grade: <%= grade %>/10</span>
                    </div>
                </div>
                
                <p class="course-meta"><strong>Course Code:</strong> <%= course.getCourseCode() %></p>
                <p class="course-meta"><strong>Category:</strong> <%= course.getCategory() != null ? course.getCategory().getCategoryName() : "N/A" %></p>
                <p class="course-meta"><strong>Duration:</strong> <%= course.getDurationHours() %> hours</p>
                <p class="course-meta"><strong>Enrolled on:</strong> <%= formattedDate %></p>
                
                <div class="progress-container">
                    <div class="progress">
                        <div class="progress-bar" role="progressbar" 
                             style="width: <%= progress %>%" 
                             aria-valuenow="<%= progress %>" 
                             aria-valuemin="0" 
                             aria-valuemax="100">
                        </div>
                    </div>
                    <p class="progress-text">Progress: <%= progress %>%</p>
                </div>

                <div class="course-actions">
                    <a href="${pageContext.request.contextPath}/course/details?id=<%= course.getId() %>" class="btn-course">
                        <i class="fas fa-book-open"></i>
                        Go to Course
                    </a>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="no-courses">
            <h3>No enrolled courses found</h3>
            <p>Start your learning journey by enrolling in a course!</p>
            <a href="${pageContext.request.contextPath}/course" class="btn-course mt-3">
                <i class="fas fa-search"></i>
                Browse Available Courses
            </a>
        </div>
        <%
            }
        %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
