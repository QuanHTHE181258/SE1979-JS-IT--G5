<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Learning</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">Online Learning</a>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/CourseController">Courses</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/blogs.jsp">Blogs</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/introduce.jsp">Introduce</a>
                        </li>
                    </ul>

                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/wishlist.jsp">
                                <i class="bi bi-heart"></i> Wishlist
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/cart.jsp">
                                <i class="bi bi-cart"></i> Cart
                            </a>
                        </li>

                        <c:choose>


                            <c:when test="${not empty sessionScope.user}">
                                <!-- Avatar + Welcome + Dropdown -->
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="userDropdown"
                                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <img src="<c:out value='${sessionScope.user.avatarUrl != null ? sessionScope.user.avatarUrl : "https://th.bing.com/th/id/OIP.-Zanaodp4hv0ry2WpuuPfgHaEf?rs=1&pid=ImgDetMain"}'/>"
                                             alt="Avatar" style="width:40px; height:40px; border-radius:50%; object-fit:cover; margin-right:8px;">

                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/${sessionScope.user.roleId == 2 ? 'teacher/profile' : 'profile'}">
                                                My Profile
                                            </a>
                                        </li>
                                        <c:if test="${sessionScope.user.roleId == 3}">
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/student/refund">
                                                    Refund Request
                                                </a>
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.roleId == 3}">
                                            <li>
                                                <a class="dropdown-item" href="myorder">
                                                    My Order
                                                </a>
                                            </li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.roleId == 1}">
                                            <li>
                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/dashBoard">
                                                    Admin DashBoard
                                                </a>
                                            </li>
                                        </c:if>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/login?action=logout">
                                                Logout
                                            </a>
                                        </li>
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

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    </body>
</html>
