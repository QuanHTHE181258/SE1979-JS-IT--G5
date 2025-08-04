<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>

<html>
<head>
    <title>Tạo giáo viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .invalid-feedback { display: block; }
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
                               pattern="^[a-zA-Z0-9_]{3,50}$" />
                        <div class="invalid-feedback">
                            Username phải có 3-50 ký tự, không chứa khoảng trắng, chỉ gồm chữ, số và dấu gạch dưới.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email <span class="text-danger">*</span></label>
                        <input type="email" name="email" id="email" class="form-control" required
                               pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" />
                        <div class="invalid-feedback">
                            Email không được chứa khoảng trắng và phải hợp lệ.
                        </div>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                        <input type="password" name="password" id="password" class="form-control" required
                               pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$" />
                        <div class="invalid-feedback">
                            Mật khẩu tối thiểu 6 ký tự, chứa chữ hoa, chữ thường, số và ký tự đặc biệt, không chứa khoảng trắng.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                        <input type="text" name="phone" id="phone" class="form-control" required
                               pattern="^0[0-9]{9,10}$" />
                        <div class="invalid-feedback">
                            Số điện thoại phải bắt đầu bằng 0 và có 10–11 chữ số.
                        </div>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Họ <span class="text-danger">*</span></label>
                        <input type="text" name="firstName" id="firstName" class="form-control" required
                               pattern="^[a-zA-ZÀ-ỹ\\s]{1,50}$" />
                        <div class="invalid-feedback">
                            Họ chỉ được chứa chữ cái và khoảng trắng, không để trống.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Tên <span class="text-danger">*</span></label>
                        <input type="text" name="lastName" id="lastName" class="form-control" required
                               pattern="^[a-zA-ZÀ-ỹ\\s]{1,50}$" />
                        <div class="invalid-feedback">
                            Tên chỉ được chứa chữ cái và khoảng trắng, không để trống.
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Ngày sinh <span class="text-danger">*</span></label>
                    <input type="date" name="dateOfBirth" id="dateOfBirth" class="form-control" required />
                    <div class="invalid-feedback">
                        Tuổi phải từ 18 đến 65, không được chọn ngày trong tương lai.
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
    (function () {
        'use strict';
        const form = document.getElementById('teacherForm');
        const inputs = form.querySelectorAll('input');

        // Xử lý ngày sinh
        const today = new Date();
        const maxDate = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());
        const minDate = new Date(today.getFullYear() - 65, today.getMonth(), today.getDate());
        const dateInput = document.getElementById('dateOfBirth');
        dateInput.max = maxDate.toISOString().split('T')[0];
        dateInput.min = minDate.toISOString().split('T')[0];

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

        function trimAndValidate(input) {
            input.value = input.value.trim();
            if (input.pattern && input.value.match(new RegExp(input.pattern))) {
                input.classList.remove('is-invalid');
                input.classList.add('is-valid');
            } else {
                input.classList.remove('is-valid');
                input.classList.add('is-invalid');
            }
        }

        inputs.forEach(function (input) {
            input.addEventListener('blur', function () {
                if (input.type !== 'date') {
                    trimAndValidate(input);
                } else {
                    validateDateOfBirth(input);
                }
            });
        });

        dateInput.addEventListener('change', function () {
            validateDateOfBirth(this);
            this.classList.toggle('is-valid', this.checkValidity());
            this.classList.toggle('is-invalid', !this.checkValidity());
        });

        form.addEventListener('submit', function (event) {
            let isFormValid = true;
            inputs.forEach(function (input) {
                input.value = input.value.trim();
                if (input.type === 'date') {
                    if (!validateDateOfBirth(input)) isFormValid = false;
                }
                if (!input.checkValidity()) {
                    isFormValid = false;
                    input.classList.add('is-invalid');
                    input.classList.remove('is-valid');
                } else {
                    input.classList.remove('is-invalid');
                    input.classList.add('is-valid');
                }
            });

            if (!isFormValid) {
                event.preventDefault();
                event.stopPropagation();
                const firstInvalid = form.querySelector(':invalid');
                if (firstInvalid) {
                    firstInvalid.focus();
                    firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            }
        });
    })();
</script>
</body>
</html>
