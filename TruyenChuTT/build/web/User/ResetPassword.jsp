<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu - TruyenTT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
     <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>📚</text></svg>">

    <style>
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #7c3aed;
        }
        
        body {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Inter', sans-serif;
        }
        
        .reset-password-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
        }
        
        .reset-password-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .reset-password-body {
            padding: 2rem;
        }
        
        .form-control {
            border-radius: 10px;
            border: 2px solid #e5e7eb;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border: none;
            border-radius: 10px;
            padding: 0.75rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(79, 70, 229, 0.3);
        }
        
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6b7280;
        }
        
        .alert {
            border-radius: 10px;
            border: none;
        }
        
        .password-strength {
            height: 4px;
            border-radius: 2px;
            margin-top: 5px;
            transition: all 0.3s ease;
        }
        
        .strength-weak { background: #ef4444; }
        .strength-medium { background: #f59e0b; }
        .strength-strong { background: #10b981; }
    </style>
</head>
<body>
    <div class="reset-password-container">
        <div class="reset-password-header">
            <h2 class="mb-0">
                <i class="fas fa-key me-2"></i>
                Đặt lại mật khẩu
            </h2>
            <p class="mb-0 mt-2 opacity-75">Tạo mật khẩu mới cho tài khoản</p>
            <c:if test="${not empty email}">
                <small class="opacity-75">${email}</small>
            </c:if>
        </div>
        
        <div class="reset-password-body">
            <!-- Hiển thị thông báo -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${error}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/reset-password" method="post" id="resetPasswordForm">
                <input type="hidden" name="token" value="${token}">
                
                <div class="mb-3">
                    <label for="matKhauMoi" class="form-label">Mật khẩu mới *</label>
                    <div class="position-relative">
                        <input type="password" class="form-control" id="matKhauMoi" name="matKhauMoi" 
                               placeholder="Nhập mật khẩu mới (ít nhất 6 ký tự)" required>
                        <i class="fas fa-eye password-toggle" onclick="togglePassword('matKhauMoi', this)"></i>
                    </div>
                    <div class="password-strength" id="passwordStrength"></div>
                    <small class="text-muted">Mật khẩu phải có ít nhất 6 ký tự</small>
                </div>
                
                <div class="mb-3">
                    <label for="xacNhanMatKhau" class="form-label">Xác nhận mật khẩu *</label>
                    <div class="position-relative">
                        <input type="password" class="form-control" id="xacNhanMatKhau" name="xacNhanMatKhau" 
                               placeholder="Nhập lại mật khẩu mới" required>
                        <i class="fas fa-eye password-toggle" onclick="togglePassword('xacNhanMatKhau', this)"></i>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary w-100 mb-3">
                    <i class="fas fa-save me-2"></i>
                    Đặt lại mật khẩu
                </button>
                
                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/User/Login.jsp" class="text-decoration-none">
                        <i class="fas fa-arrow-left me-1"></i>
                        Quay lại đăng nhập
                    </a>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePassword(inputId, icon) {
            const input = document.getElementById(inputId);
            const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
            input.setAttribute('type', type);
            icon.classList.toggle('fa-eye');
            icon.classList.toggle('fa-eye-slash');
        }
        
        // Password strength indicator
        document.getElementById('matKhauMoi').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('passwordStrength');
            
            if (password.length === 0) {
                strengthBar.style.width = '0%';
                strengthBar.className = 'password-strength';
            } else if (password.length < 6) {
                strengthBar.style.width = '33%';
                strengthBar.className = 'password-strength strength-weak';
            } else if (password.length < 10) {
                strengthBar.style.width = '66%';
                strengthBar.className = 'password-strength strength-medium';
            } else {
                strengthBar.style.width = '100%';
                strengthBar.className = 'password-strength strength-strong';
            }
        });
        
        // Form validation
        document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
            const matKhauMoi = document.getElementById('matKhauMoi').value;
            const xacNhanMatKhau = document.getElementById('xacNhanMatKhau').value;
            
            if (!matKhauMoi || !xacNhanMatKhau) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin!');
                return false;
            }
            
            if (matKhauMoi.length < 6) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                return false;
            }
            
            if (matKhauMoi !== xacNhanMatKhau) {
                e.preventDefault();
                alert('Mật khẩu và xác nhận không khớp!');
                return false;
            }
        });
        
        // Real-time password confirmation check
        document.getElementById('xacNhanMatKhau').addEventListener('input', function() {
            const matKhauMoi = document.getElementById('matKhauMoi').value;
            const xacNhanMatKhau = this.value;
            
            if (xacNhanMatKhau && matKhauMoi !== xacNhanMatKhau) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
                this.classList.add('is-invalid');
            } else {
                this.setCustomValidity('');
                this.classList.remove('is-invalid');
            }
        });
    </script>
</body>
</html>
