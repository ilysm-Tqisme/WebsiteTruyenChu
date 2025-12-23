<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, maximum-scale=5.0">
    <title>Đăng ký - TruyenMoi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>📚</text></svg>">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --vip-gradient: linear-gradient(135deg, #ffd700 0%, #ffb347 100%);
            --error-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e53 100%);
            
            --glass-bg: rgba(255, 255, 255, 0.25);
            --glass-border: rgba(255, 255, 255, 0.18);
            --shadow-light: 0 8px 32px rgba(31, 38, 135, 0.37);
            --shadow-medium: 0 15px 35px rgba(31, 38, 135, 0.4);
            --shadow-heavy: 0 25px 50px rgba(31, 38, 135, 0.5);
            
            --border-radius: 20px;
            --transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            margin: 0;
            overflow-x: hidden;
        }

        /* Animated background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 50%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 40% 80%, rgba(120, 219, 226, 0.3) 0%, transparent 50%);
            animation: backgroundShift 20s ease-in-out infinite;
            z-index: -1;
        }

        @keyframes backgroundShift {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.8; }
        }

        /* Register Container */
        .register-container {
            width: 100%;
            max-width: 520px;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-heavy);
            border: 1px solid var(--glass-border);
            overflow: hidden;
            position: relative;
            animation: slideInUp 0.8s ease-out;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .register-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.08) 0%, transparent 70%);
            animation: rotate 30s linear infinite;
            pointer-events: none;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .register-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2.5rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .register-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: shimmer 3s ease-in-out infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .register-header h2 {
            font-size: clamp(1.5rem, 4vw, 2rem);
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
        }

        .register-header i {
            font-size: 2rem;
            background: var(--vip-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            filter: drop-shadow(0 0 10px rgba(255, 215, 0, 0.8));
            margin-right: 0.75rem;
        }

        .register-header p {
            font-size: clamp(0.9rem, 3vw, 1rem);
            opacity: 0.9;
            margin-bottom: 0;
            position: relative;
            z-index: 1;
        }

        .register-body {
            padding: 2.5rem 2rem;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            position: relative;
            z-index: 1;
        }

        /* Form Styling */
        .form-label {
            color: #fff;
            font-weight: 600;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
        }

        .form-label .text-danger {
            color: #ff6b6b !important;
            text-shadow: 0 0 5px rgba(255, 107, 107, 0.5);
        }

        .form-control {
            border-radius: 15px;
            border: 2px solid var(--glass-border);
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            padding: 1rem 1.25rem;
            transition: var(--transition);
            font-size: 1rem;
            color: #333;
            box-shadow: var(--shadow-light);
        }

        .form-control::placeholder {
            color: #666;
            opacity: 0.8;
        }

        .form-control:focus {
            border-color: rgba(255, 255, 255, 0.6);
            box-shadow: 0 0 0 4px rgba(255, 255, 255, 0.2), var(--shadow-medium);
            outline: none;
            background: white;
            transform: translateY(-2px);
        }

        .form-control:hover {
            border-color: rgba(255, 255, 255, 0.4);
            background: white;
            transform: translateY(-1px);
        }

        .form-control.is-invalid {
            border-color: #ff6b6b;
            box-shadow: 0 0 0 4px rgba(255, 107, 107, 0.2);
        }

        /* Password Toggle */
        .password-container {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 1.25rem;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #666;
            font-size: 1.1rem;
            transition: var(--transition);
            z-index: 10;
        }

        .password-toggle:hover {
            color: #333;
            transform: translateY(-50%) scale(1.1);
        }

        /* Password Strength Indicator */
        .password-strength {
            height: 4px;
            border-radius: 2px;
            margin-top: 8px;
            transition: var(--transition);
            background: rgba(255, 255, 255, 0.2);
            overflow: hidden;
            position: relative;
        }

        .password-strength::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            width: 0%;
            border-radius: 2px;
            transition: var(--transition);
        }

        .strength-weak::before {
            background: var(--error-gradient);
            width: 33%;
        }

        .strength-medium::before {
            background: var(--warning-gradient);
            width: 66%;
        }

        .strength-strong::before {
            background: var(--success-gradient);
            width: 100%;
        }

        /* Button Styling */
        .btn-primary {
            background: var(--primary-gradient);
            border: none;
            border-radius: 15px;
            padding: 1rem 2rem;
            font-weight: 600;
            font-size: 1rem;
            color: white;
            transition: var(--transition);
            box-shadow: var(--shadow-medium);
            position: relative;
            overflow: hidden;
            width: 100%;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: var(--shadow-heavy);
            background: var(--primary-gradient);
        }

        .btn-primary:active {
            transform: translateY(-1px) scale(0.98);
        }

        /* Checkbox Styling */
        .form-check {
            margin-bottom: 1.5rem;
        }

        .form-check-input {
            width: 1.2rem;
            height: 1.2rem;
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid var(--glass-border);
            border-radius: 6px;
            transition: var(--transition);
        }

        .form-check-input:checked {
            background: var(--primary-gradient);
            border-color: transparent;
        }

        .form-check-input:focus {
            box-shadow: 0 0 0 4px rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.6);
        }

        .form-check-label {
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
            margin-left: 0.5rem;
            font-size: 0.9rem;
            line-height: 1.4;
        }

        /* Links */
        .text-decoration-none {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            transition: var(--transition);
            font-weight: 500;
            position: relative;
        }

        .text-decoration-none::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -2px;
            left: 0;
            background: var(--vip-gradient);
            transition: var(--transition);
        }

        .text-decoration-none:hover::after {
            width: 100%;
        }

        .text-decoration-none:hover {
            color: #ffd700;
            text-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
        }

        /* Alert Styling */
        .alert {
            border-radius: 15px;
            border: none;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow-light);
            animation: slideInDown 0.5s ease-out;
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-danger {
            background: rgba(255, 107, 107, 0.2);
            color: #fff;
            border: 1px solid rgba(255, 107, 107, 0.3);
        }

        .alert-success {
            background: rgba(79, 172, 254, 0.2);
            color: #fff;
            border: 1px solid rgba(79, 172, 254, 0.3);
        }

        .alert i {
            margin-right: 0.75rem;
            font-size: 1.1rem;
        }

        /* Bottom Section */
        .bottom-section {
            text-align: center;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .bottom-section p {
            margin-bottom: 0.75rem;
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.95rem;
        }

        .bottom-section a {
            font-size: 0.9rem;
        }

        /* Small text styling */
        .text-muted {
            color: rgba(255, 255, 255, 0.7) !important;
            font-size: 0.8rem;
            margin-top: 0.5rem;
            display: block;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 0.5rem;
            }

            .register-container {
                max-width: 100%;
                margin: 0;
            }

            .register-header {
                padding: 2rem 1.5rem;
            }

            .register-body {
                padding: 2rem 1.5rem;
            }

            .form-control {
                padding: 0.9rem 1rem;
                font-size: 0.95rem;
            }

            .btn-primary {
                padding: 0.9rem 1.5rem;
                font-size: 0.95rem;
            }

            .password-toggle {
                right: 1rem;
            }
        }

        @media (max-width: 576px) {
            .register-header {
                padding: 1.5rem 1rem;
            }

            .register-body {
                padding: 1.5rem 1rem;
            }

            .form-control {
                padding: 0.8rem 1rem;
                font-size: 0.9rem;
            }

            .btn-primary {
                padding: 0.8rem 1.25rem;
                font-size: 0.9rem;
            }

            .register-header h2 {
                font-size: 1.5rem;
            }

            .register-header i {
                font-size: 1.5rem;
            }

            .form-check-label {
                font-size: 0.85rem;
            }
        }

        /* Loading Animation */
        .loading-spinner {
            display: inline-block;
            width: 18px;
            height: 18px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
            margin-right: 0.5rem;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Focus improvements for accessibility */
        .form-control:focus,
        .form-check-input:focus,
        .btn-primary:focus {
            outline: 2px solid rgba(255, 255, 255, 0.8);
            outline-offset: 2px;
        }

        /* Enhanced validation styling */
        .invalid-feedback {
            color: #ff6b6b;
            font-size: 0.8rem;
            margin-top: 0.5rem;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        }

        .was-validated .form-control:invalid {
            border-color: #ff6b6b;
            box-shadow: 0 0 0 4px rgba(255, 107, 107, 0.2);
        }

        .was-validated .form-control:valid {
            border-color: #10b981;
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.2);
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h2>
                <i class="fas fa-user-plus"></i>
                Đăng ký TruyenMoi
            </h2>
            <p>🌟 Tạo tài khoản mới để bắt đầu đọc truyện! 🌟</p>
        </div>
        
        <div class="register-body">
            <!-- Hiển thị thông báo lỗi -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <!-- Hiển thị thông báo thành công -->
            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle"></i>
                    ${success}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" novalidate>
                <div class="mb-3">
                    <label for="fullName" class="form-label">
                        <i class="fas fa-user me-2"></i>Họ và tên <span class="text-danger">*</span>
                    </label>
                    <input type="text" class="form-control" id="fullName" name="fullName" 
                           placeholder="Nhập họ và tên của bạn" required value="${param.fullName}">
                    <div class="invalid-feedback">
                        Vui lòng nhập họ và tên.
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope me-2"></i>Email <span class="text-danger">*</span>
                    </label>
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="Nhập địa chỉ email của bạn" required value="${param.email}">
                    <div class="invalid-feedback">
                        Vui lòng nhập địa chỉ email hợp lệ.
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="phone" class="form-label">
                        <i class="fas fa-phone me-2"></i>Số điện thoại
                    </label>
                    <input type="tel" class="form-control" id="phone" name="phone" 
                           placeholder="Nhập số điện thoại (tùy chọn)" value="${param.phone}">
                    <small class="text-muted">Số điện thoại giúp bảo mật tài khoản tốt hơn</small>
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">
                        <i class="fas fa-lock me-2"></i>Mật khẩu <span class="text-danger">*</span>
                    </label>
                    <div class="password-container">
                        <input type="password" class="form-control" id="password" name="password" 
                               placeholder="Nhập mật khẩu (ít nhất 6 ký tự)" required>
                        <i class="fas fa-eye password-toggle" id="togglePassword"></i>
                    </div>
                    <div class="password-strength" id="passwordStrength"></div>
                    <small class="text-muted">Mật khẩu phải có ít nhất 6 ký tự để đảm bảo bảo mật</small>
                    <div class="invalid-feedback">
                        Mật khẩu phải có ít nhất 6 ký tự.
                    </div>
                </div>
                
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">
                        <i class="fas fa-lock me-2"></i>Xác nhận mật khẩu <span class="text-danger">*</span>
                    </label>
                    <div class="password-container">
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                               placeholder="Nhập lại mật khẩu để xác nhận" required>
                        <i class="fas fa-eye password-toggle" id="toggleConfirmPassword"></i>
                    </div>
                    <div class="invalid-feedback">
                        Mật khẩu xác nhận không khớp.
                    </div>
                </div>
                
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="agreeTerms" required>
                    <label class="form-check-label" for="agreeTerms">
                        Tôi đồng ý với <a href="#" class="text-decoration-none">Điều khoản sử dụng</a> 
                        và <a href="#" class="text-decoration-none">Chính sách bảo mật</a> của TruyenMoi
                    </label>
                    <div class="invalid-feedback">
                        Bạn phải đồng ý với điều khoản sử dụng để tiếp tục.
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary mb-3">
                    <i class="fas fa-user-plus me-2"></i>
                    Tạo tài khoản
                </button>
                
                <div class="bottom-section">
                    <p>
                        Đã có tài khoản? 
                        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                            Đăng nhập ngay
                        </a>
                    </p>
                    <p>
                        <a href="${pageContext.request.contextPath}/" class="text-decoration-none">
                            <i class="fas fa-home me-1"></i>
                            Về trang chủ
                        </a>
                    </p>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Enhanced JavaScript with modern features and improved UX
        
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
            
            // Add smooth transition effect
            this.style.transform = 'translateY(-50%) scale(1.2)';
            setTimeout(() => {
                this.style.transform = 'translateY(-50%) scale(1)';
            }, 150);
        });
        
        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const confirmPassword = document.getElementById('confirmPassword');
            const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
            confirmPassword.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
            
            // Add smooth transition effect
            this.style.transform = 'translateY(-50%) scale(1.2)';
            setTimeout(() => {
                this.style.transform = 'translateY(-50%) scale(1)';
            }, 150);
        });
        
        // Enhanced password strength indicator
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('passwordStrength');
            
            // Remove all strength classes
            strengthBar.classList.remove('strength-weak', 'strength-medium', 'strength-strong');
            
            if (password.length === 0) {
                strengthBar.classList.remove('strength-weak', 'strength-medium', 'strength-strong');
            } else if (password.length < 6) {
                strengthBar.classList.add('strength-weak');
            } else if (password.length < 10 || !/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(password)) {
                strengthBar.classList.add('strength-medium');
            } else {
                strengthBar.classList.add('strength-strong');
            }
        });
        
        // Enhanced form validation with better UX
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const form = this;
            const fullName = document.getElementById('fullName').value.trim();
            const email = document.getElementById('email').value.trim();
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const agreeTerms = document.getElementById('agreeTerms').checked;
            const submitBtn = form.querySelector('button[type="submit"]');
            
            // Reset validation state
            form.classList.remove('was-validated');
            
            let isValid = true;
            
            // Validate required fields
            if (!fullName) {
                showFieldError('fullName', 'Vui lòng nhập họ và tên.');
                isValid = false;
            } else if (fullName.length < 2) {
                showFieldError('fullName', 'Họ và tên phải có ít nhất 2 ký tự.');
                isValid = false;
            }
            
            // Validate email format
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!email) {
                showFieldError('email', 'Vui lòng nhập địa chỉ email.');
                isValid = false;
            } else if (!emailRegex.test(email)) {
                showFieldError('email', 'Địa chỉ email không hợp lệ.');
                isValid = false;
            }
            
            // Validate password
            if (!password) {
                showFieldError('password', 'Vui lòng nhập mật khẩu.');
                isValid = false;
            } else if (password.length < 6) {
                showFieldError('password', 'Mật khẩu phải có ít nhất 6 ký tự.');
                isValid = false;
            }
            
            // Validate password confirmation
            if (!confirmPassword) {
                showFieldError('confirmPassword', 'Vui lòng xác nhận mật khẩu.');
                isValid = false;
            } else if (password !== confirmPassword) {
                showFieldError('confirmPassword', 'Mật khẩu xác nhận không khớp.');
                isValid = false;
            }
            
            // Validate terms agreement
            if (!agreeTerms) {
                showAlert('Bạn phải đồng ý với điều khoản sử dụng để tiếp tục!', 'danger');
                isValid = false;
            }
            
            if (!isValid) {
                e.preventDefault();
                form.classList.add('was-validated');
                return false;
            }
            
            // Add loading state
            submitBtn.innerHTML = '<span class="loading-spinner"></span>Đang tạo tài khoản...';
            submitBtn.disabled = true;
            
            // Simulate processing time for better UX
            setTimeout(() => {
                // Form will be submitted normally
            }, 200);
        });
        
        // Real-time password confirmation check
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('password').value;
            const confirmPassword = this.value;
            
            if (confirmPassword && password !== confirmPassword) {
                this.setCustomValidity('Mật khẩu xác nhận không khớp');
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
            } else if (confirmPassword && password === confirmPassword) {
                this.setCustomValidity('');
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else {
                this.setCustomValidity('');
                this.classList.remove('is-invalid', 'is-valid');
            }
        });
        
        // Real-time validation for other fields
        document.getElementById('fullName').addEventListener('input', function() {
            const value = this.value.trim();
            if (value.length >= 2) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else if (value.length > 0) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
            } else {
                this.classList.remove('is-invalid', 'is-valid');
            }
        });
        
        document.getElementById('email').addEventListener('input', function() {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const value = this.value.trim();
            if (value && emailRegex.test(value)) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else if (value) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
            } else {
                this.classList.remove('is-invalid', 'is-valid');
            }
        });
        
        document.getElementById('password').addEventListener('input', function() {
            const value = this.value;
            const confirmPassword = document.getElementById('confirmPassword');
            
            if (value.length >= 6) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else if (value.length > 0) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
            } else {
                this.classList.remove('is-invalid', 'is-valid');
            }
            
            // Recheck confirm password
            if (confirmPassword.value) {
                confirmPassword.dispatchEvent(new Event('input'));
            }
        });
        
        // Enhanced alert system
        function showAlert(message, type) {
            // Remove existing alerts
            const existingAlerts = document.querySelectorAll('.alert');
            existingAlerts.forEach(alert => alert.remove());
        
            
            // Insert alert
            const registerBody = document.querySelector('.register-body');
            registerBody.insertBefore(alert, registerBody.firstChild);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-20px)';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
        }
        
        // Show field-specific error
        function showFieldError(fieldId, message) {
            const field = document.getElementById(fieldId);
            field.classList.add('is-invalid');
            
            // Update or create invalid feedback
            let feedback = field.parentNode.querySelector('.invalid-feedback');
            if (feedback) {
                feedback.textContent = message;
            }
        }
        
        // Add smooth focus transitions
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'translateY(-2px)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'translateY(0)';
            });
        });
        
        // Keyboard navigation improvements
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                const focusedElement = document.activeElement;
                if (focusedElement.type === 'text' || focusedElement.type === 'email' || 
                    focusedElement.type === 'tel' || focusedElement.type === 'password') {
                    const form = focusedElement.closest('form');
                    if (form) {
                        // Move to next input or submit
                        const inputs = Array.from(form.querySelectorAll('input[required], input[type="checkbox"]'));
                        const currentIndex = inputs.indexOf(focusedElement);
                        if (currentIndex < inputs.length - 1) {
                            inputs[currentIndex + 1].focus();
                        } else {
                            form.dispatchEvent(new Event('submit'));
                        }
                    }
                }
            }
        });
        
        // Add loading animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            const container = document.querySelector('.register-container');
            container.style.opacity = '0';
            container.style.transform = 'translateY(40px)';
            
            setTimeout(() => {
                container.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
                container.style.opacity = '1';
                container.style.transform = 'translateY(0)';
            }, 100);
        });
        
        // Improve mobile experience
        if ('ontouchstart' in window) {
            document.querySelectorAll('.btn-primary, .text-decoration-none').forEach(element => {
                element.addEventListener('touchstart', function() {
                    this.style.transform = this.classList.contains('btn-primary') ? 
                        'translateY(-2px) scale(1.01)' : 'scale(1.05)';
                });
                
                element.addEventListener('touchend', function() {
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                });
            });
        }
    </script>
</body>
</html>