<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    :root {
        --sidebar-width: 280px;
        --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        --sidebar-bg: linear-gradient(180deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%);
        --hover-bg: rgba(255, 255, 255, 0.1);
        --active-bg: rgba(255, 255, 255, 0.15);
        --text-primary: #ffffff;
        --text-secondary: rgba(255, 255, 255, 0.8);
        --accent-color: #00d4ff;
        --border-radius: 12px;
        --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        --shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
    }

    #sidebar {
        width: var(--sidebar-width);
        min-height: 100vh;
        background: var(--sidebar-bg);
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
        box-shadow: var(--shadow);
        transition: var(--transition);
        overflow-y: auto;
        scrollbar-width: thin;
        scrollbar-color: rgba(255, 255, 255, 0.3) transparent;
    }

    #sidebar::-webkit-scrollbar {
        width: 6px;
    }

    #sidebar::-webkit-scrollbar-track {
        background: transparent;
    }

    #sidebar::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.3);
        border-radius: 3px;
    }

    #sidebar::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.5);
    }

    .sidebar-header {
        padding: 2rem 1.5rem;
        text-align: center;
        position: relative;
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0.05) 100%);
        backdrop-filter: blur(20px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        margin-bottom: 1rem;
    }

    .sidebar-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="dots" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23dots)"/></svg>');
        pointer-events: none;
    }

    .sidebar-header h3 {
        color: var(--text-primary);
        font-size: 1.5rem;
        font-weight: 700;
        margin: 0;
        position: relative;
        z-index: 2;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .sidebar-header::after {
        content: '';
        position: absolute;
        bottom: -10px;
        left: 50%;
        transform: translateX(-50%);
        width: 60px;
        height: 3px;
        background: var(--accent-color);
        border-radius: 2px;
        box-shadow: 0 0 20px var(--accent-color);
    }

    .nav {
        padding: 0 1rem;
        list-style: none;
    }

    .nav-item {
        margin-bottom: 0.5rem;
        position: relative;
    }

    .nav-link {
        display: flex;
        align-items: center;
        padding: 1rem 1.5rem;
        color: var(--text-secondary);
        text-decoration: none;
        border-radius: var(--border-radius);
        transition: var(--transition);
        position: relative;
        overflow: hidden;
        font-weight: 500;
        font-size: 0.95rem;
        backdrop-filter: blur(10px);
        border: 1px solid transparent;
    }

    .nav-link::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
        transition: var(--transition);
    }

    .nav-link:hover::before {
        left: 100%;
    }

    .nav-link i {
        width: 20px;
        margin-right: 1rem;
        font-size: 1.1rem;
        transition: var(--transition);
    }

    .nav-link:hover {
        color: var(--text-primary);
        background: var(--hover-bg);
        transform: translateX(8px);
        border-color: rgba(255, 255, 255, 0.2);
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
    }

    .nav-link:hover i {
        color: var(--accent-color);
        transform: scale(1.1);
    }

    .nav-link.active {
        color: var(--text-primary);
        background: var(--active-bg);
        border-color: var(--accent-color);
        box-shadow: 0 0 30px rgba(0, 212, 255, 0.3);
        transform: translateX(8px);
    }

    .nav-link.active::after {
        content: '';
        position: absolute;
        right: -1px;
        top: 50%;
        transform: translateY(-50%);
        width: 4px;
        height: 60%;
        background: var(--accent-color);
        border-radius: 2px 0 0 2px;
        box-shadow: 0 0 10px var(--accent-color);
    }

    .nav-link.active i {
        color: var(--accent-color);
        transform: scale(1.1);
    }

    /* Role-based styling */
    .sidebar[data-role="ADMIN"] .sidebar-header h3 {
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .sidebar[data-role="USER_MANAGER"] .sidebar-header h3 {
        background: var(--secondary-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    /* Icon animations for different menu items */
    .nav-link[href*="dashboard"] i { color: #4facfe; }
    .nav-link[href*="user-management"] i { color: #f093fb; }
    .nav-link[href*="courses"] i { color: #00f2fe; }
    .nav-link[href*="orders"] i { color: #fa709a; }
    .nav-link[href*="revenue"] i { color: #fee140; }
    .nav-link[href*="teacher"] i { color: #667eea; }

    .nav-link:hover[href*="dashboard"] { border-left: 3px solid #4facfe; }
    .nav-link:hover[href*="user-management"] { border-left: 3px solid #f093fb; }
    .nav-link:hover[href*="courses"] { border-left: 3px solid #00f2fe; }
    .nav-link:hover[href*="orders"] { border-left: 3px solid #fa709a; }
    .nav-link:hover[href*="revenue"] { border-left: 3px solid #fee140; }
    .nav-link:hover[href*="teacher"] { border-left: 3px solid #667eea; }

    /* Responsive design */
    @media (max-width: 768px) {
        #sidebar {
            transform: translateX(-100%);
            width: 100%;
            max-width: var(--sidebar-width);
        }

        #sidebar.show {
            transform: translateX(0);
        }

        .sidebar-header {
            padding: 1.5rem 1rem;
        }

        .sidebar-header h3 {
            font-size: 1.3rem;
        }

        .nav {
            padding: 0 0.5rem;
        }

        .nav-link {
            padding: 0.875rem 1rem;
            font-size: 0.9rem;
        }
    }

    /* Loading animation */
    @keyframes slideInLeft {
        from {
            opacity: 0;
            transform: translateX(-30px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    .nav-item {
        animation: slideInLeft 0.5s ease-out;
    }

    .nav-item:nth-child(1) { animation-delay: 0s; }
    .nav-item:nth-child(2) { animation-delay: 0.1s; }
    .nav-item:nth-child(3) { animation-delay: 0.2s; }
    .nav-item:nth-child(4) { animation-delay: 0.3s; }
    .nav-item:nth-child(5) { animation-delay: 0.4s; }
    .nav-item:nth-child(6) { animation-delay: 0.5s; }

    /* Pulse effect for active items */
    @keyframes pulse {
        0% { box-shadow: 0 0 30px rgba(0, 212, 255, 0.3); }
        50% { box-shadow: 0 0 40px rgba(0, 212, 255, 0.5); }
        100% { box-shadow: 0 0 30px rgba(0, 212, 255, 0.3); }
    }

    .nav-link.active {
        animation: pulse 2s infinite;
    }

    /* Brand logo area */
    .sidebar-brand {
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1rem;
        padding: 1rem;
    }

    .brand-icon {
        width: 40px;
        height: 40px;
        background: var(--accent-color);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 0.75rem;
        box-shadow: 0 0 20px rgba(0, 212, 255, 0.5);
    }

    .brand-icon i {
        color: white;
        font-size: 1.2rem;
    }
</style>

<nav id="sidebar" class="sidebar" data-role="${sessionScope.user.role.roleName}">
    <div class="sidebar-header">
        <div class="sidebar-brand">
            <div class="brand-icon">
                <i class="fas fa-crown"></i>
            </div>
        </div>
        <h3>
            <c:choose>
                <c:when test="${sessionScope.user.role.roleName == 'ADMIN'}">Admin Panel</c:when>
                <c:when test="${sessionScope.user.role.roleName == 'USER_MANAGER'}">User Manager Panel</c:when>
                <c:otherwise>Control Panel</c:otherwise>
            </c:choose>
        </h3>
    </div>

    <ul class="nav flex-column">
        <c:if test="${sessionScope.user.role.roleName == 'ADMIN'}">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management/list">
                    <i class="fas fa-users"></i>
                    <span>User Management</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/courses">
                    <i class="fas fa-book"></i>
                    <span>Courses Management</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Order Management</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/revenue-analytics">
                    <i class="fas fa-chart-bar"></i>
                    <span>Revenue Analytics</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/teacher-performance">
                    <i class="fas fa-chart-line"></i>
                    <span>Teacher Performance</span>
                </a>
            </li>
        </c:if>

        <c:if test="${sessionScope.user.role.roleName == 'USER_MANAGER'}">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management/list">
                    <i class="fas fa-users"></i>
                    <span>User Management</span>
                </a>
            </li>
        </c:if>
    </ul>
</nav>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add active class to current page
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('.nav-link');

        navLinks.forEach(link => {
            const href = link.getAttribute('href');
            if (href && currentPath.includes(href.split('/').pop())) {
                link.classList.add('active');
            }
        });

        // Mobile toggle functionality
        const toggleBtn = document.getElementById('sidebar-toggle');
        const sidebar = document.getElementById('sidebar');

        if (toggleBtn) {
            toggleBtn.addEventListener('click', function() {
                sidebar.classList.toggle('show');
            });
        }

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            if (window.innerWidth <= 768) {
                if (!sidebar.contains(event.target) && !event.target.matches('#sidebar-toggle')) {
                    sidebar.classList.remove('show');
                }
            }
        });
    });
</script>