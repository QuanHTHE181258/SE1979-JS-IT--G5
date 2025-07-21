<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav id="sidebar" class="sidebar">
    <div class="sidebar-header">
         <h3><c:choose><c:when test="${sessionScope.user.role.roleName == 'ADMIN'}">Admin Panel</c:when><c:otherwise>User Manager Panel</c:otherwise></c:choose></h3>
    </div>
    <ul class="nav flex-column">
        <c:if test="${sessionScope.user.role.roleName == 'ADMIN'}">
            <li class="nav-item">
                <a class="nav-link <c:if test="${request.servletPath == '/admin'}">active</c:if>" href="${pageContext.request.contextPath}/admin">
                    <i class="fas fa-tachometer-alt"></i> Dashboard
                </a>
            </li>
        </c:if>
        
        <li class="nav-item">
            <a class="nav-link <c:if test="${request.servletPath == '/admin/user-management'}">active</c:if>" href="${pageContext.request.contextPath}/admin/user-management">
                <i class="fas fa-users"></i> User Management
            </a>
        </li>
        
        <c:if test="${sessionScope.user.role.roleName == 'ADMIN'}">
            <li class="nav-item">
                <a class="nav-link <c:if test="${request.servletPath == '/admin/courses'}">active</c:if>" href="${pageContext.request.contextPath}/admin/courses">
                    <i class="fas fa-book"></i> Courses Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <c:if test="${request.servletPath == '/admin/orders'}">active</c:if>" href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart"></i> Order Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <c:if test="${request.servletPath == '/admin/revenue-analytics'}">active</c:if>" href="${pageContext.request.contextPath}/admin/revenue-analytics">
                    <i class="fas fa-chart-bar"></i> Revenue Analytics
                </a>
            </li>
             <li class="nav-item">
                <a class="nav-link <c:if test="${request.servletPath == '/teacher-performance'}">active</c:if>" href="${pageContext.request.contextPath}/teacher-performance">
                    <i class="fas fa-chart-line"></i> Teacher Performance
                </a>
            </li>
        </c:if>
    </ul>
</nav> 