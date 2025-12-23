<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - TruyenTT</title>
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
        
        .forgot-password-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
        }
        
        .forgot-password-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .forgot-password-body {
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
        
        .alert {
            border-radius: 10px;
            border: none;
        }
        
        .info-box {
            background: #f8f9fa;
            border-left: 4px solid var(--primary-color);
            padding: 1rem;
            border-radius: 0 10px 10px 0;
            margin: 1rem 0;
        }
    </style>
</head>
<body>
    <div class="forgot-password-container">
        <div class="forgot-password-header">
            <h2 class="mb-0">
                <i class="fas fa-unlock-alt me-2"></i>
                Quên mật khẩu
            </h2>
            <p class="mb-0 mt-2 opacity-75">Nhập email để nhận link đặt lại mật khẩu</p>
        </div>
        
        <div class="forgot-password-body">
            <!-- Hiển thị thông báo -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    ${success}
                </div>
            </c:if>
            
            <div class="info-box">
                <h6><i class="fas fa-info-circle me-2"></i>Hướng dẫn:</h6>
                <ul class="mb-0 small">
                    <li>Nhập email đã đăng ký tài khoản</li>
                    <li>Kiểm tra hộp thư (bao gồm thư mục spam)</li>
                    <li>Nhấp vào link trong email để đặt lại mật khẩu</li>
                    <li>Link có hiệu lực trong 15 phút</li>
                </ul>
            </div>
            
            <form action="${pageContext.request.contextPath}/forgot-password" method="post" id="forgotPasswordForm">
                <div class="mb-3">
                    <label for="email" class="form-label">Email đã đăng ký *</label>
                    <input type="email" class="form-control" id="email" name="email" 
                           placeholder="example@gmail.com" required value="${param.email}">
                    <small class="text-muted">Chỉ chấp nhận email @gmail.com</small>
                </div>
                
                <button type="submit" class="btn btn-primary w-100 mb-3">
                    <i class="fas fa-paper-plane me-2"></i>
                    Gửi link đặt lại mật khẩu
                </button>
                
                <div class="text-center">
                    <p class="mb-0">
                        Nhớ mật khẩu rồi? 
                        <a href="${pageContext.request.contextPath}/User/Login.jsp" class="text-decoration-none">
                            Đăng nhập ngay
                        </a>
                    </p>
                    <p class="mt-2">
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
        // Form validation
        document.getElementById('forgotPasswordForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value.trim();
            
            if (!email) {
                e.preventDefault();
                alert('Vui lòng nhập email!');
                return false;
            }
            
            if (!email.endsWith('@gmail.com')) {
                e.preventDefault();
                alert('Chỉ chấp nhận email @gmail.com!');
                return false;
            }
        });
        
        // Real-time email validation
        document.getElementById('email').addEventListener('blur', function() {
            const email = this.value.trim();
            if (email && !email.endsWith('@gmail.com')) {
                this.setCustomValidity('Chỉ chấp nhận email @gmail.com');
                this.classList.add('is-invalid');
            } else {
                this.setCustomValidity('');
                this.classList.remove('is-invalid');
            }
        });
    </script>
</body>
</html>
