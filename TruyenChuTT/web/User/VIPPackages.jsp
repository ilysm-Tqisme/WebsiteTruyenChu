<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gói VIP - TruyenMoi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>📚</text></svg>">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --vip-gradient: linear-gradient(135deg, #ffd700 0%, #ffb347 100%);
            --premium-gradient: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            --platinum-gradient: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            
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
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .page-header {
            text-align: center;
            margin-bottom: 4rem;
            position: relative;
        }

        .page-header h1 {
            font-size: 3rem;
            font-weight: 700;
            background: var(--vip-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1rem;
            text-shadow: 0 4px 20px rgba(255, 215, 0, 0.5);
            animation: titleGlow 3s ease-in-out infinite;
        }

        @keyframes titleGlow {
            0%, 100% { filter: drop-shadow(0 0 20px rgba(255, 215, 0, 0.5)); }
            50% { filter: drop-shadow(0 0 30px rgba(255, 215, 0, 0.8)); }
        }

        .page-header p {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.8);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .vip-packages-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .vip-package-card {
            background: var(--vip-glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            border: 2px solid var(--vip-glass-border);
            box-shadow: var(--vip-shadow);
            padding: 2.5rem;
            text-align: center;
            position: relative;
            overflow: hidden;
            transition: var(--transition);
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

        .vip-package-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 0 40px rgba(255, 215, 0, 0.6);
            border-color: rgba(255, 215, 0, 0.8);
        }

        .vip-package-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.1), transparent);
            transition: var(--transition);
        }

        .vip-package-card:hover::before {
            left: 100%;
        }

        .vip-package-card.featured {
            border-color: #ffd700;
            box-shadow: 0 0 40px rgba(255, 215, 0, 0.5);
            transform: scale(1.05);
        }

        .vip-package-card.featured::after {
            content: 'PHỔ BIẾN NHẤT';
            position: absolute;
            top: -15px;
            right: 20px;
            background: var(--vip-gradient);
            color: #333;
            padding: 0.5rem 1.5rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.4);
        }

        .package-icon {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            background: var(--vip-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            filter: drop-shadow(0 0 15px rgba(255, 215, 0, 0.8));
            animation: iconFloat 3s ease-in-out infinite;
        }

        @keyframes iconFloat {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-10px) rotate(5deg); }
        }

        .package-name {
            font-size: 2rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 1rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .package-price {
            font-size: 3rem;
            font-weight: 800;
            color: #ffd700;
            margin-bottom: 0.5rem;
            text-shadow: 0 0 20px rgba(255, 215, 0, 0.5);
        }

        .package-duration {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .package-features {
            list-style: none;
            padding: 0;
            margin: 2rem 0;
        }

        .package-features li {
            padding: 0.8rem 0;
            display: flex;
            align-items: center;
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.9);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            transition: var(--transition);
        }

        .package-features li:hover {
            color: #ffd700;
            padding-left: 10px;
        }

        .package-features li i {
            color: #ffd700;
            margin-right: 1rem;
            font-size: 1.2rem;
        }

        .package-btn {
            width: 100%;
            background: var(--vip-gradient);
            color: #333;
            border: none;
            padding: 1.2rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            text-decoration: none;
            display: inline-block;
            transition: var(--transition);
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.4);
            position: relative;
            overflow: hidden;
            margin-top: 1rem;
        }

        .package-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .package-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 215, 0, 0.6);
            color: #333;
        }

        .package-btn:hover::before {
            left: 100%;
        }

        .benefits-section {
            background: var(--vip-glass-bg);
            border: 2px solid var(--vip-glass-border);
            border-radius: var(--border-radius);
            padding: 3rem;
            margin: 3rem 0;
            text-align: center;
            box-shadow: var(--vip-shadow);
            position: relative;
            overflow: hidden;
        }

        .benefits-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.1), transparent);
            animation: benefitShimmer 4s ease-in-out infinite;
        }

        @keyframes benefitShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .benefits-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffd700;
            margin-bottom: 2rem;
            text-shadow: 0 0 20px rgba(255, 215, 0, 0.5);
        }

        .benefits-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .benefit-item {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 2rem;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .benefit-item:hover {
            background: rgba(255, 215, 0, 0.15);
            transform: translateY(-5px);
        }

        .benefit-item i {
            font-size: 3rem;
            color: #ffd700;
            margin-bottom: 1rem;
            display: block;
        }

        .benefit-item h4 {
            color: #fff;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .benefit-item p {
            color: rgba(255, 255, 255, 0.8);
            line-height: 1.6;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-weight: 500;
            padding: 1rem 2rem;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 50px;
            transition: var(--transition);
            backdrop-filter: blur(10px);
            margin-top: 2rem;
        }

        .back-link:hover {
            color: #fff;
            border-color: rgba(255, 255, 255, 0.6);
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        .alert {
            border-radius: 15px;
            border: none;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 2.5rem;
            }

            .vip-packages-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .vip-package-card {
                padding: 2rem;
            }

            .benefits-section {
                padding: 2rem;
            }

            .benefits-grid {
                grid-template-columns: 1fr;
            }

            .package-price {
                font-size: 2.5rem;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 1rem 0;
            }

            .container {
                padding: 0 1rem;
            }

            .page-header h1 {
                font-size: 2rem;
            }

            .vip-package-card {
                padding: 1.5rem;
            }

            .benefits-section {
                padding: 1.5rem;
            }

            .benefits-title {
                font-size: 2rem;
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
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="fas fa-crown me-3"></i>Gói VIP Premium</h1>
            <p>Nâng cấp trải nghiệm đọc truyện của bạn với các gói VIP đặc biệt. Tận hưởng những đặc quyền độc quyền và trải nghiệm không giới hạn.</p>
        </div>

        <!-- Error Alert -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle me-2"></i>
                ${error}
            </div>
        </c:if>

        <!-- VIP Packages Grid -->
        <div class="vip-packages-grid">
            <c:forEach var="goiVIP" items="${goiVIPList}" varStatus="status">
                <div class="vip-package-card ${goiVIP.noiBat ? 'featured' : ''}">
                    <div class="package-icon">
                        <c:choose>
                            <c:when test="${goiVIP.soThang <= 1}">
                                <i class="fas fa-gem"></i>
                            </c:when>
                            <c:when test="${goiVIP.soThang <= 6}">
                                <i class="fas fa-crown"></i>
                            </c:when>
                            <c:when test="${goiVIP.soThang <= 12}">
                                <i class="fas fa-trophy"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-star"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <h3 class="package-name">${goiVIP.tenGoi}</h3>
                    
                    <div class="package-price">
                        <fmt:formatNumber value="${goiVIP.gia}" type="currency" currencySymbol="" groupingUsed="true"/>₫
                    </div>
                    
                    <div class="package-duration">
                        ${goiVIP.soThang} ${goiVIP.soThang == 1 ? 'tháng' : 'tháng'}
                    </div>

                    <c:if test="${not empty goiVIP.moTa}">
                        <p style="color: rgba(255, 255, 255, 0.8); margin: 1rem 0;">${goiVIP.moTa}</p>
                    </c:if>

                    <ul class="package-features">
                        <li><i class="fas fa-unlock-alt"></i>Đọc tất cả truyện VIP</li>
                        <li><i class="fas fa-ad"></i>Không quảng cáo</li>
                        <li><i class="fas fa-fast-forward"></i>Đọc trước chương mới</li>
                        <li><i class="fas fa-download"></i>Tải truyện offline</li>
                        <li><i class="fas fa-headset"></i>Hỗ trợ ưu tiên 24/7</li>
                        <c:if test="${goiVIP.soThang >= 12}">
                            <li><i class="fas fa-gift"></i>Quà tặng đặc biệt</li>
                        </c:if>
                    </ul>

                    <c:if test="${goiVIP.hasDiscount()}">
                        <div class="text-center mb-3">
                            <span style="color: #ff6b6b; text-decoration: line-through;">
                                <fmt:formatNumber value="${goiVIP.giaGoc}" type="currency" currencySymbol="" groupingUsed="true"/>₫
                            </span>
                            <span class="badge" style="background: var(--vip-gradient); color: #333; margin-left: 10px;">
                                Tiết kiệm ${goiVIP.phanTramGiamGia}%
                            </span>
                        </div>
                    </c:if>

                    <a href="${pageContext.request.contextPath}/vip/register?packageId=${goiVIP.id}" 
                       class="package-btn">
                        <i class="fas fa-shopping-cart me-2"></i>
                        Chọn gói này
                    </a>
                </div>
            </c:forEach>
        </div>

        <!-- Benefits Section -->
        <div class="benefits-section">
            <h2 class="benefits-title">
                <i class="fas fa-star-half-alt me-3"></i>
                Đặc quyền VIP
            </h2>
            
            <div class="benefits-grid">
                <div class="benefit-item">
                    <i class="fas fa-infinity"></i>
                    <h4>Truy cập không giới hạn</h4>
                    <p>Đọc tất cả truyện VIP, không giới hạn số lượng và thời gian đọc.</p>
                </div>
                
                <div class="benefit-item">
                    <i class="fas fa-eye-slash"></i>
                    <h4>Trải nghiệm không quảng cáo</h4>
                    <p>Thưởng thức truyện yêu thích mà không bị gián đoạn bởi quảng cáo.</p>
                </div>
                
                <div class="benefit-item">
                    <i class="fas fa-rocket"></i>
                    <h4>Cập nhật ưu tiên</h4>
                    <p>Được đọc chương mới sớm nhất, trước tất cả người dùng thường.</p>
                </div>
                
                <div class="benefit-item">
                    <i class="fas fa-cloud-download-alt"></i>
                    <h4>Tải truyện offline</h4>
                    <p>Tải truyện về máy để đọc offline, tiện lợi mọi lúc mọi nơi.</p>
                </div>
                
                <div class="benefit-item">
                    <i class="fas fa-medal"></i>
                    <h4>Huy hiệu VIP độc quyền</h4>
                    <p>Hiển thị huy hiệu VIP đặc biệt trong hồ sơ và bình luận.</p>
                </div>
                
                <div class="benefit-item">
                    <i class="fas fa-headset"></i>
                    <h4>Hỗ trợ 24/7</h4>
                    <p>Nhận hỗ trợ ưu tiên từ đội ngũ chăm sóc khách hàng chuyên nghiệp.</p>
                </div>
            </div>
        </div>

        <!-- Back Link -->
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/home" class="back-link">
                <i class="fas fa-arrow-left me-2"></i>
                Quay lại trang chủ
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animate cards on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Observe all package cards
        document.querySelectorAll('.vip-package-card').forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(40px)';
            card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            card.style.transitionDelay = `${index * 0.1}s`;
            observer.observe(card);
        });

        // Add click effects
        document.querySelectorAll('.package-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                // Add loading state
                const originalContent = this.innerHTML;
                this.innerHTML = '<span class="loading-spinner"></span>Đang xử lý...';
                this.style.pointerEvents = 'none';
                
                // Reset after a delay (in case of navigation failure)
                setTimeout(() => {
                    this.innerHTML = originalContent;
                    this.style.pointerEvents = 'auto';
                }, 3000);
            });
        });

        // Enhanced hover effects
        document.querySelectorAll('.vip-package-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.zIndex = '10';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.zIndex = '1';
            });
        });

        // Mobile touch effects
        if ('ontouchstart' in window) {
            document.querySelectorAll('.vip-package-card').forEach(card => {
                card.addEventListener('touchstart', function() {
                    this.style.transform = 'translateY(-5px) scale(1.01)';
                });
                
                card.addEventListener('touchend', function() {
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                });
            });
        }
    </script>
</body>
</html>