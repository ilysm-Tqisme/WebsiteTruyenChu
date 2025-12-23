<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chương ${chuong.soChuong}: ${chuong.tenChuong}</title>
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
            font-size: 1.5rem;
            font-weight: 700;
            color: #fff !important;
            text-decoration: none;
        }

        .nav-btn {
            background: var(--glass-bg);
            color: #fff;
            border: 1px solid var(--glass-border);
            padding: 0.5rem 1rem;
            border-radius: 25px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            backdrop-filter: blur(20px);
            transition: var(--transition);
            font-size: 0.9rem;
        }

        .nav-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            color: #fff;
            transform: translateY(-2px);
        }

        .nav-btn.disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Chapter Header */
        .chapter-header {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 2rem;
            margin: 2rem 0;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-medium);
            text-align: center;
        }

        .chapter-header h1 {
            font-size: 2rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 0.5rem;
        }

        .chapter-header .story-title {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 1rem;
        }

        .chapter-meta {
            display: flex;
            justify-content: center;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: rgba(255, 255, 255, 0.9);
        }

        .vip-badge {
            background: var(--vip-gradient);
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
        }

        /* Chapter Content */
        .chapter-content {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            padding: 2rem;
            margin: 2rem 0;
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: var(--shadow-medium);
        }

        .chapter-text {
            color: #333;
            line-height: 1.8;
            font-size: 1.1rem;
            text-align: justify;
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            word-wrap: break-word;
            overflow-wrap: break-word;
        }

        .chapter-text p {
            margin-bottom: 1.5rem;
            color: #444;
            text-indent: 2rem;
        }

        .chapter-text h1,
        .chapter-text h2,
        .chapter-text h3,
        .chapter-text h4,
        .chapter-text h5,
        .chapter-text h6 {
            color: #222;
            margin-top: 2rem;
            margin-bottom: 1rem;
            font-weight: 600;
            text-indent: 0;
        }

        .chapter-text h2 {
            font-size: 1.5rem;
            color: #1e40af;
            border-bottom: 2px solid #e5e7eb;
            padding-bottom: 0.5rem;
        }

        .chapter-text h3 {
            font-size: 1.25rem;
            color: #374151;
        }

        .chapter-text strong,
        .chapter-text b {
            color: #222;
            font-weight: 600;
        }

        .chapter-text em,
        .chapter-text i {
            color: #555;
            font-style: italic;
        }

        .chapter-text blockquote {
            background: #f8fafc;
            border-left: 4px solid #3b82f6;
            padding: 1rem 1.5rem;
            margin: 1.5rem 0;
            border-radius: 0 8px 8px 0;
            font-style: italic;
            color: #475569;
        }

        .chapter-text blockquote p {
            margin-bottom: 0;
            text-indent: 0;
        }

        .chapter-text hr {
            border: none;
            height: 1px;
            background: linear-gradient(to right, transparent, #e2e8f0, transparent);
            margin: 2rem 0;
        }

        .chapter-text .text-center {
            text-align: center;
            margin: 2rem 0;
            font-style: italic;
            color: #6b7280;
        }

        /* Chapter Navigation */
        .chapter-nav {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin: 2rem 0;
            border: 1px solid var(--glass-border);
            box-shadow: var(--shadow-medium);
        }

        .chapter-nav-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
        }

        .chapter-nav-btn {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: var(--transition);
            cursor: pointer;
            flex: 1;
            max-width: 200px;
            justify-content: center;
        }

        .chapter-nav-btn:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-light);
        }

        .chapter-nav-btn.disabled {
            background: rgba(255, 255, 255, 0.2);
            cursor: not-allowed;
        }

        .chapter-nav-btn.disabled:hover {
            transform: none;
            box-shadow: none;
        }

        .chapter-list-btn {
            background: var(--glass-bg);
            color: #fff;
            border: 1px solid var(--glass-border);
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: var(--transition);
        }

        .chapter-list-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            color: #fff;
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

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .chapter-header {
                padding: 1.5rem;
            }
            
            .chapter-header h1 {
                font-size: 1.5rem;
            }
            
            .chapter-meta {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .chapter-content {
                padding: 1.5rem;
            }
            
            .chapter-text {
                padding: 1.5rem;
                font-size: 1rem;
            }
            
            .chapter-nav-buttons {
                flex-direction: column;
                gap: 1rem;
            }
            
            .chapter-nav-btn {
                max-width: none;
            }
            
            .vip-modal-buttons {
                flex-direction: column;
            }
        }

        @media (max-width: 576px) {
            .chapter-header {
                padding: 1rem;
            }
            
            .chapter-content {
                padding: 1rem;
            }
            
            .chapter-text {
                padding: 1rem;
                font-size: 1rem;
                line-height: 1.6;
            }
            
            .chapter-text p {
                margin-bottom: 1rem;
                text-indent: 1rem;
            }
        }

        /* Tablet responsive */
        @media (min-width: 577px) and (max-width: 991px) {
            .chapter-text {
                padding: 1.75rem;
                font-size: 1.05rem;
            }
        }

        /* Large desktop */
        @media (min-width: 1200px) {
            .chapter-text {
                max-width: 800px;
                margin: 0 auto;
                font-size: 1.15rem;
                line-height: 1.9;
            }
        }

        /* Print styles */
        @media print {
            .navbar, .chapter-nav, .vip-modal {
                display: none !important;
            }
            
            .chapter-header, .chapter-content {
                background: white !important;
                box-shadow: none !important;
                border: 1px solid #ddd !important;
            }
            
            body {
                background: white !important;
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
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/story?id=${chuong.truyen.id}" class="nav-btn">
                    <i class="fas fa-list"></i>
                    Danh sách chương
                </a>
                <a href="${pageContext.request.contextPath}/home" class="nav-btn">
                    <i class="fas fa-home"></i>
                    Trang chủ
                </a>
            </div>
        </div>
    </nav>

    <div class="container">
        <c:choose>
            <c:when test="${not empty errorMessage}">
                <!-- VIP Error Display -->
                <div class="chapter-header">
                    <h1>
                        <i class="fas fa-lock"></i>
                        Nội dung VIP
                    </h1>
                    <div class="story-title">${chuong.truyen.tenTruyen}</div>
                    <div class="vip-badge">
                        <i class="fas fa-crown"></i>
                        Chương VIP
                    </div>
                </div>

                <div class="chapter-content">
                    <div class="text-center">
                        <i class="fas fa-crown" style="font-size: 4rem; color: #ffd700; margin-bottom: 1rem;"></i>
                        <h3 style="color: #fff; margin-bottom: 1rem;">Chương ${chuong.soChuong}: ${chuong.tenChuong}</h3>
                        <p style="color: rgba(255, 255, 255, 0.9); margin-bottom: 2rem; line-height: 1.6;">
                            ${errorMessage}
                        </p>
                        <div class="d-flex justify-content-center gap-3">
                            <a href="${pageContext.request.contextPath}/vip/register" class="chapter-nav-btn">
                                <i class="fas fa-crown"></i>
                                Nâng cấp VIP
                            </a>
                            <a href="${pageContext.request.contextPath}/story?id=${chuong.truyen.id}" class="chapter-list-btn">
                                <i class="fas fa-list"></i>
                                Danh sách chương
                            </a>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Chapter Header -->
                <div class="chapter-header">
                    <h1>Chương ${chuong.soChuong}: ${chuong.tenChuong}</h1>
                    <div class="story-title">${chuong.truyen.tenTruyen}</div>
                    <div class="chapter-meta">
                        <div class="meta-item">
                            <i class="fas fa-calendar"></i>
                            <span>${chuong.ngayTaoFormatted}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-eye"></i>
                            <span>${chuong.luotXemFormatted} lượt xem</span>
                        </div>
                        <c:if test="${chuong.chiDanhChoVIP}">
                            <div class="vip-badge">
                                <i class="fas fa-crown"></i>
                                VIP
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Chapter Content -->
                <div class="chapter-content">
                    <div class="chapter-text" id="chapterContent">
                        <!-- Nội dung sẽ được xử lý bởi JavaScript -->
                        <c:out value="${chuong.noiDung}" escapeXml="false"/>
                    </div>
                </div>

                <!-- Chapter Navigation -->
                <div class="chapter-nav">
                    <div class="chapter-nav-buttons">
                        <c:choose>
                            <c:when test="${not empty chuongTruoc}">
                                <a href="${pageContext.request.contextPath}/chapter?id=${chuongTruoc.id}" 
                                   class="chapter-nav-btn">
                                    <i class="fas fa-chevron-left"></i>
                                    Chương trước
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="chapter-nav-btn disabled">
                                    <i class="fas fa-chevron-left"></i>
                                    Chương trước
                                </span>
                            </c:otherwise>
                        </c:choose>

                        <a href="${pageContext.request.contextPath}/story?id=${chuong.truyen.id}" 
                           class="chapter-list-btn">
                            <i class="fas fa-list"></i>
                            Danh sách chương
                        </a>

                        <c:choose>
                            <c:when test="${not empty chuongSau}">
                                <a href="javascript:void(0)" 
                                   onclick="readNextChapter(${chuongSau.id}, ${chuongSau.chiDanhChoVIP})"
                                   class="chapter-nav-btn">
                                    Chương tiếp theo
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="chapter-nav-btn disabled">
                                    Chương tiếp theo
                                    <i class="fas fa-chevron-right"></i>
                                </span>
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
            <p id="vipMessage">Bạn cần nâng cấp tài khoản VIP để đọc chương tiếp theo!</p>
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

    <script>
        const isVIP = ${isVIP};
        
        function readNextChapter(nextChapterId, isVIPChapter) {
            if (isVIPChapter && !isVIP) {
                showVIPModal('Chương tiếp theo là nội dung VIP. Bạn cần nâng cấp tài khoản để đọc chương này!');
                return;
            }
            
            window.location.href = `${pageContext.request.contextPath}/chapter?id=` + nextChapterId;
        }
        
        function showVIPModal(message) {
            document.getElementById('vipMessage').textContent = message;
            document.getElementById('vipModal').classList.add('show');
        }
        
        function closeVIPModal() {
            document.getElementById('vipModal').classList.remove('show');
        }
        
        function upgradeVIP() {
            window.location.href = `${pageContext.request.contextPath}/vip/register`;
        }
        
        // Close modal when clicking outside
        document.getElementById('vipModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeVIPModal();
            }
        });
        
        // Format chapter content
        function formatChapterContent() {
            const content = document.getElementById('chapterContent');
            if (!content) return;
            
            let html = content.innerHTML;
            
            // Xử lý các định dạng cơ bản
            html = html.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
            html = html.replace(/\*(.*?)\*/g, '<em>$1</em>');
            html = html.replace(/__(.*?)__/g, '<u>$1</u>');
            html = html.replace(/\"(.*?)\"/g, '<blockquote><p>"$1"</p></blockquote>');
            html = html.replace(/---/g, '<hr>');
            html = html.replace(/\*\*\*/g, '<div class="text-center">* * *</div>');
            
            // Xử lý tiêu đề
            html = html.replace(/^# (.*$)/gim, '<h1>$1</h1>');
            html = html.replace(/^## (.*$)/gim, '<h2>$1</h2>');
            html = html.replace(/^### (.*$)/gim, '<h3>$1</h3>');
            
            // Xử lý đoạn văn
            const lines = html.split('\n');
            let formattedLines = [];
            let inParagraph = false;
            
            for (let i = 0; i < lines.length; i++) {
                const line = lines[i].trim();
                
                if (line === '') {
                    if (inParagraph) {
                        formattedLines.push('</p>');
                        inParagraph = false;
                    }
                    continue;
                }
                
                // Kiểm tra nếu là thẻ HTML
                if (line.match(/^<(h[1-6]|hr|blockquote|div)/)) {
                    if (inParagraph) {
                        formattedLines.push('</p>');
                        inParagraph = false;
                    }
                    formattedLines.push(line);
                } else {
                    if (!inParagraph) {
                        formattedLines.push('<p>');
                        inParagraph = true;
                    }
                    formattedLines.push(line);
                }
            }
            
            if (inParagraph) {
                formattedLines.push('</p>');
            }
            
            content.innerHTML = formattedLines.join('\n');
        }
        
        // Auto-scroll to top when page loads
        window.addEventListener('load', function() {
            window.scrollTo(0, 0);
            formatChapterContent();
        });
        
        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey) {
                switch(e.key) {
                    case 'ArrowLeft':
                        e.preventDefault();
                        <c:if test="${not empty chuongTruoc}">
                            window.location.href = '${pageContext.request.contextPath}/chapter?id=${chuongTruoc.id}';
                        </c:if>
                        break;
                    case 'ArrowRight':
                        e.preventDefault();
                        <c:if test="${not empty chuongSau}">
                            readNextChapter(${chuongSau.id}, ${chuongSau.chiDanhChoVIP});
                        </c:if>
                        break;
                }
            }
        });
    </script>
</body>
</html>