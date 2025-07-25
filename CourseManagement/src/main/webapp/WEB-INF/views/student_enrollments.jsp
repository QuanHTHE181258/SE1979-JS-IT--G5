<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="project.demo.coursemanagement.entities.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Enrolled Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --success-color: #4facfe;
            --warning-color: #fa709a;
            --danger-color: #f56565;
            --info-color: #43e97b;
            --dark-color: #2d3748;
            --light-color: #f8fafc;
            --shadow-soft: 0 4px 20px rgba(0, 0, 0, 0.08);
            --shadow-medium: 0 8px 30px rgba(0, 0, 0, 0.12);
            --border-radius: 16px;
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            color: var(--dark-color);
            line-height: 1.6;
        }

        /* Modern Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: var(--shadow-soft);
            padding: 1rem 0;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-link {
            font-weight: 500;
            transition: var(--transition);
            position: relative;
            color: var(--dark-color) !important;
        }

        .nav-link:hover {
            color: var(--primary-color) !important;
            transform: translateY(-2px);
        }

        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -5px;
            left: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            transition: var(--transition);
            transform: translateX(-50%);
        }

        .nav-link:hover::after {
            width: 100%;
        }

        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            padding: 4rem 0 2rem;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="25" cy="75" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="75" cy="25" r="1" fill="rgba(255,255,255,0.05)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.5;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: white;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 0 2px 20px rgba(0, 0, 0, 0.3);
        }

        .hero-subtitle {
            font-size: 1.25rem;
            font-weight: 400;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Stats Cards */
        .stats-container {
            margin: -2rem 0 3rem;
            position: relative;
            z-index: 3;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: var(--border-radius);
            padding: 2rem;
            text-align: center;
            box-shadow: var(--shadow-soft);
            transition: var(--transition);
            height: 100%;
        }

        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-medium);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 1.5rem;
            color: white;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #718096;
            font-weight: 500;
            font-size: 0.95rem;
        }

        /* Main Content Card */
        .main-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-soft);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .card-header-modern {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            padding: 2rem;
            border: none;
            position: relative;
            overflow: hidden;
        }

        .card-header-modern::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .card-title-modern {
            color: white;
            font-size: 1.75rem;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .card-subtitle-modern {
            color: rgba(255, 255, 255, 0.8);
            margin: 0.5rem 0 0;
            font-size: 1rem;
        }

        /* Enhanced Filter Section */
        .filter-section {
            background: var(--light-color);
            padding: 2rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .filter-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--shadow-soft);
            border: 1px solid #e2e8f0;
        }

        .filter-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            font-weight: 500;
            transition: var(--transition);
            background: white;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        /* Modern Table */
        .table-container {
            padding: 0;
            position: relative;
        }

        .table-modern {
            margin: 0;
        }

        .table-modern thead th {
            background: var(--light-color);
            border: none;
            padding: 1.5rem 1rem;
            font-weight: 600;
            color: #4a5568;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .table-modern tbody td {
            padding: 1.5rem 1rem;
            border: none;
            border-bottom: 1px solid #e2e8f0;
            vertical-align: middle;
        }

        .table-modern tbody tr {
            transition: var(--transition);
        }

        .table-modern tbody tr:hover {
            background: #f7fafc;
            transform: scale(1.01);
        }

        /* Enhanced Badges */
        .badge-modern {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
        }

        .badge-completed {
            background: linear-gradient(135deg, var(--success-color), #00f2fe);
            color: white;
        }

        .badge-active {
            background: linear-gradient(135deg, var(--info-color), #38f9d7);
            color: white;
        }

        .badge-cancelled {
            background: linear-gradient(135deg, #434343, #000000);
            color: white;
        }

        .badge-certificate {
            background: linear-gradient(135deg, var(--warning-color), #fee140);
            color: white;
        }

        .badge-no-certificate {
            background: #e2e8f0;
            color: #718096;
        }

        .badge-score {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
        }

        /* Enhanced Progress Bar */
        .progress-modern {
            height: 12px;
            border-radius: 50px;
            background: #e2e8f0;
            overflow: hidden;
            position: relative;
        }

        .progress-bar-modern {
            background: linear-gradient(135deg, var(--success-color), #00f2fe);
            height: 100%;
            border-radius: 50px;
            transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .progress-bar-modern::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            animation: progressShine 2s infinite;
        }

        @keyframes progressShine {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        .progress-text {
            font-size: 0.75rem;
            font-weight: 600;
            color: #4a5568;
            margin-top: 0.25rem;
            text-align: center;
        }

        /* Action Buttons */
        .btn-modern {
            border-radius: 12px;
            padding: 0.5rem 1rem;
            font-weight: 600;
            font-size: 0.875rem;
            border: none;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            margin: 0.125rem;
        }

        .btn-primary-modern {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
        }

        .btn-warning-modern {
            background: linear-gradient(135deg, var(--warning-color), #fee140);
            color: white;
        }

        .btn-modern:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
            color: white;
        }

        /* Course Name Styling */
        .course-name {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.25rem;
        }

        .course-meta {
            font-size: 0.75rem;
            color: #718096;
        }

        /* Pagination */
        .pagination-modern {
            justify-content: center;
            margin: 2rem 0;
        }

        .pagination-modern .page-link {
            border: none;
            padding: 0.75rem 1rem;
            margin: 0 0.25rem;
            border-radius: 12px;
            font-weight: 600;
            color: #4a5568;
            transition: var(--transition);
        }

        .pagination-modern .page-item.active .page-link {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            color: white;
        }

        .pagination-modern .page-link:hover {
            background: #f7fafc;
            color: var(--primary-color);
            transform: translateY(-2px);
        }

        /* Alert Messages */
        .alert-modern {
            border: none;
            border-radius: var(--border-radius);
            padding: 1.25rem;
            font-weight: 500;
            box-shadow: var(--shadow-soft);
        }

        .alert-success-modern {
            background: linear-gradient(135deg, rgba(72, 187, 120, 0.1) 0%, rgba(56, 178, 172, 0.1) 100%);
            color: #2f855a;
            border-left: 4px solid #48bb78;
        }

        .alert-danger-modern {
            background: linear-gradient(135deg, rgba(245, 101, 101, 0.1) 0%, rgba(237, 137, 54, 0.1) 100%);
            color: #c53030;
            border-left: 4px solid #f56565;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #718096;
        }

        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-state-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 0.5rem;
        }

        /* Loading Animation */
        .loading-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.9);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10;
            opacity: 0;
            visibility: hidden;
            transition: var(--transition);
        }

        .loading-overlay.show {
            opacity: 1;
            visibility: visible;
        }

        .loading-spinner {
            width: 40px;
            height: 40px;
            border: 3px solid #e2e8f0;
            border-top: 3px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }

            .hero-subtitle {
                font-size: 1rem;
            }

            .stats-container {
                margin-top: -1rem;
            }

            .filter-section {
                padding: 1rem;
            }

            .table-responsive {
                border-radius: 0;
            }

            .btn-modern {
                font-size: 0.75rem;
                padding: 0.375rem 0.75rem;
            }
        }

        /* Fade in animation */
        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<!-- Enhanced Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class="fas fa-graduation-cap me-2"></i>Online Learning
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-home me-1"></i>Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/course">
                        <i class="fas fa-book me-1"></i>Courses
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/blogs.jsp">
                        <i class="fas fa-blog me-1"></i>Blogs
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/introduce.jsp">
                        <i class="fas fa-info-circle me-1"></i>About
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/wishlist.jsp">
                        <i class="fas fa-heart me-1"></i>Wishlist
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/cart.jsp">
                        <i class="fas fa-shopping-cart me-1"></i>Cart
                    </a>
                </li>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown"
                               role="button" data-bs-toggle="dropdown">
                                <img src="<c:out value='${sessionScope.user.avatarUrl != null ? sessionScope.user.avatarUrl : "https://th.bing.com/th/id/OIP.-Zanaodp4hv0ry2WpuuPfgHaEf?rs=1&pid=ImgDetMain"}'/>"
                                     alt="Avatar" style="width:32px; height:32px; border-radius:50%; object-fit:cover; margin-right:8px;">
                                <span>${sessionScope.user.firstName}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/${sessionScope.user.roleId == 2 ? 'teacher/profile' : 'profile'}">
                                    <i class="fas fa-user me-2"></i>My Profile</a></li>
                                <c:if test="${sessionScope.user.roleId == 3}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/student/refund">
                                        <i class="fas fa-undo me-2"></i>Refund Request</a></li>
                                    <li><a class="dropdown-item" href="myorder">
                                        <i class="fas fa-shopping-bag me-2"></i>My Orders</a></li>
                                </c:if>
                                <c:if test="${sessionScope.user.roleId == 1}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/dashBoard">
                                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard</a></li>
                                </c:if>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login?action=logout">
                                    <i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="hero-content fade-in">
            <h1 class="hero-title">My Learning Journey</h1>
            <p class="hero-subtitle">Track your progress, celebrate achievements, and continue growing with your enrolled courses</p>
        </div>
    </div>
</section>

<!-- Stats Section -->
<div class="container stats-container">
    <div class="row g-4 fade-in">
        <div class="col-md-3 col-sm-6">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));">
                    <i class="fas fa-book"></i>
                </div>
                <div class="stat-number" id="totalCourses">0</div>
                <div class="stat-label">Total Courses</div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, var(--success-color), #00f2fe);">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-number" id="completedCourses">0</div>
                <div class="stat-label">Completed</div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, var(--info-color), #38f9d7);">
                    <i class="fas fa-play-circle"></i>
                </div>
                <div class="stat-number" id="activeCourses">0</div>
                <div class="stat-label">In Progress</div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, var(--warning-color), #fee140);">
                    <i class="fas fa-certificate"></i>
                </div>
                <div class="stat-number" id="certificatesEarned">0</div>
                <div class="stat-label">Certificates</div>
            </div>
        </div>
    </div>
