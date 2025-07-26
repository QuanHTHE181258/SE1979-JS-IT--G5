<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userRole != '4'}">
    <nav class="admin-sidebar">
        <div class="sidebar-brand">
            <i class="fas fa-graduation-cap"></i>
            <span>Admin Dashboard</span>
        </div>

        <ul class="nav-list">
            <li class="nav-item">
                <a class="nav-link ${param.active == 'dashboard' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>

            <li class="nav-section">
                <span class="nav-section-text">Management</span>
            </li>

            <li class="nav-item">
                <a class="nav-link ${param.active == 'courses' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/courses">
                    <i class="fas fa-book"></i>
                    <span>Courses</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${param.active == 'orders' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Orders</span>
                </a>
            </li>

            <li class="nav-item">
                <a class="nav-link ${param.active == 'users' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i>
                    <span>Users</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.active == 'users' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/revenue-analytics">
                    <i class="fas fa-users"></i>
                    <span>Revenue</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link ${param.active == 'users' ? 'active' : ''}"
                   href="${pageContext.request.contextPath}/admin/blog/list">
                    <i class="fas fa-users"></i>
                    <span>Blogs</span>
                </a>
            </li>
        </ul>
    </nav>

    <style>
        :root {
            --sidebar-width: 280px;
            --sidebar-bg: #2c3e50;
            --sidebar-hover: #34495e;
            --text-color: #ecf0f1;
            --text-muted: #95a5a6;
            --accent-color: #3498db;
        }

        .admin-sidebar {
            position: fixed;
            left: 0;
            top: 70px;
            width: var(--sidebar-width);
            height: calc(100vh - 70px);
            background: var(--sidebar-bg);
            color: var(--text-color);
            overflow-y: auto;
            transition: all 0.3s ease;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }

        .sidebar-brand {
            padding: 1.5rem 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--text-color);
            border-bottom: 1px solid rgba(255,255,255,0.1);
            background: linear-gradient(to right, var(--sidebar-bg), var(--sidebar-hover));
        }

        .sidebar-brand i {
            font-size: 1.8rem;
            color: var(--accent-color);
        }

        .nav-list {
            padding: 1.5rem 0;
            list-style: none;
            margin: 0;
        }

        .nav-section {
            padding: 1.5rem 2rem 0.75rem;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-muted);
            font-weight: 600;
        }

        .nav-item {
            margin: 4px 1rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.5rem;
            color: var(--text-color) !important;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-size: 1rem;
        }

        .nav-link i {
            width: 24px;
            text-align: center;
            font-size: 1.2rem;
        }

        .nav-link:hover {
            background: var(--sidebar-hover);
            transform: translateX(4px);
            padding-left: 2rem;
        }

        .nav-link.active {
            background: var(--accent-color);
            color: white !important;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        .nav-link.active:hover {
            background: #2980b9;
            transform: translateX(4px) scale(1.02);
        }

        /* Scrollbar Styling */
        .admin-sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .admin-sidebar::-webkit-scrollbar-track {
            background: var(--sidebar-bg);
        }

        .admin-sidebar::-webkit-scrollbar-thumb {
            background: var(--sidebar-hover);
            border-radius: 3px;
        }

        .admin-sidebar::-webkit-scrollbar-thumb:hover {
            background: var(--accent-color);
        }

        /* Main content adjustment */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 2rem;
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add smooth hover effect
            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.addEventListener('mouseenter', e => {
                    e.target.style.transform = 'translateX(4px)';
                });
                link.addEventListener('mouseleave', e => {
                    if (!e.target.classList.contains('active')) {
                        e.target.style.transform = 'translateX(0)';
                    }
                });
            });
        });
    </script>
</c:if>
