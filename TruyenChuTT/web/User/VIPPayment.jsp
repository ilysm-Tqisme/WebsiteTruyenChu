<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán VIP - TruyenMoi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>📚</text></svg>">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --vip-gradient: linear-gradient(135deg, #ffd700 0%, #ffb347 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            
            --glass-bg: rgba(255, 255, 255, 0.25);
            --glass-border: rgba(255, 255, 255, 0.18);
            --vip-glass-bg: rgba(30, 30, 50, 0.4);
            --vip-glass-border: rgba(255, 215, 0, 0.3);
            --vip-shadow: 0 0 30px rgba(255, 215, 0, 0.3);
            
            --shadow-light: 0 8px 32px rgba(31, 38, 135, 0.37);
            --shadow-heavy: 0 25px 50px rgba(31, 38, 135, 0.5);
            --border-radius: 20px;
            --transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
        }

        body {
            font-family: 'Inter', 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 30%, #0f3460 60%, #533483 100%);
            background-attachment: fixed;
            min-height: 100vh;
            padding: 2rem 0;
            color: #fff;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 50%, rgba(255, 215, 0, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 183, 77, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 80%, rgba(255, 235, 59, 0.1) 0%, transparent 50%);
            animation: backgroundShift 20s ease-in-out infinite;
            z-index: -1;
        }

        @keyframes backgroundShift {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.8; }
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .payment-container {
            background: var(--vip-glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            border: 2px solid var(--vip-glass-border);
            box-shadow: var(--vip-shadow);
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

        .payment-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.1), transparent);
            animation: containerShimmer 4s ease-in-out infinite;
        }

        @keyframes containerShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .payment-header {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 30%, #533483 70%, #ffd700 100%);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .payment-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: headerShimmer 3s ease-in-out infinite;
        }

        @keyframes headerShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .payment-header h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
        }

        .payment-header p {
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.9);
            position: relative;
            z-index: 1;
        }

        .payment-header .crown-icon {
            color: #ffd700;
            filter: drop-shadow(0 0 15px rgba(255, 215, 0, 0.8));
            animation: crownFloat 3s ease-in-out infinite;
        }

        @keyframes crownFloat {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-10px) rotate(5deg); }
        }

        .payment-body {
            padding: 3rem 2.5rem;
            position: relative;
            z-index: 1;
        }

        .alert {
            border-radius: 15px;
            border: none;
            padding: 1rem 1.25rem;
            margin-bottom: 2rem;
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

        .alert i {
            margin-right: 0.75rem;
            font-size: 1.1rem;
        }

        .package-summary {
            background: rgba(255, 215, 0, 0.1);
            border: 2px solid rgba(255, 215, 0, 0.3);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2.5rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.15);
        }

        .package-summary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.1), transparent);
            animation: packageShimmer 3s ease-in-out infinite;
        }

        @keyframes packageShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .package-summary h4 {
            color: #fff;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            font-size: 1.5rem;
        }

        .package-summary h4 i {
            color: #ffd700;
            margin-right: 0.75rem;
            font-size: 1.8rem;
        }

        .package-details {
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 2rem;
            align-items: center;
        }

        .package-info p {
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 0.75rem;
            font-size: 1rem;
        }

        .package-info strong {
            color: #ffd700;
            font-weight: 600;
        }

        .package-price {
            text-align: right;
        }

        .package-price h3 {
            color: #ffd700;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0;
            text-shadow: 0 0 20px rgba(255, 215, 0, 0.5);
            animation: priceGlow 2s ease-in-out infinite;
        }

        @keyframes priceGlow {
            0%, 100% { text-shadow: 0 0 20px rgba(255, 215, 0, 0.5); }
            50% { text-shadow: 0 0 30px rgba(255, 215, 0, 0.8); }
        }

        .original-price {
            color: #ff6b6b;
            font-size: 1.2rem;
            text-decoration: line-through;
            opacity: 0.8;
        }

        .payment-methods-title {
            color: #fff;
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
        }

        .payment-methods-title i {
            color: #ffd700;
            margin-right: 0.5rem;
        }

        .payment-method {
            background: rgba(255, 255, 255, 0.05);
            border: 2px solid transparent;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .payment-method::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: var(--transition);
        }

        .payment-method:hover {
            border-color: rgba(255, 215, 0, 0.6);
            background: rgba(255, 215, 0, 0.1);
            transform: translateY(-2px);
        }

        .payment-method:hover::before {
            left: 100%;
        }

        .manual-transfer-highlight {
            background: rgba(255, 215, 0, 0.15);
            border: 2px solid rgba(255, 215, 0, 0.6);
            box-shadow: 0 0 25px rgba(255, 215, 0, 0.2);
        }

        .manual-transfer-highlight:hover {
            border-color: rgba(255, 215, 0, 0.8);
            box-shadow: 0 0 35px rgba(255, 215, 0, 0.4);
        }

        .payment-method-content {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .payment-icon {
            font-size: 2.5rem;
            flex-shrink: 0;
        }

        .payment-icon.bank {
            color: #ffd700;
            filter: drop-shadow(0 0 10px rgba(255, 215, 0, 0.5));
        }

        .payment-icon.disabled {
            color: #666;
        }

        .payment-info {
            flex-grow: 1;
        }

        .payment-info h6 {
            margin-bottom: 0.5rem;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .payment-info small {
            opacity: 0.8;
        }

        .payment-info .highlight {
            color: #ffd700;
            font-weight: 600;
        }

        .payment-info .disabled-text {
            color: #666;
        }

        .payment-action {
            flex-shrink: 0;
        }

        .continue-btn {
            background: var(--vip-gradient);
            color: #333;
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.4);
            position: relative;
            overflow: hidden;
        }

        .continue-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .continue-btn:hover {
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.6);
            color: #333;
        }

        .continue-btn:hover::before {
            left: 100%;
        }

        .disabled-method {
            opacity: 0.5;
            cursor: not-allowed;
            pointer-events: none;
        }

        .security-notice {
            text-align: center;
            margin-top: 2rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .security-notice small {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
        }

        .security-notice i {
            color: #4facfe;
            margin-right: 0.5rem;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-weight: 500;
            padding: 0.8rem 1.5rem;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 50px;
            transition: var(--transition);
            backdrop-filter: blur(10px);
            margin-top: 1.5rem;
        }

        .back-link:hover {
            color: #fff;
            border-color: rgba(255, 255, 255, 0.6);
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                margin: 1rem auto;
                padding: 0 1rem;
            }

            .payment-header {
                padding: 2rem 1.5rem;
            }

            .payment-header h2 {
                font-size: 2rem;
            }

            .payment-body {
                padding: 2rem 1.5rem;
            }

            .package-summary {
                padding: 1.5rem;
            }

            .package-details {
                grid-template-columns: 1fr;
                gap: 1.5rem;
                text-align: center;
            }

            .package-price {
                text-align: center;
            }

            .package-price h3 {
                font-size: 2rem;
            }

            .payment-method {
                padding: 1rem;
            }

            .payment-method-content {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }

            .payment-action {
                align-self: stretch;
            }

            .continue-btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .payment-header {
                padding: 1.5rem 1rem;
            }

            .payment-body {
                padding: 1.5rem 1rem;
            }

            .payment-header h2 {
                font-size: 1.8rem;
            }

            .package-summary h4 {
                font-size: 1.3rem;
            }

            .package-price h3 {
                font-size: 1.8rem;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="payment-container">
            <div class="payment-header">
                <h2><i class="fas fa-crown me-2 crown-icon"></i>Thanh toán gói VIP</h2>
                <p>Hoàn tất đăng ký để trở thành thành viên VIP và tận hưởng đặc quyền độc quyền</p>
            </div>

            <div class="payment-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i>
                        ${error}
                    </div>
                </c:if>

                <!-- Package Summary -->
                <div class="package-summary">
                    <h4><i class="fas fa-crown"></i>${goiVIP.tenGoi}</h4>
                    <div class="package-details">
                        <div class="package-info">
                            <p><strong>Thời hạn:</strong> ${goiVIP.soThang} tháng</p>
                            <p><strong>Mô tả:</strong> ${goiVIP.moTa}</p>
                            <p><strong>Đặc quyền:</strong> Đọc truyện VIP không giới hạn</p>
                        </div>
                        <div class="package-price">
                            <h3><fmt:formatNumber value="${goiVIP.gia}" type="currency" currencySymbol="" groupingUsed="true"/>₫</h3>
                            <c:if test="${goiVIP.hasDiscount()}">
                                <p class="original-price"><fmt:formatNumber value="${goiVIP.giaGoc}" type="currency" currencySymbol="" groupingUsed="true"/>₫</p>
                            </c:if>
                        </div>
                    </div>
                </div>

                <h5 class="payment-methods-title">
                    <i class="fas fa-credit-card"></i>
                    Chọn phương thức thanh toán:
                </h5>

                <!-- Manual Transfer Method (Highlighted) -->
                <div class="payment-method manual-transfer-highlight">
                    <div class="payment-method-content">
                        <i class="fas fa-university payment-icon bank"></i>
                        <div class="payment-info">
                            <h6 class="highlight">Chuyển khoản ngân hàng (Khuyên dùng)</h6>
                            <small>Thanh toán bằng cách chuyển khoản, admin sẽ xác nhận trong 24h. Phương thức an toàn và nhanh chóng nhất.</small>
                        </div>
                        <div class="payment-action">
                            <a href="${pageContext.request.contextPath}/vip/register?packageId=${goiVIP.id}&action=detail" 
                               class="continue-btn">
                                <i class="fas fa-arrow-right me-2"></i>Tiếp tục
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Other Payment Methods (Coming Soon) -->
                <div class="payment-method disabled-method">
                    <div class="payment-method-content">
                        <i class="fas fa-credit-card payment-icon disabled"></i>
                        <div class="payment-info">
                            <h6 class="disabled-text">VNPay</h6>
                            <small class="disabled-text">Sắp ra mắt - Thanh toán qua ví điện tử VNPay</small>
                        </div>
                        <div class="payment-action">
                            <span class="badge bg-secondary">Sắp ra mắt</span>
                        </div>
                    </div>
                </div>

                <div class="payment-method disabled-method">
                    <div class="payment-method-content">
                        <i class="fas fa-mobile-alt payment-icon disabled"></i>
                        <div class="payment-info">
                            <h6 class="disabled-text">MoMo</h6>
                            <small class="disabled-text">Sắp ra mắt - Thanh toán qua ví MoMo</small>
                        </div>
                        <div class="payment-action">
                            <span class="badge bg-secondary">Sắp ra mắt</span>
                        </div>
                    </div>
                </div>

                <div class="payment-method disabled-method">
                    <div class="payment-method-content">
                        <i class="fas fa-wallet payment-icon disabled"></i>
                        <div class="payment-info">
                            <h6 class="disabled-text">ZaloPay</h6>
                            <small class="disabled-text">Sắp ra mắt - Thanh toán qua ví ZaloPay</small>
                        </div>
                        <div class="payment-action">
                            <span class="badge bg-secondary">Sắp ra mắt</span>
                        </div>
                    </div>
                </div>

                <div class="security-notice">
                    <small>
                        <i class="fas fa-shield-alt"></i>
                        Thanh toán được bảo mật với công nghệ SSL 256-bit. Thông tin của bạn luôn được bảo vệ an toàn.
                    </small>
                </div>

                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/vip/register" class="back-link">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách gói
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Enhanced animations and interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Animate payment methods on load
            const paymentMethods = document.querySelectorAll('.payment-method');
            paymentMethods.forEach((method, index) => {
                method.style.opacity = '0';
                method.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    method.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                    method.style.opacity = '1';
                    method.style.transform = 'translateY(0)';
                }, 200 + (index * 100));
            });

            // Add click effects for continue button
            const continueBtn = document.querySelector('.continue-btn');
            if (continueBtn) {
                continueBtn.addEventListener('click', function(e) {
                    // Add loading state
                    const originalContent = this.innerHTML;
                    this.innerHTML = '<span class="loading-spinner"></span>Đang chuyển hướng...';
                    this.style.pointerEvents = 'none';
                    
                    // Reset after delay (in case navigation fails)
                    setTimeout(() => {
                        this.innerHTML = originalContent;
                        this.style.pointerEvents = 'auto';
                    }, 3000);
                });
            }

            // Enhanced hover effects for payment methods
            paymentMethods.forEach(method => {
                if (!method.classList.contains('disabled-method')) {
                    method.addEventListener('mouseenter', function() {
                        this.style.transform = 'translateY(-5px) scale(1.02)';
                        this.style.zIndex = '10';
                    });
                    
                    method.addEventListener('mouseleave', function() {
                        this.style.transform = '';
                        this.style.zIndex = '1';
                    });
                }
            });

            // Mobile touch effects
            if ('ontouchstart' in window) {
                paymentMethods.forEach(method => {
                    if (!method.classList.contains('disabled-method')) {
                        method.addEventListener('touchstart', function() {
                            this.style.transform = 'translateY(-2px) scale(1.01)';
                        });
                        
                        method.addEventListener('touchend', function() {
                            setTimeout(() => {
                                this.style.transform = '';
                            }, 150);
                        });
                    }
                });
            }

            // Animate package summary
            const packageSummary = document.querySelector('.package-summary');
            if (packageSummary) {
                packageSummary.style.opacity = '0';
                packageSummary.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    packageSummary.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
                    packageSummary.style.opacity = '1';
                    packageSummary.style.transform = 'translateY(0)';
                }, 100);
            }
        });

        // Add keyboard navigation
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                const focused = document.activeElement;
                if (focused.classList.contains('payment-method') && !focused.classList.contains('disabled-method')) {
                    const continueBtn = focused.querySelector('.continue-btn');
                    if (continueBtn) {
                        continueBtn.click();
                    }
                }
            }
        });
    </script>
</body>
</html>