</div>

<!-- Main Content -->
<div class="container">
    <div class="main-card fade-in">
        <!-- Card Header -->
        <div class="card-header-modern">
            <h2 class="card-title-modern">
                <i class="fas fa-graduation-cap"></i>
                My Enrolled Courses
            </h2>
            <p class="card-subtitle-modern">Manage and track your learning progress across all enrolled courses</p>
        </div>

        <!-- Enhanced Filter Section -->
        <div class="filter-section">
            <div class="filter-card">
                <div class="filter-title">
                    <i class="fas fa-filter"></i>
                    Filter & Search
                </div>
                <form id="filterForm">
                    <div class="row g-3">
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label text-muted small">Course Title</label>
                            <input type="text" class="form-control" id="filterTitle" placeholder="Search by title...">
                        </div>
                        <div class="col-lg-2 col-md-6">
                            <label class="form-label text-muted small">Status</label>
                            <select class="form-select" id="filterStatus">
                                <option value="">All Statuses</option>
                                <option value="ACTIVE">Active</option>
                                <option value="COMPLETED">Completed</option>
                                <option value="CANCELLED">Cancelled</option>
                            </select>
                        </div>
                        <div class="col-lg-2 col-md-4">
                            <label class="form-label text-muted small">Min Score</label>
                            <input type="number" class="form-control" id="filterMinScore" placeholder="0" min="0" max="100">
                        </div>
                        <div class="col-lg-2 col-md-4">
                            <label class="form-label text-muted small">Max Score</label>
                            <input type="number" class="form-control" id="filterMaxScore" placeholder="100" min="0" max="100">
                        </div>
                        <div class="col-lg-3 col-md-4">
                            <label class="form-label text-muted small">Certificate</label>
                            <select class="form-select" id="filterCertificate">
                                <option value="">All Certificates</option>
                                <option value="yes">Has Certificate</option>
                                <option value="no">No Certificate</option>
                            </select>
                        </div>
                    </div>
                    <div class="row g-3 mt-2">
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label text-muted small">Min Progress (%)</label>
                            <input type="number" class="form-control" id="filterMinProgress" placeholder="0" min="0" max="100">
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label text-muted small">Max Progress (%)</label>
                            <input type="number" class="form-control" id="filterMaxProgress" placeholder="100" min="0" max="100">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Table Container -->
        <div class="table-container position-relative">
            <div class="loading-overlay" id="loadingOverlay">
                <div class="loading-spinner"></div>
            </div>

            <div class="table-responsive">
                <table class="table table-modern" id="enrollmentsTable">
                    <thead>
                    <tr>
                        <th><i class="fas fa-book me-2"></i>Course</th>
                        <th><i class="fas fa-calendar-plus me-2"></i>Start Date</th>
                        <th><i class="fas fa-calendar-check me-2"></i>Completion</th>
                        <th><i class="fas fa-chart-line me-2"></i>Progress</th>
                        <th><i class="fas fa-info-circle me-2"></i>Status</th>
                        <th><i class="fas fa-star me-2"></i>Score</th>
                        <th><i class="fas fa-certificate me-2"></i>Certificate</th>
                        <th><i class="fas fa-cogs me-2"></i>Actions</th>
                    </tr>
                    </thead>
                    <tbody id="enrollmentsBody">
                    <!-- Table content will be populated by JavaScript -->
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <nav>
                <ul class="pagination pagination-modern" id="pagination"></ul>
            </nav>
        </div>
    </div>

    <!-- Feedback Messages -->
    <c:if test="${param.message == 'feedback_added'}">
        <div class="alert alert-success-modern alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>Thank you for your feedback!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${param.error != null}">
        <div class="alert alert-danger-modern alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>
            <c:choose>
                <c:when test="${param.error == 'not_completed'}">
                    You can only provide feedback for completed courses.
                </c:when>
                <c:when test="${param.error == 'already_feedback'}">
                    You have already provided feedback for this course.
                </c:when>
                <c:when test="${param.error == 'feedback_failed'}">
                    Failed to submit feedback. Please try again.
                </c:when>
                <c:when test="${param.error == 'invalid_parameters'}">
                    Invalid input parameters. Please try again.
                </c:when>
                <c:otherwise>
                    An error occurred. Please try again later.
                </c:otherwise>
            </c:choose>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
