<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, maximum-scale=5.0">
    <title>Đăng nhập - TruyenMoi</title>
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

        /* Login Container */
        .login-container {
            width: 100%;
            max-width: 420px;
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

        .login-container::before {
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

        .login-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2.5rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .login-header::before {
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

        .login-header h2 {
            font-size: clamp(1.5rem, 4vw, 2rem);
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
        }

        .login-header i {
            font-size: 2rem;
            background: var(--vip-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            filter: drop-shadow(0 0 10px rgba(255, 215, 0, 0.8));
            margin-right: 0.75rem;
        }

        .login-header p {
            font-size: clamp(0.9rem, 3vw, 1rem);
            opacity: 0.9;
            margin-bottom: 0;
            position: relative;
            z-index: 1;
        }

        .login-body {
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
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 0.5rem;
            }

            .login-container {
                max-width: 100%;
                margin: 0;
            }

            .login-header {
                padding: 2rem 1.5rem;
            }

            .login-body {
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

            .form-check {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
            }

            .form-check > div:last-child {
                align-self: flex-end;
            }
        }

        @media (max-width: 576px) {
            .login-header {
                padding: 1.5rem 1rem;
            }

            .login-body {
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

            .login-header h2 {
                font-size: 1.5rem;
            }

            .login-header i {
                font-size: 1.5rem;
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
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h2>
                <i class="fas fa-book-open"></i>
                Đăng nhập TruyenMoi
            </h2>
            <p>🌟 Chào mừng bạn trở lại! 🌟</p>
        </div>
        
        <div class="login-body">
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
            
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
                <div class="mb-3">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope me-2"></i>Email
                    </label>
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="Nhập email của bạn" required value="${param.email}">
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">
                        <i class="fas fa-lock me-2"></i>Mật khẩu
                    </label>
                    <div class="password-container">
                        <input type="password" class="form-control" id="password" name="password" 
                               placeholder="Nhập mật khẩu" required>
                        <i class="fas fa-eye password-toggle" id="togglePassword"></i>
                    </div>
                </div>
                
                <div class="form-check">
                    <div class="d-flex align-items-center">
                        <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                        <label class="form-check-label" for="rememberMe">
                            Ghi nhớ đăng nhập
                        </label>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none small">
                            Quên mật khẩu?
                        </a>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary mb-3">
                    <i class="fas fa-sign-in-alt me-2"></i>
                    Đăng nhập
                </button>
                
                <div class="bottom-section">
                    <p>
                        Chưa có tài khoản? 
                        <a href="${pageContext.request.contextPath}/register" class="text-decoration-none">
                            Đăng ký ngay
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
        
        // Form validation with enhanced UX
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const submitBtn = this.querySelector('button[type="submit"]');
            
            // Validation
            if (!email || !password) {
                e.preventDefault();
                showAlert('Vui lòng nhập đầy đủ thông tin!', 'danger');
                return false;
            }
            
            if (!email.includes('@')) {
                e.preventDefault();
                showAlert('Email không hợp lệ!', 'danger');
                return false;
            }
            
            // Add loading state
            submitBtn.innerHTML = '<span class="loading-spinner"></span>Đang xử lý...';
            submitBtn.disabled = true;
            
            // Simulate processing time for better UX
            setTimeout(() => {
                // Form will be submitted normally
            }, 200);
        });
        
        // Enhanced alert system
        function showAlert(message, type) {
            // Remove existing alerts
            const existingAlerts = document.querySelectorAll('.alert');
            existingAlerts.forEach(alert => alert.remove());
            
    
            // Insert alert
            const loginBody = document.querySelector('.login-body');
            loginBody.insertBefore(alert, loginBody.firstChild);
            
            // Auto remove after 5 seconds
            setTimeout(() => {
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-20px)';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
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
                if (focusedElement.type === 'email' || focusedElement.type === 'password') {
                    const form = focusedElement.closest('form');
                    if (form) {
                        form.dispatchEvent(new Event('submit'));
                    }
                }
            }
        });
        
        // Add loading animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            const container = document.querySelector('.login-container');
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