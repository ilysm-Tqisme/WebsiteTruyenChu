<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, maximum-scale=5.0">
    <title>Bình luận - ${truyen.tenTruyen} - TruyenMoi</title>
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
            --vip-glass-bg: rgba(30, 30, 50, 0.4);
            --vip-glass-border: rgba(255, 215, 0, 0.3);
            --vip-shadow: 0 0 30px rgba(255, 215, 0, 0.3);
            
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
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            overflow-x: hidden;
        }

        body.vip-user {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 30%, #0f3460 60%, #533483 100%);
        }

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

        body.vip-user::before {
            background: 
                radial-gradient(circle at 20% 50%, rgba(255, 215, 0, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 183, 77, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 80%, rgba(255, 235, 59, 0.1) 0%, transparent 50%);
        }

        @keyframes backgroundShift {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.8; }
        }

        /* Navigation */
        .navbar {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--glass-border);
            box-shadow: var(--shadow-light);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .vip-user .navbar {
            background: var(--vip-glass-bg);
            border-bottom: 1px solid var(--vip-glass-border);
            box-shadow: var(--vip-shadow);
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 700;
            color: #fff !important;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            transition: var(--transition);
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .navbar-brand:hover {
            transform: scale(1.05);
            filter: drop-shadow(0 0 20px rgba(255, 255, 255, 0.5));
        }

        .navbar-brand i {
            font-size: 2rem;
            background: var(--vip-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            filter: drop-shadow(0 0 10px rgba(255, 215, 0, 0.8));
        }

        .navbar-nav .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            transition: var(--transition);
            margin: 0 0.25rem;
            position: relative;
            overflow: hidden;
        }

        .navbar-nav .nav-link:hover {
            background: var(--glass-bg);
            color: #fff !important;
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        /* Main Container */
        .comments-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        /* Story Header */
        .story-header {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-medium);
            position: relative;
            overflow: hidden;
        }

        .story-header.vip {
            background: var(--vip-glass-bg);
            border: 2px solid var(--vip-glass-border);
            box-shadow: var(--vip-shadow);
        }

        .story-header h1 {
            color: #fff;
            font-size: clamp(1.5rem, 4vw, 2.5rem);
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .story-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
        }

        .back-btn {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            color: #fff;
            border: 1px solid var(--glass-border);
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
            transition: var(--transition);
            box-shadow: var(--shadow-light);
            margin-bottom: 1.5rem;
        }

        .back-btn:hover {
            color: #fff;
            transform: translateY(-3px) scale(1.05);
            box-shadow: var(--shadow-heavy);
        }

        /* Comments Section */
        .comments-section {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-medium);
            overflow: hidden;
        }

        .comments-section.vip {
            background: var(--vip-glass-bg);
            border: 2px solid var(--vip-glass-border);
            box-shadow: var(--vip-shadow);
        }

        .comments-header {
            padding: 2rem;
            background: var(--primary-gradient);
            color: white;
            position: relative;
        }

        .comments-header.vip {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 30%, #533483 70%, #ffd700 100%);
        }

        .comments-header h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .comments-stats {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .comment-count {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            backdrop-filter: blur(10px);
        }

        .sort-controls {
            display: flex;
            gap: 0.5rem;
            margin-left: auto;
        }

        .sort-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            transition: var(--transition);
            cursor: pointer;
            backdrop-filter: blur(10px);
        }

        .sort-btn:hover,
        .sort-btn.active {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        /* Comment Form */
        .comment-form {
            padding: 2rem;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--glass-border);
        }

        .comment-form.vip {
            background: var(--vip-glass-bg);
            border-bottom: 1px solid var(--vip-glass-border);
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

        .form-control:focus {
            border-color: rgba(255, 255, 255, 0.6);
            box-shadow: 0 0 0 4px rgba(255, 255, 255, 0.2), var(--shadow-medium);
            outline: none;
            background: white;
            transform: translateY(-2px);
        }

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
        }

        .vip-user .btn-primary {
            background: var(--vip-gradient);
            box-shadow: var(--vip-shadow);
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: var(--shadow-heavy);
        }

        .btn-outline-secondary {
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: rgba(255, 255, 255, 0.9);
            background: transparent;
            border-radius: 15px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: var(--transition);
            backdrop-filter: blur(10px);
        }

        .btn-outline-secondary:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.6);
            color: #fff;
            transform: translateY(-2px);
        }

        /* Comments List */
        .comments-list {
            padding: 2rem;
        }

        .comment-item {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid var(--glass-border);
            transition: var(--transition);
            position: relative;
        }

        .comment-item.vip {
            background: var(--vip-glass-bg);
            border: 1px solid var(--vip-glass-border);
        }

        .comment-item:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
        }

        .comment-item.vip:hover {
            background: rgba(255, 215, 0, 0.15);
        }

        .comment-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .comment-avatar {
            position: relative;
            flex-shrink: 0;
        }

        .avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 2px solid rgba(255, 255, 255, 0.3);
            object-fit: cover;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .avatar.vip {
            border: 2px solid rgba(255, 215, 0, 0.6);
            box-shadow: var(--vip-shadow);
        }

        .avatar-placeholder {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 2px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            justify-content: center;
            color: rgba(255, 255, 255, 0.7);
            font-size: 1.2rem;
        }

        .avatar-placeholder.vip {
            border: 2px solid rgba(255, 215, 0, 0.6);
            box-shadow: var(--vip-shadow);
        }

        /* VIP Crown */
        .comment-avatar.vip::before {
            content: '👑';
            position: absolute;
            top: -5px;
            right: -5px;
            font-size: 1.2rem;
            z-index: 1;
            animation: crownFloat 2s ease-in-out infinite;
            filter: drop-shadow(0 0 10px rgba(255, 215, 0, 0.8));
        }

        @keyframes crownFloat {
            0%, 100% { transform: translateY(0px) rotate(-10deg); }
            50% { transform: translateY(-3px) rotate(-5deg); }
        }

        .comment-info {
            flex: 1;
        }

        .comment-author {
            font-weight: 600;
            color: #fff;
            margin-bottom: 0.25rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .vip-badge {
            background: var(--vip-gradient);
            color: white;
            padding: 0.2rem 0.5rem;
            border-radius: 12px;
            font-size: 0.7rem;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            animation: vipPulse 2s ease-in-out infinite;
        }

        @keyframes vipPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .comment-time {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.85rem;
        }

        .comment-actions {
            display: flex;
            gap: 0.5rem;
            margin-left: auto;
        }

        .comment-btn {
            background: rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.7);
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            transition: var(--transition);
            cursor: pointer;
            backdrop-filter: blur(10px);
        }

        .comment-btn:hover {
            background: rgba(255, 255, 255, 0.2);
            color: #fff;
            transform: translateY(-2px);
        }

        .comment-btn.delete:hover {
            background: rgba(255, 107, 107, 0.3);
            border-color: rgba(255, 107, 107, 0.5);
        }

        .comment-content {
            color: #fff;
            line-height: 1.6;
            margin-bottom: 1rem;
            font-size: 1rem;
        }

        /* Reply Comments */
        .reply-comments {
            margin-top: 1rem;
            padding-left: 2rem;
            border-left: 2px solid rgba(255, 255, 255, 0.2);
        }

        .reply-comment {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .reply-comment.vip {
            background: rgba(255, 215, 0, 0.1);
            border: 1px solid rgba(255, 215, 0, 0.2);
        }

        .reply-form {
            margin-top: 1rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            display: none;
        }

        .reply-form.show {
            display: block;
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Empty State */
        .empty-comments {
            text-align: center;
            padding: 3rem 2rem;
            color: rgba(255, 255, 255, 0.7);
        }

        .empty-comments i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-comments h3 {
            color: #fff;
            margin-bottom: 1rem;
        }

        /* Pagination */
        .pagination {
            justify-content: center;
            margin-top: 2rem;
            gap: 0.5rem;
        }

        .pagination .page-link {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            color: #fff;
            padding: 0.75rem 1rem;
            border-radius: 15px;
            transition: var(--transition);
            font-size: 0.9rem;
            font-weight: 500;
            min-width: 3rem;
            text-align: center;
        }

        .pagination .page-link:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px) scale(1.05);
            box-shadow: var(--shadow-light);
            color: #fff;
        }

        .pagination .page-item.active .page-link {
            background: var(--primary-gradient);
            border-color: transparent;
            box-shadow: var(--shadow-medium);
            transform: scale(1.1);
        }

        /* Alerts */
        .alert {
            border-radius: 15px;
            border: none;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow-light);
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            max-width: 400px;
            animation: slideInAlert 0.3s ease-out;
        }

        @keyframes slideInAlert {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .alert-success {
            background: rgba(79, 172, 254, 0.2);
            color: #fff;
            border: 1px solid rgba(79, 172, 254, 0.3);
        }

        .alert-danger {
            background: rgba(255, 107, 107, 0.2);
            color: #fff;
            border: 1px solid rgba(255, 107, 107, 0.3);
        }

        .alert-warning {
            background: rgba(255, 193, 7, 0.2);
            color: #fff;
            border: 1px solid rgba(255, 193, 7, 0.3);
        }

        /* Loading Spinner */
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .comments-container {
                margin: 1rem auto;
                padding: 0 0.5rem;
            }

            .story-header {
                padding: 1.5rem;
            }

            .story-header h1 {
                font-size: 1.8rem;
            }

            .story-meta {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .comments-header {
                padding: 1.5rem;
            }

            .comments-header h2 {
                font-size: 1.3rem;
            }

            .comments-stats {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .sort-controls {
                margin-left: 0;
                width: 100%;
            }

            .comment-form {
                padding: 1.5rem;
            }

            .comments-list {
                padding: 1.5rem;
            }

            .comment-item {
                padding: 1rem;
            }

            .comment-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
            }

            .comment-actions {
                margin-left: 0;
                width: 100%;
                justify-content: flex-start;
            }

            .reply-comments {
                padding-left: 1rem;
            }

            .back-btn {
                padding: 0.6rem 1.2rem;
                font-size: 0.9rem;
            }
        }

        @media (max-width: 576px) {
            .story-header {
                padding: 1rem;
            }

            .comments-header {
                padding: 1rem;
            }

            .comment-form {
                padding: 1rem;
            }

            .comments-list {
                padding: 1rem;
            }

            .comment-item {
                padding: 0.75rem;
            }

            .avatar,
            .avatar-placeholder {
                width: 40px;
                height: 40px;
            }

            .comment-avatar.vip::before {
                font-size: 1rem;
                top: -3px;
                right: -3px;
            }

            .sort-controls {
                flex-direction: column;
                gap: 0.5rem;
            }

            .sort-btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body class="${currentUserIsVIP ? 'vip-user' : ''}">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-book-open"></i>
                TruyenMoi
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home me-2"></i>Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/truyen">
                            <i class="fas fa-list me-2"></i>Danh sách truyện
                        </a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-2"></i>${sessionScope.user.hoTen}
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                        <i class="fas fa-user-edit me-2"></i>Thông tin cá nhân</a></li>
                                    <c:if test="${sessionScope.user.vaiTro == 'ADMIN'}">
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Admin/HomeAdmin.jsp">
                                            <i class="fas fa-tachometer-alt me-2"></i>Admin Panel</a></li>
                                    </c:if>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt me-2"></i>Đăng nhập
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                    <i class="fas fa-user-plus me-2"></i>Đăng ký
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="comments-container">
        <!-- Back Button -->
        <a href="${pageContext.request.contextPath}/story?id=${truyen.id}" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            <span>Quay lại truyện</span>
        </a>

        <!-- Story Header -->
        <div class="story-header ${currentUserIsVIP ? 'vip' : ''}">
            <h1><c:out value="${truyen.tenTruyen}" /></h1>
            <div class="story-meta">
                <span><i class="fas fa-user me-2"></i>Tác giả: <c:out value="${truyen.tacGiaTen}" /></span>
                <span><i class="fas fa-eye me-2"></i>Lượt xem: <c:out value="${truyen.luotXemFormatted}" /></span>
                <span><i class="fas fa-star me-2"></i>Đánh giá: <c:out value="${truyen.danhGiaFormatted}" /></span>
            </div>
        </div>

        <!-- Comments Section -->
        <div class="comments-section ${currentUserIsVIP ? 'vip' : ''}">
            <!-- Comments Header -->
            <div class="comments-header ${currentUserIsVIP ? 'vip' : ''}">
                <h2><i class="fas fa-comments me-2"></i>Bình luận</h2>
                <div class="comments-stats">
                    <div class="comment-count">
                        <i class="fas fa-comment me-2"></i>
                        <span id="totalCommentsCount"><c:out value="${totalComments}" /> bình luận</span>
                    </div>
                    <div class="sort-controls">
                        <button class="sort-btn ${sortOrder == 'newest' ? 'active' : ''}" 
                                onclick="changeSortOrder('newest')">
                            <i class="fas fa-clock me-1"></i>Mới nhất
                        </button>
                        <button class="sort-btn ${sortOrder == 'oldest' ? 'active' : ''}" 
                                onclick="changeSortOrder('oldest')">
                            <i class="fas fa-history me-1"></i>Cũ nhất
                        </button>
                    </div>
                </div>
            </div>

            <!-- Comment Form -->
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="comment-form ${currentUserIsVIP ? 'vip' : ''}">
                        <form id="commentForm" onsubmit="submitComment(event)">
                            <div class="mb-3">
                                <label for="commentContent" class="form-label text-white">
                                    <i class="fas fa-edit me-2"></i>Viết bình luận
                                </label>
                                <textarea class="form-control" id="commentContent" rows="3" 
                                          placeholder="Chia sẻ cảm nhận của bạn về truyện..." required></textarea>
                            </div>
                            <div class="d-flex justify-content-end">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-paper-plane me-2"></i>Đăng bình luận
                                </button>
                            </div>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="comment-form">
                        <div class="alert alert-warning" role="alert">
                            <i class="fas fa-info-circle me-2"></i>
                            Vui lòng <a href="${pageContext.request.contextPath}/login" class="text-warning">đăng nhập</a> 
                            để bình luận
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

            <!-- Comments List -->
            <div class="comments-list" id="commentsList">
                <c:choose>
                    <c:when test="${empty binhLuanList}">
                        <div class="empty-comments">
                            <i class="fas fa-comments"></i>
                            <h3>Chưa có bình luận nào</h3>
                            <p>Hãy là người đầu tiên bình luận về truyện này!</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="binhLuan" items="${binhLuanList}">
                            <div class="comment-item ${binhLuan.nguoiDung.trangThaiVIP ? 'vip' : ''}" 
                                 data-comment-id="${binhLuan.id}">
                                <div class="comment-header">
                                    <div class="comment-avatar ${binhLuan.nguoiDung.trangThaiVIP ? 'vip' : ''}">
                                        <c:choose>
                                            <c:when test="${not empty binhLuan.nguoiDung.anhDaiDien}">
                                                <img src="${pageContext.request.contextPath}/<c:out value='${binhLuan.nguoiDung.anhDaiDien}' />" 
                                                     alt="<c:out value='${binhLuan.nguoiDung.hoTen}' />" 
                                                     class="avatar ${binhLuan.nguoiDung.trangThaiVIP ? 'vip' : ''}">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="avatar-placeholder ${binhLuan.nguoiDung.trangThaiVIP ? 'vip' : ''}">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="comment-info">
                                        <div class="comment-author">
                                            <c:out value="${binhLuan.nguoiDung.hoTen}" />
                                            <c:if test="${binhLuan.nguoiDung.trangThaiVIP}">
                                                <span class="vip-badge">
                                                    <i class="fas fa-crown"></i>VIP
                                                </span>
                                            </c:if>
                                        </div>
                                        <div class="comment-time">
                                            <c:out value="${binhLuan.ngayTaoFormatted}" />
                                        </div>
                                    </div>
                                    <div class="comment-actions">
                                        <c:if test="${not empty sessionScope.user}">
                                            <button class="comment-btn reply" 
                                                    onclick="toggleReplyForm(${binhLuan.id})">
                                                <i class="fas fa-reply me-1"></i>Trả lời
                                            </button>
                                            <c:if test="${sessionScope.user.id == binhLuan.nguoiDung.id || sessionScope.user.vaiTro == 'ADMIN'}">
                                                <button class="comment-btn delete" 
                                                        onclick="deleteComment(${binhLuan.id})">
                                                    <i class="fas fa-trash me-1"></i>Xóa
                                                </button>
                                            </c:if>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="comment-content">
                                    <c:out value="${binhLuan.noiDung}" />
                                </div>

                                <!-- Reply Form -->
                                <c:if test="${not empty sessionScope.user}">
                                    <div class="reply-form" id="replyForm-${binhLuan.id}">
                                        <form onsubmit="submitReply(event, ${binhLuan.id})">
                                            <div class="mb-3">
                                                <textarea class="form-control" rows="2" 
                                                          placeholder="Viết câu trả lời..." required></textarea>
                                            </div>
                                            <div class="d-flex justify-content-end gap-2">
                                                <button type="button" class="btn btn-outline-secondary btn-sm" 
                                                        onclick="toggleReplyForm(${binhLuan.id})">
                                                    Hủy
                                                </button>
                                                <button type="submit" class="btn btn-primary btn-sm">
                                                    <i class="fas fa-paper-plane me-1"></i>Trả lời
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </c:if>

                                <!-- Reply Comments -->
                                <c:if test="${not empty binhLuan.binhLuanCon}">
                                    <div class="reply-comments">
                                        <c:forEach var="reply" items="${binhLuan.binhLuanCon}">
                                            <div class="reply-comment ${reply.nguoiDung.trangThaiVIP ? 'vip' : ''}" 
                                                 data-comment-id="${reply.id}">
                                                <div class="comment-header">
                                                    <div class="comment-avatar ${reply.nguoiDung.trangThaiVIP ? 'vip' : ''}">
                                                        <c:choose>
                                                            <c:when test="${not empty reply.nguoiDung.anhDaiDien}">
                                                                <img src="${pageContext.request.contextPath}/<c:out value='${reply.nguoiDung.anhDaiDien}' />" 
                                                                     alt="<c:out value='${reply.nguoiDung.hoTen}' />" 
                                                                     class="avatar ${reply.nguoiDung.trangThaiVIP ? 'vip' : ''}">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="avatar-placeholder ${reply.nguoiDung.trangThaiVIP ? 'vip' : ''}">
                                                                    <i class="fas fa-user"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="comment-info">
                                                        <div class="comment-author">
                                                            <c:out value="${reply.nguoiDung.hoTen}" />
                                                            <c:if test="${reply.nguoiDung.trangThaiVIP}">
                                                                <span class="vip-badge">
                                                                    <i class="fas fa-crown"></i>VIP
                                                                </span>
                                                            </c:if>
                                                        </div>
                                                        <div class="comment-time">
                                                           <c:out value="${reply.ngayTaoFormatted}" />
                                                        </div>
                                                    </div>
                                                    <div class="comment-actions">
                                                        <c:if test="${sessionScope.user.id == reply.nguoiDung.id || sessionScope.user.vaiTro == 'ADMIN'}">
                                                            <button class="comment-btn delete" 
                                                                    onclick="deleteComment(${reply.id})">
                                                                <i class="fas fa-trash me-1"></i>Xóa
                                                            </button>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="comment-content">
                                                    <c:out value="${reply.noiDung}" />
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="?truyenId=${truyen.id}&page=${currentPage - 1}&sort=${sortOrder}">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <li class="page-item active">
                                        <span class="page-link">${i}</span>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item">
                                        <a class="page-link" href="?truyenId=${truyen.id}&page=${i}&sort=${sortOrder}">${i}</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="?truyenId=${truyen.id}&page=${currentPage + 1}&sort=${sortOrder}">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </div>
    </div>

    <!-- Alert Container -->
    <div id="alertContainer"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Global variables
        const truyenId = ${truyen.id};
        const contextPath = '${pageContext.request.contextPath}';
        let currentSort = '${sortOrder}';
        
        // Submit comment function
        function submitComment(event) {
            event.preventDefault();
            
            const content = document.getElementById('commentContent').value.trim();
            if (!content) {
                showAlert('Vui lòng nhập nội dung bình luận', 'danger');
                return;
            }
            
            const submitBtn = event.target.querySelector('button[type="submit"]');
            const originalContent = submitBtn.innerHTML;
            submitBtn.innerHTML = '<div class="loading-spinner"></div>Đang gửi...';
            submitBtn.disabled = true;
            
            // Create form data with proper encoding
            const params = new URLSearchParams();
            params.append('action', 'add');
            params.append('truyenId', truyenId);
            params.append('noiDung', content);
            
            console.log('Sending comment data:', {
                action: 'add',
                truyenId: truyenId,
                noiDung: content
            });
            
            fetch(contextPath + '/comments', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: params.toString()
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                console.log('Comment response:', data);
                if (data.success) {
                    showAlert('Bình luận thành công!', 'success');
                    document.getElementById('commentContent').value = '';
                    
                    // Try to add comment immediately
                    if (data.commentData) {
                        addNewCommentToList(data.commentData);
                        updateCommentCount();
                    } else {
                        // Fallback: reload page
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    }
                } else {
                    showAlert(data.message || 'Có lỗi xảy ra', 'danger');
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                showAlert('Có lỗi xảy ra khi gửi bình luận', 'danger');
            })
            .finally(function() {
                submitBtn.innerHTML = originalContent;
                submitBtn.disabled = false;
            });
        }
        
        // Submit reply function
        function submitReply(event, parentCommentId) {
            event.preventDefault();
            
            const textarea = event.target.querySelector('textarea');
            const content = textarea.value.trim();
            if (!content) {
                showAlert('Vui lòng nhập nội dung trả lời', 'danger');
                return;
            }
            
            const submitBtn = event.target.querySelector('button[type="submit"]');
            const originalContent = submitBtn.innerHTML;
            submitBtn.innerHTML = '<div class="loading-spinner"></div>Đang gửi...';
            submitBtn.disabled = true;
            
            // Create form data with proper encoding
            const params = new URLSearchParams();
            params.append('action', 'reply');
            params.append('truyenId', truyenId);
            params.append('noiDung', content);
            params.append('binhLuanChaId', parentCommentId);
            
            console.log('Sending reply data:', {
                action: 'reply',
                truyenId: truyenId,
                noiDung: content,
                binhLuanChaId: parentCommentId
            });
            
            fetch(contextPath + '/comments', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: params.toString()
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                console.log('Reply response:', data);
                if (data.success) {
                    showAlert('Trả lời thành công!', 'success');
                    textarea.value = '';
                    toggleReplyForm(parentCommentId);
                    
                    // Try to add reply immediately
                    if (data.commentData) {
                        addNewReplyToList(parentCommentId, data.commentData);
                        updateCommentCount();
                    } else {
                        // Fallback: reload page
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    }
                } else {
                    showAlert(data.message || 'Có lỗi xảy ra', 'danger');
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                showAlert('Có lỗi xảy ra khi gửi trả lời', 'danger');
            })
            .finally(function() {
                submitBtn.innerHTML = originalContent;
                submitBtn.disabled = false;
            });
        }
        
        // Delete comment function
        function deleteComment(commentId) {
            if (!confirm('Bạn có chắc chắn muốn xóa bình luận này?')) {
                return;
            }
            
            // Create form data with proper encoding
            const params = new URLSearchParams();
            params.append('action', 'delete');
            params.append('binhLuanId', commentId);
            
            console.log('Sending delete data:', {
                action: 'delete',
                binhLuanId: commentId
            });
            
            fetch(contextPath + '/comments', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: params.toString()
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                console.log('Delete response:', data);
                if (data.success) {
                    showAlert('Xóa bình luận thành công!', 'success');
                    
                    // Remove comment from DOM immediately
                    const commentElement = document.querySelector('[data-comment-id="' + commentId + '"]');
                    if (commentElement) {
                        commentElement.style.opacity = '0';
                        commentElement.style.transform = 'translateY(-20px)';
                        setTimeout(function() {
                            commentElement.remove();
                            updateCommentCountDecrease();
                        }, 300);
                    }
                } else {
                    showAlert(data.message || 'Có lỗi xảy ra', 'danger');
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                showAlert('Có lỗi xảy ra khi xóa bình luận', 'danger');
            });
        }
        
        // Toggle reply form
        function toggleReplyForm(commentId) {
            const replyForm = document.getElementById('replyForm-' + commentId);
            if (replyForm) {
                replyForm.classList.toggle('show');
                
                if (replyForm.classList.contains('show')) {
                    const textarea = replyForm.querySelector('textarea');
                    setTimeout(function() {
                        textarea.focus();
                    }, 100);
                }
            }
        }
        
        // Function to add new comment to the list
        function addNewCommentToList(commentData) {
            const commentsList = document.getElementById('commentsList');
            if (!commentsList) return;
            
            // Create new comment HTML
            const newCommentHTML = '<div class="comment-item ' + (commentData.nguoiDung.trangThaiVIP ? 'vip' : '') + '" ' +
                'data-comment-id="' + commentData.id + '" style="opacity: 0; transform: translateY(20px);">' +
                '<div class="comment-header">' +
                    '<div class="comment-avatar ' + (commentData.nguoiDung.trangThaiVIP ? 'vip' : '') + '">' +
                        (commentData.nguoiDung.anhDaiDien ? 
                            '<img src="' + contextPath + '/' + commentData.nguoiDung.anhDaiDien + '" ' +
                                 'alt="' + commentData.nguoiDung.hoTen + '" ' +
                                 'class="avatar ' + (commentData.nguoiDung.trangThaiVIP ? 'vip' : '') + '">' :
                            '<div class="avatar-placeholder ' + (commentData.nguoiDung.trangThaiVIP ? 'vip' : '') + '">' +
                                '<i class="fas fa-user"></i>' +
                            '</div>'
                        ) +
                    '</div>' +
                    '<div class="comment-info">' +
                        '<div class="comment-author">' +
                            commentData.nguoiDung.hoTen +
                            (commentData.nguoiDung.trangThaiVIP ? 
                                '<span class="vip-badge">' +
                                    '<i class="fas fa-crown"></i>VIP' +
                                '</span>' :
                                ''
                            ) +
                        '</div>' +
                        '<div class="comment-time">' +
                            'Vừa xong' +
                        '</div>' +
                    '</div>' +
                    '<div class="comment-actions">' +
                        (commentData.nguoiDung.id == ${sessionScope.user.id} || '${sessionScope.user.vaiTro}' == 'ADMIN' ? 
                            '<button class="comment-btn delete" ' +
                                    'onclick="deleteComment(' + commentData.id + ')">' +
                                '<i class="fas fa-trash me-1"></i>Xóa' +
                            '</button>' : ''
                        ) +
                    '</div>' +
                '</div>' +
                '<div class="comment-content">' +
                    commentData.noiDung +
                '</div>' +
            '</div>';
            
            // Add new comment at the beginning of the list
            commentsList.insertAdjacentHTML('afterbegin', newCommentHTML);
            
            // Animate comment
            const newComment = commentsList.firstElementChild;
            setTimeout(function() {
                newComment.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                newComment.style.opacity = '1';
                newComment.style.transform = 'translateY(0)';
            }, 100);
        }
        
        // Function to add new reply to the list
        function addNewReplyToList(parentCommentId, replyData) {
            const parentComment = document.querySelector('[data-comment-id="' + parentCommentId + '"]');
            if (!parentComment) return;
            
            // Find or create reply container
            let replyContainer = parentComment.querySelector('.reply-comments');
            if (!replyContainer) {
                replyContainer = document.createElement('div');
                replyContainer.className = 'reply-comments';
                parentComment.appendChild(replyContainer);
            }
            
            // Create new reply HTML
            const newReplyHTML = '<div class="reply-comment ' + (replyData.nguoiDung.trangThaiVIP ? 'vip' : '') + '" ' +
                'data-comment-id="' + replyData.id + '" style="opacity: 0; transform: translateY(20px);">' +
                '<div class="comment-header">' +
                    '<div class="comment-avatar ' + (replyData.nguoiDung.trangThaiVIP ? 'vip' : '') + '">' +
                        (replyData.nguoiDung.anhDaiDien ? 
                            '<img src="' + contextPath + '/' + replyData.nguoiDung.anhDaiDien + '" ' +
                                 'alt="' + replyData.nguoiDung.hoTen + '" ' +
                                 'class="avatar ' + (replyData.nguoiDung.trangThaiVIP ? 'vip' : '') + '">' :
                            '<div class="avatar-placeholder ' + (replyData.nguoiDung.trangThaiVIP ? 'vip' : '') + '">' +
                                '<i class="fas fa-user"></i>' +
                            '</div>'
                        ) +
                    '</div>' +
                    '<div class="comment-info">' +
                        '<div class="comment-author">' +
                            replyData.nguoiDung.hoTen +
                            (replyData.nguoiDung.trangThaiVIP ? 
                                '<span class="vip-badge">' +
                                    '<i class="fas fa-crown"></i>VIP' +
                                '</span>' :
                                ''
                            ) +
                        '</div>' +
                        '<div class="comment-time">' +
                            'Vừa xong' +
                        '</div>' +
                    '</div>' +
                    '<div class="comment-actions">' +
                        (replyData.nguoiDung.id == ${sessionScope.user.id} || '${sessionScope.user.vaiTro}' == 'ADMIN' ? 
                            '<button class="comment-btn delete" ' +
                                    'onclick="deleteComment(' + replyData.id + ')">' +
                                '<i class="fas fa-trash me-1"></i>Xóa' +
                            '</button>' : ''
                        ) +
                    '</div>' +
                '</div>' +
                '<div class="comment-content">' +
                    replyData.noiDung +
                '</div>' +
            '</div>';
            
            // Add reply at the end of replies
            replyContainer.insertAdjacentHTML('beforeend', newReplyHTML);
            
            // Animate reply
            const newReply = replyContainer.lastElementChild;
            setTimeout(function() {
                newReply.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                newReply.style.opacity = '1';
                newReply.style.transform = 'translateY(0)';
            }, 100);
        }
        
        // Function to update comment count (increase)
        function updateCommentCount() {
            const commentCountElements = document.querySelectorAll('#totalCommentsCount');
            commentCountElements.forEach(function(element) {
                const text = element.textContent;
                const match = text.match(/(\d+)/);
                if (match) {
                    const currentCount = parseInt(match[1]);
                    const newCount = currentCount + 1;
                    element.textContent = text.replace(/\d+/, newCount);
                }
            });
        }
        
        // Function to update comment count (decrease)
        function updateCommentCountDecrease() {
            const commentCountElements = document.querySelectorAll('#totalCommentsCount');
            commentCountElements.forEach(function(element) {
                const text = element.textContent;
                const match = text.match(/(\d+)/);
                if (match) {
                    const currentCount = parseInt(match[1]);
                    const newCount = Math.max(0, currentCount - 1);
                    element.textContent = text.replace(/\d+/, newCount);
                }
            });
        }
        
        // Show alert function
        function showAlert(message, type) {
            // Remove existing alerts
            const existingAlerts = document.querySelectorAll('.alert');
            existingAlerts.forEach(function(alert) {
                alert.remove();
            });
            
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-' + type;
            alertDiv.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check-circle' : type === 'danger' ? 'exclamation-circle' : 'info-circle') + ' me-2"></i>' + message;
            
            document.body.appendChild(alertDiv);
            
            // Auto remove after 3 seconds
            setTimeout(function() {
                alertDiv.style.animation = 'slideOutAlert 0.3s ease-out forwards';
                setTimeout(function() {
                    if (alertDiv.parentNode) {
                        alertDiv.remove();
                    }
                }, 300);
            }, 3000);
        }
        
        // Change sort order
        function changeSortOrder(sortOrder) {
            const url = new URL(window.location);
            url.searchParams.set('sort', sortOrder);
            url.searchParams.set('page', '1'); // Reset to first page
            window.location.href = url.toString();
        }
        
        // Add slide out animation
        const style = document.createElement('style');
        style.textContent = '@keyframes slideOutAlert { from { transform: translateX(0); opacity: 1; } to { transform: translateX(100%); opacity: 0; } }';
        document.head.appendChild(style);
        
        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            // Add scroll animations
            const observer = new IntersectionObserver(function(entries) {
                entries.forEach(function(entry) {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            });
            
            // Observe comment items
            document.querySelectorAll('.comment-item').forEach(function(item) {
                item.style.opacity = '0';
                item.style.transform = 'translateY(20px)';
                item.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                observer.observe(item);
            });
            
            // Auto-resize textareas
            document.querySelectorAll('textarea').forEach(function(textarea) {
                textarea.addEventListener('input', function() {
                    this.style.height = 'auto';
                    this.style.height = this.scrollHeight + 'px';
                });
            });
        });
    </script>
</body>
</html>