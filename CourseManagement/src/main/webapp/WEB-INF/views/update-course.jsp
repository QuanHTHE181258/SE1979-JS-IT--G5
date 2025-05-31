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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Course</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .main-container {
            padding: 2rem 0;
        }

        .form-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0 !important;
            padding: 1.5rem;
            border: none;
        }

        .card-header h2 {
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-floating label {
            color: #6c757d;
            font-weight: 500;
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 600;
        }

        .form-section {
            margin-bottom: 2rem;
        }

        .section-title {
            color: #495057;
            font-weight: 600;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e9ecef;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert {
            border-radius: 10px;
            border: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .price-input {
            position: relative;
        }

        .price-input::before {
            content: "$";
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-weight: 600;
            z-index: 10;
        }

        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
            }

            .form-card {
                border-radius: 15px;
            }

            .card-header {
                border-radius: 15px 15px 0 0 !important;
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="container main-container">
    <div class="row justify-content-center">
        <div class="col-12 col-lg-10 col-xl-8">

            <!-- Success Message -->
            <% if ("success".equals(updateStatus)) { %>
            <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <strong>Success!</strong> Course updated successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <!-- Error Messages -->
            <% if (error != null) { %>
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <strong>Error!</strong>
                <%
                    switch (error) {
                        case "invalidinput": out.print("Invalid input data!"); break;
                        case "notfound": out.print("Course not found!"); break;
                        default: out.print("Unknown error, please try again."); break;
                    }
                %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <% if (course == null) { %>
            <div class="card form-card">
                <div class="card-body p-5 text-center">
                    <i class="bi bi-exclamation-circle text-warning display-1"></i>
                    <h3 class="mt-3">Course Not Found</h3>
                    <p class="text-muted">Could not find the course to edit.</p>
                    <a href="<%= request.getContextPath() %>/courses" class="btn btn-primary">
                        <i class="bi bi-arrow-left me-2"></i>Back to List
                    </a>
                </div>
            </div>
            <% } else { %>

            <!-- Main Form Card -->
            <div class="card form-card">
                <div class="card-header">
                    <h2>
                        <i class="bi bi-pencil-square"></i>
                        Edit Course
                    </h2>
                </div>
                <div class="card-body p-4">
                    <form action="<%= request.getContextPath() %>/update-course" method="post">
                        <input type="hidden" name="courseCode" value="<%= course.getCourseCode() %>">

                        <!-- Basic Information Section -->
                        <div class="form-section">
                            <h5 class="section-title">
                                <i class="bi bi-info-circle"></i>
                                Basic Information
                            </h5>

                            <div class="row">
                                <div class="col-12 mb-3">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="title" name="title"
                                               placeholder="Course Title" required
                                               value="<%= course.getTitle() != null ? course.getTitle() : "" %>">
                                        <label for="title">
                                            <i class="bi bi-card-heading me-2"></i>Course Title
                                        </label>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-floating">
                                        <select class="form-select" id="level" name="level">
                                            <option value="">Select Level</option>
                                            <option value="Beginner" <%= "Beginner".equals(course.getLevel()) ? "selected" : "" %>>Beginner</option>
                                            <option value="Intermediate" <%= "Intermediate".equals(course.getLevel()) ? "selected" : "" %>>Intermediate</option>
                                            <option value="Advanced" <%= "Advanced".equals(course.getLevel()) ? "selected" : "" %>>Advanced</option>
                                        </select>
                                        <label for="level">
                                            <i class="bi bi-bar-chart-steps me-2"></i>Level
                                        </label>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-floating">
                                        <select class="form-select" id="categoryId" name="categoryId">
                                            <option value="1" <%= course.getCategoryId() == 1 ? "selected" : "" %>>Programming</option>
                                            <option value="2" <%= course.getCategoryId() == 2 ? "selected" : "" %>>Design</option>
                                            <option value="3" <%= course.getCategoryId() == 3 ? "selected" : "" %>>Business</option>
                                            <option value="4" <%= course.getCategoryId() == 4 ? "selected" : "" %>>Language</option>
                                            <option value="5" <%= course.getCategoryId() == 5 ? "selected" : "" %>>Other</option>
                                        </select>
                                        <label for="categoryId">
                                            <i class="bi bi-tag me-2"></i>Category
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <div class="form-floating">
                                    <input type="url" class="form-control" id="imageUrl" name="imageUrl"
                                           placeholder="Course Image URL"
                                           value="<%= course.getImageUrl() != null ? course.getImageUrl() : "" %>">
                                    <label for="imageUrl">
                                        <i class="bi bi-image me-2"></i>Course Image URL
                                    </label>
                                </div>
                            </div>

                            <div class="mb-3">
                                <div class="form-floating">
                                        <textarea class="form-control" id="shortDescription" name="shortDescription"
                                                  placeholder="Short Description" style="height: 100px;"><%= course.getShortDescription() != null ? course.getShortDescription() : "" %></textarea>
                                    <label for="shortDescription">
                                        <i class="bi bi-text-left me-2"></i>Short Description
                                    </label>
                                </div>
                            </div>

                            <div class="mb-3">
                                <div class="form-floating">
                                        <textarea class="form-control" id="description" name="description"
                                                  placeholder="Detailed Description" style="height: 120px;"><%= course.getDescription() != null ? course.getDescription() : "" %></textarea>
                                    <label for="description">
                                        <i class="bi bi-card-text me-2"></i>Detailed Description
                                    </label>
                                </div>
                            </div>
                        </div>

                        <!-- Course Details Section -->
                        <div class="form-section">
                            <h5 class="section-title">
                                <i class="bi bi-gear"></i>
                                Course Details
                            </h5>

                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <div class="form-floating price-input">
                                        <input type="number" step="0.01" class="form-control" id="price" name="price"
                                               placeholder="Course Price" style="padding-right: 40px;"
                                               value="<%= course.getPrice() != null ? course.getPrice() : "" %>">
                                        <label for="price">
                                            <i class="bi bi-currency-dollar me-2"></i>Price (USD)
                                        </label>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <div class="form-floating">
                                        <input type="number" class="form-control" id="durationHours" name="durationHours"
                                               placeholder="Duration"
                                               value="<%= course.getDurationHours() %>">
                                        <label for="durationHours">
                                            <i class="bi bi-clock me-2"></i>Duration (hours)
                                        </label>
                                    </div>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <div class="form-floating">
                                        <input type="number" class="form-control" id="maxStudents" name="maxStudents"
                                               placeholder="Max Students"
                                               value="<%= course.getMaxStudents() %>">
                                        <label for="maxStudents">
                                            <i class="bi bi-people me-2"></i>Max Students
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Dates Section -->
                        <div class="form-section">
                            <h5 class="section-title">
                                <i class="bi bi-calendar-range"></i>
                                Dates
                            </h5>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <div class="form-floating">
                                        <input type="date" class="form-control" id="enrollmentStartDate" name="enrollmentStartDate"
                                               value="<%= course.getEnrollmentStartDate() != null ? dtf.format(course.getEnrollmentStartDate()) : "" %>">
                                        <label for="enrollmentStartDate">
                                            <i class="bi bi-calendar-plus me-2"></i>Enrollment Start Date
                                        </label>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-floating">
                                        <input type="date" class="form-control" id="enrollmentEndDate" name="enrollmentEndDate"
                                               value="<%= course.getEnrollmentEndDate() != null ? dtf.format(course.getEnrollmentEndDate()) : "" %>">
                                        <label for="enrollmentEndDate">
                                            <i class="bi bi-calendar-x me-2"></i>Enrollment End Date
                                        </label>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-floating">
                                        <input type="date" class="form-control" id="startDate" name="startDate"
                                               value="<%= course.getStartDate() != null ? dtf.format(course.getStartDate()) : "" %>">
                                        <label for="startDate">
                                            <i class="bi bi-play-circle me-2"></i>Start Date
                                        </label>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-floating">
                                        <input type="date" class="form-control" id="endDate" name="endDate"
                                               value="<%= course.getEndDate() != null ? dtf.format(course.getEndDate()) : "" %>">
                                        <label for="endDate">
                                            <i class="bi bi-stop-circle me-2"></i>End Date
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Status Section -->
                        <div class="form-section">
                            <h5 class="section-title">
                                <i class="bi bi-toggles"></i>
                                Status
                            </h5>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <div class="form-floating">
                                        <select class="form-select" id="isPublished" name="isPublished">
                                            <option value="true" <%= course.isPublished() ? "selected" : "" %>>Yes</option>
                                            <option value="false" <%= !course.isPublished() ? "selected" : "" %>>No</option>
                                        </select>
                                        <label for="isPublished">
                                            <i class="bi bi-eye me-2"></i>Published
                                        </label>
                                    </div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <div class="form-floating">
                                        <select class="form-select" id="isActive" name="isActive">
                                            <option value="true" <%= course.isActive() ? "selected" : "" %>>Yes</option>
                                            <option value="false" <%= !course.isActive() ? "selected" : "" %>>No</option>
                                        </select>
                                        <label for="isActive">
                                            <i class="bi bi-power me-2"></i>Active
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Action Buttons -->
                        <div class="d-flex gap-3 justify-content-end pt-3 border-top">
                            <a href="<%= request.getContextPath() %>/manager-courses" class="btn btn-secondary">
                                <i class="bi bi-arrow-left me-2"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg me-2"></i>Update Course
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS for enhanced UX -->
<script>
    // Auto-dismiss alerts after 5 seconds
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            if (alert.querySelector('.btn-close')) {
                alert.classList.remove('show');
                setTimeout(() => alert.remove(), 150);
            }
        });
    }, 5000);

    // Form validation feedback
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', function(e) {
                const button = form.querySelector('button[type="submit"]');
                button.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Updating...';
                button.disabled = true;
            });
        }
    });
</script>
</body>
</html>