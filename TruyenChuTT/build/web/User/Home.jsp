<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes, maximum-scale=5.0">
    <title>Trang chủ - TruyenMoi</title>
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

    /* VIP User Body */
    body.vip-user {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

    body.vip-user::before {
        background: 
            radial-gradient(circle at 20% 50%, rgba(255, 215, 0, 0.2) 0%, transparent 50%),
            radial-gradient(circle at 80% 20%, rgba(255, 183, 77, 0.15) 0%, transparent 50%),
            radial-gradient(circle at 40% 80%, rgba(255, 235, 59, 0.15) 0%, transparent 50%);
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
        box-shadow: 0 0 30px rgba(255, 215, 0, 0.2);
    }

    /* VIP Navigation Link - Changed to button for modal trigger */
    .vip-nav-link {
        background: var(--vip-gradient) !important;
        color: white !important;
        border-radius: 25px !important;
        font-weight: 600 !important;
        text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3) !important;
        box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3) !important;
        animation: vipGlow 2s ease-in-out infinite alternate !important;
        border: none !important;
        padding: 0.5rem 1.5rem !important;
        cursor: pointer !important;
    }

    @keyframes vipGlow {
        from { box-shadow: 0 4px 15px rgba(255, 215, 0, 0.3); }
        to { box-shadow: 0 4px 20px rgba(255, 215, 0, 0.5); }
    }

    .vip-nav-link:hover {
        transform: translateY(-2px) scale(1.05) !important;
        box-shadow: 0 6px 25px rgba(255, 215, 0, 0.4) !important;
        color: white !important;
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

    /* Improved Notification Bell Design */
    .notification-dropdown {
        position: relative;
    }

    .notification-bell {
        position: relative;
        background: var(--glass-bg);
        border: 1px solid var(--glass-border);
        color: #fff;
        padding: 0.75rem;
        border-radius: 50%;
        transition: var(--transition);
        cursor: pointer;
        backdrop-filter: blur(20px);
        box-shadow: var(--shadow-light);
        display: flex;
        align-items: center;
        justify-content: center;
        width: 46px;
        height: 46px;
        font-size: 1.1rem;
    }

    .notification-bell:hover {
        background: rgba(255, 255, 255, 0.3);
        transform: translateY(-2px) scale(1.05);
        box-shadow: var(--shadow-medium);
        border-color: rgba(255, 255, 255, 0.4);
    }

    .notification-badge {
        position: absolute;
        top: -5px;
        right: -5px;
        background: linear-gradient(135deg, #ff4757 0%, #ff3838 100%);
        color: white;
        border-radius: 50%;
        min-width: 20px;
        height: 20px;
        font-size: 0.65rem;
        font-weight: 700;
        display: flex;
        align-items: center;
        justify-content: center;
        animation: notificationPulse 2s ease-in-out infinite;
        box-shadow: 0 2px 8px rgba(255, 71, 87, 0.4);
        border: 2px solid rgba(255, 255, 255, 0.3);
        line-height: 1;
        padding: 0 0.2rem;
    }

    @keyframes notificationPulse {
        0%, 100% { 
            transform: scale(1);
            box-shadow: 0 2px 8px rgba(255, 71, 87, 0.4);
        }
        50% { 
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(255, 71, 87, 0.6);
        }
    }

    /* NEW: Notification Modal (Like VIP Modal) */
    .notification-modal {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        backdrop-filter: blur(10px);
        z-index: 1060;
        display: none;
        align-items: center;
        justify-content: center;
        padding: 1rem;
        overflow-y: auto;
    }

    .notification-modal.show {
        display: flex;
        animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    .notification-modal-content {
        background: var(--glass-bg);
        backdrop-filter: blur(20px);
        border: 1px solid var(--glass-border);
        border-radius: var(--border-radius);
        width: 100%;
        max-width: 600px;
        max-height: 80vh;
        overflow: hidden;
        box-shadow: var(--shadow-heavy);
        position: relative;
        animation: slideInUp 0.4s ease;
    }

    @keyframes slideInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .notification-modal-header {
        padding: 1.5rem 2rem;
        border-bottom: 1px solid var(--glass-border);
        background: linear-gradient(135deg, rgba(79, 172, 254, 0.1) 0%, rgba(0, 242, 254, 0.1) 100%);
        position: sticky;
        top: 0;
        z-index: 1;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .notification-modal-title {
        color: #fff;
        font-weight: 700;
        margin: 0;
        font-size: 1.4rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .notification-modal-title i {
        color: #4facfe;
        font-size: 1.2rem;
        animation: bellShake 2s ease-in-out infinite;
    }

    @keyframes bellShake {
        0%, 50%, 100% { transform: rotate(0deg); }
        10%, 30% { transform: rotate(-10deg); }
        20%, 40% { transform: rotate(10deg); }
    }

    .notification-modal-actions {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .mark-all-read-btn {
        background: var(--success-gradient);
        color: white;
        border: none;
        padding: 0.5rem 1rem;
        border-radius: 25px;
        font-size: 0.85rem;
        font-weight: 600;
        transition: var(--transition);
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .mark-all-read-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(79, 172, 254, 0.3);
    }

    .mark-all-read-btn:disabled {
        opacity: 0.6;
        cursor: not-allowed;
        transform: none;
    }

    .notification-modal-close {
        position: absolute;
        top: 1rem;
        right: 1rem;
        background: transparent;
        border: none;
        color: rgba(255, 255, 255, 0.8);
        font-size: 1.5rem;
        cursor: pointer;
        padding: 0.5rem;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: var(--transition);
    }

    .notification-modal-close:hover {
        background: rgba(255, 255, 255, 0.1);
        color: #fff;
        transform: scale(1.1);
    }

    .notification-modal-body {
        max-height: 400px;
        overflow-y: auto;
        scrollbar-width: thin;
        scrollbar-color: rgba(255, 255, 255, 0.3) transparent;
    }

    .notification-modal-body::-webkit-scrollbar {
        width: 6px;
    }

    .notification-modal-body::-webkit-scrollbar-track {
        background: transparent;
    }

    .notification-modal-body::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.3);
        border-radius: 3px;
    }

    .notification-modal-body::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.5);
    }

    .notification-modal-item {
        padding: 1.5rem;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        cursor: pointer;
        transition: var(--transition);
        position: relative;
        background: rgba(255, 255, 255, 0.05);
    }

    .notification-modal-item:last-child {
        border-bottom: none;
    }

    .notification-modal-item:hover {
        background: rgba(255, 255, 255, 0.1);
        transform: translateX(5px);
    }

    .notification-modal-item.unread {
        background: rgba(79, 172, 254, 0.1);
        border-left: 4px solid #4facfe;
    }

    .notification-modal-item.unread::before {
        content: '';
        position: absolute;
        top: 1rem;
        right: 1rem;
        width: 8px;
        height: 8px;
        background: #4facfe;
        border-radius: 50%;
        animation: pulse 2s ease-in-out infinite;
    }

    .notification-item-content {
        display: flex;
        align-items: flex-start;
        gap: 1rem;
    }

    .notification-item-icon {
        width: 40px;
        height: 40px;
        background: var(--success-gradient);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.1rem;
        color: white;
        flex-shrink: 0;
        box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
    }

    .notification-item-details {
        flex: 1;
        min-width: 0;
    }

    .notification-item-title {
        color: #fff;
        font-weight: 600;
        margin: 0 0 0.5rem 0;
        font-size: 1rem;
        line-height: 1.3;
    }

    .notification-item-text {
        color: rgba(255, 255, 255, 0.85);
        font-size: 0.9rem;
        line-height: 1.4;
        margin: 0 0 0.75rem 0;
        word-wrap: break-word;
    }

    .notification-item-time {
        color: rgba(255, 255, 255, 0.6);
        font-size: 0.8rem;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 0.3rem;
    }

    .notification-modal-footer {
        padding: 1rem 2rem;
        text-align: center;
        border-top: 1px solid var(--glass-border);
        background: rgba(255, 255, 255, 0.05);
    }

    .notification-modal-footer a {
        color: #4facfe;
        text-decoration: none;
        font-weight: 600;
        transition: var(--transition);
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.75rem 1.5rem;
        border-radius: 25px;
        background: rgba(79, 172, 254, 0.1);
        border: 1px solid rgba(79, 172, 254, 0.3);
    }

    .notification-modal-footer a:hover {
        color: #fff;
        background: var(--success-gradient);
        border-color: transparent;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(79, 172, 254, 0.3);
    }

    .notification-empty {
        text-align: center;
        padding: 3rem 2rem;
        color: rgba(255, 255, 255, 0.7);
    }

    .notification-empty i {
        font-size: 3rem;
        margin-bottom: 1rem;
        opacity: 0.5;
        color: rgba(255, 255, 255, 0.4);
    }

    .notification-empty h4 {
        color: rgba(255, 255, 255, 0.8);
        margin-bottom: 0.5rem;
        font-size: 1.2rem;
    }

    .notification-empty p {
        margin: 0;
        font-size: 0.9rem;
    }

    /* Hero Section */
    .hero-section {
        text-align: center;
        padding: 3rem 1rem;
        background: var(--glass-bg);
        backdrop-filter: blur(20px);
        border-radius: var(--border-radius);
        margin: 2rem 0;
        border: 1px solid var(--glass-border);
        box-shadow: var(--shadow-medium);
        position: relative;
        overflow: hidden;
    }

    .hero-section::before {
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

    .hero-title {
        font-size: clamp(2rem, 5vw, 3.5rem);
        font-weight: 700;
        background: linear-gradient(135deg, #fff 0%, #e0e7ff 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 1.5rem;
        text-shadow: 0 2px 20px rgba(255, 255, 255, 0.5);
        position: relative;
        z-index: 1;
    }

    .hero-subtitle {
        font-size: clamp(1rem, 3vw, 1.3rem);
        color: rgba(255, 255, 255, 0.9);
        margin-bottom: 2rem;
        position: relative;
        z-index: 1;
    }

    /* Search Section */
    .search-section {
        max-width: 700px;
        margin: 0 auto 2rem;
        position: relative;
        z-index: 1;
    }

    .search-form {
        position: relative;
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

    /* Filter Section */
    .filter-section {
        margin-bottom: 2rem;
        position: relative;
        z-index: 1;
    }

    .filter-section .form-control,
    .filter-section .form-select {
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

    .filter-section .form-control::placeholder,
    .filter-section .form-select option {
        color: #666;
        background: white;
    }

    .filter-section .form-control:focus,
    .filter-section .form-select:focus {
        border-color: var(--primary-gradient);
        box-shadow: 0 0 0 4px rgba(103, 80, 164, 0.2);
        outline: none;
        background: white;
        transform: translateY(-2px);
    }

    /* Custom select styling */
    .filter-section .form-select {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%23333' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m1 6 7 7 7-7'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 0.75rem center;
        background-size: 16px 12px;
    }

    .filter-section .form-select:hover {
        background: white;
        border-color: var(--primary-gradient);
        transform: translateY(-1px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    }

    /* VIP Membership Section */
    .vip-membership-section {
        margin-bottom: 3rem;
        display: none;
    }

    .vip-membership-section.show {
        display: block;
    }

    .vip-membership-section.hide {
        display: none;
    }

    .vip-header {
        text-align: center;
        margin-bottom: 2rem;
        padding: 2rem 1rem;
        background: var(--glass-bg);
        backdrop-filter: blur(20px);
        border-radius: var(--border-radius);
        border: 1px solid var(--glass-border);
        box-shadow: var(--shadow-medium);
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
        background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.2), transparent);
        animation: shimmer 3s ease-in-out infinite;
    }

    @keyframes shimmer {
        0% { left: -100%; }
        50% { left: 100%; }
        100% { left: 100%; }
    }

    .vip-title {
        font-size: clamp(1.8rem, 4vw, 2.5rem);
        font-weight: 700;
        background: var(--vip-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 1rem;
        position: relative;
        z-index: 1;
    }

    .vip-subtitle {
        color: rgba(255, 255, 255, 0.9);
        font-size: clamp(1rem, 2vw, 1.2rem);
        position: relative;
        z-index: 1;
    }

    .vip-card {
        background: var(--glass-bg);
        backdrop-filter: blur(20px);
        border-radius: var(--border-radius);
        border: 1px solid var(--glass-border);
        box-shadow: var(--shadow-light);
        transition: var(--transition);
        height: 100%;
        position: relative;
        overflow: hidden;
    }

    .vip-card:hover {
        transform: translateY(-10px) scale(1.02);
        box-shadow: var(--shadow-heavy);
        border-color: rgba(255, 215, 0, 0.5);
    }

    .vip-card.popular {
        border: 2px solid #ffd700;
        box-shadow: 0 0 30px rgba(255, 215, 0, 0.3);
    }

    .vip-card.popular::before {
        content: '🌟 PHỔ BIẾN 🌟';
        position: absolute;
        top: 20px;
        right: -30px;
        background: var(--vip-gradient);
        color: white;
        padding: 0.5rem 3rem;
        font-size: 0.8rem;
        font-weight: 600;
        transform: rotate(45deg);
        z-index: 2;
    }

    .vip-card-header {
        padding: 2rem 1.5rem 1rem;
        text-align: center;
        position: relative;
    }

    .vip-icon {
        font-size: 3rem;
        margin-bottom: 1rem;
        background: var(--vip-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        filter: drop-shadow(0 2px 10px rgba(255, 215, 0, 0.5));
    }

    .vip-package-name {
        font-size: 1.5rem;
        font-weight: 700;
        color: #fff;
        margin-bottom: 0.5rem;
    }

    .vip-duration {
        color: rgba(255, 255, 255, 0.8);
        font-size: 0.9rem;
    }

    .vip-card-body {
        padding: 0 1.5rem 1.5rem;
        text-align: center;
    }

    .vip-price {
        font-size: 2.5rem;
        font-weight: 700;
        color: #ffd700;
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
    }

    .vip-price .currency {
        font-size: 1.2rem;
    }

    .vip-price-original {
        font-size: 1.2rem;
        color: rgba(255, 255, 255, 0.6);
        text-decoration: line-through;
    }

    .vip-discount {
        background: #dc3545;
        color: white;
        padding: 0.3rem 0.6rem;
        border-radius: 12px;
        font-size: 0.8rem;
        font-weight: 600;
    }

    .vip-features {
        list-style: none;
        padding: 0;
        margin: 1.5rem 0;
    }

    .vip-features li {
        color: rgba(255, 255, 255, 0.9);
        padding: 0.5rem 0;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .vip-features li i {
        color: #28a745;
        font-size: 1rem;
    }

    .vip-btn {
        width: 100%;
        padding: 1rem;
        border: none;
        border-radius: 50px;
        font-weight: 600;
        font-size: 1rem;
        text-decoration: none;
        display: inline-block;
        text-align: center;
        transition: var(--transition);
        box-shadow: var(--shadow-light);
        position: relative;
        overflow: hidden;
    }

    .vip-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
        transition: var(--transition);
    }

    .vip-btn:hover::before {
        left: 100%;
    }

    .vip-btn.btn-gold {
        background: var(--vip-gradient);
        color: white;
    }

    .vip-btn.btn-gold:hover {
        transform: translateY(-3px);
        box-shadow: var(--shadow-heavy);
        color: white;
    }

    .vip-btn.btn-outline {
        background: transparent;
        color: #fff;
        border: 2px solid rgba(255, 255, 255, 0.5);
    }

    .vip-btn.btn-outline:hover {
        background: rgba(255, 255, 255, 0.1);
        border-color: #fff;
        color: #fff;
        transform: translateY(-3px);
    }

    /* Category Sections */
    .category-section {
        margin-bottom: 3rem;
    }

    .category-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 2rem;
        padding: 1.5rem;
        background: var(--glass-bg);
        backdrop-filter: blur(20px);
        border-radius: var(--border-radius);
        border: 1px solid var(--glass-border);
        box-shadow: var(--shadow-medium);
        position: relative;
        overflow: hidden;
    }

    .category-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
        transition: var(--transition);
    }

    .category-header:hover::before {
        left: 100%;
    }

    .category-info {
        display: flex;
        align-items: center;
        gap: 1.5rem;
    }

    .category-icon {
        width: 70px;
        height: 70px;
        border-radius: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        color: white;
        box-shadow: var(--shadow-medium);
        transition: var(--transition);
        position: relative;
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

    .category-title {
        font-size: clamp(1.5rem, 4vw, 2rem);
        font-weight: 700;
        color: #fff;
        margin-bottom: 0.5rem;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    }

    .category-description {
        color: rgba(255, 255, 255, 0.8);
        font-size: clamp(0.8rem, 2vw, 1rem);
    }

    .view-all-btn {
        background: var(--primary-gradient);
        color: #fff;
        border: none;
        padding: 0.75rem 1.5rem;
        border-radius: 50px;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 0.75rem;
        transition: var(--transition);
        box-shadow: var(--shadow-light);
        position: relative;
        overflow: hidden;
        font-size: 0.9rem;
    }

    .view-all-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
        transition: var(--transition);
    }

    .view-all-btn:hover::before {
        left: 100%;
    }

    .view-all-btn:hover {
        color: #fff;
        transform: translateY(-3px) scale(1.05);
        box-shadow: var(--shadow-heavy);
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
        height: 250px;
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
        justify-content: space-between;
        align-items: flex-start;
        font-size: 0.75rem;
        color: rgba(255, 255, 255, 0.7);
        gap: 0.75rem;
        flex-wrap: wrap;
        margin-bottom: 0.75rem;
    }

    .story-stats {
        display: flex;
        gap: 0.75rem;
        flex-wrap: wrap;
    }

    .story-stats span {
        display: flex;
        align-items: center;
        gap: 0.4rem;
        padding: 0.4rem 0.6rem;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 15px;
        transition: var(--transition);
        backdrop-filter: blur(10px);
        font-size: 0.7rem;
    }

    .story-stats span:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: scale(1.05);
    }

    .story-status {
        padding: 0.4rem 0.8rem;
        border-radius: 15px;
        font-size: 0.7rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.05em;
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
    }

    .pagination .page-link {
        background: var(--glass-bg);
        backdrop-filter: blur(20px);
        border: 1px solid var(--glass-border);
        color: #fff;
        padding: 0.6rem 0.9rem;
        margin: 0 0.2rem;
        border-radius: 10px;
        transition: var(--transition);
        font-size: 0.9rem;
    }

    .pagination .page-link:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
        box-shadow: var(--shadow-light);
    }

    .pagination .page-item.active .page-link {
        background: var(--primary-gradient);
        border-color: transparent;
    }

    /* Login Required Modal Styles */
    .login-required-modal {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        backdrop-filter: blur(10px);
        z-index: 1060;
        display: none;
        align-items: center;
        justify-content: center;
        padding: 1rem;
    }

    .login-required-modal.show {
        display: flex;
    }

    .login-modal-content {
        background: var(--glass-bg);
        backdrop-filter: blur(20px);
        border: 1px solid var(--glass-border);
        border-radius: var(--border-radius);
        padding: 2rem;
        max-width: 400px;
        width: 100%;
        text-align: center;
        box-shadow: var(--shadow-heavy);
    }

    .login-modal-icon {
        font-size: 4rem;
        color: #ffd700;
        margin-bottom: 1rem;
    }

    .login-modal-title {
        color: #fff;
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 1rem;
    }

    .login-modal-text {
        color: rgba(255, 255, 255, 0.8);
        margin-bottom: 2rem;
        line-height: 1.6;
    }

    .login-modal-buttons {
        display: flex;
        gap: 1rem;
        justify-content: center;
        flex-wrap: wrap;
    }

    .login-modal-btn {
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 50px;
        font-weight: 600;
        text-decoration: none;
        transition: var(--transition);
        min-width: 120px;
    }

    .login-modal-btn.primary {
        background: var(--vip-gradient);
        color: white;
    }

    .login-modal-btn.secondary {
        background: transparent;
        color: #fff;
        border: 2px solid rgba(255, 255, 255, 0.5);
    }

    .login-modal-btn:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-medium);
    }

    /* VIP Modal - New implementation */
    .vip-modal {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        backdrop-filter: blur(10px);
        z-index: 1060;
        display: none;
        align-items: center;
        justify-content: center;
        padding: 1rem;
        overflow-y: auto;
    }

    .vip-modal.show {
        display: flex;
    }

    .vip-modal-content {
        background: var(--glass-bg);
        backdrop-filter: blur(20px);
        border: 1px solid var(--glass-border);
        border-radius: var(--border-radius);
        width: 100%;
        max-width: 1200px;
        max-height: 90vh;
        overflow-y: auto;
        box-shadow: var(--shadow-heavy);
        position: relative;
    }

    .vip-modal-header {
        padding: 2rem;
        text-align: center;
        border-bottom: 1px solid var(--glass-border);
        background: linear-gradient(135deg, rgba(255, 215, 0, 0.1) 0%, rgba(255, 183, 77, 0.1) 100%);
        position: sticky;
        top: 0;
        z-index: 1;
    }

    .vip-modal-title {
        color: #ffd700;
        font-weight: 700;
        margin-bottom: 0.5rem;
        font-size: 1.8rem;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
    }

    .vip-modal-subtitle {
        color: rgba(255, 255, 255, 0.8);
        margin: 0;
        font-size: 1rem;
    }

    .vip-modal-close {
        position: absolute;
        top: 1rem;
        right: 1rem;
        background: transparent;
        border: none;
        color: rgba(255, 255, 255, 0.8);
        font-size: 1.5rem;
        cursor: pointer;
        padding: 0.5rem;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: var(--transition);
    }

    .vip-modal-close:hover {
        background: rgba(255, 255, 255, 0.1);
        color: #fff;
        transform: scale(1.1);
    }

    .vip-modal-body {
        padding: 2rem;
    }

    .vip-package-modal-item {
        background: rgba(30, 30, 40, 0.8);
        border: 1px solid rgba(255, 215, 0, 0.2);
        border-radius: 20px;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        transition: var(--transition);
        position: relative;
        overflow: hidden;
    }

    .vip-package-modal-item:last-child {
        margin-bottom: 0;
    }

    .vip-package-modal-item.featured {
        border: 2px solid #ffd700;
        background: rgba(255, 215, 0, 0.1);
    }

    .vip-package-modal-item.featured::after {
        content: 'PHỔ BIẾN';
        position: absolute;
        top: 1rem;
        right: -1.5rem;
        background: #ff6b6b;
        color: white;
        padding: 0.3rem 2rem;
        font-size: 0.7rem;
        font-weight: 700;
        transform: rotate(25deg);
        letter-spacing: 0.1em;
    }

    .vip-package-modal-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 35px rgba(255, 215, 0, 0.3);
        border-color: rgba(255, 215, 0, 0.5);
    }

    .package-header-modal {
        display: flex;
        align-items: center;
        gap: 1.5rem;
        margin-bottom: 1rem;
    }

    .package-icon-modal {
        width: 60px;
        height: 60px;
        background: var(--vip-gradient);
        border-radius: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        color: white;
        flex-shrink: 0;
    }

    .package-info-modal {
        flex: 1;
    }

    .package-name-modal {
        color: #fff;
        font-weight: 700;
        margin: 0 0 0.5rem 0;
        font-size: 1.5rem;
    }

    .package-duration-modal {
        color: rgba(255, 255, 255, 0.7);
        font-size: 1rem;
    }

    .package-price-modal {
        text-align: right;
    }

    .package-price-modal .price {
        color: #ffd700;
        font-weight: 700;
        font-size: 1.8rem;
        display: block;
        line-height: 1;
    }

    .package-price-modal .price-old {
        color: rgba(255, 255, 255, 0.5);
        font-size: 1rem;
        text-decoration: line-through;
        margin-top: 0.25rem;
    }

    .package-features-modal {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
        margin: 1.5rem 0;
    }

    .package-features-modal span {
        background: rgba(255, 255, 255, 0.1);
        color: rgba(255, 255, 255, 0.9);
        padding: 0.75rem 1rem;
        border-radius: 12px;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: var(--transition);
    }

    .package-features-modal span:hover {
        background: rgba(255, 255, 255, 0.2);
        transform: translateY(-2px);
    }

    .package-features-modal span i {
        color: #4ecdc4;
        font-size: 1rem;
    }

    .btn-select-package-modal {
        background: var(--vip-gradient);
        color: white;
        border: none;
        padding: 1rem 2rem;
        border-radius: 50px;
        font-weight: 700;
        text-decoration: none;
        display: inline-block;
        font-size: 1rem;
        transition: var(--transition);
        width: 100%;
        text-align: center;
        margin-top: 1rem;
    }

    .btn-select-package-modal:hover {
        color: white;
        transform: translateY(-3px);
        box-shadow: 0 10px 30px rgba(255, 215, 0, 0.4);
    }

    /* Responsive Design Improvements */
    @media (max-width: 992px) {
        .category-header {
            flex-direction: column;
            gap: 1rem;
            text-align: center;
            padding: 1rem;
        }

        .category-info {
            flex-direction: column;
            text-align: center;
            gap: 1rem;
        }

        .package-header-modal {
            flex-direction: column;
            text-align: center;
            gap: 1rem;
        }

        .package-price-modal {
            text-align: center;
        }

        .package-features-modal {
            grid-template-columns: 1fr;
        }

        .notification-modal-content {
            max-width: 90%;
        }
    }

    @media (max-width: 768px) {
        .filter-section .form-select {
            font-size: 0.85rem;
            padding: 0.6rem 0.8rem;
        }

        .category-icon {
            width: 60px;
            height: 60px;
            font-size: 1.5rem;
        }

        .story-image {
            height: 200px;
        }

        .story-meta {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.5rem;
        }

        .story-stats {
            gap: 0.5rem;
        }

        .hero-section {
            padding: 2rem 1rem;
        }

        .filter-section .row {
            gap: 0.75rem;
        }

        .navbar-brand {
            font-size: 1.5rem;
        }

        .view-all-btn {
            padding: 0.6rem 1.2rem;
            font-size: 0.85rem;
        }

        .vip-card {
            margin-bottom: 1.5rem;
        }

        .vip-modal-content {
            margin: 1rem;
            max-width: calc(100% - 2rem);
        }

        .vip-modal-header {
            padding: 1.5rem 1rem;
        }

        .vip-modal-body {
            padding: 1rem;
        }

        .login-modal-buttons {
            flex-direction: column;
            align-items: center;
        }

        .login-modal-btn {
            width: 100%;
            max-width: 200px;
        }

        .notification-modal-content {
            max-width: 95%;
            max-height: 85vh;
        }

        .notification-modal-header {
            padding: 1rem 1.5rem;
            flex-direction: column;
            gap: 1rem;
            text-align: center;
        }

        .notification-modal-actions {
            justify-content: center;
        }

        .notification-modal-item {
            padding: 1rem;
        }

        .notification-item-content {
            gap: 0.75rem;
        }

        .notification-item-icon {
            width: 35px;
            height: 35px;
            font-size: 1rem;
        }
    }

    @media (max-width: 576px) {
        .navbar-nav {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px; /* tạo khoảng cách giữa các mục */
        }

        .navbar-nav .nav-item {
            width: 100%;
            margin-right: 0 !important;
            margin-left: 0 !important;
        }

        .navbar-nav .nav-link {
            width: 100%;
            display: flex;
            align-items: center;
            padding: 8px 12px;
        }
        .filter-section .form-select {
            font-size: 0.8rem;
            padding: 0.5rem 0.7rem;
        }

        .category-tag {
            font-size: 0.6rem;
            padding: 0.25rem 0.5rem;
        }

        .hero-section {
            padding: 1.5rem 0.75rem;
            margin: 1rem 0;
        }

        .story-image {
            height: 180px;
        }

        .story-info {
            padding: 1rem;
        }

        .category-icon {
            width: 50px;
            height: 50px;
            font-size: 1.3rem;
        }

        .category-section {
            margin-bottom: 2rem;
        }

        .story-stats span {
            font-size: 0.65rem;
            padding: 0.3rem 0.5rem;
        }

        .category-tag {
            font-size: 0.6rem;
            padding: 0.25rem 0.5rem;
        }

        .vip-membership-section {
            margin-bottom: 2rem;
        }

        .vip-header {
            padding: 1.5rem 0.75rem;
        }

        .vip-modal-header {
            padding: 1rem;
        }

        .vip-modal-title {
            font-size: 1.3rem;
        }

        .package-icon-modal {
            width: 50px;
            height: 50px;
            font-size: 1.5rem;
        }

        .package-name-modal {
            font-size: 1.2rem;
        }

        .package-price-modal .price {
            font-size: 1.5rem;
        }

        .notification-modal-content {
            max-width: 100%;
            max-height: 90vh;
            margin: 0;
            border-radius: 0;
        }

        .notification-modal-header {
            padding: 1rem;
        }

        .notification-modal-title {
            font-size: 1.1rem;
        }

        .notification-modal-item {
            padding: 0.75rem;
        }

        .notification-item-content {
            flex-direction: column;
            align-items: flex-start;
            gap: 0.5rem;
        }

        .notification-item-icon {
            width: 30px;
            height: 30px;
            font-size: 0.9rem;
        }

        .notification-item-title {
            font-size: 0.9rem;
        }

        .notification-item-text {
            font-size: 0.8rem;
        }

        .notification-item-time {
            font-size: 0.7rem;
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

    /* Grid improvements for mobile */
    @media (max-width: 576px) {
        .row.g-4 {
            --bs-gutter-x: 0.75rem;
            --bs-gutter-y: 0.75rem;
        }
    }

    /* Login prompt styling */
    .login-prompt {
        text-align: center;
        padding: 1.5rem;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 15px;
        margin-top: 2rem;
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .login-prompt i {
        color: #ffd700;
        margin-right: 0.5rem;
    }

    .login-prompt strong {
        color: #fff;
    }

    .login-prompt a {
        color: #ffd700;
        text-decoration: none;
        font-weight: 600;
        margin-left: 0.5rem;
        transition: var(--transition);
    }

    .login-prompt a:hover {
        color: #fff;
        text-decoration: underline;
    }

    /* Feedback Toast */
    .notification-feedback {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        max-width: 400px;
        padding: 1rem 1.5rem;
        border-radius: 10px;
        color: white;
        font-weight: 600;
        font-size: 0.9rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        backdrop-filter: blur(20px);
    }

    .notification-feedback.success {
        background: var(--success-gradient);
    }

    .notification-feedback.error {
        background: var(--hot-gradient);
    }

    .notification-feedback i {
        font-size: 1.2rem;
    }

    @keyframes slideInRight {
        from {
            opacity: 0;
            transform: translateX(100%);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    @keyframes slideOutRight {
        from {
            opacity: 1;
            transform: translateX(0);
        }
        to {
            opacity: 0;
            transform: translateX(100%);
        }
    }

    .notification-feedback.slide-in {
        animation: slideInRight 0.3s ease;
    }

    .notification-feedback.slide-out {
        animation: slideOutRight 0.3s ease forwards;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/home">
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
                            <li class="nav-item d-flex align-items-center me-3">
                                <c:choose>
                                    <c:when test="${isCurrentUserVIP}">
                                        <a href="${pageContext.request.contextPath}/vip/register" class="vip-nav-link" onclick="showCrownEffect(event)">
                                            <i class="fas fa-crown me-2"></i>Thông tin chi tiết VIP
                                        </a>
                                    </c:when>
                                <c:otherwise>
                                        <button class="vip-nav-link" onclick="showVipModal()">
                                            <i class="fas fa-crown me-2"></i>VIP
                                        </button>
                                </c:otherwise>
                                </c:choose>
                            </li>
                            
                            <!-- Notification Bell with Modal -->
                            <li class="nav-item notification-dropdown me-3">
                                <div class="notification-bell" onclick="showNotificationModal()" title="Xem thông báo">
                                    <i class="fas fa-bell"></i>
                                    <c:if test="${soThongBaoChuaDoc > 0}">
                                        <span class="notification-badge">${soThongBaoChuaDoc > 99 ? '99+' : soThongBaoChuaDoc}</span>
                                    </c:if>
                                </div>
                            </li>
                            
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user me-2"></i>${sessionScope.user.hoTen}
                                    <c:if test="${sessionScope.user.trangThaiVIP}">
                                        <i class="fas fa-crown text-warning ms-1"></i>
                                    </c:if>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                        <i class="fas fa-user-edit me-2"></i>Thông tin cá nhân</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/yeuthich">
                                            <i class="fas fa-heart"></i> Truyện yêu thích</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/tutruyen">
                                        <i class="fas fa-bookmark"></i> Truyện đã lưu</a></li>
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
        <!-- Hero Section -->
        <div class="hero-section">
            <h1 class="hero-title">🌟 Khám Phá Thế Giới Truyện 🌟</h1>
            <p class="hero-subtitle">Hàng ngàn câu chuyện hấp dẫn đang chờ bạn khám phá</p>
            
            <!-- Search Section -->
            <div class="search-section">
                <form class="search-form" action="${pageContext.request.contextPath}/truyen" method="GET">
                    <input type="text" class="form-control" name="keyword" 
                           placeholder="Tìm kiếm truyện yêu thích..." value="${keyword}">
                    <i class="fas fa-search search-icon"></i>
                </form>
            </div>
            
            <!-- Filter Section -->
            <div class="filter-section">
                <div class="row g-3">
                    <div class="col-md-6">
                        <select class="form-select" onchange="filterByCategory(this.value)">
                            <option value="">🎭 Tất cả thể loại</option>
                            <c:forEach var="theLoai" items="${danhSachTheLoai}">
                                <option value="${theLoai.id}">
                                    ${theLoai.tenTheLoai}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <select class="form-select" onchange="sortStories(this.value)">
                            <option value="">📊 Sắp xếp theo</option>
                            <option value="ngay_tao">🆕 Mới nhất</option>
                            <option value="luot_xem">👁️ Lượt xem</option>
                            <option value="danh_gia">⭐ Đánh giá</option>
                            <option value="ten_truyen">🔤 Tên A-Z</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <!-- VIP Membership Section -->
        <c:if test="${empty sessionScope.user}">
            <div class="vip-membership-section" id="vipMembershipSection">
                <div class="vip-header">
                    <h2 class="vip-title">
                        <i class="fas fa-crown me-3"></i>
                        Trở thành thành viên VIP
                    </h2>
                    <p class="vip-subtitle">
                        <c:choose>
                            <c:when test="${chuaDangNhap}">
                                Đăng nhập ngay để trải nghiệm các tính năng VIP độc quyền!
                            </c:when>
                            <c:otherwise>
                                Nâng cấp tài khoản để trải nghiệm các tính năng VIP độc quyền!
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>

                <div class="row g-4">
                    <c:forEach var="goi" items="${danhSachGoiVIP}" varStatus="status">
                        <div class="col-lg-4 col-md-6">
                            <div class="vip-card ${goi.noiBat ? 'popular' : ''}">
                                <div class="vip-card-header">
                                    <div class="vip-icon">
                                        <i class="${not empty goi.icon ? goi.icon : 'fas fa-crown'}"></i>
                                    </div>
                                    <h3 class="vip-package-name">${goi.tenGoi}</h3>
                                    <p class="vip-duration">${goi.soThang} tháng</p>
                                </div>

                                <div class="vip-card-body">
                                    <div class="vip-price">
                                        <span class="currency">₫</span>
                                        <span>${goi.giaFormatted}</span>
                                        <c:if test="${goi.hasDiscount()}">
                                            <span class="vip-discount">-${goi.phanTramGiamGia}%</span>
                                        </c:if>
                                    </div>
                                    <c:if test="${goi.hasDiscount()}">
                                        <div class="vip-price-original">₫${goi.giaGocFormatted}</div>
                                    </c:if>

                                    <ul class="vip-features">
                                        <li><i class="fas fa-check-circle"></i> Đọc tất cả truyện VIP</li>
                                        <li><i class="fas fa-check-circle"></i> Không có quảng cáo</li>
                                        <li><i class="fas fa-check-circle"></i> Đọc trước chương mới</li>
                                        <li><i class="fas fa-check-circle"></i> Tải truyện offline</li>
                                        <li><i class="fas fa-check-circle"></i> Hỗ trợ ưu tiên</li>
                                    </ul>

                                    <c:choose>
                                        <c:when test="${chuaDangNhap}">
                                            <button class="vip-btn btn-gold" onclick="showLoginRequired()">
                                                <i class="fas fa-crown me-2"></i>
                                                Đăng ký gói này
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/vip/register?package=${goi.id}" 
                                               class="vip-btn ${goi.noiBat ? 'btn-gold' : 'btn-outline'}">
                                                <i class="fas fa-crown me-2"></i>
                                                Đăng ký gói này
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Login Prompt for non-logged users -->
                <div class="login-prompt">
                    <i class="fas fa-info-circle"></i>
                    <strong>Bạn cần đăng nhập để đăng ký hội viên VIP.</strong>
                    <a href="${pageContext.request.contextPath}/login?redirect=vip">Đăng nhập ngay</a>
                </div>
            </div>
        </c:if>

        <!-- Truyện VIP Section -->
        <div class="category-section">
            <div class="category-header">
                <div class="category-info">
                    <div class="category-icon vip">
                        <i class="fas fa-crown"></i>
                    </div>
                    <div>
                        <h2 class="category-title">👑 Truyện VIP</h2>
                        <p class="category-description">Nội dung độc quyền dành cho thành viên VIP</p>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/truyen?category=vip" class="view-all-btn">
                    <span>Xem tất cả</span>
                    <i class="fas fa-chevron-right"></i>
                </a>
            </div>

            <c:choose>
                <c:when test="${empty truyenVIP}">
                    <div class="empty-state">
                        <i class="fas fa-crown"></i>
                        <h3>Chưa có truyện VIP nào</h3>
                        <p>Hãy quay lại sau để khám phá những nội dung độc quyền.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-4">
                        <c:forEach var="truyen" items="${truyenVIP}" varStatus="status">
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
                                            <div class="story-badge vip-badge">
                                                <i class="fas fa-crown"></i>
                                                VIP
                                            </div>
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
                                                        ${truyen.luotXemFormatted}
                                                    </span>
                                                    <span title="Số chương">
                                                        <i class="fas fa-list"></i>${truyen.soLuongChuong}
                                                    </span>
                                                    <span title="Đánh giá">
                                                        <i class="fas fa-star"></i>
                                                        ${truyen.danhGiaFormatted}
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
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Truyện Hot Section -->
        <div class="category-section">
            <div class="category-header">
                <div class="category-info">
                    <div class="category-icon hot">
                        <i class="fas fa-fire"></i>
                    </div>
                    <div>
                        <h2 class="category-title">🔥 Truyện Hot</h2>
                        <p class="category-description">Những truyện được yêu thích nhất</p>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/truyen?category=hot" class="view-all-btn">
                    <span>Xem tất cả</span>
                    <i class="fas fa-chevron-right"></i>
                </a>
            </div>

            <c:choose>
                <c:when test="${empty truyenHot}">
                    <div class="empty-state">
                        <i class="fas fa-fire"></i>
                        <h3>Chưa có truyện hot nào</h3>
                        <p>Hãy quay lại sau để khám phá những truyện được yêu thích nhất.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-4">
                        <c:forEach var="truyen" items="${truyenHot}" varStatus="status">
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
                                            <div class="story-badge hot-badge">
                                                <i class="fas fa-fire"></i>
                                                HOT
                                            </div>
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
                                                        ${truyen.luotXemFormatted}
                                                    </span>
                                                    <span title="Số chương">
                                                        <i class="fas fa-list"></i>${truyen.soLuongChuong}
                                                    </span>
                                                    <span title="Đánh giá">
                                                        <i class="fas fa-star"></i>
                                                        ${truyen.danhGiaFormatted}
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
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Truyện Mới Section -->
        <div class="category-section">
            <div class="category-header">
                <div class="category-info">
                    <div class="category-icon new">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div>
                        <h2 class="category-title">⏰ Truyện Mới</h2>
                        <p class="category-description">Truyện mới cập nhật gần đây</p>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/truyen?category=new" class="view-all-btn">
                    <span>Xem tất cả</span>
                    <i class="fas fa-chevron-right"></i>
                </a>
            </div>

            <c:choose>
                <c:when test="${empty truyenMoiNhat}">
                    <div class="empty-state">
                        <i class="fas fa-clock"></i>
                        <h3>Chưa có truyện mới nào</h3>
                        <p>Hãy quay lại sau để khám phá những truyện mới nhất.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-4">
                        <c:forEach var="truyen" items="${truyenMoiNhat}" varStatus="status">
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
                                            <div class="story-badge new-badge">
                                                <i class="fas fa-clock"></i>
                                                MỚI
                                            </div>
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
                                                        ${truyen.luotXemFormatted}
                                                    </span>
                                                    <span title="Số chương">
                                                        <i class="fas fa-list"></i>${truyen.soLuongChuong}
                                                    </span>
                                                    <span title="Đánh giá">
                                                        <i class="fas fa-star"></i>
                                                        ${truyen.danhGiaFormatted}
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
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- NEW: Notification Modal (Replaced Dropdown) -->
    <div class="notification-modal" id="notificationModal">
        <div class="notification-modal-content">
            <div class="notification-modal-header">
                <button class="notification-modal-close" onclick="hideNotificationModal()" title="Đóng">
                    <i class="fas fa-times"></i>
                </button>
                <h3 class="notification-modal-title">
                    <i class="fas fa-bell"></i>
                    Thông báo của bạn
                </h3>
                <div class="notification-modal-actions">
                    <c:if test="${soThongBaoChuaDoc > 0}">
                        <button class="mark-all-read-btn" onclick="markAllAsRead()" title="Đánh dấu tất cả đã đọc">
                            <i class="fas fa-check-double"></i>
                            Đánh dấu tất cả
                        </button>
                    </c:if>
                </div>
            </div>
            
            <div class="notification-modal-body">
                <c:choose>
                    <c:when test="${empty danhSachThongBao}">
                        <div class="notification-empty">
                            <i class="fas fa-bell-slash"></i>
                            <h4>Chưa có thông báo nào</h4>
                            <p>Các thông báo mới sẽ xuất hiện tại đây</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="thongBao" items="${danhSachThongBao}" varStatus="status">
                            <div class="notification-modal-item ${!thongBao.daDoc ? 'unread' : ''}" 
                                 onclick="readNotification(${thongBao.id})">
                                <div class="notification-item-content">
                                    <div class="notification-item-icon">
                                        <i class="fas fa-info-circle"></i>
                                    </div>
                                    <div class="notification-item-details">
                                        <h5 class="notification-item-title">${thongBao.tieuDe}</h5>
                                        <p class="notification-item-text">
                                            <c:choose>
                                                <c:when test="${fn:length(thongBao.noiDung) > 150}">
                                                    ${fn:substring(thongBao.noiDung, 0, 150)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${thongBao.noiDung}
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <div class="notification-item-time">
                                            <i class="fas fa-clock"></i>
                                            ${thongBao.ngayTaoFormatted}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="notification-modal-footer">
                <a href="${pageContext.request.contextPath}/notifications">
                    <i class="fas fa-list"></i>
                    Xem tất cả thông báo
                </a>
            </div>
        </div>
    </div>

    <!-- VIP Modal -->
    <div class="vip-modal" id="vipModal">
        <div class="vip-modal-content">
            <div class="vip-modal-header">
                <button class="vip-modal-close" onclick="hideVipModal()">
                    <i class="fas fa-times"></i>
                </button>
                <h2 class="vip-modal-title">
                    <i class="fas fa-crown"></i>
                    Gói Hội Viên VIP
                </h2>
                <p class="vip-modal-subtitle">
                    Trải nghiệm đọc truyện không giới hạn với những tính năng độc quyền
                </p>
            </div>
            
            <div class="vip-modal-body">
                <c:forEach var="goi" items="${danhSachGoiVIP}" varStatus="status">
                    <div class="vip-package-modal-item ${status.index == 1 ? 'featured' : ''}">
                        <div class="package-header-modal">
                            <div class="package-icon-modal">
                                <i class="${not empty goi.icon ? goi.icon : 'fas fa-crown'}"></i>
                            </div>
                            <div class="package-info-modal">
                                <h3 class="package-name-modal">${goi.tenGoi}</h3>
                                <p class="package-duration-modal">${goi.soThang} tháng</p>
                            </div>
                            <div class="package-price-modal">
                                <span class="price">${goi.giaFormatted}₫</span>
                                <c:if test="${goi.hasDiscount()}">
                                    <div class="price-old">${goi.giaGocFormatted}₫</div>
                                </c:if>
                            </div>
                        </div>
                        
                        <div class="package-features-modal">
                            <span><i class="fas fa-check"></i> Đọc tất cả truyện VIP</span>
                            <span><i class="fas fa-check"></i> Không có quảng cáo</span>
                            <span><i class="fas fa-check"></i> Đọc trước chương mới</span>
                            <span><i class="fas fa-check"></i> Tải truyện offline</span>
                            <span><i class="fas fa-check"></i> Hỗ trợ ưu tiên 24/7</span>
                            <span><i class="fas fa-check"></i> Truy cập tính năng beta</span>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/vip/register?packageId=${goi.id}" class="btn-select-package-modal">
                            <i class="fas fa-crown me-2"></i>
                            Chọn gói này
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- Login Required Modal -->
    <div class="login-required-modal" id="loginRequiredModal">
        <div class="login-modal-content">
            <div class="login-modal-icon">
                <i class="fas fa-lock"></i>
            </div>
            <h3 class="login-modal-title">Yêu cầu đăng nhập</h3>
            <p class="login-modal-text">
                Bạn cần đăng nhập để đăng ký gói VIP và trải nghiệm những tính năng độc quyền!
            </p>
            <div class="login-modal-buttons">
                <a href="${pageContext.request.contextPath}/login" class="login-modal-btn primary">
                    <i class="fas fa-sign-in-alt me-2"></i>
                    Đăng nhập
                </a>
                <button class="login-modal-btn secondary" onclick="hideLoginRequired()">
                    Hủy bỏ
                </button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Filter and sort functions - redirect to /truyen
        function filterByCategory(categoryId) {
            const url = new URL(window.location.origin + '${pageContext.request.contextPath}/truyen');
            if (categoryId) {
                url.searchParams.set('theLoai', categoryId);
            }
            
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

        function sortStories(sortBy) {
            const url = new URL(window.location.origin + '${pageContext.request.contextPath}/truyen');
            if (sortBy) {
                url.searchParams.set('sort', sortBy);
            }
            
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

        // NEW: Notification Modal Functions
        function showNotificationModal() {
            const modal = document.getElementById('notificationModal');
            modal.classList.add('show');
            document.body.style.overflow = 'hidden';
        }

        function hideNotificationModal() {
            const modal = document.getElementById('notificationModal');
            modal.classList.remove('show');
            document.body.style.overflow = 'auto';
        }

        // IMPROVED: Read notification function with better error handling
        function readNotification(notificationId) {
            if (!notificationId) return;
            
            // Show loading state
            const notificationItem = event.currentTarget;
            const originalContent = notificationItem.innerHTML;
            
            // Create loading overlay
            const loadingOverlay = document.createElement('div');
            loadingOverlay.style.cssText = 
                'position: absolute; top: 0; left: 0; right: 0; bottom: 0; ' +
                'background: rgba(0, 0, 0, 0.5); display: flex; align-items: center; ' +
                'justify-content: center; color: white; font-weight: 600; z-index: 10;';
            loadingOverlay.innerHTML = '<div class="loading-spinner"></div> <span style="margin-left: 10px;">Đang xử lý...</span>';
            
            notificationItem.style.position = 'relative';
            notificationItem.appendChild(loadingOverlay);
            
            // Mark as read via AJAX
            fetch('${pageContext.request.contextPath}/notification/read', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: 'id=' + encodeURIComponent(notificationId)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text();
            })
            .then(data => {
                // Remove loading overlay
                if (loadingOverlay.parentNode) {
                    loadingOverlay.remove();
                }
                
                // Update UI immediately
                notificationItem.classList.remove('unread');
                updateNotificationBadge();
                
                // Show success feedback
                showNotificationFeedback('Đã đánh dấu thông báo là đã đọc', 'success');
                
                // Optional: Close modal after a delay
                setTimeout(() => {
                    hideNotificationModal();
                }, 1500);
            })
            .catch(error => {
                console.error('Error marking notification as read:', error);
                
                // Remove loading overlay
                if (loadingOverlay.parentNode) {
                    loadingOverlay.remove();
                }
                
                // Show error feedback
                showNotificationFeedback('Có lỗi xảy ra, vui lòng thử lại', 'error');
            });
        }

        // IMPROVED: Mark all as read function
        function markAllAsRead() {
            const button = event.target.closest('.mark-all-read-btn');
            if (!button) return;
            
            const originalContent = button.innerHTML;
            
            // Show loading state
            button.innerHTML = '<div class="loading-spinner"></div> Đang xử lý...';
            button.disabled = true;
            
            fetch('${pageContext.request.contextPath}/notification/markAllRead', {
                method: 'POST',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text();
            })
            .then(data => {
                // Update UI immediately
                document.querySelectorAll('.notification-modal-item.unread').forEach(item => {
                    item.classList.remove('unread');
                });
                
                // Remove notification badge
                const badge = document.querySelector('.notification-badge');
                if (badge) {
                    badge.remove();
                }
                
                // Hide the mark all button
                button.style.display = 'none';
                
                // Show success feedback
                showNotificationFeedback('Đã đánh dấu tất cả thông báo là đã đọc', 'success');
            })
            .catch(error => {
                console.error('Error marking all notifications as read:', error);
                
                // Restore button
                button.innerHTML = originalContent;
                button.disabled = false;
                
                // Show error feedback
                showNotificationFeedback('Có lỗi xảy ra, vui lòng thử lại', 'error');
            });
        }

        // NEW: Notification feedback system
        function showNotificationFeedback(message, type) {
            type = type || 'success';
            
            // Remove existing feedback
            const existingFeedback = document.querySelector('.notification-feedback');
            if (existingFeedback) {
                existingFeedback.remove();
            }
            
            // Create feedback element
            const feedback = document.createElement('div');
            feedback.className = 'notification-feedback ' + type + ' slide-in';
            
            const iconClass = type === 'success' ? 'fas fa-check-circle' : 'fas fa-exclamation-triangle';
            feedback.innerHTML = 
                '<i class="' + iconClass + '"></i>' +
                '<span>' + message + '</span>';
            
            document.body.appendChild(feedback);
            
            // Remove after 3 seconds
            setTimeout(() => {
                feedback.classList.remove('slide-in');
                feedback.classList.add('slide-out');
                setTimeout(() => {
                    if (feedback.parentNode) {
                        feedback.remove();
                    }
                }, 300);
            }, 3000);
        }

        // IMPROVED: Update notification badge
        function updateNotificationBadge() {
            const badge = document.querySelector('.notification-badge');
            if (badge) {
                const currentCount = parseInt(badge.textContent.replace('+', '')) || 0;
                const newCount = Math.max(0, currentCount - 1);
                
                if (newCount <= 0) {
                    badge.remove();
                } else {
                    badge.textContent = newCount > 99 ? '99+' : newCount.toString();
                }
            }
        }

        // VIP Modal functions
        function showVipModal() {
            document.getElementById('vipModal').classList.add('show');
            document.body.style.overflow = 'hidden';
        }

        function hideVipModal() {
            document.getElementById('vipModal').classList.remove('show');
            document.body.style.overflow = 'auto';
        }

        // Login required modal functions
        function showLoginRequired() {
            document.getElementById('loginRequiredModal').classList.add('show');
            document.body.style.overflow = 'hidden';
        }

        function hideLoginRequired() {
            document.getElementById('loginRequiredModal').classList.remove('show');
            document.body.style.overflow = 'auto';
        }

        // IMPROVED: Close modals when clicking outside or pressing ESC
        document.addEventListener('click', function(event) {
            // Close notification modal when clicking outside
            const notificationModal = document.getElementById('notificationModal');
            if (event.target === notificationModal) {
                hideNotificationModal();
            }

            // Close VIP modal when clicking outside
            const vipModal = document.getElementById('vipModal');
            if (event.target === vipModal) {
                hideVipModal();
            }

            // Close login modal when clicking outside
            const loginModal = document.getElementById('loginRequiredModal');
            if (event.target === loginModal) {
                hideLoginRequired();
            }
        });

        // Close modals on ESC key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                hideNotificationModal();
                hideVipModal();
                hideLoginRequired();
            }
        });

        // Add smooth scrolling for better navigation
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
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
            document.querySelectorAll('.story-card, .vip-card').forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'opacity 0.6s ease ' + (index * 0.1) + 's, transform 0.6s ease ' + (index * 0.1) + 's';
                observer.observe(card);
            });
        });

        // Add loading state to search form
        const searchForm = document.querySelector('.search-form');
        if (searchForm) {
            searchForm.addEventListener('submit', function() {
                const submitBtn = this.querySelector('button[type="submit"]');
                if (submitBtn) {
                    submitBtn.innerHTML = '<div class="loading-spinner"></div> Đang tìm...';
                    submitBtn.disabled = true;
                }
            });
        }

        // Improve mobile touch interactions
        if ('ontouchstart' in window) {
            document.querySelectorAll('.story-card, .vip-card').forEach(card => {
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

        // Hide/Show VIP section based on user status
        <c:if test="${not empty sessionScope.user}">
            document.addEventListener('DOMContentLoaded', function() {
                const vipSection = document.getElementById('vipMembershipSection');
                if (vipSection) {
                    vipSection.classList.add('hide');
                }
            });
        </c:if>
        
        <c:if test="${empty sessionScope.user}">
            document.addEventListener('DOMContentLoaded', function() {
                const vipSection = document.getElementById('vipMembershipSection');
                if (vipSection) {
                    vipSection.classList.add('show');
                }
            });
        </c:if>
            
    </script>
</body>
</html>