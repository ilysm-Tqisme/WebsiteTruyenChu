<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, maximum-scale=5.0">
    <title>Thông tin cá nhân - TruyenMoi</title>
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
            --vip-premium-gradient: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            --error-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e53 100%);
            
            --glass-bg: rgba(255, 255, 255, 0.25);
            --glass-border: rgba(255, 255, 255, 0.18);
            
            /* Improved VIP colors - easier on the eyes */
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

        /* Improved VIP Body Background - darker and more elegant */
        body.vip-user {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 30%, #0f3460 60%, #533483 100%);
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

        /* Improved VIP Animated Background - subtle gold accents */
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

        /* Improved VIP Navigation */
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

        /* Profile Container */
        .profile-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .profile-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-heavy);
            border: 1px solid var(--glass-border);
            overflow: hidden;
            position: relative;
            animation: slideInUp 0.8s ease-out;
        }

        /* Improved VIP Profile Card */
        .profile-card.vip {
            background: var(--vip-glass-bg);
            border: 2px solid var(--vip-glass-border);
            box-shadow: var(--vip-shadow);
        }

        .profile-card.vip::before {
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

        .profile-card::after {
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

        .profile-header {
            background: var(--primary-gradient);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        /* Improved VIP Profile Header */
        .profile-header.vip {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 30%, #533483 70%, #ffd700 100%);
            position: relative;
        }

        .profile-header.vip::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: vipShimmer 3s ease-in-out infinite;
        }

        @keyframes vipShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .profile-header::after {
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

        .avatar-container {
            position: relative;
            display: inline-block;
            margin-bottom: 1.5rem;
            z-index: 1;
        }

        .avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid rgba(255, 255, 255, 0.3);
            object-fit: cover;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            transition: var(--transition);
            box-shadow: var(--shadow-heavy);
        }

        /* VIP Avatar */
        .avatar.vip {
            border: 5px solid rgba(255, 215, 0, 0.6);
            box-shadow: var(--vip-shadow);
        }

        .avatar:hover {
            transform: scale(1.05);
            border-color: rgba(255, 255, 255, 0.6);
        }

        .avatar.vip:hover {
            border-color: rgba(255, 215, 0, 0.8);
        }

        /* VIP Crown Overlay - ONLY show when user has avatar AND is VIP */
        .avatar-container.vip.has-avatar::before {
            content: '👑';
            position: absolute;
            top: -15px;
            left: -15px;
            font-size: 2.5rem;
            z-index: 1;
            animation: crownFloat 2s ease-in-out infinite;
            filter: drop-shadow(0 0 15px rgba(255, 215, 0, 0.8));
            pointer-events: none;
        }

        @keyframes crownFloat {
            0%, 100% { transform: translateY(0px) rotate(-10deg); }
            50% { transform: translateY(-5px) rotate(-5deg); }
        }

        .avatar-upload {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: var(--vip-gradient);
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: var(--shadow-medium);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            z-index: 10;
        }

        .avatar-upload:hover {
            transform: scale(1.1) rotate(5deg);
            box-shadow: var(--shadow-heavy);
        }

        .user-info h3 {
            font-size: clamp(1.8rem, 4vw, 2.5rem);
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
        }

        .user-meta {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 1.5rem;
            margin-top: 1rem;
            position: relative;
            z-index: 1;
        }

        .user-meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.95rem;
            padding: 0.5rem 1rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 25px;
            backdrop-filter: blur(10px);
            transition: var(--transition);
        }

        .user-meta-item:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .vip-badge {
            background: var(--vip-gradient);
            color: white;
            padding: 0.6rem 1.5rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: var(--vip-shadow);
            animation: vipPulse 2s ease-in-out infinite;
            position: relative;
            overflow: hidden;
        }

        .vip-badge::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            animation: vipBadgeShimmer 3s ease-in-out infinite;
        }

        @keyframes vipBadgeShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes vipPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .vip-badge i {
            font-size: 1.1rem;
            animation: crownRotate 4s ease-in-out infinite;
        }

        @keyframes crownRotate {
            0%, 100% { transform: rotate(0deg); }
            25% { transform: rotate(-5deg); }
            75% { transform: rotate(5deg); }
        }

        /* Improved VIP Info Section */
        .vip-info {
            background: var(--vip-glass-bg);
            border: 1px solid var(--vip-glass-border);
            border-radius: 15px;
            padding: 1.5rem;
            margin: 1.5rem 0;
            box-shadow: var(--vip-shadow);
            position: relative;
            overflow: hidden;
        }

        .vip-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.1), transparent);
            animation: vipInfoShimmer 4s ease-in-out infinite;
        }

        @keyframes vipInfoShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .vip-info h6 {
            color: #fff;
            font-weight: 700;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .vip-info h6 i {
            color: #ffd700;
            font-size: 1.2rem;
        }

        .vip-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .vip-detail-item {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 1rem;
            text-align: center;
            transition: var(--transition);
        }

        .vip-detail-item:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
        }

        .vip-detail-item i {
            font-size: 1.5rem;
            color: #ffd700;
            margin-bottom: 0.5rem;
        }

        .vip-detail-item .label {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }

        .vip-detail-item .value {
            color: #fff;
            font-weight: 600;
            font-size: 1rem;
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .stat-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-light);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        /* Improved VIP Stats Cards */
        .stat-card.vip {
            background: var(--vip-glass-bg);
            border: 1px solid var(--vip-glass-border);
            box-shadow: var(--vip-shadow);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-heavy);
        }

        .stat-card.vip:hover {
            box-shadow: var(--vip-shadow);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: var(--transition);
        }

        .stat-card:hover::before {
            left: 100%;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
            margin: 0 auto 1rem;
            box-shadow: var(--shadow-medium);
            transition: var(--transition);
        }

        .stat-icon:hover {
            transform: scale(1.1) rotate(5deg);
        }

        .stat-icon.reading {
            background: var(--success-gradient);
        }

        .stat-icon.bookmarks {
            background: var(--warning-gradient);
        }

        .stat-icon.comments {
            background: var(--secondary-gradient);
        }

        .stat-icon.ratings {
            background: var(--vip-gradient);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .stat-label {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Profile Body */
        .profile-body {
            padding: 2.5rem;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            position: relative;
            z-index: 1;
        }

        /* Improved VIP Profile Body */
        .profile-body.vip {
            background: var(--vip-glass-bg);
        }

        /* Tabs */
        .nav-tabs {
            border: none;
            margin-bottom: 2rem;
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .nav-tabs .nav-link {
            border: none;
            color: rgba(255, 255, 255, 0.7);
            font-weight: 600;
            padding: 1rem 1.5rem;
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .nav-tabs .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .nav-tabs .nav-link:hover::before {
            left: 100%;
        }

        .nav-tabs .nav-link:hover {
            color: #fff;
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .nav-tabs .nav-link.active {
            color: #fff;
            background: var(--primary-gradient);
            box-shadow: var(--shadow-medium);
        }

        /* VIP Tabs */
        .vip-user .nav-tabs .nav-link.active {
            background: var(--vip-gradient);
            box-shadow: var(--vip-shadow);
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

        .form-control[readonly] {
            background: rgba(255, 255, 255, 0.6);
            color: #666;
            cursor: not-allowed;
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
        }

        /* VIP Button */
        .vip-user .btn-primary {
            background: var(--vip-gradient);
            box-shadow: var(--vip-shadow);
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

        .vip-user .btn-primary:hover {
            background: var(--vip-gradient);
            box-shadow: var(--vip-shadow);
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

        /* Password Change Section */
        .password-section {
            text-align: center;
            padding: 3rem 2rem;
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-light);
        }

        .password-section.vip {
            background: var(--vip-glass-bg);
            border: 1px solid var(--vip-glass-border);
            box-shadow: var(--vip-shadow);
        }

        .password-section i {
            font-size: 4rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1.5rem;
            filter: drop-shadow(0 0 10px rgba(103, 80, 164, 0.5));
        }

        .password-section.vip i {
            background: var(--vip-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            filter: drop-shadow(0 0 10px rgba(255, 215, 0, 0.5));
        }

        .password-section h5 {
            color: #fff;
            font-weight: 700;
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }

        .password-section p {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 2rem;
            font-size: 1rem;
        }

        /* Recent Activity */
        .activity-item {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid var(--glass-border);
            transition: var(--transition);
        }

        .activity-item.vip {
            background: var(--vip-glass-bg);
            border: 1px solid var(--vip-glass-border);
        }

        .activity-item:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
        }

        .activity-item.vip:hover {
            background: rgba(255, 215, 0, 0.15);
        }

        .activity-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: white;
            margin-right: 1rem;
            flex-shrink: 0;
        }

        .activity-content h6 {
            color: #fff;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .activity-content p {
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 0.25rem;
            font-size: 0.9rem;
        }

        .activity-time {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.8rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .profile-container {
                margin: 1rem auto;
                padding: 0 0.5rem;
            }

            .profile-header {
                padding: 2rem 1rem;
            }

            .profile-body {
                padding: 1.5rem;
            }

            .avatar {
                width: 120px;
                height: 120px;
            }

            .avatar-upload {
                width: 40px;
                height: 40px;
                font-size: 1rem;
            }

            .avatar-container.vip.has-avatar::before {
                font-size: 2rem;
                top: -10px;
                left: -10px;
            }

            .user-meta {
                flex-direction: column;
                align-items: center;
                gap: 1rem;
            }

            .stats-container {
                grid-template-columns: repeat(2, 1fr);
                gap: 1rem;
            }

            .stat-card {
                padding: 1rem;
            }

            .stat-icon {
                width: 50px;
                height: 50px;
                font-size: 1.2rem;
            }

            .stat-number {
                font-size: 1.5rem;
            }

            .nav-tabs {
                flex-direction: column;
            }

            .nav-tabs .nav-link {
                text-align: center;
            }

            .password-section {
                padding: 2rem 1rem;
            }

            .activity-item {
                padding: 1rem;
            }

            .activity-icon {
                width: 40px;
                height: 40px;
                font-size: 1rem;
            }

            .vip-details {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 576px) {
            .profile-header {
                padding: 1.5rem 0.75rem;
            }

            .profile-body {
                padding: 1rem;
            }

            .avatar {
                width: 100px;
                height: 100px;
            }

            .avatar-container.vip.has-avatar::before {
                font-size: 1.5rem;
                top: -8px;
                left: -8px;
            }

            .stats-container {
                grid-template-columns: 1fr;
            }

            .user-info h3 {
                font-size: 1.5rem;
            }

            .form-control {
                padding: 0.8rem 1rem;
                font-size: 0.9rem;
            }

            .btn-primary {
                padding: 0.8rem 1.5rem;
                font-size: 0.9rem;
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
        .btn-primary:focus,
        .btn-outline-secondary:focus {
            outline: 2px solid rgba(255, 255, 255, 0.8);
            outline-offset: 2px;
        }

        /* Improved VIP Floating Particles - smaller and more subtle */
        .vip-particles {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .vip-particle {
            position: absolute;
            width: 4px;
            height: 4px;
            background: #ffd700;
            border-radius: 50%;
            animation: float 8s ease-in-out infinite;
            opacity: 0.3;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-30px) rotate(180deg); }
        }
    </style>
</head>
<body class="${isVIP ? 'vip-user' : ''}">
    <!-- VIP Particles -->
    <c:if test="${isVIP}">
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
    </c:if>

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
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="profile-container">
        <div class="profile-card ${isVIP ? 'vip' : ''}">
            <div class="profile-header ${isVIP ? 'vip' : ''}">
                <div class="avatar-container ${isVIP ? 'vip' : ''} ${not empty user.anhDaiDien ? 'has-avatar' : ''}" id="avatarContainer">
                    <c:choose>
                        <c:when test="${not empty user.anhDaiDien}">
                            <img src="${pageContext.request.contextPath}/${user.anhDaiDien}" 
                                 alt="Avatar" class="avatar ${isVIP ? 'vip' : ''}" id="avatarPreview">
                        </c:when>
                        <c:otherwise>
                            <div class="avatar ${isVIP ? 'vip' : ''} d-flex align-items-center justify-content-center" id="avatarPlaceholder">
                                <i class="fas fa-user fa-4x" style="color: rgba(255,255,255,0.7);"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <button type="button" class="avatar-upload" onclick="document.getElementById('avatarInput').click()">
                        <i class="fas fa-camera"></i>
                    </button>
                </div>
                
                <div class="user-info">
                    <h3>${user.hoTen}</h3>
                    <div class="user-meta">
                        <div class="user-meta-item">
                            <i class="fas fa-envelope"></i>
                            <span>${user.email}</span>
                        </div>
                        <div class="user-meta-item">
                            <i class="fas fa-phone"></i>
                            <span>${not empty user.soDienThoai ? user.soDienThoai : 'Chưa cập nhật'}</span>
                        </div>
                        <div class="user-meta-item">
                            <i class="fas fa-calendar-alt"></i>
                            <span>Tham gia: ${user.ngayTaoFormatted}</span>
                        </div>
                        <c:if test="${user.vaiTro == 'ADMIN'}">
                            <div class="vip-badge">
                                <i class="fas fa-crown"></i>
                                <span>ADMIN</span>
                            </div>
                        </c:if>
                        <c:if test="${isVIP}">
                            <div class="vip-badge">
                                <i class="fas fa-crown"></i>
                                <span>VIP MEMBER</span>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- VIP Info Section -->
            <c:if test="${isVIP && vipInfo != null}">
                <div class="vip-info">
                    <h6>
                        <i class="fas fa-star"></i>
                        Thông tin VIP
                    </h6>
                    <div class="vip-details">
                        <div class="vip-detail-item">
                            <i class="fas fa-gem"></i>
                            <div class="label">Loại VIP</div>
                            <div class="value">${vipInfo.loaiVIP}</div>
                        </div>
                        <div class="vip-detail-item">
                            <i class="fas fa-calendar-check"></i>
                            <div class="label">Ngày đăng ký</div>
                            <div class="value">${vipInfo.ngayBatDauFormatted}</div>
                        </div>
                        <div class="vip-detail-item">
                            <i class="fas fa-clock"></i>
                            <div class="label">Ngày hết hạn</div>
                            <div class="value">${vipInfo.ngayKetThucFormatted}</div>
                        </div>
                        <div class="vip-detail-item">
                            <i class="fas fa-money-bill-wave"></i>
                            <div class="label">Giá trị</div>
                            <div class="value">${vipInfo.giaVIPFormatted}</div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- User Statistics -->
            <div class="stats-container">
                <div class="stat-card ${isVIP ? 'vip' : ''}">
                    <div class="stat-icon reading">
                        <i class="fas fa-book-reader"></i>
                    </div>
                    <div class="stat-number">${lichSuDocCount != null ? lichSuDocCount : 0}</div>
                    <div class="stat-label">Truyện đã đọc</div>
                </div>
                
                <div class="stat-card ${isVIP ? 'vip' : ''}">
                    <div class="stat-icon bookmarks">
                        <i class="fas fa-bookmark"></i>
                    </div>
                    <div class="stat-number">${tuTruyenCount != null ? tuTruyenCount : 0}</div>
                    <div class="stat-label">Truyện đã lưu</div>
                </div>
                
                <div class="stat-card ${isVIP ? 'vip' : ''}">
                    <div class="stat-icon comments">
                        <i class="fas fa-comments"></i>
                    </div>
                    <div class="stat-number">${binhLuanCount != null ? binhLuanCount : 0}</div>
                    <div class="stat-label">Bình luận</div>
                </div>
                
                <div class="stat-card ${isVIP ? 'vip' : ''}">
                    <div class="stat-icon ratings">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-number">${danhGiaCount != null ? danhGiaCount : 0}</div>
                    <div class="stat-label">Đánh giá</div>
                </div>
            </div>
            
            <div class="profile-body ${isVIP ? 'vip' : ''}">
                <!-- Hiển thị thông báo -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-circle"></i>
                        ${error}
                    </div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle"></i>
                        ${success}
                    </div>
                </c:if>
                
                <!-- Tabs -->
                <ul class="nav nav-tabs" id="profileTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="info-tab" data-bs-toggle="tab" 
                                data-bs-target="#info" type="button" role="tab">
                            <i class="fas fa-user me-2"></i>Thông tin cá nhân
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="password-tab" data-bs-toggle="tab" 
                                data-bs-target="#password" type="button" role="tab">
                            <i class="fas fa-lock me-2"></i>Đổi mật khẩu
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="activity-tab" data-bs-toggle="tab" 
                                data-bs-target="#activity" type="button" role="tab">
                            <i class="fas fa-history me-2"></i>Hoạt động gần đây
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="favorites-tab" data-bs-toggle="tab" 
                                data-bs-target="#favorites" type="button" role="tab">
                            <i class="fas fa-heart me-2"></i>Yêu thích
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="library-tab" data-bs-toggle="tab" 
                                data-bs-target="#library" type="button" role="tab">
                            <i class="fas fa-bookmark me-2"></i>Tủ truyện
                        </button>
                    </li>
                </ul>
                
                <div class="tab-content mt-4" id="profileTabsContent">
                    <!-- Tab thông tin cá nhân -->
                    <div class="tab-pane fade show active" id="info" role="tabpanel">
                        <form action="${pageContext.request.contextPath}/profile" method="post" id="profileForm">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="hoTen" class="form-label">
                                        <i class="fas fa-user me-2"></i>Họ và tên <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="hoTen" name="hoTen" 
                                           value="${user.hoTen}" required>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope me-2"></i>Email
                                    </label>
                                    <input type="email" class="form-control" id="email" 
                                           value="${user.email}" readonly>
                                    <small class="text-muted">Email không thể thay đổi</small>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="soDienThoai" class="form-label">
                                        <i class="fas fa-phone me-2"></i>Số điện thoại
                                    </label>
                                    <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai" 
                                           value="${user.soDienThoai}" placeholder="0123456789">
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="vaiTro" class="form-label">
                                        <i class="fas fa-crown me-2"></i>Vai trò
                                    </label>
                                    <input type="text" class="form-control" id="vaiTro" 
                                           value="${user.vaiTro}" readonly>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="ngayTao" class="form-label">
                                        <i class="fas fa-calendar-plus me-2"></i>Ngày tham gia
                                    </label>
                                    <input type="text" class="form-control" id="ngayTao" 
                                           value="${user.ngayTaoFormatted}" readonly>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="ngayCapNhat" class="form-label">
                                        <i class="fas fa-calendar-check me-2"></i>Cập nhật lần cuối
                                    </label>
                                    <input type="text" class="form-control" id="ngayCapNhat" 
                                           value="${user.ngayCapNhatFormatted}" readonly>
                                </div>
                            </div>
                            
                            <div class="text-end">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Cập nhật thông tin
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Tab đổi mật khẩu -->
                    <div class="tab-pane fade" id="password" role="tabpanel">
                        <div class="password-section ${isVIP ? 'vip' : ''}">
                            <i class="fas fa-shield-alt"></i>
                            <h5>Bảo mật tài khoản</h5>
                            <p>Để bảo mật tài khoản, vui lòng sử dụng mật khẩu mạnh và thay đổi định kỳ</p>
                            
                            <a href="${pageContext.request.contextPath}/change-password" class="btn btn-primary">
                                <i class="fas fa-key me-2"></i>Đổi mật khẩu
                            </a>
                        </div>
                    </div>

                    <!-- Tab hoạt động gần đây -->
                    <div class="tab-pane fade" id="activity" role="tabpanel">
                        <h5 class="text-white mb-4">
                            <i class="fas fa-history me-2"></i>Hoạt động gần đây
                        </h5>
                        
                        <!-- Recent Reading History -->
                        <c:if test="${not empty recentReading}">
                            <h6 class="text-white-50 mb-3">📖 Truyện đã đọc gần đây</h6>
                            <c:forEach var="reading" items="${recentReading}" varStatus="status">
                                <div class="activity-item ${isVIP ? 'vip' : ''} d-flex">
                                    <div class="activity-icon reading">
                                        <i class="fas fa-book-open"></i>
                                    </div>
                                    <div class="activity-content flex-grow-1">
                                        <h6>Đã đọc: ${reading.truyen.tenTruyen}</h6>
                                        <p>Chương ${reading.chuong.soChuong}: ${reading.chuong.tenChuong}</p>
                                        <div class="activity-time">
                                            ${reading.ngayDocFormatted}
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>

                        <!-- Recent Comments -->
                        <c:if test="${not empty recentComments}">
                            <h6 class="text-white-50 mb-3 mt-4">💬 Bình luận gần đây</h6>
                            <c:forEach var="comment" items="${recentComments}" varStatus="status">
                                <div class="activity-item ${isVIP ? 'vip' : ''} d-flex">
                                    <div class="activity-icon comments">
                                        <i class="fas fa-comment"></i>
                                    </div>
                                    <div class="activity-content flex-grow-1">
                                        <h6>Bình luận trên: ${comment.truyen.tenTruyen}</h6>
                                        <p>${comment.noiDung}</p>
                                        <div class="activity-time">
                                           ${user.ngayTaoFormatted}
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>

                        <!-- Recent Ratings -->
                        <c:if test="${not empty recentRatings}">
                            <h6 class="text-white-50 mb-3 mt-4">⭐ Đánh giá gần đây</h6>
                            <c:forEach var="rating" items="${recentRatings}" varStatus="status">
                                <div class="activity-item ${isVIP ? 'vip' : ''} d-flex">
                                    <div class="activity-icon ratings">
                                        <i class="fas fa-star"></i>
                                    </div>
                                    <div class="activity-content flex-grow-1">
                                        <h6>Đánh giá: ${rating.truyen.tenTruyen}</h6>
                                        <p>
                                            <c:forEach begin="1" end="${rating.diemSo}">
                                                <i class="fas fa-star text-warning"></i>
                                            </c:forEach>
                                            <c:forEach begin="${rating.diemSo + 1}" end="5">
                                                <i class="far fa-star text-warning"></i>
                                            </c:forEach>
                                            <c:if test="${not empty rating.nhanXet}">
                                                <br><small>${rating.nhanXet}</small>
                                            </c:if>
                                        </p>
                                        <div class="activity-time">
                                            ${rating.ngayDanhGiatFormatted}
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>

                          
                        <c:if test="${empty recentReading && empty recentComments && empty recentRatings}">
                            <div class="text-center py-5">
                                <i class="fas fa-history fa-4x text-white-50 mb-3"></i>
                                <h5 class="text-white">Chưa có hoạt động nào</h5>
                                <p class="text-white-50">Hãy bắt đầu đọc truyện để xem hoạt động của bạn tại đây</p>
                                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                                    <i class="fas fa-book me-2"></i>Khám phá truyện
                                </a>
                            </div>
                        </c:if>
                    </div>
                
                    <!-- Tab yêu thích -->
                    <div class="tab-pane fade" id="favorites" role="tabpanel">
                        <h5 class="text-white mb-4">
                            <i class="fas fa-heart me-2"></i>Truyện Yêu Thích
                        </h5>
                        
                        <c:choose>
                            <c:when test="${not empty danhSachYeuThich}">
                                <div class="row">
                                    <c:forEach var="yeuThich" items="${danhSachYeuThich}">
                                        <div class="col-md-6 col-lg-4 mb-4">
                                            <div class="activity-item ${isVIP ? 'vip' : ''}">
                                                <div class="d-flex">
                                                    <div class="activity-icon" style="background: var(--error-gradient);">
                                                        <i class="fas fa-heart"></i>
                                                    </div>
                                                    <div class="activity-content flex-grow-1">
                                                        <h6>
                                                            <a href="${pageContext.request.contextPath}/story?id=${yeuThich.truyen.id}" 
                                                               class="text-white text-decoration-none">
                                                                ${yeuThich.truyen.tenTruyen}
                                                            </a>
                                                        </h6>
                                                        <p class="text-white-50 small mb-1">
                                                            <i class="fas fa-user"></i> ${yeuThich.truyen.tacGiaTen != null ? yeuThich.truyen.tacGiaTen : 'Chưa có'}
                                                        </p>
                                                        <div class="activity-time">
                                                            <i class="fas fa-calendar"></i> ${yeuThich.ngayYeuThichFormatted}
                                                        </div>
                                                        <div class="mt-2">
                                                            <a href="${pageContext.request.contextPath}/story?id=${yeuThich.truyen.id}" 
                                                               class="btn btn-sm btn-primary me-2">
                                                                <i class="fas fa-book-open"></i> Đọc ngay
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/yeuthich" 
                                                               class="btn btn-sm btn-outline-secondary">
                                                                <i class="fas fa-list"></i> Xem tất cả
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/yeuthich" class="btn btn-primary">
                                        <i class="fas fa-heart me-2"></i>Xem tất cả truyện yêu thích
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-heart fa-4x text-white-50 mb-3"></i>
                                    <h5 class="text-white">Chưa có truyện yêu thích</h5>
                                    <p class="text-white-50">Hãy thêm truyện vào yêu thích để đọc sau!</p>
                                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                                        <i class="fas fa-search me-2"></i>Tìm truyện
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Tab tủ truyện -->
                    <div class="tab-pane fade" id="library" role="tabpanel">
                        <h5 class="text-white mb-4">
                            <i class="fas fa-bookmark me-2"></i>Tủ Truyện Của Tôi
                        </h5>
                        
                        <c:choose>
                            <c:when test="${not empty danhSachTuTruyen}">
                                <div class="row">
                                    <c:forEach var="tuTruyen" items="${danhSachTuTruyen}">
                                        <div class="col-md-6 col-lg-4 mb-4">
                                            <div class="activity-item ${isVIP ? 'vip' : ''}">
                                                <div class="d-flex">
                                                    <div class="activity-icon" style="background: var(--warning-gradient);">
                                                        <i class="fas fa-bookmark"></i>
                                                    </div>
                                                    <div class="activity-content flex-grow-1">
                                                        <h6>
                                                            <a href="${pageContext.request.contextPath}/story?id=${tuTruyen.truyen.id}" 
                                                               class="text-white text-decoration-none">
                                                                ${tuTruyen.truyen.tenTruyen}
                                                            </a>
                                                        </h6>
                                                        <p class="text-white-50 small mb-1">
                                                            <i class="fas fa-user"></i> ${tuTruyen.truyen.tacGiaTen != null ? tuTruyen.truyen.tacGiaTen : 'Chưa có'}
                                                        </p>
                                                        <div class="activity-time">
                                                            <i class="fas fa-calendar"></i> ${tuTruyen.ngayLuuFormatted}
                                                        </div>
                                                        <div class="mt-2">
                                                            <a href="${pageContext.request.contextPath}/story?id=${tuTruyen.truyen.id}" 
                                                               class="btn btn-sm btn-primary me-2">
                                                                <i class="fas fa-book-open"></i> Đọc ngay
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/tutruyen" 
                                                               class="btn btn-sm btn-outline-secondary">
                                                                <i class="fas fa-list"></i> Xem tất cả
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/tutruyen" class="btn btn-primary">
                                        <i class="fas fa-bookmark me-2"></i>Xem tất cả truyện trong tủ
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="fas fa-bookmark fa-4x text-white-50 mb-3"></i>
                                    <h5 class="text-white">Chưa có truyện trong tủ</h5>
                                    <p class="text-white-50">Hãy thêm truyện vào tủ để đọc sau!</p>
                                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                                        <i class="fas fa-search me-2"></i>Tìm truyện
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>            
            </div>
        </div>
    </div>
        
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Quay lại trang chủ
            </a>
        </div>
    </div>
    
    <!-- Form upload avatar ẩn -->
    <form id="avatarForm" action="${pageContext.request.contextPath}/upload-avatar" 
          method="post" enctype="multipart/form-data" style="display: none;">
        <input type="file" id="avatarInput" name="avatar" accept="image/*" onchange="uploadAvatar()">
    </form>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Enhanced JavaScript with improved avatar logic
        
        function uploadAvatar() {
            const fileInput = document.getElementById('avatarInput');
            const file = fileInput.files[0];
            
            if (file) {
                // Validate file size (5MB)
                if (file.size > 5 * 1024 * 1024) {
                    showAlert('File ảnh không được vượt quá 5MB!', 'danger');
                    return;
                }
                
                // Validate file type
                const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
                if (!validTypes.includes(file.type)) {
                    showAlert('Chỉ chấp nhận file ảnh (JPG, JPEG, PNG, GIF)!', 'danger');
                    return;
                }
                
                // Preview image and show crown for VIP users
                const reader = new FileReader();
                reader.onload = function(e) {
                    const avatarContainer = document.getElementById('avatarContainer');
                    const avatarPreview = document.getElementById('avatarPreview');
                    const avatarPlaceholder = document.getElementById('avatarPlaceholder');
                    
                    if (avatarPreview) {
                        avatarPreview.src = e.target.result;
                    } else {
                        // Replace placeholder with new image
                        if (avatarPlaceholder) {
                            const newImg = document.createElement('img');
                            newImg.src = e.target.result;
                            newImg.alt = 'Avatar';
                            newImg.className = 'avatar' + (document.body.classList.contains('vip-user') ? ' vip' : '');
                            newImg.id = 'avatarPreview';
                            avatarContainer.replaceChild(newImg, avatarPlaceholder);
                        }
                    }
                    
                    // Add has-avatar class to show crown for VIP users
                    avatarContainer.classList.add('has-avatar');
                };
                reader.readAsDataURL(file);
                
                // Add loading state
                const uploadBtn = document.querySelector('.avatar-upload');
                const originalContent = uploadBtn.innerHTML;
                uploadBtn.innerHTML = '<div class="loading-spinner"></div>';
                uploadBtn.disabled = true;
                
                // Submit form
                document.getElementById('avatarForm').submit();
                
                // Reset button after a delay (in case of error)
                setTimeout(() => {
                    uploadBtn.innerHTML = originalContent;
                    uploadBtn.disabled = false;
                }, 5000);
            }
        }
        
        // Enhanced form validation
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            const hoTen = document.getElementById('hoTen').value.trim();
            const soDienThoai = document.getElementById('soDienThoai').value.trim();
            
            if (!hoTen) {
                e.preventDefault();
                showAlert('Vui lòng nhập họ và tên!', 'danger');
                return false;
            }
            
            if (hoTen.length < 2) {
                e.preventDefault();
                showAlert('Họ và tên phải có ít nhất 2 ký tự!', 'danger');
                return false;
            }
            
            if (soDienThoai && !soDienThoai.match(/^0[0-9]{9}$/)) {
                e.preventDefault();
                showAlert('Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0!', 'danger');
                return false;
            }
            
            // Add loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalContent = submitBtn.innerHTML;
            submitBtn.innerHTML = '<span class="loading-spinner"></span>Đang cập nhật...';
            submitBtn.disabled = true;
            
            // Reset button after a delay (in case of error)
            setTimeout(() => {
                submitBtn.innerHTML = originalContent;
                submitBtn.disabled = false;
            }, 5000);
        });
        
        // Real-time phone validation
        document.getElementById('soDienThoai').addEventListener('input', function() {
            const phone = this.value.trim();
            if (phone && !phone.match(/^0[0-9]{9}$/)) {
                this.setCustomValidity('Số điện thoại phải có 10 chữ số và bắt đầu bằng số 0');
                this.classList.add('is-invalid');
            } else {
                this.setCustomValidity('');
                this.classList.remove('is-invalid');
                if (phone) this.classList.add('is-valid');
            }
        });
        
        // Real-time name validation
        document.getElementById('hoTen').addEventListener('input', function() {
            const name = this.value.trim();
            if (name.length >= 2) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else if (name.length > 0) {
                this.classList.add('is-invalid');
                this.classList.remove('is-valid');
            } else {
                this.classList.remove('is-invalid', 'is-valid');
            }
        });
        
        // Enhanced alert system
        function showAlert(message, type) {
            // Remove existing alerts
            const existingAlerts = document.querySelectorAll('.alert');
            existingAlerts.forEach(alert => alert.remove());
            
            // Insert alert
            const profileBody = document.querySelector('.profile-body');
            profileBody.insertBefore(alert, profileBody.firstChild);
            
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
        
        // Add loading animation on page load
        document.addEventListener('DOMContentLoaded', function() {
            const profileCard = document.querySelector('.profile-card');
            profileCard.style.opacity = '0';
            profileCard.style.transform = 'translateY(40px)';
            
            setTimeout(() => {
                profileCard.style.transition = 'opacity 0.8s ease, transform 0.8s ease';
                profileCard.style.opacity = '1';
                profileCard.style.transform = 'translateY(0)';
            }, 100);
            
            // Animate stats cards
            document.querySelectorAll('.stat-card').forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 200 + (index * 100));
            });
        });
        
        // Improved VIP particle effects
        if (document.body.classList.contains('vip-user')) {
            function createVIPParticles() {
                const particles = document.querySelector('.vip-particles');
                if (!particles) return;
                
                setInterval(() => {
                    const particle = document.createElement('div');
                    particle.className = 'vip-particle';
                    particle.style.left = Math.random() * 100 + '%';
                    particle.style.top = '100%';
                    particle.style.animationDelay = Math.random() * 2 + 's';
                    particles.appendChild(particle);
                    
                    setTimeout(() => {
                        particle.remove();
                    }, 8000);
                }, 1200);
            }
            
            createVIPParticles();
        }
        
        // Improve mobile experience
        if ('ontouchstart' in window) {
            document.querySelectorAll('.btn-primary, .btn-outline-secondary, .stat-card').forEach(element => {
                element.addEventListener('touchstart', function() {
                    this.style.transform = this.classList.contains('stat-card') ? 
                        'translateY(-3px) scale(1.01)' : 'translateY(-2px) scale(1.01)';
                });
                
                element.addEventListener('touchend', function() {
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                });
            });
        }
        
        // Check if user already has avatar on page load and add has-avatar class
        document.addEventListener('DOMContentLoaded', function() {
            const avatarPreview = document.getElementById('avatarPreview');
            const avatarContainer = document.getElementById('avatarContainer');
            
            if (avatarPreview && avatarContainer) {
                avatarContainer.classList.add('has-avatar');
            }
        });
    </script>
</body>
</html>