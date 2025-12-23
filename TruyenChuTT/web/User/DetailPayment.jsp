<%@page import="model.NguoiDung"%>
<%@page import="model.GoiVIP"%>
<%@page import="util.VietQRGenerator"%>
<%@page import="util.BankInfo"%>
<%@page import="java.math.BigDecimal"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết thanh toán - TruyenMoi</title>
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
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ff8e53 100%);
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
            padding: 1rem 0;
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
            max-width: 1000px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
            padding: 0 15px;
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
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
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
            padding: 2rem 1rem;
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
            font-size: clamp(1.5rem, 4vw, 2.5rem);
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
        }

        .payment-header p {
            font-size: clamp(0.9rem, 2.5vw, 1.1rem);
            color: rgba(255, 255, 255, 0.9);
            position: relative;
            z-index: 1;
            margin-bottom: 0;
        }

        .crown-icon {
            color: #ffd700;
            filter: drop-shadow(0 0 15px rgba(255, 215, 0, 0.8));
            animation: crownFloat 3s ease-in-out infinite;
        }

        @keyframes crownFloat {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-10px) rotate(5deg); }
        }

        .payment-body {
            padding: 1.5rem;
            position: relative;
            z-index: 1;
        }

        .alert {
            border-radius: 15px;
            border: none;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: flex-start;
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow-light);
            animation: slideInDown 0.5s ease-out;
            position: relative;
            overflow: hidden;
        }

        @keyframes slideInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .alert::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            animation: alertShimmer 2s ease-in-out infinite;
        }

        @keyframes alertShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .alert-danger {
            background: rgba(255, 107, 107, 0.2);
            color: #fff;
            border: 1px solid rgba(255, 107, 107, 0.4);
        }

        .alert-success {
            background: rgba(79, 172, 254, 0.2);
            color: #fff;
            border: 1px solid rgba(79, 172, 254, 0.4);
        }

        .alert i {
            margin-right: 0.75rem;
            font-size: 1.2rem;
            flex-shrink: 0;
            margin-top: 0.1rem;
        }

        .alert-content {
            flex-grow: 1;
        }

        .alert-content strong {
            display: block;
            font-size: 1rem;
            margin-bottom: 0.25rem;
        }

        .package-info {
            background: rgba(255, 215, 0, 0.1);
            border: 2px solid rgba(255, 215, 0, 0.3);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.15);
            position: relative;
            overflow: hidden;
        }

        .package-info::before {
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

        .package-info h4 {
            color: #fff;
            font-weight: 700;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            font-size: clamp(1.1rem, 3vw, 1.5rem);
            flex-wrap: wrap;
        }

        .package-info h4 i {
            color: #ffd700;
            margin-right: 0.5rem;
            font-size: clamp(1.2rem, 3.5vw, 1.8rem);
        }

        .package-details {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
            align-items: start;
        }

        .package-details-info p {
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 0.5rem;
            font-size: clamp(0.85rem, 2.5vw, 1rem);
            word-break: break-word;
        }

        .package-details-info strong {
            color: #ffd700;
            font-weight: 600;
        }

        .user-info-highlight {
            background: rgba(255, 215, 0, 0.15);
            border: 1px solid rgba(255, 215, 0, 0.4);
            border-radius: 10px;
            padding: 0.75rem 1rem;
            margin: 0.5rem 0;
            font-weight: 600;
            color: #ffd700;
            font-size: clamp(0.9rem, 2.5vw, 1.1rem);
        }

        .price-highlight {
            text-align: center;
            margin-top: 1rem;
        }

        .price-highlight h3 {
            color: #ffd700;
            font-size: clamp(1.8rem, 5vw, 2.5rem);
            font-weight: 800;
            margin-bottom: 0;
            text-shadow: 0 0 20px rgba(255, 215, 0, 0.5);
            animation: priceGlow 2s ease-in-out infinite;
        }

        @keyframes priceGlow {
            0%, 100% { text-shadow: 0 0 20px rgba(255, 215, 0, 0.5); }
            50% { text-shadow: 0 0 30px rgba(255, 215, 0, 0.8); }
        }

        .price-original {
            color: rgba(255, 255, 255, 0.6);
            text-decoration: line-through;
            font-size: clamp(1rem, 3vw, 1.2rem);
            margin-bottom: 0.5rem;
        }

        .discount-badge {
            background: var(--danger-gradient);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-left: 0.5rem;
            display: inline-block;
        }

        .pending-notice {
            background: rgba(255, 193, 7, 0.15);
            border: 2px solid rgba(255, 193, 7, 0.4);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.2);
            position: relative;
            overflow: hidden;
        }

        .pending-notice::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 193, 7, 0.1), transparent);
            animation: pendingShimmer 2s ease-in-out infinite;
        }

        @keyframes pendingShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .pending-notice i {
            font-size: clamp(2rem, 6vw, 3rem);
            color: #ffc107;
            margin-bottom: 1rem;
            animation: pendingPulse 2s ease-in-out infinite;
        }

        @keyframes pendingPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .pending-notice h5 {
            color: #ffc107;
            font-weight: 700;
            margin-bottom: 0.5rem;
            font-size: clamp(1rem, 3vw, 1.25rem);
        }

        .pending-notice p {
            color: rgba(255, 193, 7, 0.9);
            font-size: clamp(0.85rem, 2.5vw, 1rem);
            margin-bottom: 0;
        }

        .bank-info {
            background: rgba(255, 215, 0, 0.1);
            border: 2px solid rgba(255, 215, 0, 0.4);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.15);
            position: relative;
            overflow: hidden;
        }

        .bank-info::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.1), transparent);
            animation: bankShimmer 3s ease-in-out infinite;
        }

        @keyframes bankShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .bank-info h5 {
            color: #ffd700;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            font-size: clamp(1rem, 3vw, 1.4rem);
            flex-wrap: wrap;
        }

        .bank-info h5 i {
            margin-right: 0.5rem;
            font-size: clamp(1.2rem, 3.5vw, 1.6rem);
        }

        .bank-detail {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .bank-detail::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transition: var(--transition);
        }

        .bank-detail:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .bank-detail:hover::before {
            left: 100%;
        }

        .bank-detail-info {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            min-width: 0;
        }

        .bank-detail-info strong {
            color: #ffd700;
            font-weight: 600;
            margin-bottom: 0.25rem;
            font-size: clamp(0.85rem, 2.5vw, 1rem);
        }

        .bank-detail-info span {
            color: rgba(255, 255, 255, 0.9);
            font-size: clamp(0.8rem, 2.2vw, 1rem);
            word-break: break-all;
        }

        .copy-btn {
            background: var(--vip-gradient);
            color: #333;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: clamp(0.75rem, 2vw, 0.9rem);
            font-weight: 600;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            cursor: pointer;
            flex-shrink: 0;
            white-space: nowrap;
        }

        .copy-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .copy-btn:hover {
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 5px 15px rgba(255, 215, 0, 0.4);
        }

        .copy-btn:hover::before {
            left: 100%;
        }

        .copy-btn.copied {
            background: var(--success-gradient);
            color: white;
        }

        .qr-section {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .qr-section h5 {
            color: #fff;
            font-weight: 700;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: clamp(1rem, 3vw, 1.25rem);
            flex-wrap: wrap;
            text-align: center;
        }

        .qr-section h5 i {
            color: #ffd700;
            margin-right: 0.5rem;
            font-size: clamp(1.1rem, 3.2vw, 1.3rem);
        }

        .qr-code {
            background: white;
            padding: 1rem;
            border-radius: 12px;
            display: inline-block;
            margin-bottom: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: var(--transition);
            max-width: 100%;
        }

        .qr-code:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }

        .qr-code img {
            max-width: 100%;
            height: auto;
            display: block;
        }

        .qr-section p {
            color: rgba(255, 255, 255, 0.8);
            font-size: clamp(0.8rem, 2.2vw, 0.9rem);
            margin-bottom: 0;
        }

        .qr-section .supported-apps {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 1rem;
            margin-top: 1rem;
            flex-wrap: wrap;
        }

        .app-logo {
            background: rgba(255, 255, 255, 0.1);
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.9);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: var(--transition);
        }

        .app-logo:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .transfer-content {
            background: rgba(255, 215, 0, 0.15);
            border: 2px dashed rgba(255, 215, 0, 0.6);
            border-radius: 12px;
            padding: 1rem;
            color: #ffd700;
            font-weight: 600;
            font-size: clamp(0.9rem, 2.5vw, 1.1rem);
            text-align: center;
            margin: 1rem 0;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            flex-wrap: wrap;
            word-break: break-word;
        }

        .transfer-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 215, 0, 0.1), transparent);
            animation: transferShimmer 2s ease-in-out infinite;
        }

        @keyframes transferShimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .steps {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .steps h5 {
            color: #fff;
            font-weight: 700;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            font-size: clamp(1rem, 3vw, 1.25rem);
            flex-wrap: wrap;
        }

        .steps h5 i {
            color: #ffd700;
            margin-right: 0.5rem;
            font-size: clamp(1.1rem, 3.2vw, 1.3rem);
        }

        .step-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1rem;
            padding: 1rem;
            border-radius: 10px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .step-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.05), transparent);
            transition: var(--transition);
        }

        .step-item:hover {
            background: rgba(255, 215, 0, 0.05);
            transform: translateX(5px);
        }

        .step-item:hover::before {
            left: 100%;
        }

        .step-number {
            background: var(--vip-gradient);
            color: #333;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: clamp(0.9rem, 2.5vw, 1.1rem);
            margin-right: 1rem;
            flex-shrink: 0;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.4);
        }

        .step-content {
            color: rgba(255, 255, 255, 0.9);
            flex-grow: 1;
        }

        .step-content strong {
            color: #fff;
            font-weight: 600;
            display: block;
            margin-bottom: 0.25rem;
            font-size: clamp(0.85rem, 2.5vw, 1rem);
        }

        .step-content span,
        .step-content br + text {
            font-size: clamp(0.8rem, 2.2vw, 0.9rem);
        }

        .confirm-btn {
            width: 100%;
            background: var(--vip-gradient);
            color: #333;
            border: none;
            padding: 1rem 1.5rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: clamp(0.9rem, 2.5vw, 1.2rem);
            transition: var(--transition);
            margin-bottom: 1rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(255, 215, 0, 0.4);
        }

        .confirm-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .confirm-btn:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 15px 40px rgba(255, 215, 0, 0.6);
        }

        .confirm-btn:hover::before {
            left: 100%;
        }

        .confirm-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
            background: var(--warning-gradient);
            color: #fff;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-weight: 500;
            padding: 0.75rem 1.25rem;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 50px;
            transition: var(--transition);
            backdrop-filter: blur(10px);
            font-size: clamp(0.85rem, 2.5vw, 1rem);
        }

        .back-link:hover {
            color: #fff;
            border-color: rgba(255, 255, 255, 0.6);
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        .support-info {
            background: rgba(79, 172, 254, 0.15);
            color: #4facfe;
            padding: 1rem;
            border-radius: 15px;
            border: 1px solid rgba(79, 172, 254, 0.3);
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.2);
            font-size: clamp(0.8rem, 2.2vw, 0.9rem);
            text-align: center;
            flex-wrap: wrap;
            justify-content: center;
        }

        /* Custom Modal Styles */
        .modal-content {
            background: var(--vip-glass-bg);
            backdrop-filter: blur(20px);
            border: 2px solid var(--vip-glass-border);
            border-radius: var(--border-radius);
            box-shadow: var(--vip-shadow);
            color: #fff;
        }

        .modal-header {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 30%, #533483 70%, #ffd700 100%);
            border-bottom: 1px solid var(--vip-glass-border);
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        .modal-title {
            color: #fff;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .modal-title i {
            color: #ffd700;
            font-size: 1.5rem;
        }

        .modal-body {
            padding: 2rem;
            text-align: center;
        }

        .modal-body .success-icon {
            font-size: 4rem;
            color: #4facfe;
            margin-bottom: 1rem;
            animation: successPulse 2s ease-in-out infinite;
        }

        @keyframes successPulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }

        .modal-body h5 {
            color: #4facfe;
            font-weight: 700;
            margin-bottom: 1rem;
            font-size: 1.25rem;
        }

        .modal-body p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        .modal-footer {
            border-top: 1px solid var(--vip-glass-border);
            justify-content: center;
        }

        .btn-close {
            filter: invert(1);
        }

        .modal-backdrop {
            background-color: rgba(0, 0, 0, 0.8);
        }

        /* Responsive Design Improvements */
        @media (max-width: 1200px) {
            .container { max-width: 95%; }
        }

        @media (max-width: 992px) {
            .payment-body { padding: 1.25rem; }
            .bank-detail { flex-direction: column; align-items: stretch; gap: 1rem; text-align: center; }
            .bank-detail-info { text-align: center; }
            .copy-btn { align-self: center; width: auto; }
        }

        @media (max-width: 768px) {
            body { padding: 0.5rem 0; }
            .container { padding: 0 10px; }
            .payment-header { padding: 1.5rem 1rem; }
            .payment-body { padding: 1rem; }
            .package-info, .bank-info, .steps, .qr-section { padding: 1rem; }
            .package-details { text-align: center; }
            .price-highlight { margin-top: 0.5rem; }
            .step-item { flex-direction: column; text-align: center; gap: 0.75rem; padding: 0.75rem; }
            .step-number { margin: 0 auto 0.5rem; }
            .step-content { text-align: center; }
            .transfer-content { flex-direction: column; gap: 0.75rem; padding: 0.75rem; }
            .support-info { padding: 0.75rem; flex-direction: column; text-align: center; }
            .modal-body { padding: 1.5rem; }
            .modal-body .success-icon { font-size: 3rem; }
            .supported-apps { gap: 0.5rem; }
            .app-logo { padding: 0.4rem 0.8rem; font-size: 0.7rem; }
        }

        @media (max-width: 576px) {
            .payment-header { padding: 1rem 0.75rem; }
            .payment-body { padding: 0.75rem; }
            .package-info h4, .bank-info h5, .steps h5, .qr-section h5 { justify-content: center; text-align: center; }
            .confirm-btn { padding: 0.875rem 1.25rem; }
            .back-link { padding: 0.625rem 1rem; }
            .qr-code { padding: 0.75rem; }
            .bank-detail { padding: 0.75rem; }
            .step-item { padding: 0.5rem; }
            .modal-body { padding: 1rem; }
            .modal-body .success-icon { font-size: 2.5rem; }
        }

        @media (max-width: 400px) {
            .payment-header h2 { line-height: 1.2; }
            .bank-detail-info span { font-size: 0.75rem; }
            .copy-btn { padding: 0.4rem 0.8rem; font-size: 0.7rem; }
            .step-number { width: 30px; height: 30px; font-size: 0.85rem; }
        }

        /* Loading Animation */
        .loading-spinner {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: #fff;
            animation: spin 1s ease-in-out infinite;
            margin-right: 0.5rem;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Toast Animation */
        .toast-notification {
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--success-gradient);
            color: white;
            padding: 0.75rem 1.25rem;
            border-radius: 50px;
            font-weight: 600;
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.4);
            z-index: 9999;
            animation: toastSlideIn 0.5s ease-out;
            font-size: clamp(0.8rem, 2.2vw, 0.9rem);
            max-width: calc(100vw - 40px);
            word-wrap: break-word;
        }

        @keyframes toastSlideIn {
            from { opacity: 0; transform: translateX(100%); }
            to { opacity: 1; transform: translateX(0); }
        }

        @media (max-width: 576px) {
            .toast-notification { top: 10px; right: 10px; left: 10px; max-width: none; text-align: center; }
        }

        /* Accessibility improvements */
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after { animation-duration: 0.01ms !important; animation-iteration-count: 1 !important; transition-duration: 0.01ms !important; }
        }

        /* High contrast mode support */
        @media (prefers-contrast: high) {
            .bank-detail, .step-item, .package-info, .bank-info { border: 2px solid #fff; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="payment-container">
            <div class="payment-header">
                <h2><i class="fas fa-university me-2 crown-icon"></i>Chi tiết thanh toán</h2>
                <p>Quét mã QR bằng MoMo, Vietcombank hoặc app ngân hàng để chuyển khoản tự động</p>
            </div>

            <div class="payment-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i>
                        <div class="alert-content">
                            <strong>Có lỗi xảy ra!</strong>
                            <span>${error}</span>
                        </div>
                    </div>
                </c:if>

                <!-- Package Info -->
                <div class="package-info">
                    <h4><i class="fas fa-crown"></i><c:out value="${goiVIP.tenGoi != null ? goiVIP.tenGoi : 'Gói VIP không xác định'}" /></h4>
                    <div class="package-details">
                        <div class="package-details-info">
                            <p><strong>Thời hạn:</strong> <c:out value="${goiVIP.soThang}" /> tháng</p>
                            <p><strong>Tên người dùng:</strong></p>
                            <div class="user-info-highlight">
                                <i class="fas fa-user me-2"></i><c:out value="${user.hoTen != null ? user.hoTen : 'Không xác định'}" />
                            </div>
                            <p><strong>Email đăng ký:</strong></p>
                            <div class="user-info-highlight">
                                <i class="fas fa-envelope me-2"></i><c:out value="${user.email != null ? user.email : 'Không xác định'}" />
                            </div>
                            <p><strong>Gói VIP:</strong></p>
                            <div class="user-info-highlight">
                                <i class="fas fa-crown me-2"></i><c:out value="${goiVIP.displayName}" />
                            </div>
                            <p><strong>Mô tả:</strong> <c:out value="${goiVIP.moTa != null ? goiVIP.moTa : 'Không có mô tả'}" /></p>
                        </div>
                        <div class="price-highlight">
                            <c:if test="${goiVIP.hasDiscount()}">
                                <div class="price-original">
                                    <c:out value="${goiVIP.giaGocFormatted}"/>₫
                                    <span class="discount-badge">-${goiVIP.phanTramGiamGia}%</span>
                                </div>
                            </c:if>
                            <h3><c:out value="${goiVIP.giaFormatted}"/>₫</h3>
                        </div>
                    </div>
                </div>

                <c:if test="${hasExistingRequest}">
                    <div class="pending-notice">
                        <i class="fas fa-clock"></i>
                        <h5>Yêu cầu thanh toán đang được xử lý</h5>
                        <p>Bạn đã tạo yêu cầu thanh toán cho gói này. Vui lòng đợi admin xác nhận trong vòng 24 giờ hoặc liên hệ hỗ trợ nếu cần thiết.</p>
                    </div>
                </c:if>

                <!-- Bank Information -->
                <div class="bank-info">
                    <h5>
                        <i class="fas fa-university"></i>
                        Thông tin chuyển khoản
                    </h5>
                    <div class="bank-detail">
                        <div class="bank-detail-info">
                            <strong>Ngân hàng:</strong>
                            <span>Vietcombank (VCB)</span>
                        </div>
                        <button class="copy-btn" onclick="copyToClipboard('Vietcombank')">
                            <i class="fas fa-copy me-1"></i>Copy
                        </button>
                    </div>
                    <div class="bank-detail">
                        <div class="bank-detail-info">
                            <strong>Số tài khoản:</strong>
                            <span>1028177524</span>
                        </div>
                        <button class="copy-btn" onclick="copyToClipboard('1028177524')">
                            <i class="fas fa-copy me-1"></i>Copy
                        </button>
                    </div>
                    <div class="bank-detail">
                        <div class="bank-detail-info">
                            <strong>Chủ tài khoản:</strong>
                            <span>VO TAN QUY</span>
                        </div>
                        <button class="copy-btn" onclick="copyToClipboard('VO TAN QUY')">
                            <i class="fas fa-copy me-1"></i>Copy
                        </button>
                    </div>
                    <div class="bank-detail">
                        <div class="bank-detail-info">
                            <strong>Số tiền:</strong>
                            <span style="color: #ffd700; font-weight: 700;"><c:out value="${goiVIP.giaFormatted}"/>₫</span>
                        </div>
                        <button class="copy-btn" onclick="copyToClipboard('<c:out value="${goiVIP.gia}"/>')">
                            <i class="fas fa-copy me-1"></i>Copy
                        </button>
                    </div>
                </div>

                <div>
                    <label style="color: #ffd700; font-weight: 700; margin-bottom: 1rem; display: block; font-size: clamp(0.9rem, 2.5vw, 1.1rem);">
                        <i class="fas fa-edit me-2"></i>Nội dung chuyển khoản:
                    </label>
                    <div class="transfer-content" id="transferContent">
                        <span style="word-break: break-word;"><c:out value="${user.email != null ? user.email : ''}" /> <c:out value="${user.hoTen != null ? user.hoTen : ''}" /> <c:out value="${goiVIP.tenGoi != null ? goiVIP.tenGoi : ''}" /></span>
                        <button class="copy-btn" onclick="copyTransferContent()">
                            <i class="fas fa-copy me-1"></i>Copy
                        </button>
                    </div>
                    <small style="color: #ffc107; display: flex; align-items: center; margin-top: 0.5rem; font-size: clamp(0.75rem, 2vw, 0.85rem);">
                        
                       
                    </small>
                </div>

                <!-- Steps -->
                <div class="steps">
                    <h5>
                        <i class="fas fa-list-ol"></i>
                        Hướng dẫn thanh toán 
                    </h5>
                    <div class="step-item">
                        <div class="step-number">1</div>
                        <div class="step-content">
                            <strong>Mở app ngân hàng hoặc MoMo</strong>
                            <span>Mở ứng dụng Vietcombank, MoMo, hoặc bất kỳ app ngân hàng nào. </span>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">2</div>
                        <div class="step-content">
                            <strong>Chọn đúng ngân hàng Vietcombank </strong>
                            <span>Nhập đúng STK và nội dung chuyển khoản.</span>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">3</div>
                        <div class="step-content">
                            <strong>Kiểm tra thông tin</strong>
                            <span>Thông tin ngân hàng, số tài khoản, số tiền <strong style="color: #ffd700;">(<c:out value="${goiVIP.giaFormatted}"/>₫)</strong> và nội dung chuyển khoản.</span>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">4</div>
                        <div class="step-content">
                            <strong>Xác nhận chuyển khoản</strong>
                            <span>Kiểm tra lại thông tin và xác nhận chuyển khoản trong app</span>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">5</div>
                        <div class="step-content">
                            <strong>Tạo yêu cầu xác nhận</strong>
                            <span>Sau khi chuyển khoản thành công, nhấn nút bên dưới để tạo yêu cầu xác nhận</span>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <form method="post" id="paymentForm" action="${pageContext.request.contextPath}/vip/register">
                    <input type="hidden" name="packageId" value="${goiVIP.id}">
                    <input type="hidden" name="action" value="createPaymentRequest">
                    <c:if test="${hasExistingRequest}">
                        <input type="hidden" id="requestTimestamp" value="${requestTimestamp != null ? requestTimestamp : ''}">
                    </c:if>
                    <button type="submit" class="confirm-btn" id="confirmPaymentBtn" <c:if test="${hasExistingRequest}">disabled</c:if>>
                        <i class="fas fa-check-circle me-2"></i>
                        <c:choose>
                            <c:when test="${hasExistingRequest}">
                                Đang chờ xác nhận
                            </c:when>
                            <c:otherwise>
                                Đã chuyển khoản - Tạo yêu cầu xác nhận
                            </c:otherwise>
                        </c:choose>
                    </button>
                </form>

                <div class="text-center">
                    <a href="${pageContext.request.contextPath}/vip/register?packageId=${goiVIP.id}"
                        class="back-link me-2 mb-2 d-inline-flex">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                    </a>
                </div>

                <div class="text-center mt-3">
                    <div class="support-info">
                        <i class="fas fa-headset"></i>
                        <span>Cần hỗ trợ? Liên hệ: accsv12ttt@gmail.com | 0934487739</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Success Modal -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="successModalLabel">
                        <i class="fas fa-check-circle"></i>
                        Gửi yêu cầu thành công
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="success-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h5>Yêu cầu của bạn đã được gửi đi!</h5>
                    <p>
                        Chúng tôi đã nhận được yêu cầu thanh toán VIP của bạn. 
                        Admin sẽ kiểm tra và xác nhận trong vòng <strong>24 giờ</strong> làm việc.
                    </p>
                    <p>
                        Bạn sẽ nhận được thông báo qua email khi yêu cầu được duyệt. 
                        Cảm ơn bạn đã tin tưởng và sử dụng dịch vụ của chúng tôi!
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Đóng
                    </button>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-warning">
                        <i class="fas fa-home me-2"></i>Về trang chủ
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Store data safely in JavaScript variables with null checks
        var packageData = {
            price: '<c:out value="${goiVIP.gia}"/>',
            priceFormatted: '<c:out value="${goiVIP.giaFormatted}"/>₫',
            packageName: '<c:out value="${goiVIP.tenGoi != null ? goiVIP.tenGoi : ''}"/>',
            userName: '<c:out value="${user.hoTen != null ? user.hoTen : ''}"/>',
            userEmail: '<c:out value="${user.email != null ? user.email : ''}"/>'
        };

        // Create transfer content
        var transferContentText = packageData.userName + ' ' + packageData.packageName;

        // Wait for DOM to be ready
        document.addEventListener('DOMContentLoaded', function () {
            // Check if form was submitted successfully and show modal
            var urlParams = new URLSearchParams(window.location.search);
            var success = urlParams.get('success');
            if (success === 'true') {
                var modal = new bootstrap.Modal(document.getElementById('successModal'));
                modal.show();
            }

            // Disable button if request is pending and within 24 hours
            var confirmBtn = document.getElementById('confirmPaymentBtn');
            var requestTimestamp = document.getElementById('requestTimestamp');
            if (confirmBtn && requestTimestamp && requestTimestamp.value) {
                var timestamp = new Date(requestTimestamp.value).getTime();
                var now = new Date().getTime();
                var hoursDiff = (now - timestamp) / (1000 * 60 * 60);
                if (hoursDiff < 24) {
                    confirmBtn.disabled = true;
                    confirmBtn.innerHTML = '<i class="fas fa-clock me-2"></i>Đang chờ xác nhận';
                } else {
                    confirmBtn.disabled = false;
                    confirmBtn.innerHTML = '<i class="fas fa-check-circle me-2"></i>Đã chuyển khoản - Tạo yêu cầu xác nhận';
                }
            }

            // Animate elements on load
            animateElements();
        });

        // Enhanced copy to clipboard function
        function copyToClipboard(text) {
            if (!text) {
                showToast('Không có nội dung để sao chép!', 'error');
                return;
            }
            if (navigator.clipboard && window.isSecureContext) {
                navigator.clipboard.writeText(text).then(function() {
                    showCopySuccess(event.target, text);
                }, function(err) {
                    console.error('Could not copy text: ', err);
                    fallbackCopyTextToClipboard(text, event.target);
                });
            } else {
                fallbackCopyTextToClipboard(text, event.target);
            }
        }

        // Copy transfer content specifically
        function copyTransferContent() {
            copyToClipboard(transferContentText);
        }

        // Fallback copy method for older browsers
        function fallbackCopyTextToClipboard(text, button) {
            var textArea = document.createElement("textarea");
            textArea.value = text;
            textArea.style.top = "0";
            textArea.style.left = "0";
            textArea.style.position = "fixed";
            textArea.style.opacity = "0";
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();
            
            try {
                var successful = document.execCommand('copy');
                if (successful) {
                    showCopySuccess(button, text);
                } else {
                    showCopyError();
                }
            } catch (err) {
                console.error('Fallback: Could not copy text: ', err);
                showCopyError();
            }
            
            document.body.removeChild(textArea);
        }

        // Show copy success feedback
        function showCopySuccess(button, text) {
            var originalContent = button.innerHTML;
            button.innerHTML = '<i class="fas fa-check me-1"></i>Copied!';
            button.classList.add('copied');
            
            setTimeout(function() {
                button.innerHTML = originalContent;
                button.classList.remove('copied');
            }, 2000);
            
            showToast('Đã sao chép: ' + text);
        }

        // Show copy error feedback
        function showCopyError() {
            showToast('Không thể sao chép tự động. Vui lòng copy thủ công!', 'error');
        }

        // Enhanced toast notification
        function showToast(message, type) {
            type = type || 'success';
            
            var existingToasts = document.querySelectorAll('.toast-notification');
            existingToasts.forEach(function(toast) {
                toast.remove();
            });
            
            var toast = document.createElement('div');
            toast.className = 'toast-notification';
            
            if (type === 'error') {
                toast.style.background = 'var(--danger-gradient)';
            }
            
            toast.innerHTML = '<i class="fas fa-' + (type === 'success' ? 'check' : 'exclamation-triangle') + ' me-2"></i>' + message;
            
            document.body.appendChild(toast);
            
            setTimeout(function() {
                toast.style.opacity = '0';
                toast.style.transform = 'translateX(100%)';
                setTimeout(function() {
                    if (toast.parentNode) {
                        toast.remove();
                    }
                }, 300);
            }, 3000);
        }

        // Enhanced form submission
        var paymentForm = document.getElementById('paymentForm');
        if (paymentForm) {
            paymentForm.addEventListener('submit', function(e) {
                var submitBtn = this.querySelector('button[type="submit"]');
                if (submitBtn && !submitBtn.disabled) {
                    var originalContent = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<span class="loading-spinner"></span>Đang xử lý yêu cầu...';
                    submitBtn.disabled = true;
                    
                    setTimeout(function() {
                        if (submitBtn) {
                            submitBtn.innerHTML = originalContent;
                            submitBtn.disabled = false;
                        }
                    }, 5000);
                }
            });
        }

        // Animate elements on load
        function animateElements() {
            var elements = [
                '.package-info',
                '.bank-info',
                '.qr-section',
                '.steps'
            ];

            elements.forEach(function(selector, index) {
                var element = document.querySelector(selector);
                if (element) {
                    element.style.opacity = '0';
                    element.style.transform = 'translateY(30px)';
                    setTimeout(function() {
                        element.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                        element.style.opacity = '1';
                        element.style.transform = 'translateY(0)';
                    }, 200 + (index * 150));
                }
            });

            var bankDetails = document.querySelectorAll('.bank-detail');
            bankDetails.forEach(function(detail, index) {
                detail.style.opacity = '0';
                detail.style.transform = 'translateX(-20px)';
                setTimeout(function() {
                    detail.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    detail.style.opacity = '1';
                    detail.style.transform = 'translateX(0)';
                }, 800 + (index * 100));
            });

            var stepItems = document.querySelectorAll('.step-item');
            stepItems.forEach(function(step, index) {
                step.style.opacity = '0';
                step.style.transform = 'translateX(-20px)';
                setTimeout(function() {
                    step.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    step.style.opacity = '1';
                    step.style.transform = 'translateX(0)';
                }, 1200 + (index * 100));
            });
        }

        // Mobile touch effects
        if ('ontouchstart' in window) {
            var touchElements = document.querySelectorAll('.copy-btn, .confirm-btn, .back-link');
            touchElements.forEach(function(element) {
                element.addEventListener('touchstart', function() {
                    var currentTransform = this.style.transform || '';
                    this.style.transform = currentTransform + ' scale(0.95)';
                });
                
                element.addEventListener('touchend', function() {
                    var self = this;
                    setTimeout(function() {
                        self.style.transform = self.style.transform.replace(' scale(0.95)', '');
                    }, 150);
                });
            });
        }

        // Enhanced keyboard navigation
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                var toasts = document.querySelectorAll('.toast-notification');
                toasts.forEach(function(toast) {
                    toast.remove();
                });
                
                var modal = bootstrap.Modal.getInstance(document.getElementById('successModal'));
                if (modal) {
                    modal.hide();
                }
            }
        });

        // Error handling for missing elements
        window.addEventListener('error', function(e) {
            console.error('JavaScript error:', e.error);
        });

        // Prevent form double submission
        var formSubmitted = false;
        if (paymentForm) {
            paymentForm.addEventListener('submit', function(e) {
                if (formSubmitted) {
                    e.preventDefault();
                    return false;
                }
                formSubmitted = true;
            });
        }

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    if (alert && alert.parentNode) {
                        alert.style.opacity = '0';
                        alert.style.transform = 'translateY(-20px)';
                        setTimeout(function() {
                            if (alert.parentNode) {
                                alert.remove();
                            }
                        }, 300);
                    }
                }, 5000);
            });
        });
    </script>
</body>
</html>