</div>

<script>
    // Convert enrollments from server to JS array
    var enrollments = [
            <% if (request.getAttribute("enrollments") != null) {
                List<Enrollment> enrollments = (List<Enrollment>) request.getAttribute("enrollments");
                if (!enrollments.isEmpty()) {
                    for (int i = 0; i < enrollments.size(); i++) {
                        Enrollment e = enrollments.get(i);
                        Cours c = e.getCourse();
            %>{
            courseName: "<%= c != null ? c.getTitle().replace("\"", "\\\"") : "" %>",
            courseId: <%= c != null ? c.getId() : 0 %>,
            enrollmentDate: "<%= e.getEnrollmentDate() != null ? e.getEnrollmentDate().toString().substring(0, 10) : "" %>",
            completionDate: "<%= e.getCompletionDate() != null ? e.getCompletionDate().toString().substring(0, 10) : "" %>",
            progress: <%= e.getProgressPercentage() != null ? e.getProgressPercentage() : 0 %>,
            status: "<%= e.getStatus() %>",
            score: <%= e.getGrade() != null ? e.getGrade() : 0 %>,
            certificate: "<%= Boolean.TRUE.equals(e.getCertificateIssued()) ? "yes" : "no" %>",
            price: <%= c != null && c.getPrice() != null ? c.getPrice() : 0 %>
        }<%= (i < enrollments.size() - 1) ? "," : "" %>
        <%          }
            }
        } %>
    ];

    // Pagination and filter state
    var currentPage = 1;
    var pageSize = 5;

    // Update statistics
    function updateStats() {
        var totalCourses = enrollments.length;
        var completedCourses = enrollments.filter(function(e) { return e.status == 'COMPLETED'; }).length;
        var activeCourses = enrollments.filter(function(e) { return e.status == 'ACTIVE'; }).length;
        var certificatesEarned = enrollments.filter(function(e) { return e.certificate == 'yes'; }).length;

        document.getElementById('totalCourses').textContent = totalCourses;
        document.getElementById('completedCourses').textContent = completedCourses;
        document.getElementById('activeCourses').textContent = activeCourses;
        document.getElementById('certificatesEarned').textContent = certificatesEarned;

        // Animate counters
        animateCounter('totalCourses', totalCourses);
        animateCounter('completedCourses', completedCourses);
        animateCounter('activeCourses', activeCourses);
        animateCounter('certificatesEarned', certificatesEarned);
    }

    function animateCounter(elementId, target) {
        var element = document.getElementById(elementId);
        var current = 0;
        var increment = target / 30;
        var timer = setInterval(function() {
            current += increment;
            if (current >= target) {
                current = target;
                clearInterval(timer);
            }
            element.textContent = Math.floor(current);
        }, 50);
    }

    function showLoading() {
        document.getElementById('loadingOverlay').classList.add('show');
    }

    function hideLoading() {
        document.getElementById('loadingOverlay').classList.remove('show');
    }

    function filterAndRender() {
        showLoading();

        setTimeout(function() {
            // Get filter values
            var title = document.getElementById('filterTitle').value.toLowerCase();
            var status = document.getElementById('filterStatus').value;
            var minScore = parseFloat(document.getElementById('filterMinScore').value) || null;
            var maxScore = parseFloat(document.getElementById('filterMaxScore').value) || null;
            var certificate = document.getElementById('filterCertificate').value;
            var minProgress = parseFloat(document.getElementById('filterMinProgress').value) || null;
            var maxProgress = parseFloat(document.getElementById('filterMaxProgress').value) || null;

            var filtered = enrollments.filter(function(e) {
                if (title && e.courseName.toLowerCase().indexOf(title) == -1) return false;
                if (status && e.status != status) return false;
                if (certificate && e.certificate != certificate) return false;
                if (minScore != null && e.score < minScore) return false;
                if (maxScore != null && e.score > maxScore) return false;
                if (minProgress != null && e.progress < minProgress) return false;
                if (maxProgress != null && e.progress > maxProgress) return false;
                return true;
            });

            // Pagination
            var totalPages = Math.ceil(filtered.length / pageSize) || 1;
            if (currentPage > totalPages) currentPage = totalPages;
            var start = (currentPage - 1) * pageSize;
            var end = start + pageSize;
            var pageData = filtered.slice(start, end);

            // Render table
            var tbody = document.getElementById('enrollmentsBody');

            if (pageData.length == 0) {
                tbody.innerHTML = '<tr><td colspan="8" class="empty-state"><div class="empty-state-icon"><i class="fas fa-search"></i></div><div class="empty-state-title">No courses found</div><p>Try adjusting your search criteria</p></td></tr>';
            } else {
                var htmlRows = pageData.map(function(e) {
                    var completionDateHtml = e.completionDate && e.completionDate != 'null' && e.completionDate != ''
                        ? '<span class="badge badge-modern badge-completed"><i class="fas fa-check"></i> ' + e.completionDate + '</span>'
                        : '<span class="badge badge-modern badge-no-certificate"><i class="fas fa-clock"></i> In Progress</span>';

                    var statusHtml = '';
                    if (e.status == 'COMPLETED') {
                        statusHtml = '<span class="badge badge-modern badge-completed"><i class="fas fa-check-circle"></i> COMPLETED</span>';
                    } else if (e.status == 'ACTIVE') {
                        statusHtml = '<span class="badge badge-modern badge-active"><i class="fas fa-play-circle"></i> ACTIVE</span>';
                    } else {
                        statusHtml = '<span class="badge badge-modern badge-cancelled"><i class="fas fa-times-circle"></i> ' + e.status + '</span>';
                    }

                    var scoreHtml = e.score > 0
                        ? '<span class="badge badge-modern badge-score"><i class="fas fa-star"></i> ' + e.score + '</span>'
                        : '<span class="text-muted">No Score</span>';

                    var certificateHtml = e.certificate == 'yes'
                        ? '<span class="badge badge-modern badge-certificate"><i class="fas fa-certificate"></i> Available</span>'
                        : '<span class="badge badge-modern badge-no-certificate"><i class="fas fa-times"></i> Not Available</span>';

                    var progressHtml = '<div class="progress-modern mb-1">' +
                        '<div class="progress-bar-modern" style="width: ' + e.progress + '%"></div>' +
                        '</div>' +
                        '<div class="progress-text">' + e.progress + '%</div>';

                    var actionsHtml = '<a href="lessons?courseId=' + e.courseId + '" class="btn btn-modern btn-primary-modern"><i class="fas fa-eye"></i> View</a>';
                    if (e.status == 'COMPLETED') {
                        actionsHtml += '<a href="feedback?courseId=' + e.courseId + '" class="btn btn-modern btn-warning-modern"><i class="fas fa-comment"></i> Feedback</a>';
                    }

                    return '<tr>' +
                        '<td><div class="course-name">' + e.courseName + '</div><div class="course-meta">Course ID: ' + e.courseId + '</div></td>' +
                        '<td>' + (e.enrollmentDate || 'N/A') + '</td>' +
                        '<td>' + completionDateHtml + '</td>' +
                        '<td>' + progressHtml + '</td>' +
                        '<td>' + statusHtml + '</td>' +
                        '<td>' + scoreHtml + '</td>' +
                        '<td>' + certificateHtml + '</td>' +
                        '<td>' + actionsHtml + '</td>' +
                        '</tr>';
                }).join('');
                tbody.innerHTML = htmlRows;
            }

            // Render pagination
            renderPagination(totalPages);
            hideLoading();
        }, 500);
    }

    function renderPagination(totalPages) {
        var pagination = document.getElementById('pagination');
        if (totalPages <= 1) {
            pagination.innerHTML = '';
            return;
        }

        var pagHtml = '';

        // Previous button
        pagHtml += '<li class="page-item' + (currentPage == 1 ? ' disabled' : '') + '">';
        pagHtml += '<a class="page-link" href="#" onclick="gotoPage(' + (currentPage - 1) + ');return false;">';
        pagHtml += '<i class="fas fa-chevron-left"></i> Previous</a></li>';

        // Page numbers
        var startPage = Math.max(1, currentPage - 2);
        var endPage = Math.min(totalPages, currentPage + 2);

        if (startPage > 1) {
            pagHtml += '<li class="page-item"><a class="page-link" href="#" onclick="gotoPage(1);return false;">1</a></li>';
            if (startPage > 2) {
                pagHtml += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }
        }

        for (var i = startPage; i <= endPage; i++) {
            pagHtml += '<li class="page-item' + (i == currentPage ? ' active' : '') + '">';
            pagHtml += '<a class="page-link" href="#" onclick="gotoPage(' + i + ');return false;">' + i + '</a></li>';
        }

        if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
                pagHtml += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }
            pagHtml += '<li class="page-item"><a class="page-link" href="#" onclick="gotoPage(' + totalPages + ');return false;">' + totalPages + '</a></li>';
        }

        // Next button
        pagHtml += '<li class="page-item' + (currentPage == totalPages ? ' disabled' : '') + '">';
        pagHtml += '<a class="page-link" href="#" onclick="gotoPage(' + (currentPage + 1) + ');return false;">';
        pagHtml += 'Next <i class="fas fa-chevron-right"></i></a></li>';

        pagination.innerHTML = pagHtml;
    }

    function gotoPage(page) {
        if (page < 1 || page > Math.ceil(enrollments.length / pageSize)) return;
        currentPage = page;
        filterAndRender();
    }

    // Attach event handlers
    document.addEventListener('DOMContentLoaded', function() {
        var filterElements = document.querySelectorAll('#filterForm input, #filterForm select');
        for (var i = 0; i < filterElements.length; i++) {
            filterElements[i].addEventListener('input', function() {
                currentPage = 1;
                filterAndRender();
            });
            filterElements[i].addEventListener('change', function() {
                currentPage = 1;
                filterAndRender();
            });
        }

        // Initial render
        updateStats();
        filterAndRender();

        // Add fade-in animation to elements
        setTimeout(function() {
            var elements = document.querySelectorAll('.fade-in');
            for (var i = 0; i < elements.length; i++) {
                elements[i].style.opacity = '1';
                elements[i].style.transform = 'translateY(0)';
            }
        }, 100);
    });
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>