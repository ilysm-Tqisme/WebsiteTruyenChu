<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, maximum-scale=5.0">
    <title>${categoryTitle} - TruyenMoi</title>
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
            --hot-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e53 100%);
            --new-gradient: linear-gradient(135deg, #4ecdc4 0%, #44a08d 100%);
            
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
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            min-height: 100vh;
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

        .navbar-nav .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .navbar-nav .nav-link:hover::before {
            left: 100%;
        }

        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            background: var(--glass-bg);
            color: #fff !important;
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }

        /* Back Button */
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
            position: relative;
            overflow: hidden;
        }

        .back-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .back-btn:hover::before {
            left: 100%;
        }

        .back-btn:hover {
            color: #fff;
            transform: translateY(-3px) scale(1.05);
            box-shadow: var(--shadow-heavy);
            border-color: rgba(255, 255, 255, 0.4);
        }

        /* Breadcrumb */
        .breadcrumb-nav {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-light);
        }

        .breadcrumb {
            margin: 0;
            background: none;
        }

        .breadcrumb-item a {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            transition: var(--transition);
            font-weight: 500;
        }

        .breadcrumb-item a:hover {
            color: #ffd700;
        }

        .breadcrumb-item.active {
            color: rgba(255, 255, 255, 0.7);
        }

        .breadcrumb-item + .breadcrumb-item::before {
            color: rgba(255, 255, 255, 0.6);
        }

        /* Search and Filter Section */
        .search-filter-section {
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

        .search-filter-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .search-filter-section .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 1.5rem;
            text-align: center;
            position: relative;
            z-index: 1;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .search-form {
            position: relative;
            z-index: 1;
            margin-bottom: 1.5rem;
        }

        .search-form .form-control {
            border-radius: 50px;
            padding: 1rem 1.5rem 1rem 3.5rem;
            border: 2px solid var(--glass-border);
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            color: #fff;
            font-size: 1rem;
            transition: var(--transition);
            box-shadow: var(--shadow-light);
        }

        .search-form .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .search-form .form-control:focus {
            border-color: rgba(255, 255, 255, 0.5);
            box-shadow: 0 0 0 4px rgba(255, 255, 255, 0.2), var(--shadow-medium);
            outline: none;
            transform: translateY(-2px) scale(1.02);
        }

        .search-form .search-icon {
            position: absolute;
            left: 1.5rem;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.2rem;
        }

        .filter-controls {
            position: relative;
            z-index: 1;
        }

        .filter-controls .form-control,
        .filter-controls .form-select {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border: 2px solid rgba(103, 80, 164, 0.3);
            border-radius: 15px;
            color: #333;
            padding: 0.75rem 1rem;
            transition: var(--transition);
            font-size: 0.9rem;
            font-weight: 500;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .filter-controls .form-control::placeholder,
        .filter-controls .form-select option {
            color: #666;
            background: white;
        }

        .filter-controls .form-control:focus,
        .filter-controls .form-select:focus {
            border-color: var(--primary-gradient);
            box-shadow: 0 0 0 4px rgba(103, 80, 164, 0.2);
            outline: none;
            background: white;
            transform: translateY(-2px);
        }

        .filter-controls .form-select {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23333' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m1 6 7 7 7-7'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 16px 12px;
        }

        .filter-controls .form-select:hover {
            background: white;
            border-color: var(--primary-gradient);
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        /* Page Header */
        .page-header {
            text-align: center;
            padding: 3rem 2rem;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            margin: 2rem 0;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-medium);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        .category-icon {
            width: 100px;
            height: 100px;
            border-radius: var(--border-radius);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: white;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-heavy);
            transition: var(--transition);
            position: relative;
            z-index: 1;
            overflow: hidden;
        }

        .category-icon::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transition: var(--transition);
            transform: translate(-50%, -50%);
        }

        .category-icon:hover::before {
            width: 100%;
            height: 100%;
        }

        .category-icon:hover {
            transform: scale(1.1) rotate(5deg);
        }

        .category-icon.vip {
            background: var(--vip-gradient);
        }

        .category-icon.hot {
            background: var(--hot-gradient);
        }

        .category-icon.new {
            background: var(--new-gradient);
        }

        .page-title {
            font-size: clamp(2rem, 5vw, 3rem);
            font-weight: 700;
            background: linear-gradient(135deg, #fff 0%, #e0e7ff 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1rem;
            text-shadow: 0 2px 20px rgba(255, 255, 255, 0.5);
            position: relative;
            z-index: 1;
        }

        .page-description {
            font-size: clamp(1rem, 3vw, 1.2rem);
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 1.5rem;
            position: relative;
            z-index: 1;
        }

        .stats-info {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            color: #fff;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-light);
            position: relative;
            z-index: 1;
        }

        /* Story Cards */
        .story-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--shadow-light);
            transition: var(--transition);
            height: 100%;
            border: 1px solid var(--glass-border);
            position: relative;
        }

        .story-card:hover {
            box-shadow: var(--shadow-heavy);
            transform: translateY(-8px) scale(1.02);
            border-color: rgba(255, 255, 255, 0.4);
        }

        .story-image-container {
            position: relative;
            overflow: hidden;
        }

        .story-image {
            width: 100%;
            height: 280px;
            object-fit: cover;
            transition: var(--transition);
        }

        .story-card:hover .story-image {
            transform: scale(1.1);
            filter: brightness(1.1) saturate(1.3);
        }

        /* Story Badges */
        .story-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.4rem;
            box-shadow: var(--shadow-medium);
            z-index: 2;
            animation: pulse 2s ease-in-out infinite;
        }

        .vip-badge {
            background: var(--vip-gradient);
        }

        .hot-badge {
            background: var(--hot-gradient);
        }

        .new-badge {
            background: var(--new-gradient);
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .story-info {
            padding: 1.2rem;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
        }

        .story-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #fff;
            margin-bottom: 0.75rem;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            transition: var(--transition);
            text-shadow: 0 1px 5px rgba(0, 0, 0, 0.3);
        }

        .story-card:hover .story-title {
            color: #ffd700;
        }

        .story-author {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.85rem;
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .story-meta {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            font-size: 0.75rem;
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 0.75rem;
        }

        .story-stats {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            padding: 0.6rem;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .story-stats span {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            flex: 1;
            gap: 0.3rem;
            transition: var(--transition);
            font-size: 0.65rem;
            position: relative;
        }

        .story-stats span:not(:last-child)::after {
            content: '';
            position: absolute;
            right: -1px;
            top: 20%;
            height: 60%;
            width: 1px;
            background: rgba(255, 255, 255, 0.2);
        }

        .story-stats span i {
            font-size: 0.9rem;
            margin-bottom: 0.2rem;
            opacity: 0.8;
        }

        .story-stats span .stat-value {
            font-weight: 600;
            color: #fff;
            font-size: 0.75rem;
        }

        .story-stats span .stat-label {
            font-size: 0.6rem;
            opacity: 0.7;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .story-stats span:hover {
            transform: translateY(-2px);
        }

        .story-stats span:hover i {
            opacity: 1;
            transform: scale(1.1);
        }

        .story-status {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.65rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .status-ongoing {
            background: var(--new-gradient);
            color: white;
        }

        .status-completed {
            background: var(--success-gradient);
            color: white;
        }

        .status-paused {
            background: var(--warning-gradient);
            color: white;
        }

        /* Category Tags */
        .category-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.4rem;
            margin-top: 0.75rem;
        }

        .category-tag {
            background: linear-gradient(135deg, rgba(103, 80, 164, 0.8) 0%, rgba(125, 82, 96, 0.8) 100%);
            color: white;
            padding: 0.3rem 0.6rem;
            border-radius: 12px;
            font-size: 0.65rem;
            font-weight: 500;
            transition: var(--transition);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        }

        .category-tag:hover {
            background: linear-gradient(135deg, rgba(103, 80, 164, 1) 0%, rgba(125, 82, 96, 1) 100%);
            transform: scale(1.05);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-light);
            color: rgba(255, 255, 255, 0.8);
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            opacity: 0.6;
            color: rgba(255, 255, 255, 0.5);
        }

        .empty-state h3 {
            color: #fff;
            margin-bottom: 1rem;
        }

        /* Pagination */
        .pagination {
            justify-content: center;
            margin-top: 3rem;
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
            position: relative;
            overflow: hidden;
        }

        .pagination .page-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .pagination .page-link:hover::before {
            left: 100%;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-header {
                padding: 2rem 1rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .category-icon {
                width: 80px;
                height: 80px;
                font-size: 2rem;
            }

            .story-image {
                height: 240px;
            }

            .story-meta {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .story-stats {
                gap: 0.5rem;
            }

            .navbar-brand {
                font-size: 1.5rem;
            }

            .back-btn {
                padding: 0.6rem 1.2rem;
                font-size: 0.9rem;
            }

            .search-filter-section {
                padding: 1.5rem;
            }
        }

        @media (max-width: 576px) {
            .page-header {
                padding: 1.5rem 1rem;
                margin: 1rem 0;
            }

            .category-icon {
                width: 70px;
                height: 70px;
                font-size: 1.8rem;
            }

            .story-image {
                height: 200px;
            }

            .story-info {
                padding: 1rem;
            }

            .story-stats span {
                font-size: 0.65rem;
                padding: 0.3rem 0.5rem;
            }

            .category-tag {
                font-size: 0.6rem;
                padding: 0.25rem 0.5rem;
            }

            .pagination .page-link {
                padding: 0.6rem 0.8rem;
                font-size: 0.85rem;
            }

            .row.g-4 {
                --bs-gutter-x: 0.75rem;
                --bs-gutter-y: 0.75rem;
            }

            .search-filter-section {
                padding: 1rem;
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
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/truyen">
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

    <div class="container">
        <!-- Back Button -->
        <a href="${pageContext.request.contextPath}/home" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            <span>Quay lại trang chủ</span>
        </a>

        <!-- Breadcrumb -->
        <nav class="breadcrumb-nav">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-home"></i> Trang chủ
                    </a>
                </li>
                <li class="breadcrumb-item active">${categoryTitle}</li>
            </ol>
        </nav>

        <!-- Search and Filter Section -->
        <div class="search-filter-section">
            <h2 class="section-title">🔍 Tìm kiếm và lọc truyện</h2>
            
            <!-- Search Form -->
            <form class="search-form" action="${pageContext.request.contextPath}/truyen" method="GET">
                <input type="text" class="form-control" name="keyword" 
                       placeholder="Tìm kiếm theo tên truyện hoặc tác giả..." value="${keyword}">
                <i class="fas fa-search search-icon"></i>
                
                <!-- Giữ lại các tham số khác -->
                <c:if test="${not empty selectedCategory}">
                    <input type="hidden" name="theLoai" value="${selectedCategory}">
                </c:if>
                <c:if test="${not empty sortBy}">
                    <input type="hidden" name="sort" value="${sortBy}">
                </c:if>
                <c:if test="${not empty category}">
                    <input type="hidden" name="category" value="${category}">
                </c:if>
            </form>
            
            <!-- Filter Controls -->
            <div class="filter-controls">
                <div class="row g-3">
                    <div class="col-md-6">
                        <select class="form-select" onchange="filterByCategory(this.value)">
                            <option value="">🎭 Tất cả thể loại</option>
                            <c:forEach var="theLoai" items="${danhSachTheLoai}">
                                <option value="${theLoai.id}" ${selectedCategory == theLoai.id ? 'selected' : ''}>
                                    ${theLoai.tenTheLoai}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <select class="form-select" onchange="sortStories(this.value)">
                            <option value="">📊 Sắp xếp theo</option>
                            <option value="ngay_tao" ${sortBy == 'ngay_tao' ? 'selected' : ''}>🆕 Mới nhất</option>
                            <option value="luot_xem" ${sortBy == 'luot_xem' ? 'selected' : ''}>👁️ Lượt xem</option>
                            <option value="danh_gia" ${sortBy == 'danh_gia' ? 'selected' : ''}>⭐ Đánh giá</option>
                            <option value="ten_truyen" ${sortBy == 'ten_truyen' ? 'selected' : ''}>🔤 Tên A-Z</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
            
        <!-- Page Header -->
        <div class="page-header">
            <div class="category-icon ${category}">
                <c:choose>
                    <c:when test="${category == 'vip'}">
                        <i class="fas fa-crown"></i>
                    </c:when>
                    <c:when test="${category == 'hot'}">
                        <i class="fas fa-fire"></i>
                    </c:when>
                    <c:when test="${category == 'new'}">
                        <i class="fas fa-clock"></i>
                    </c:when>
                    <c:when test="${not empty keyword || not empty selectedCategory}">
                        <i class="fas fa-search"></i>
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-book"></i>
                    </c:otherwise>
                </c:choose>
            </div>
            <h1 class="page-title">${categoryTitle}</h1>
            <p class="page-description">${categoryDescription}</p>
            <div class="stats-info">
                <i class="fas fa-chart-bar"></i>
                <span>Tổng cộng ${totalStories} truyện</span>
            </div>
        </div>

        <!-- Stories Grid -->
        <c:choose>
            <c:when test="${empty danhSachTruyen}">
                <div class="empty-state">
                    <c:choose>
                        <c:when test="${category == 'vip'}">
                            <i class="fas fa-crown"></i>
                            <h3>Chưa có truyện VIP nào</h3>
                            <p>Hãy quay lại sau để khám phá những nội dung độc quyền.</p>
                        </c:when>
                        <c:when test="${category == 'hot'}">
                            <i class="fas fa-fire"></i>
                            <h3>Chưa có truyện hot nào</h3>
                            <p>Hãy quay lại sau để khám phá những truyện được yêu thích nhất.</p>
                        </c:when>
                        <c:when test="${category == 'new'}">
                            <i class="fas fa-clock"></i>
                            <h3>Chưa có truyện mới nào</h3>
                            <p>Hãy quay lại sau để khám phá những truyện mới nhất.</p>
                        </c:when>
                        <c:when test="${not empty keyword || not empty selectedCategory}">
                            <i class="fas fa-search"></i>
                            <h3>Không tìm thấy truyện nào</h3>
                            <p>Thử thay đổi từ khóa tìm kiếm hoặc bộ lọc của bạn.</p>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-book"></i>
                            <h3>Không tìm thấy truyện nào</h3>
                            <p>Thử thay đổi bộ lọc hoặc quay lại sau.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="truyen" items="${danhSachTruyen}" varStatus="status">
                        <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 col-6">
                            <div class="story-card">
                                <a href="${pageContext.request.contextPath}/story?id=${truyen.id}" class="text-decoration-none">
                                    <div class="story-image-container">
                                        <c:choose>
                                            <c:when test="${not empty truyen.anhBia}">
                                                <img src="${pageContext.request.contextPath}/${truyen.anhBia}" 
                                                     alt="${truyen.tenTruyen}" class="story-image">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="story-image d-flex align-items-center justify-content-center bg-dark">
                                                    <i class="fas fa-book fa-3x text-light"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <!-- Hiển thị badge theo thuộc tính truyện -->
                                        <c:choose>
                                            <c:when test="${truyen.chiDanhChoVIP}">
                                                <div class="story-badge vip-badge">
                                                    <i class="fas fa-crown"></i>
                                                    VIP
                                                </div>
                                            </c:when>
                                            <c:when test="${truyen.noiBat}">
                                                <div class="story-badge hot-badge">
                                                    <i class="fas fa-fire"></i>
                                                    HOT
                                                </div>
                                            </c:when>
                                            <c:when test="${truyen.truyenMoi}">
                                                <div class="story-badge new-badge">
                                                    <i class="fas fa-clock"></i>
                                                    MỚI
                                                </div>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    
                                    <div class="story-info">
                                        <h5 class="story-title">${truyen.tenTruyen}</h5>
                                        <p class="story-author">
                                            <i class="fas fa-user"></i>${truyen.tacGiaTen}
                                        </p>
                                        
                                        <div class="story-meta">
                                            <div class="story-stats">
                                                <span title="Lượt xem">
                                                    <i class="fas fa-eye"></i>
                                                    <div class="stat-value">${truyen.luotXemFormatted}</div>
                                                    <div class="stat-label">Lượt xem</div>
                                                </span>
                                                <span title="Số chương">
                                                    <i class="fas fa-list"></i>
                                                    <div class="stat-value">${truyen.soLuongChuong}</div>
                                                    <div class="stat-label">Chương</div>
                                                </span>
                                                <span title="Đánh giá">
                                                    <i class="fas fa-star"></i>
                                                    <div class="stat-value">${truyen.danhGiaFormatted}</div>
                                                    <div class="stat-label">Đánh giá</div>
                                                </span>
                                            </div>
                                            <span class="story-status ${truyen.trangThai == 'HOAN_THANH' ? 'status-completed' : 
                                                                       truyen.trangThai == 'TAM_DUNG' ? 'status-paused' : 'status-ongoing'}">
                                                <c:choose>
                                                    <c:when test="${truyen.trangThai == 'HOAN_THANH'}">Hoàn thành</c:when>
                                                    <c:when test="${truyen.trangThai == 'TAM_DUNG'}">Tạm dừng</c:when>
                                                    <c:otherwise>Đang ra</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        
                                        <c:if test="${not empty truyen.theLoaiTenList}">
                                            <div class="category-tags">
                                                <c:forEach var="theLoai" items="${truyen.theLoaiTenList}" varStatus="loop">
                                                    <span class="category-tag">${theLoai}</span>
                                                </c:forEach>
                                            </div>
                                        </c:if>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/truyen?page=${currentPage - 1}${not empty category ? '&category='.concat(category) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty selectedCategory ? '&theLoai='.concat(selectedCategory) : ''}${not empty sortBy ? '&sort='.concat(sortBy) : ''}">
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
                                            <a class="page-link" href="${pageContext.request.contextPath}/truyen?page=${i}${not empty category ? '&category='.concat(category) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty selectedCategory ? '&theLoai='.concat(selectedCategory) : ''}${not empty sortBy ? '&sort='.concat(sortBy) : ''}">${i}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/truyen?page=${currentPage + 1}${not empty category ? '&category='.concat(category) : ''}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty selectedCategory ? '&theLoai='.concat(selectedCategory) : ''}${not empty sortBy ? '&sort='.concat(sortBy) : ''}">
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // ✅ Hàm lọc theo thể loại
        function filterByCategory(categoryId) {
            const url = new URL(window.location);
            if (categoryId) {
                url.searchParams.set('theLoai', categoryId);
            } else {
                url.searchParams.delete('theLoai');
            }
            url.searchParams.set('page', '1'); // Reset về trang 1
            
            // Add smooth loading state
            const select = event.target;
            const originalText = select.options[select.selectedIndex].text;
            select.options[select.selectedIndex].innerHTML = '<div class="loading-spinner"></div> Đang tải...';
            select.disabled = true;
            
            // Add a pleasant delay for better UX
            setTimeout(() => {
                window.location.href = url.toString();
            }, 500);
        }

        // ✅ Hàm sắp xếp
        function sortStories(sortBy) {
            const url = new URL(window.location);
            if (sortBy) {
                url.searchParams.set('sort', sortBy);
            } else {
                url.searchParams.delete('sort');
            }
            url.searchParams.set('page', '1'); // Reset về trang 1
            
            // Add smooth loading state
            const select = event.target;
            const originalText = select.options[select.selectedIndex].text;
            select.options[select.selectedIndex].innerHTML = '<div class="loading-spinner"></div> Đang tải...';
            select.disabled = true;
            
            // Add a pleasant delay for better UX
            setTimeout(() => {
                window.location.href = url.toString();
            }, 500);
        }

        // Add intersection observer for scroll animations
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

        // Observe all story cards for animation
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.story-card').forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = `opacity 0.6s ease ${index * 0.1}s, transform 0.6s ease ${index * 0.1}s`;
                observer.observe(card);
            });
        });

        // Improve mobile touch interactions
        if ('ontouchstart' in window) {
            document.querySelectorAll('.story-card').forEach(card => {
                card.addEventListener('touchstart', function() {
                    this.style.transform = 'translateY(-4px) scale(1.01)';
                });
                
                card.addEventListener('touchend', function() {
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                });
            });
        }

        // Add smooth scrolling for pagination
        document.querySelectorAll('.pagination .page-link').forEach(link => {
            link.addEventListener('click', function(e) {
                // Add loading state
                const originalText = this.innerHTML;
                this.innerHTML = '<div class="loading-spinner"></div>';
                
                // Scroll to top smoothly
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            });
        });

        // ✅ Xử lý form tìm kiếm
        document.querySelector('.search-form').addEventListener('submit', function() {
            const submitBtn = this.querySelector('button[type="submit"]');
            if (submitBtn) {
                submitBtn.innerHTML = '<div class="loading-spinner"></div> Đang tìm...';
                submitBtn.disabled = true;
            }
        });

        // ✅ Auto submit form khi nhấn Enter trong ô tìm kiếm
        document.querySelector('input[name="keyword"]').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                this.closest('form').submit();
            }
        });
    </script>
</body>
</html>