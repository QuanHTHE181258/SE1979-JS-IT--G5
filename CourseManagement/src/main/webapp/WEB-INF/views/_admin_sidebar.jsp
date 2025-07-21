<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav id="sidebar" class="sidebar">
    <div class="sidebar-header">
        <h3>
            <c:choose>
                <c:when test="${sessionScope.user.role.roleName == 'ADMIN'}">Admin Panel</c:when>
                <c:when test="${sessionScope.user.role.roleName == 'USER_MANAGER'}">User Manager Panel</c:when>
                <c:otherwise>Panel</c:otherwise>
            </c:choose>
        </h3>
    </div>
    <ul class="nav flex-column">
        <c:if test="${sessionScope.user.role.roleName == 'ADMIN'}">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management/list"><i class="fas fa-users"></i> User Management</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/courses"><i class="fas fa-book"></i> Courses Management</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/orders"><i class="fas fa-shopping-cart"></i> Order Management</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/revenue-analytics"><i class="fas fa-chart-bar"></i> Revenue Analytics</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/teacher-performance"><i class="fas fa-chart-line"></i> Teacher Performance</a>
            </li>
        </c:if>
        <c:if test="${sessionScope.user.role.roleName == 'USER_MANAGER'}">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/user-management/list"><i class="fas fa-users"></i> User Management</a>
            </li>
        </c:if>
    </ul>
</nav> 