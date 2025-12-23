<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${truyen.tenTruyen} - Chi tiết truyện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --vip-gradient: linear-gradient(135deg, #ffd700 0%, #ffb347 100%);
            --glass-bg: rgba(255, 255, 255, 0.25);
            --glass-border: rgba(255, 255, 255, 0.18);
            --shadow-light: 0 8px 32px rgba(31, 38, 135, 0.37);
            --shadow-medium: 0 15px 35px rgba(31, 38, 135, 0.4);
            --border-radius: 20px;
            --transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            background-attachment: fixed;
            color: #333;
            min-height: 100vh;
            margin: 0;
            padding: 0;
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

        /* Navigation */
        .navbar {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--glass-border);
            box-shadow: var(--shadow-light);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 700;
            color: #fff !important;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .navbar-brand i {
            font-size: 2rem;
            background: var(--vip-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .back-btn {
            background: var(--glass-bg);
            color: #fff;
            border: 1px solid var(--glass-border);
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            backdrop-filter: blur(20px);
            transition: var(--transition);
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            color: #fff;
            transform: translateY(-2px);
        }

        /* Story Header */
        .story-header {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 2rem;
            margin: 2rem 0;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-medium);
        }

        .story-cover {
            width: 100%;
            max-width: 250px;
            height: 350px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: var(--shadow-medium);
            transition: var(--transition);
        }

        .story-cover:hover {
            transform: scale(1.05);
        }

        .story-info h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 1rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .story-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.95rem;
        }

        .meta-item i {
            color: #ffd700;
        }

        .story-status {
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .status-ongoing {
            background: linear-gradient(135deg, #4ecdc4 0%, #44a08d 100%);
            color: white;
        }

        .status-completed {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .vip-badge {
            background: var(--vip-gradient);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .story-description {
            color: rgba(255, 255, 255, 0.9);
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .action-btn {
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            border: none;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: var(--transition);
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, #ff6b6b 0%, #ff8e53 100%);
            color: white;
        }

        .btn-secondary {
            background: var(--glass-bg);
            color: #fff;
            border: 1px solid var(--glass-border);
        }

        .btn-outline {
            background: transparent;
            color: #fff;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }
        
        .action-btn.active {
            background: var(--vip-gradient);
            color: white;
            border-color: transparent;
        }
        
        .action-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        /* Chapter List */
        .chapter-section {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 2rem;
            margin: 2rem 0;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-medium);
        }

        .chapter-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .chapter-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
            color: #fff;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .chapter-count {
            background: var(--vip-gradient);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .chapter-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .chapter-item {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: var(--transition);
            cursor: pointer;
            position: relative;
        }

        .chapter-item:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
        }

        .chapter-item.vip {
            border-color: #ffd700;
        }

        .chapter-item.vip::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(255, 215, 0, 0.1) 0%, rgba(255, 179, 71, 0.1) 100%);
            border-radius: 15px;
            z-index: 1;
        }

        .chapter-content {
            position: relative;
            z-index: 2;
        }

        .chapter-number {
            background: var(--primary-gradient);
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 10px;
            font-size: 0.75rem;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 0.5rem;
        }

        .chapter-title {
            font-size: 1rem;
            font-weight: 600;
            color: #fff;
            margin-bottom: 0.5rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .chapter-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.7);
        }

        .chapter-vip-badge {
            background: var(--vip-gradient);
            color: white;
            padding: 0.2rem 0.5rem;
            border-radius: 10px;
            font-size: 0.7rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            position: absolute;
            top: 0.5rem;
            right: 0.5rem;
            z-index: 3;
        }

        /* Comments Section - Moved to bottom */
        .comments-section {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 2rem;
            margin: 2rem 0;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-medium);
        }

        .comments-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .comments-header h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .comment-count {
            background: var(--vip-gradient);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .comment-form {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .form-control {
            background: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 10px;
            padding: 0.75rem;
            color: #333;
            transition: var(--transition);
            width: 100%;
            resize: vertical;
        }

        .form-control:focus {
            background: white;
            border-color: rgba(255, 255, 255, 0.5);
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.1);
            outline: none;
        }

        .form-label {
            color: #fff;
            font-weight: 600;
            margin-bottom: 0.5rem;
            display: block;
        }

        .comment-item {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: var(--transition);
        }

        .comment-item:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
        }

        .comment-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .comment-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 1.2rem;
            position: relative;
            flex-shrink: 0;
        }

        .comment-avatar img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
        }

        /* VIP Crown for comment avatars */
        .comment-avatar.vip::before {
            content: '👑';
            position: absolute;
            top: -8px;
            right: -8px;
            font-size: 1.2rem;
            z-index: 10;
            animation: crownFloat 2s ease-in-out infinite;
            filter: drop-shadow(0 0 10px rgba(255, 215, 0, 0.8));
        }

        @keyframes crownFloat {
            0%, 100% { 
                transform: translateY(0px) rotate(-10deg); 
            }
            50% { 
                transform: translateY(-3px) rotate(-5deg); 
            }
        }

        .comment-info {
            flex: 1;
            min-width: 0;
        }

        .comment-author {
            font-weight: 600;
            color: #fff;
            margin-bottom: 0.25rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .comment-time {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.85rem;
        }

        .comment-content {
            color: #fff;
            line-height: 1.6;
            margin-bottom: 1rem;
            word-wrap: break-word;
            overflow-wrap: break-word;
        }

        .view-all-comments {
            text-align: center;
            margin-top: 1.5rem;
        }

        .vip-badge-comment {
            background: var(--vip-gradient);
            color: white;
            padding: 0.2rem 0.5rem;
            border-radius: 12px;
            font-size: 0.7rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            animation: vipPulse 2s ease-in-out infinite;
            white-space: nowrap;
        }

        @keyframes vipPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        /* Pagination */
        .pagination {
            justify-content: center;
            margin-top: 2rem;
        }

        .pagination .page-link {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            color: #fff;
            padding: 0.75rem 1rem;
            margin: 0 0.25rem;
            border-radius: 10px;
            transition: var(--transition);
        }

        .pagination .page-link:hover {
            background: rgba(255, 255, 255, 0.3);
            color: #fff;
            transform: translateY(-2px);
        }

        .pagination .page-item.active .page-link {
            background: var(--primary-gradient);
            border-color: transparent;
        }

        /* VIP Modal */
        .vip-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 2000;
            backdrop-filter: blur(10px);
        }

        .vip-modal.show {
            display: flex;
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.3s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .vip-modal-content {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 2rem;
            max-width: 500px;
            width: 90%;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-medium);
            text-align: center;
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .vip-modal-content h3 {
            color: #fff;
            margin-bottom: 1rem;
        }

        .vip-modal-content p {
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .vip-modal-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .modal-btn {
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .modal-btn.upgrade {
            background: var(--vip-gradient);
            color: white;
        }

        .modal-btn.close {
            background: transparent;
            color: #fff;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .modal-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: rgba(255, 255, 255, 0.8);
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        /* Alerts */
        .alert {
            border-radius: 15px;
            border: none;
            padding: 1rem;
            margin-bottom: 1rem;
            backdrop-filter: blur(10px);
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
            background: rgba(76, 175, 80, 0.2);
            color: #fff;
            border: 1px solid rgba(76, 175, 80, 0.3);
        }

        .alert-danger {
            background: rgba(244, 67, 54, 0.2);
            color: #fff;
            border: 1px solid rgba(244, 67, 54, 0.3);
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
            .story-header {
                padding: 1.5rem;
            }
            
            .story-info h1 {
                font-size: 2rem;
            }
            
            .story-meta {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .chapter-list {
                grid-template-columns: 1fr;
            }
            
            .chapter-header {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }
            
            .vip-modal-content {
                padding: 1.5rem;
            }
            
            .vip-modal-buttons {
                flex-direction: column;
            }

            .comments-section {
                padding: 1.5rem;
            }

            .comments-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .comment-form {
                padding: 1rem;
            }

            .comment-item {
                padding: 1rem;
            }

            .comment-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
            }

            .comment-avatar {
                width: 45px;
                height: 45px;
                font-size: 1.1rem;
            }

            .comment-avatar.vip::before {
                font-size: 1rem;
                top: -6px;
                right: -6px;
            }

            .comment-author {
                font-size: 0.95rem;
            }

            .vip-badge-comment {
                font-size: 0.65rem;
                padding: 0.15rem 0.4rem;
            }
        }

        @media (max-width: 576px) {
            .story-header {
                padding: 1rem;
            }
            
            .story-info h1 {
                font-size: 1.5rem;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .chapter-section {
                padding: 1rem;
            }

            .comments-section {
                padding: 1rem;
            }

            .comment-form {
                padding: 0.75rem;
            }

            .comment-item {
                padding: 0.75rem;
            }

            .comment-avatar {
                width: 40px;
                height: 40px;
                font-size: 1rem;
            }

            .comment-avatar.vip::before {
                font-size: 0.9rem;
                top: -5px;
                right: -5px;
            }

            .comment-author {
                font-size: 0.9rem;
            }

            .comment-time {
                font-size: 0.8rem;
            }

            .comment-content {
                font-size: 0.95rem;
            }

            .vip-badge-comment {
                font-size: 0.6rem;
                padding: 0.1rem 0.3rem;
            }

            .form-control {
                padding: 0.6rem;
                font-size: 0.95rem;
            }

            .action-btn {
                padding: 0.6rem 1.2rem;
                font-size: 0.9rem;
            }
        }

        @media (max-width: 480px) {
            .comments-header h3 {
                font-size: 1.3rem;
            }

            .comment-count {
                font-size: 0.8rem;
                padding: 0.2rem 0.6rem;
            }

            .comment-avatar {
                width: 35px;
                height: 35px;
                font-size: 0.9rem;
            }

            .comment-avatar.vip::before {
                font-size: 0.8rem;
                top: -4px;
                right: -4px;
            }

            .comment-author {
                font-size: 0.85rem;
            }

            .vip-badge-comment {
                font-size: 0.55rem;
                padding: 0.1rem 0.25rem;
            }

            .alert {
                max-width: calc(100vw - 2rem);
                margin: 1rem;
                top: 10px;
                right: 10px;
            }
        }

        /* Ultra small screens */
        @media (max-width: 360px) {
            .story-header {
                padding: 0.75rem;
            }

            .comments-section {
                padding: 0.75rem;
            }

            .comment-form {
                padding: 0.5rem;
            }

            .comment-item {
                padding: 0.5rem;
            }

            .comment-avatar {
                width: 32px;
                height: 32px;
                font-size: 0.8rem;
            }

            .comment-avatar.vip::before {
                font-size: 0.7rem;
                top: -3px;
                right: -3px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-book-open"></i>
                TruyenMoi
            </a>
            <a href="${pageContext.request.contextPath}/home" class="back-btn">
                <i class="fas fa-arrow-left"></i>
                Quay lại
            </a>
        </div>
    </nav>

    <div class="container">
        <c:choose>
            <c:when test="${not empty errorMessage}">
                <!-- VIP Error Display -->
                <div class="story-header">
                    <div class="row align-items-center">
                        <div class="col-md-3 text-center">
                            <c:choose>
                                <c:when test="${not empty truyen.anhBia}">
                                    <img src="${pageContext.request.contextPath}/${truyen.anhBia}" 
                                         alt="${truyen.tenTruyen}" class="story-cover">
                                </c:when>
                                <c:otherwise>
                                    <div class="story-cover d-flex align-items-center justify-content-center bg-dark">
                                        <i class="fas fa-book fa-3x text-light"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-9">
                            <div class="story-info">
                                <h1>${truyen.tenTruyen}</h1>
                                <div class="vip-badge">
                                    <i class="fas fa-crown"></i>
                                    Nội dung VIP
                                </div>
                                <div class="empty-state mt-4">
                                    <i class="fas fa-lock"></i>
                                    <h3>Nội dung VIP</h3>
                                    <p>${errorMessage}</p>
                                    <div class="action-buttons">
                                        <a href="#" class="action-btn btn-primary">
                                            <i class="fas fa-crown"></i>
                                            Nâng cấp VIP
                                        </a>
                                        <a href="${pageContext.request.contextPath}/home" class="action-btn btn-outline">
                                            <i class="fas fa-arrow-left"></i>
                                            Quay lại
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Story Header -->
                <div class="story-header">
                    <div class="row align-items-center">
                        <div class="col-md-3 text-center">
                            <c:choose>
                                <c:when test="${not empty truyen.anhBia}">
                                    <img src="${pageContext.request.contextPath}/${truyen.anhBia}" 
                                         alt="${truyen.tenTruyen}" class="story-cover">
                                </c:when>
                                <c:otherwise>
                                    <div class="story-cover d-flex align-items-center justify-content-center bg-dark">
                                        <i class="fas fa-book fa-3x text-light"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-9">
                            <div class="story-info">
                                <h1>${truyen.tenTruyen}</h1>
                                
                                <div class="story-meta">
                                    <div class="meta-item">
                                        <i class="fas fa-user"></i>
                                        <span>Tác giả: ${truyen.tacGiaTen}</span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-list"></i>
                                        <span>Thể loại: 
                                            <c:forEach var="theLoai" items="${truyen.theLoaiTenList}" varStatus="loop">
                                                ${theLoai}<c:if test="${!loop.last}">, </c:if>
                                            </c:forEach>
                                        </span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-eye"></i>
                                        <span>${truyen.luotXemFormatted} lượt xem</span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-star"></i>
                                        <span>${truyen.danhGiaFormatted}/5</span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-comments"></i>
                                        <span id="totalCommentsDisplay">${totalComments} bình luận</span>
                                    </div>
                                </div>

                                <div class="d-flex align-items-center gap-3 mb-3">
                                    <span class="story-status ${truyen.trangThai == 'HOAN_THANH' ? 'status-completed' : 'status-ongoing'}">
                                        <c:choose>
                                            <c:when test="${truyen.trangThai == 'HOAN_THANH'}">Hoàn thành</c:when>
                                            <c:otherwise>Đang ra</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <c:if test="${truyen.chiDanhChoVIP}">
                                        <span class="vip-badge">
                                            <i class="fas fa-crown"></i>
                                            VIP
                                        </span>
                                    </c:if>
                                </div>

                                <div class="story-description">
                                    ${truyen.moTa}
                                </div>

                                <div class="action-buttons">
                                    <c:if test="${not empty danhSachChuong}">
                                        <a href="${pageContext.request.contextPath}/chapter?id=${danhSachChuong[0].id}" class="action-btn btn-primary">
                                            <i class="fas fa-play"></i>
                                            Đọc từ đầu
                                        </a>
                                    </c:if>
                                    <a href="#chapters" class="action-btn btn-secondary">
                                        <i class="fas fa-list"></i>
                                        Danh sách chương
                                    </a>
                                    <a href="#comments" class="action-btn btn-secondary">
                                        <i class="fas fa-comments"></i>
                                        <span id="commentButtonText">Bình luận (${totalComments})</span>
                                    </a>
                                    <button type="button" class="action-btn btn-outline ${isFavorite ? 'active' : ''}" 
                                            id="favoriteBtn" onclick="toggleFavorite(${truyen.id})" 
                                            ${empty sessionScope.user ? 'disabled title="Vui lòng đăng nhập"' : ''}>
                                        <i class="fas fa-heart"></i>
                                        <span id="favoriteBtnText">${isFavorite ? 'Đã yêu thích' : 'Yêu thích'}</span>
                                    </button>
                                    <button type="button" class="action-btn btn-outline ${isInLibrary ? 'active' : ''}" 
                                            id="libraryBtn" onclick="toggleLibrary(${truyen.id})" 
                                            ${empty sessionScope.user ? 'disabled title="Vui lòng đăng nhập"' : ''}>
                                        <i class="fas fa-bookmark"></i>
                                        <span id="libraryBtnText">${isInLibrary ? 'Đã lưu' : 'Lưu vào tủ'}</span>
                                    </button>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Chapter List -->
                <div class="chapter-section" id="chapters">
                    <div class="chapter-header">
                        <h2>
                            <i class="fas fa-list"></i>
                            Danh sách chương
                            <span class="chapter-count">${totalChapters} chương</span>
                        </h2>
                    </div>

                    <c:choose>
                        <c:when test="${empty danhSachChuong}">
                            <div class="empty-state">
                                <i class="fas fa-book-open"></i>
                                <h3>Chưa có chương nào</h3>
                                <p>Truyện này chưa có chương nào được đăng.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="chapter-list">
                                <c:forEach var="chuong" items="${danhSachChuong}">
                                    <div class="chapter-item ${chuong.chiDanhChoVIP ? 'vip' : ''}" 
                                         onclick="readChapter(${chuong.id}, ${chuong.chiDanhChoVIP}, '${chuong.tenChuong}')">
                                        
                                        <c:if test="${chuong.chiDanhChoVIP}">
                                            <div class="chapter-vip-badge">
                                                <i class="fas fa-crown"></i>
                                                VIP
                                            </div>
                                        </c:if>
                                        
                                        <div class="chapter-content">
                                            <div class="chapter-number">
                                                Chương ${chuong.soChuong}
                                            </div>
                                            <div class="chapter-title">
                                                ${chuong.tenChuong}
                                            </div>
                                            <div class="chapter-meta">
                                                <span>
                                                    <i class="fas fa-calendar"></i>
                                                    ${chuong.ngayTaoFormatted}
                                                </span>
                                                <span>
                                                    <i class="fas fa-eye"></i>
                                                    ${chuong.luotXemFormatted}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <nav aria-label="Chapter pagination">
                                    <ul class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/story?id=${truyen.id}&page=${currentPage - 1}">
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
                                                        <a class="page-link" href="${pageContext.request.contextPath}/story?id=${truyen.id}&page=${i}">${i}</a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/story?id=${truyen.id}&page=${currentPage + 1}">
                                                    <i class="fas fa-chevron-right"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Comments Section - Moved to bottom -->
                <div class="comments-section" id="comments">
                    <div class="comments-header">
                        <h3>
                            <i class="fas fa-comments"></i>
                            Bình luận
                            <span class="comment-count" id="commentCountBadge">${totalComments}</span>
                        </h3>
                        <c:if test="${totalComments > 5}">
                            <a href="${pageContext.request.contextPath}/comments?truyenId=${truyen.id}" class="action-btn btn-outline">
                                <i class="fas fa-eye"></i>
                                Xem tất cả
                            </a>
                        </c:if>
                    </div>

                    <!-- Comment Form -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="comment-form">
                                <form id="quickCommentForm" onsubmit="submitQuickComment(event)">
                                    <div class="mb-3">
                                        <label for="quickCommentContent" class="form-label">
                                            <i class="fas fa-edit me-2"></i>Viết bình luận
                                        </label>
                                        <textarea class="form-control" id="quickCommentContent" rows="3" 
                                                  placeholder="Chia sẻ cảm nhận của bạn về truyện..." required></textarea>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <c:if test="${totalComments > 0}">
                                            <a href="${pageContext.request.contextPath}/comments?truyenId=${truyen.id}" class="action-btn btn-outline">
                                                <i class="fas fa-comments"></i>
                                                Xem tất cả bình luận
                                            </a>
                                        </c:if>
                                        <button type="submit" class="action-btn btn-primary">
                                            <i class="fas fa-paper-plane"></i>
                                            Đăng bình luận
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

                    <!-- Recent Comments -->
                    <div id="recentCommentsContainer">
                        <c:choose>
                            <c:when test="${empty recentComments}">
                                <div class="empty-state" id="emptyCommentsState">
                                    <i class="fas fa-comments"></i>
                                    <h4>Chưa có bình luận nào</h4>
                                    <p>Hãy là người đầu tiên bình luận về truyện này!</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div id="commentsList">
                                    <c:forEach var="comment" items="${recentComments}">
                                        <div class="comment-item">
                                            <div class="comment-header">
                                                <div class="comment-avatar ${comment.nguoiDung.trangThaiVIP ? 'vip' : ''}">
                                                    <c:choose>
                                                        <c:when test="${not empty comment.nguoiDung.anhDaiDien}">
                                                            <img src="${pageContext.request.contextPath}/${comment.nguoiDung.anhDaiDien}" 
                                                                 alt="${comment.nguoiDung.hoTen}">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-user"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="comment-info">
                                                    <div class="comment-author">
                                                        ${comment.nguoiDung.hoTen}
                                                        <c:if test="${comment.nguoiDung.trangThaiVIP}">
                                                            <span class="vip-badge-comment">
                                                                <i class="fas fa-crown"></i>VIP
                                                            </span>
                                                        </c:if>
                                                    </div>
                                                    <div class="comment-time">
                                                        ${comment.ngayTaoFormatted}
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="comment-content">
                                                ${comment.noiDung}
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                
                                <c:if test="${totalComments > 3}">
                                    <div class="view-all-comments">
                                        <a href="${pageContext.request.contextPath}/comments?truyenId=${truyen.id}" class="action-btn btn-primary">
                                            <i class="fas fa-comments"></i>
                                            Xem tất cả ${totalComments} bình luận
                                        </a>
                                    </div>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- VIP Modal -->
    <div id="vipModal" class="vip-modal">
        <div class="vip-modal-content">
            <h3>
                <i class="fas fa-crown text-warning"></i>
                Nội dung VIP
            </h3>
            <p id="vipMessage">Bạn cần nâng cấp tài khoản VIP để đọc chương này!</p>
            <div class="vip-modal-buttons">
                <button class="modal-btn upgrade" onclick="upgradeVIP()">
                    <i class="fas fa-crown"></i>
                    Nâng cấp VIP
                </button>
                <button class="modal-btn close" onclick="closeVIPModal()">
                    <i class="fas fa-times"></i>
                    Đóng
                </button>
            </div>
        </div>
    </div>

    <!-- Alert Container -->
    <div id="alertContainer"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const isVIP = ${isVIP};
        const truyenId = ${truyen.id};
        const contextPath = '${pageContext.request.contextPath}';
        const isLoggedIn = ${not empty sessionScope.user};
        let isFavorite = ${isFavorite};
        let isInLibrary = ${isInLibrary};

        function readChapter(chapterId, isVIPChapter, chapterTitle) {
            if (isVIPChapter && !isVIP) {
                showVIPModal('Chương "' + chapterTitle + '" là nội dung VIP. Bạn cần nâng cấp tài khoản để đọc chương này!');
                return;
            }
            
            // Redirect to chapter detail
            window.location.href = contextPath + '/chapter?id=' + chapterId;
        }
        
        function showVIPModal(message) {
            document.getElementById('vipMessage').textContent = message;
            document.getElementById('vipModal').classList.add('show');
        }
        
        function closeVIPModal() {
            document.getElementById('vipModal').classList.remove('show');
        }
        
        function upgradeVIP() {
            // Redirect to VIP upgrade page
            window.location.href = contextPath + '/vip/register';
        }
        
        // Close modal when clicking outside
        document.getElementById('vipModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeVIPModal();
            }
        });
        
        // Show alert function
        function showAlert(message, type) {
            // Remove existing alerts
            const existingAlerts = document.querySelectorAll('.alert');
            existingAlerts.forEach(alert => alert.remove());
            
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
        
        // Quick comment submission
        function submitQuickComment(event) {
            event.preventDefault();
            
            const content = document.getElementById('quickCommentContent').value.trim();
            if (!content) {
                showAlert('Vui lòng nhập nội dung bình luận', 'danger');
                return;
            }
            
            const submitBtn = event.target.querySelector('button[type="submit"]');
            const originalContent = submitBtn.innerHTML;
            submitBtn.innerHTML = '<div class="loading-spinner"></div>Đang gửi...';
            submitBtn.disabled = true;
            
            console.log('Submitting comment...', {
                truyenId: truyenId,
                noiDung: content
            });
            
            // Create form data with proper encoding
            const params = new URLSearchParams();
            params.append('action', 'add');
            params.append('truyenId', truyenId);
            params.append('noiDung', content);
            
            fetch(contextPath + '/comments', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: params.toString()
            })
            .then(function(response) {
                console.log('Response status:', response.status);
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(function(data) {
                console.log('Response data:', data);
                if (data.success) {
                    showAlert('Bình luận thành công!', 'success');
                    document.getElementById('quickCommentContent').value = '';
                    
                    // Try to add comment to list immediately
                    if (data.commentData) {
                        addNewCommentToList(data.commentData);
                        updateCommentCount();
                    } else {
                        // Fallback: reload page after 1 second
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
        
        // Function to add new comment to the list
        function addNewCommentToList(commentData) {
            const emptyState = document.getElementById('emptyCommentsState');
            let commentsList = document.getElementById('commentsList');
            const recentCommentsContainer = document.getElementById('recentCommentsContainer');
            
            // Hide empty state if it exists
            if (emptyState) {
                emptyState.style.display = 'none';
            }
            
            // Create comments list if it doesn't exist
            if (!commentsList) {
                commentsList = document.createElement('div');
                commentsList.id = 'commentsList';
                recentCommentsContainer.appendChild(commentsList);
            }
            
            // Create new comment HTML
            const newCommentHTML = '<div class="comment-item" style="opacity: 0; transform: translateY(20px);">' +
                '<div class="comment-header">' +
                    '<div class="comment-avatar ' + (commentData.nguoiDung.trangThaiVIP ? 'vip' : '') + '">' +
                        (commentData.nguoiDung.anhDaiDien ? 
                            '<img src="' + contextPath + '/' + commentData.nguoiDung.anhDaiDien + '" alt="' + commentData.nguoiDung.hoTen + '">' :
                            '<i class="fas fa-user"></i>'
                        ) +
                    '</div>' +
                    '<div class="comment-info">' +
                        '<div class="comment-author">' +
                            commentData.nguoiDung.hoTen +
                            (commentData.nguoiDung.trangThaiVIP ? 
                                '<span class="vip-badge-comment"><i class="fas fa-crown"></i>VIP</span>' : 
                                ''
                            ) +
                        '</div>' +
                        '<div class="comment-time">Vừa xong</div>' +
                    '</div>' +
                '</div>' +
                '<div class="comment-content">' + commentData.noiDung + '</div>' +
            '</div>';
            
            // Add new comment at the beginning of the list
            commentsList.insertAdjacentHTML('afterbegin', newCommentHTML);
            
            // Animate the new comment
            const newComment = commentsList.firstElementChild;
            setTimeout(function() {
                newComment.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                newComment.style.opacity = '1';
                newComment.style.transform = 'translateY(0)';
            }, 100);
            
            // Remove the last comment if we have more than 5
            const allComments = commentsList.querySelectorAll('.comment-item');
            if (allComments.length > 5) {
                const lastComment = allComments[allComments.length - 1];
                lastComment.style.opacity = '0';
                lastComment.style.transform = 'translateY(-20px)';
                setTimeout(function() {
                    lastComment.remove();
                }, 300);
            }
        }
        
        // Function to update comment count
        function updateCommentCount() {
            // Update comment count badge
            const commentCountBadge = document.getElementById('commentCountBadge');
            if (commentCountBadge) {
                const currentCount = parseInt(commentCountBadge.textContent);
                commentCountBadge.textContent = currentCount + 1;
            }
            
            // Update total comments display
            const totalCommentsDisplay = document.getElementById('totalCommentsDisplay');
            if (totalCommentsDisplay) {
                const text = totalCommentsDisplay.textContent;
                const match = text.match(/(\d+)/);
                if (match) {
                    const currentCount = parseInt(match[1]);
                    const newCount = currentCount + 1;
                    totalCommentsDisplay.textContent = text.replace(/\d+/, newCount);
                }
            }
            
            // Update comment button text
            const commentButtonText = document.getElementById('commentButtonText');
            if (commentButtonText) {
                const text = commentButtonText.textContent;
                const match = text.match(/(\d+)/);
                if (match) {
                    const currentCount = parseInt(match[1]);
                    const newCount = currentCount + 1;
                    commentButtonText.textContent = text.replace(/\d+/, newCount);
                }
            }
        }
        
        // Add slide out animation
        const style = document.createElement('style');
        style.textContent = '@keyframes slideOutAlert { from { transform: translateX(0); opacity: 1; } to { transform: translateX(100%); opacity: 0; } }';
        document.head.appendChild(style);
        
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
        
        // Animation on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };
        
        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(function(entry) {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);
        
        // Observe elements for animation
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.chapter-item, .comment-item').forEach(function(item, index) {
                item.style.opacity = '0';
                item.style.transform = 'translateY(20px)';
                item.style.transition = 'opacity 0.6s ease ' + (index * 0.05) + 's, transform 0.6s ease ' + (index * 0.05) + 's';
                observer.observe(item);
            });
        });
        
        // Toggle favorite function
        function toggleFavorite(truyenId) {
            if (!isLoggedIn) {
                showAlert('Vui lòng đăng nhập để sử dụng chức năng này', 'warning');
                return;
            }
            
            const favoriteBtn = document.getElementById('favoriteBtn');
            const favoriteBtnText = document.getElementById('favoriteBtnText');
            const originalContent = favoriteBtn.innerHTML;
            
            favoriteBtn.disabled = true;
            favoriteBtn.innerHTML = '<div class="loading-spinner"></div>Đang xử lý...';
            
            const action = isFavorite ? 'remove' : 'add';
            const url = contextPath + '/yeuthich/' + action;
            
            const params = new URLSearchParams();
            params.append('truyenId', truyenId);
            
            fetch(url, {
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
                if (data.success) {
                    isFavorite = !isFavorite;
                    if (isFavorite) {
                        favoriteBtn.classList.add('active');
                        favoriteBtnText.textContent = 'Đã yêu thích';
                        favoriteBtn.innerHTML = '<i class="fas fa-heart"></i><span id="favoriteBtnText">Đã yêu thích</span>';
                    } else {
                        favoriteBtn.classList.remove('active');
                        favoriteBtnText.textContent = 'Yêu thích';
                        favoriteBtn.innerHTML = '<i class="fas fa-heart"></i><span id="favoriteBtnText">Yêu thích</span>';
                    }
                    showAlert(data.message, 'success');
                } else {
                    showAlert(data.message || 'Có lỗi xảy ra', 'danger');
                    favoriteBtn.innerHTML = originalContent;
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                showAlert('Có lỗi xảy ra khi xử lý', 'danger');
                favoriteBtn.innerHTML = originalContent;
            })
            .finally(function() {
                favoriteBtn.disabled = false;
            });
        }
        
        // Toggle library function
        function toggleLibrary(truyenId) {
            if (!isLoggedIn) {
                showAlert('Vui lòng đăng nhập để sử dụng chức năng này', 'warning');
                return;
            }
            
            const libraryBtn = document.getElementById('libraryBtn');
            const libraryBtnText = document.getElementById('libraryBtnText');
            const originalContent = libraryBtn.innerHTML;
            
            libraryBtn.disabled = true;
            libraryBtn.innerHTML = '<div class="loading-spinner"></div>Đang xử lý...';
            
            const action = isInLibrary ? 'remove' : 'add';
            const url = contextPath + '/tutruyen/' + action;
            
            const params = new URLSearchParams();
            params.append('truyenId', truyenId);
            
            fetch(url, {
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
                if (data.success) {
                    isInLibrary = !isInLibrary;
                    if (isInLibrary) {
                        libraryBtn.classList.add('active');
                        libraryBtnText.textContent = 'Đã lưu';
                        libraryBtn.innerHTML = '<i class="fas fa-bookmark"></i><span id="libraryBtnText">Đã lưu</span>';
                    } else {
                        libraryBtn.classList.remove('active');
                        libraryBtnText.textContent = 'Lưu vào tủ';
                        libraryBtn.innerHTML = '<i class="fas fa-bookmark"></i><span id="libraryBtnText">Lưu vào tủ</span>';
                    }
                    showAlert(data.message, 'success');
                } else {
                    showAlert(data.message || 'Có lỗi xảy ra', 'danger');
                    libraryBtn.innerHTML = originalContent;
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                showAlert('Có lỗi xảy ra khi xử lý', 'danger');
                libraryBtn.innerHTML = originalContent;
            })
            .finally(function() {
                libraryBtn.disabled = false;
            });
        }
    </script>
</body>
</html>