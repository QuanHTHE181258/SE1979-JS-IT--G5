<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.userRole != '4'}">
    <nav class="thanh-quantri">
        <div class="thanh-logo">
            <i class="fas fa-graduation-cap"></i>
            <span>Bảng điều khiển quản trị</span>
        </div>

        <ul class="danh-sach-menu">
            <li class="muc-menu">
                <a class="duong-dan ${param.active == 'dashboard' ? 'dang-chon' : ''}"
                   href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Trang tổng quan</span>
                </a>
            </li>

            <li class="phan-menu">
                <span class="ten-phan">Quản lý</span>
            </li>

            <li class="muc-menu">
                <a class="duong-dan ${param.active == 'courses' ? 'dang-chon' : ''}"
                   href="${pageContext.request.contextPath}/admin/courses">
                    <i class="fas fa-book"></i>
                    <span>Khóa học</span>
                </a>
            </li>

            <li class="muc-menu">
                <a class="duong-dan ${param.active == 'orders' ? 'dang-chon' : ''}"
                   href="${pageContext.request.contextPath}/admin/orders">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Đơn hàng</span>
                </a>
            </li>

            <li class="muc-menu">
                <a class="duong-dan ${param.active == 'users' ? 'dang-chon' : ''}"
                   href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users"></i>
                    <span>Người dùng</span>
                </a>
            </li>
            <li class="muc-menu">
                <a class="duong-dan ${param.active == 'users' ? 'dang-chon' : ''}"
                   href="${pageContext.request.contextPath}/admin/revenue-analytics">
                    <i class="fas fa-chart-line"></i>
                    <span>Doanh thu</span>
                </a>
            </li>
            <li class="muc-menu">
                <a class="duong-dan ${param.active == 'users' ? 'dang-chon' : ''}"
                   href="${pageContext.request.contextPath}/admin/blog/list">
                    <i class="fas fa-blog"></i>
                    <span>Bài viết</span>
                </a>
            </li>
        </ul>
    </nav>

    <style>
        :root {
            --menu-rong: 280px;
            --nen-menu: #2c3e50;
            --mau-hover: #34495e;
            --mau-chu: #ecf0f1;
            --chu-mo: #95a5a6;
            --mau-nhan: #3498db;
        }

        .thanh-quantri {
            position: fixed;
            left: 0;
            top: 70px;
            width: var(--menu-rong);
            height: calc(100vh - 70px);
            background: var(--nen-menu);
            color: var(--mau-chu);
            overflow-y: auto;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        }

        .thanh-logo {
            padding: 1.5rem 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--mau-chu);
            border-bottom: 1px solid rgba(255,255,255,0.1);
            background: linear-gradient(to right, var(--nen-menu), var(--mau-hover));
        }

        .thanh-logo i {
            font-size: 1.8rem;
            color: var(--mau-nhan);
        }

        .danh-sach-menu {
            padding: 1.5rem 0;
            list-style: none;
            margin: 0;
        }

        .phan-menu {
            padding: 1.5rem 2rem 0.75rem;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--chu-mo);
            font-weight: 600;
        }

        .muc-menu {
            margin: 4px 1rem;
        }

        .duong-dan {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.5rem;
            color: var(--mau-chu) !important;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
            font-size: 1rem;
        }

        .duong-dan i {
            width: 24px;
            text-align: center;
            font-size: 1.2rem;
        }

        .duong-dan:hover {
            background: var(--mau-hover);
            transform: translateX(4px);
            padding-left: 2rem;
        }

        .duong-dan.dang-chon {
            background: var(--mau-nhan);
            color: white !important;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        .duong-dan.dang-chon:hover {
            background: #2980b9;
            transform: translateX(4px) scale(1.02);
        }

        .thanh-quantri::-webkit-scrollbar {
            width: 6px;
        }

        .thanh-quantri::-webkit-scrollbar-track {
            background: var(--nen-menu);
        }

        .thanh-quantri::-webkit-scrollbar-thumb {
            background: var(--mau-hover);
            border-radius: 3px;
        }

        .thanh-quantri::-webkit-scrollbar-thumb:hover {
            background: var(--mau-nhan);
        }

        .noi-dung-chinh {
            margin-left: var(--menu-rong);
            padding: 2rem;
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const duongDans = document.querySelectorAll('.duong-dan');
            duongDans.forEach(link => {
                link.addEventListener('mouseenter', e => {
                    e.target.style.transform = 'translateX(4px)';
                });
                link.addEventListener('mouseleave', e => {
                    if (!e.target.classList.contains('dang-chon')) {
                        e.target.style.transform = 'translateX(0)';
                    }
                });
            });
        });
    </script>
</c:if>
