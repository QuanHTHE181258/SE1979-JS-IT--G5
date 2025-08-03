<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>

<html>
<head>
    <title>Tạo giáo viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .invalid-feedback {
            display: block;
        }
        .form-control.is-invalid {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        .form-control.is-valid {
            border-color: #198754;
            box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25);
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/_admin_sidebar.jsp" />
<div class="container mt-5 mb-5">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Tạo tài khoản giáo viên</h4>
        </div>
        <div class="card-body">

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/admin/teachers/create" id="teacherForm" novalidate>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Username <span class="text-danger">*</span></label>
                        <input type="text" name="username" id="username" class="form-control" required
                               minlength="3" maxlength="50" pattern="^[a-zA-Z0-9_]+$" />
                        <div class="invalid-feedback">
                            Username phải có 3-50 ký tự và chỉ chứa chữ cái, số và dấu gạch dưới.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email <span class="text-danger">*</span></label>
                        <input type="email" name="email" id="email" class="form-control" required />
                        <div class="invalid-feedback">
                            Vui lòng nhập email hợp lệ.
                        </div>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                        <input type="password" name="password" id="password" class="form-control" required
                               minlength="6" maxlength="100" />
                        <div class="invalid-feedback">
                            Mật khẩu phải có ít nhất 6 ký tự.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" name="phone" id="phone" class="form-control"
                               pattern="^[0-9]{10,11}$" />
                        <div class="invalid-feedback">
                            Số điện thoại phải có 10-11 chữ số.
                        </div>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Họ <span class="text-danger">*</span></label>
                        <input type="text" name="firstName" id="firstName" class="form-control" required
                               minlength="1" maxlength="50" pattern="^[a-zA-ZÀ-ỹ\s]+$" />
                        <div class="invalid-feedback">
                            Họ chỉ được chứa chữ cái và khoảng trắng.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tên <span class="text-danger">*</span></label>
                        <input type="text" name="lastName" id="lastName" class="form-control" required
                               minlength="1" maxlength="50" pattern="^[a-zA-ZÀ-ỹ\s]+$" />
                        <div class="invalid-feedback">
                            Tên chỉ được chứa chữ cái và khoảng trắng.
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Ngày sinh <span class="text-danger">*</span></label>
                    <input type="date" name="dateOfBirth" id="dateOfBirth" class="form-control" required />
                    <div class="invalid-feedback">
                        Vui lòng chọn ngày sinh hợp lệ.
                    </div>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-success">Tạo giáo viên</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (function() {
        'use strict';

        // Lấy form
        const form = document.getElementById('teacherForm');
        const inputs = form.querySelectorAll('input[required], input[pattern]');

        // Thiết lập ngày tối đa (18 tuổi) và tối thiểu (65 tuổi)
        const today = new Date();
        const maxDate = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());
        const minDate = new Date(today.getFullYear() - 65, today.getMonth(), today.getDate());

        const dateInput = document.getElementById('dateOfBirth');
        dateInput.max = maxDate.toISOString().split('T')[0];
        dateInput.min = minDate.toISOString().split('T')[0];

        // Validate ngày sinh
        function validateDateOfBirth(input) {
            const selectedDate = new Date(input.value);
            let age = today.getFullYear() - selectedDate.getFullYear();
            const monthDiff = today.getMonth() - selectedDate.getMonth();

            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < selectedDate.getDate())) {
                age--;
            }

            if (age < 18 || age > 65) {
                input.setCustomValidity('Tuổi phải từ 18 đến 65');
                return false;
            } else {
                input.setCustomValidity('');
                return true;
            }
        }

        // Validate real-time cho từng input
        inputs.forEach(function(input) {
            input.addEventListener('input', function() {
                validateInput(this);
            });

            input.addEventListener('blur', function() {
                validateInput(this);
            });
        });

        // Validate ngày sinh
        dateInput.addEventListener('change', function() {
            validateDateOfBirth(this);
            validateInput(this);
        });

        function validateInput(input) {
            const isValid = input.checkValidity();

            if (isValid) {
                input.classList.remove('is-invalid');
                input.classList.add('is-valid');
            } else {
                input.classList.remove('is-valid');
                input.classList.add('is-invalid');
            }
        }

        // Validate khi submit form
        form.addEventListener('submit', function(event) {
            let isFormValid = true;

            // Kiểm tra tất cả inputs
            inputs.forEach(function(input) {
                if (input.id === 'dateOfBirth') {
                    if (!validateDateOfBirth(input)) {
                        isFormValid = false;
                    }
                }

                if (!input.checkValidity()) {
                    isFormValid = false;
                    input.classList.add('is-invalid');
                    input.classList.remove('is-valid');
                } else {
                    input.classList.add('is-valid');
                    input.classList.remove('is-invalid');
                }
            });

            // Kiểm tra username unique (có thể gọi AJAX để check)
            const usernameInput = document.getElementById('username');
            if (usernameInput.value.length > 0) {
                // Có thể thêm AJAX call ở đây để kiểm tra username đã tồn tại chưa
            }

            // Kiểm tra email unique (có thể gọi AJAX để check)
            const emailInput = document.getElementById('email');
            if (emailInput.value.length > 0) {
                // Có thể thêm AJAX call ở đây để kiểm tra email đã tồn tại chưa
            }

            if (!isFormValid) {
                event.preventDefault();
                event.stopPropagation();

                // Scroll đến input đầu tiên có lỗi
                const firstInvalid = form.querySelector(':invalid');
                if (firstInvalid) {
                    firstInvalid.focus();
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }

            form.classList.add('was-validated');
        });

    })();
</script>
</body>
</html>