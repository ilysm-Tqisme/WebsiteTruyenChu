<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trạng thái VIP - TruyenMoi</title>
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
            --royal-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #ffd700 100%);
            
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

        /* VIP Floating Particles */
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

        .vip-particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
            overflow: hidden;
        }

        .vip-particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: #ffd700;
            border-radius: 50%;
            animation: float 8s ease-in-out infinite;
            opacity: 0.3;
            box-shadow: 0 0 10px rgba(255, 215, 0, 0.8);
        }

        @keyframes float {
            0%, 100% { 
                transform: translateY(0px) rotate(0deg);
                opacity: 0.3;
            }
            50% { 
                transform: translateY(-30px) rotate(180deg);
                opacity: 0.6;
            }
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .vip-container {
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

        .vip-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: var(--vip-gradient);
            border-radius: var(--border-radius);
            z-index: -1;
            animation: vipGlow 3s ease-in-out infinite;
            opacity: 0.3;
        }

        @keyframes vipGlow {
            0%, 100% { opacity: 0.2; }
            50% { opacity: 0.4; }
        }

        .vip-container::after {
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

        .vip-header {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 30%, #533483 70%, #ffd700 100%);
            color: white;
            padding: 4rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .vip-header::before {
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

        .vip-crown {
            font-size: 5rem;
            margin-bottom: 1.5rem;
            animation: crownFloat 3s ease-in-out infinite;
            filter: drop-shadow(0 0 20px rgba(255, 215, 0, 0.8));
            position: relative;
            z-index: 1;
        }

        @keyframes crownFloat {
            0%, 100% { 
                transform: translateY(0px) rotate(0deg) scale(1);
                filter: drop-shadow(0 0 20px rgba(255, 215, 0, 0.8));
            }
            50% { 
                transform: translateY(-15px) rotate(5deg) scale(1.05);
                filter: drop-shadow(0 0 30px rgba(255, 215, 0, 1));
            }
        }

        .vip-header h2 {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
            background: var(--vip-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .vip-header p {
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            position: relative;
            z-index: 1;
            max-width: 600px;
            margin: 0 auto;
        }

        .vip-body {
            padding: 3rem 2.5rem;
            position: relative;
            z-index: 1;
        }

        .alert {
            border-radius: 15px;
            border: none;
            padding: 1.2rem 1.5rem;
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

        .alert-warning {
            background: rgba(255, 193, 7, 0.2);
            color: #ffc107;
            border: 1px solid rgba(255, 193, 7, 0.4);
        }

        .alert i {
            margin-right: 1rem;
            font-size: 1.3rem;
        }

        .vip-info-card {
            background: rgba(255, 215, 0, 0.1);
            border: 2px solid rgba(255, 215, 0, 0.3);
            border-radius: 15px;
            padding: 2.5rem;
            margin-bottom: 2.5rem;
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.15);
            position: relative;
            overflow: hidden;
        }

        .vip-info-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.1), transparent);
            animation: infoShimmer 3s ease-in-out infinite;
        }

        @keyframes infoShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .vip-info-card h5 {
            color: #fff;
            font-weight: 700;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            font-size: 1.4rem;
        }

        .vip-info-card h5 i {
            color: #ffd700;
            margin-right: 0.75rem;
            font-size: 1.6rem;
        }

        .vip-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .vip-info-item {
            text-align: center;
            padding: 1.5rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .vip-info-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: var(--transition);
        }

        .vip-info-item:hover {
            background: rgba(255, 215, 0, 0.1);
            transform: translateY(-3px);
        }

        .vip-info-item:hover::before {
            left: 100%;
        }

        .vip-info-item strong {
            display: block;
            color: #ffd700;
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .vip-info-item span {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
            font-weight: 500;
        }

        .vip-benefits {
            margin: 3rem 0;
        }

        .vip-benefits h5 {
            color: #fff;
            font-weight: 700;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            font-size: 1.4rem;
        }

        .vip-benefits h5 i {
            color: #ffd700;
            margin-right: 0.75rem;
        }

        .benefits-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
        }

        .benefit-item {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .benefit-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.05), transparent);
            transition: var(--transition);
        }

        .benefit-item:hover {
            background: rgba(255, 215, 0, 0.1);
            border-color: rgba(255, 215, 0, 0.3);
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(255, 215, 0, 0.2);
        }

        .benefit-item:hover::before {
            left: 100%;
        }

        .benefit-item i {
            font-size: 3rem;
            color: #ffd700;
            margin-bottom: 1rem;
            display: block;
            animation: benefitIconFloat 3s ease-in-out infinite;
        }

        @keyframes benefitIconFloat {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-5px); }
        }

        .benefit-item h6 {
            color: #fff;
            font-weight: 600;
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .benefit-item small {
            color: rgba(255, 255, 255, 0.8);
            line-height: 1.5;
        }

        .action-buttons {
            text-align: center;
            margin-top: 3rem;
        }

        .btn-primary {
            background: var(--vip-gradient);
            color: #333;
            border: none;
            padding: 1.2rem 3rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: var(--transition);
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.4);
            position: relative;
            overflow: hidden;
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

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 40px rgba(255, 215, 0, 0.6);
            color: #333;
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-outline-secondary {
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: rgba(255, 255, 255, 0.9);
            background: transparent;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: var(--transition);
            backdrop-filter: blur(10px);
            margin-left: 1rem;
        }

        .btn-outline-secondary:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.6);
            color: #fff;
            transform: translateY(-2px);
        }

        .vip-stats {
            background: rgba(255, 255, 255, 0.03);
            border-radius: 15px;
            padding: 2rem;
            margin: 2rem 0;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .vip-stats h6 {
            color: #ffd700;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-align: center;
            font-size: 1.2rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 1.5rem;
            text-align: center;
        }

        .stat-item {
            padding: 1rem;
            background: rgba(255, 215, 0, 0.05);
            border-radius: 10px;
            transition: var(--transition);
        }

        .stat-item:hover {
            background: rgba(255, 215, 0, 0.1);
            transform: translateY(-2px);
        }

        .stat-number {
            font-size: 1.8rem;
            font-weight: 700;
            color: #ffd700;
            margin-bottom: 0.5rem;
            text-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
        }

        .stat-label {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                margin: 1rem auto;
                padding: 0 1rem;
            }

            .vip-header {
                padding: 2.5rem 1.5rem;
            }

            .vip-header h2 {
                font-size: 2.2rem;
            }

            .vip-crown {
                font-size: 4rem;
            }

            .vip-body {
                padding: 2rem 1.5rem;
            }

            .vip-info-card {
                padding: 2rem;
            }

            .vip-info-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 1rem;
            }

            .benefits-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                display: flex;
                flex-direction: column;
                gap: 1rem;
                align-items: center;
            }

            .btn-outline-secondary {
                margin-left: 0;
            }
        }

        @media (max-width: 576px) {
            .vip-header {
                padding: 2rem 1rem;
            }

            .vip-header h2 {
                font-size: 1.8rem;
            }

            .vip-header p {
                font-size: 1.1rem;
            }

            .vip-body {
                padding: 1.5rem 1rem;
            }

            .vip-info-grid {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .btn-primary {
                padding: 1rem 2rem;
                font-size: 1rem;
            }

            .vip-crown {
                font-size: 3.5rem;
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

        /* Special VIP Elements */
        .vip-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            background: var(--vip-gradient);
            color: #333;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.4);
            animation: badgePulse 3s ease-in-out infinite;
        }

        @keyframes badgePulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
    </style>
</head>
<body>
    <!-- VIP Particles -->
    <div class="vip-particles">
        <div class="vip-particle" style="left: 10%; animation-delay: 0s;"></div>
        <div class="vip-particle" style="left: 20%; animation-delay: 1s;"></div>
        <div class="vip-particle" style="left: 30%; animation-delay: 2s;"></div>
        <div class="vip-particle" style="left: 40%; animation-delay: 3s;"></div>
        <div class="vip-particle" style="left: 50%; animation-delay: 4s;"></div>
        <div class="vip-particle" style="left: 60%; animation-delay: 5s;"></div>
        <div class="vip-particle" style="left: 70%; animation-delay: 1.5s;"></div>
        <div class="vip-particle" style="left: 80%; animation-delay: 2.5s;"></div>
        <div class="vip-particle" style="left: 90%; animation-delay: 3.5s;"></div>
    </div>

    <div class="container">
        <div class="vip-container">
            <div class="vip-badge">
                <i class="fas fa-crown me-1"></i>
                VIP MEMBER
            </div>
            
            <div class="vip-header">
                <div class="vip-crown">👑</div>
                <h2>Chúc mừng! Bạn đã là thành viên VIP</h2>
                <p>Tận hưởng tất cả đặc quyền VIP độc quyền và trải nghiệm đọc truyện không giới hạn</p>
            </div>

            <div class="vip-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle"></i>
                        ${error}
                    </div>
                </c:if>

                <!-- VIP Information Card -->
                <div class="vip-info-card">
                    <h5><i class="fas fa-star"></i>Thông tin VIP của bạn</h5>
                    <div class="vip-info-grid">
                        <div class="vip-info-item">
                            <strong>Tên người dùng</strong>
                            <span>${vipInfo.hoTen}</span>
                        </div>
                        <div class="vip-info-item">
                            <strong>Email</strong>
                            <span>${vipInfo.email}</span>
                        </div>
                        
                        <div class="vip-info-item">
                            <strong>Trạng thái</strong>
                            <span style="color: #4facfe; font-weight: 600;">
                                <i class="fas fa-check-circle me-1"></i>
                                <span>Đang hoạt động</span>
                            </span>
                        </div>
                        <div class="vip-info-item">
                            <strong>Ngày đăng ký</strong>
                            <span>${vipInfo.ngayDangKyVIPFormatted != null ? vipInfo.ngayDangKyVIPFormatted : 'N/A'}</span>
                        </div>
                        <div class="vip-info-item">
                            <strong>Ngày hết hạn</strong>
                            <span>${vipInfo.ngayHetHanVIPFormatted != null ? vipInfo.ngayHetHanVIPFormatted : 'N/A'}</span>
                        </div>
                        
                    </div>
                </div>

                <!-- VIP Stats -->
                <div class="vip-stats">
                    <h6><i class="fas fa-chart-line me-2"></i>Thống kê VIP</h6>
                    <div class="stats-grid">
                        <div class="stat-item">
                            <div class="stat-number">∞</div>
                            <div class="stat-label">Truyện VIP</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">0</div>
                            <div class="stat-label">Quảng cáo</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">24/7</div>
                            <div class="stat-label">Hỗ trợ</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-number">100%</div>
                            <div class="stat-label">Đặc quyền</div>
                        </div>
                    </div>
                </div>

                <!-- VIP Benefits -->
                <div class="vip-benefits">
                    <h5><i class="fas fa-crown"></i>Đặc quyền VIP của bạn</h5>
                    <div class="benefits-grid">
                        <div class="benefit-item">
                            <i class="fas fa-unlock-alt"></i>
                            <h6>Đọc tất cả truyện VIP</h6>
                            <small>Truy cập không giới hạn đến toàn bộ thư viện truyện VIP cao cấp</small>
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-ad"></i>
                            <h6>Trải nghiệm không quảng cáo</h6>
                            <small>Đọc truyện mượt mà, tập trung hoàn toàn vào nội dung</small>
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-fast-forward"></i>
                            <h6>Đọc trước chương mới</h6>
                            <small>Cập nhật sớm nhất, trước tất cả người dùng thường</small>
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-download"></i>
                            <h6>Tải truyện offline</h6>
                            <small>Tải về và đọc mọi lúc mọi nơi, không cần kết nối internet</small>
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-medal"></i>
                            <h6>Huy hiệu VIP độc quyền</h6>
                            <small>Hiển thị đẳng cấp VIP trong hồ sơ và bình luận</small>
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-headset"></i>
                            <h6>Hỗ trợ ưu tiên 24/7</h6>
                            <small>Nhận hỗ trợ nhanh chóng từ đội ngũ chuyên nghiệp</small>
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-gift"></i>
                            <h6>Quà tặng đặc biệt</h6>
                            <small>Nhận những món quà và ưu đãi độc quyền dành riêng cho VIP</small>
                        </div>
                        <div class="benefit-item">
                            <i class="fas fa-star"></i>
                            <h6>Đánh giá ưu tiên</h6>
                            <small>Đánh giá và bình luận được hiển thị nổi bật</small>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/home" class="btn-primary">
                        <i class="fas fa-book-reader me-2"></i>Khám phá truyện VIP
                    </a>
                    <a href="${pageContext.request.contextPath}/profile" class="btn-outline-secondary">
                        <i class="fas fa-user me-2"></i>Hồ sơ của tôi
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Enhanced animations and interactions
        document.addEventListener('DOMContentLoaded', function() {
            // Animate benefit items on load
            const benefitItems = document.querySelectorAll('.benefit-item');
            benefitItems.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateY(30px)';
                setTimeout(() => {
                    item.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                    item.style.opacity = '1';
                    item.style.transform = 'translateY(0)';
                }, 200 + (index * 100));
            });

            // Animate VIP info items
            const vipInfoItems = document.querySelectorAll('.vip-info-item');
            vipInfoItems.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateX(-20px)';
                setTimeout(() => {
                    item.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    item.style.opacity = '1';
                    item.style.transform = 'translateX(0)';
                }, 400 + (index * 100));
            });

            // Animate stats
            const statItems = document.querySelectorAll('.stat-item');
            statItems.forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'scale(0.8)';
                setTimeout(() => {
                    item.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    item.style.opacity = '1';
                    item.style.transform = 'scale(1)';
                }, 600 + (index * 80));
            });

            // Enhanced button click effects
            document.querySelectorAll('.btn-primary, .btn-outline-secondary').forEach(btn => {
                btn.addEventListener('click', function(e) {
                    // Add loading state for primary buttons
                    if (this.classList.contains('btn-primary')) {
                        const originalContent = this.innerHTML;
                        this.innerHTML = '<span class="loading-spinner"></span>Đang tải...';
                        this.style.pointerEvents = 'none';
                        
                        setTimeout(() => {
                            this.innerHTML = originalContent;
                            this.style.pointerEvents = 'auto';
                        }, 2000);
                    }
                });
            });

            // Create additional floating particles
            createFloatingParticles();
            
            // Add sparkle effects
            createSparkleEffects();
        });

        // Create additional floating particles
        function createFloatingParticles() {
            const particlesContainer = document.querySelector('.vip-particles');
            
            setInterval(() => {
                if (Math.random() > 0.7) { // 30% chance
                    const particle = document.createElement('div');
                    particle.className = 'vip-particle';
                    particle.style.left = Math.random() * 100 + '%';
                    particle.style.top = '100%';
                    particle.style.animationDelay = Math.random() * 2 + 's';
                    particle.style.animationDuration = (4 + Math.random() * 4) + 's';
                    particlesContainer.appendChild(particle);
                    
                    setTimeout(() => {
                        particle.remove();
                    }, 8000);
                }
            }, 2000);
        }

        // Create sparkle effects around crown
        function createSparkleEffects() {
            const crown = document.querySelector('.vip-crown');
            if (!crown) return;
            
            setInterval(() => {
                const sparkle = document.createElement('div');
                sparkle.style.cssText = `
                    position: absolute;
                    width: 6px;
                    height: 6px;
                    background: #ffd700;
                    border-radius: 50%;
                    pointer-events: none;
                    z-index: 10;
                    box-shadow: 0 0 15px rgba(255, 215, 0, 0.8);
                    animation: sparkle 2s ease-out forwards;
                `;
                
                const rect = crown.getBoundingClientRect();
                sparkle.style.left = (rect.left + Math.random() * rect.width) + 'px';
                sparkle.style.top = (rect.top + Math.random() * rect.height) + 'px';
                
                document.body.appendChild(sparkle);
                
                setTimeout(() => {
                    sparkle.remove();
                }, 2000);
            }, 1500);
        }

        // Add sparkle animation keyframe
        const sparkleStyle = document.createElement('style');
        sparkleStyle.textContent = `
            @keyframes sparkle {
                0% {
                    opacity: 0;
                    transform: scale(0) rotate(0deg);
                }
                50% {
                    opacity: 1;
                    transform: scale(1) rotate(180deg);
                }
                100% {
                    opacity: 0;
                    transform: scale(0) rotate(360deg);
                }
            }
        `;
        document.head.appendChild(sparkleStyle);

        // Mobile touch effects
        if ('ontouchstart' in window) {
            document.querySelectorAll('.benefit-item, .vip-info-item, .stat-item').forEach(item => {
                item.addEventListener('touchstart', function() {
                    this.style.transform = this.style.transform.replace('translateY(0)', 'translateY(-2px)') + ' scale(1.02)';
                });
                
                item.addEventListener('touchend', function() {
                    setTimeout(() => {
                        this.style.transform = this.style.transform.replace('translateY(-2px)', 'translateY(0)').replace(' scale(1.02)', '');
                    }, 150);
                });
            });
        }

        // Add scroll-triggered animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0) scale(1)';
                }
            });
        }, observerOptions);

        // Observe elements for scroll animations
        document.querySelectorAll('.vip-info-card, .vip-stats, .vip-benefits').forEach(element => {
            element.style.opacity = '0';
            element.style.transform = 'translateY(30px)';
            element.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
            observer.observe(element);
        });

        // Enhanced keyboard navigation
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                const focused = document.activeElement;
                if (focused.classList.contains('btn-primary') || focused.classList.contains('btn-outline-secondary')) {
                    focused.click();
                }
            }
        });
    </script>
</body>
</html>