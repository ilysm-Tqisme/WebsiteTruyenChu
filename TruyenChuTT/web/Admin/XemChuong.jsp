<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xem chương - ${chuong.tenChuong} - TruyenTT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #7c3aed;
            --accent-color: #db2777;
            --bg-color: #f1f5f9;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --info-color: #06b6d4;
        }
        
        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-color); 
        }
        
        .sidebar { 
            min-height: 100vh; 
            background: linear-gradient(180deg, var(--primary-color) 0%, var(--secondary-color) 100%); 
            padding: 1.5rem; 
            position: sticky; 
            top: 0; 
            box-shadow: 2px 0 15px rgba(0, 0, 0, 0.1); 
        }
        
        .sidebar .nav-link { 
            color: rgba(255, 255, 255, 0.9); 
            padding: 0.875rem 1.25rem; 
            border-radius: 12px; 
            margin: 0.25rem 0; 
            transition: all 0.3s ease; 
            display: flex; 
            align-items: center; 
            gap: 0.875rem; 
            font-weight: 500; 
        }
        
        .sidebar .nav-link:hover, .sidebar .nav-link.active { 
            background-color: rgba(255, 255, 255, 0.2); 
            color: white; 
            transform: translateX(8px); 
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); 
        }
        
        .sidebar .nav-link i { 
            width: 20px; 
            text-align: center; 
            font-size: 1.1rem; 
        }
        
        .card { 
            border: none; 
            border-radius: 20px; 
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08); 
            transition: all 0.3s ease; 
            overflow: hidden; 
        }
        
        .card:hover { 
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12); 
        }
        
        .card-header { 
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); 
            color: white; 
            border-radius: 20px 20px 0 0; 
            padding: 1.5rem; 
            border: none; 
        }
        
        .main-content { 
            padding: 2.5rem; 
            min-height: 100vh; 
        }
        
        .sidebar-brand { 
            background: rgba(255, 255, 255, 0.1); 
            border-radius: 15px; 
            padding: 1.5rem; 
            margin-bottom: 2rem; 
            text-align: center; 
            backdrop-filter: blur(10px); 
        }
        
        .sidebar-brand h4 { 
            margin: 0; 
            font-weight: 700; 
            font-size: 1.5rem; 
        }
        
        .sidebar-brand p { 
            margin: 0.5rem 0 0 0; 
            opacity: 0.8; 
            font-size: 0.9rem; 
        }
        
        .page-header { 
            background: linear-gradient(135deg, white 0%, #f8fafc 100%); 
            border-radius: 20px; 
            padding: 2rem; 
            margin-bottom: 2rem; 
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); 
        }
        
        .chapter-info {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid #e2e8f0;
        }
        
        .chapter-content {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            line-height: 1.8;
            font-size: 1.1rem;
        }
        
        .chapter-content p {
            margin-bottom: 1.5rem;
            text-align: justify;
        }
        
        .chapter-content strong {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .chapter-content em {
            color: #6b7280;
            font-style: italic;
        }
        
        .chapter-content blockquote {
            border-left: 4px solid var(--primary-color);
            padding-left: 1rem;
            margin: 1.5rem 0;
            font-style: italic;
            color: #4b5563;
        }
        
        .chapter-content hr {
            border: none;
            height: 1px;
            background: linear-gradient(to right, transparent, #e2e8f0, transparent);
            margin: 2rem 0;
        }
        
        .chapter-navigation {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        
        .breadcrumb {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .breadcrumb a {
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .breadcrumb a:hover {
            text-decoration: underline;
        }
        
        .badge-custom {
            font-size: 0.8rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            margin: 0.25rem;
            display: inline-block;
        }
        
        .chapter-stats {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 1rem;
        }
        
        .stat-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6b7280;
            font-size: 0.9rem;
        }
        
        .btn {
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--secondary-color) 0%, var(--primary-color) 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.3);
        }
        
        .btn-outline-secondary {
            border: 1px solid #e2e8f0;
            color: #6b7280;
        }
        
        .btn-outline-secondary:hover {
            background: #f8fafc;
            border-color: #d1d5db;
            color: #374151;
        }
        
        .btn-success {
            background: linear-gradient(135deg, var(--success-color) 0%, #059669 100%);
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, #059669 0%, var(--success-color) 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.3);
        }
        
        .btn-warning {
            background: linear-gradient(135deg, var(--warning-color) 0%, #d97706 100%);
        }
        
        .btn-warning:hover {
            background: linear-gradient(135deg, #d97706 0%, var(--warning-color) 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(245, 158, 11, 0.3);
        }
        
        .chapter-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 1.5rem;
        }
        
        .reading-progress {
            background: #f8fafc;
            border-radius: 10px;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .progress {
            height: 8px;
            border-radius: 4px;
            background: #e2e8f0;
        }
        
        .progress-bar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border-radius: 4px;
        }
        
        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            
            .page-header {
                padding: 1.5rem;
            }
            
            .chapter-content {
                padding: 1.5rem;
                font-size: 1rem;
            }
            
            .chapter-actions {
                flex-direction: column;
            }
            
            .chapter-stats {
                flex-direction: column;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 px-0">
                <div class="sidebar">
                    <div class="sidebar-brand">
                        <h4 class="text-white d-flex align-items-center justify-content-center">
                            <i class="fas fa-book-open me-2"></i>TruyenTT
                        </h4>
                        <p class="text-white-50 mb-0">Admin Panel</p>
                    </div>
                    <nav class="nav flex-column">
                        <a class="nav-link" href="${pageContext.request.contextPath}/Admin/HomeAdmin.jsp">
                            <i class="fas fa-tachometer-alt"></i>Dashboard
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                            <i class="fas fa-users"></i>Quản lý người dùng
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/stories">
                            <i class="fas fa-book"></i>Quản lý truyện
                        </a>
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/chapters">
                            <i class="fas fa-file-alt"></i>Quản lý chương
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/authors">
                            <i class="fas fa-pen-fancy"></i>Quản lý tác giả
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                            <i class="fas fa-tags"></i>Quản lý thể loại
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/comments">
                            <i class="fas fa-comments"></i>Quản lý bình luận
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/ads">
                            <i class="fas fa-ad"></i>Quản lý quảng cáo
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/vip">
                            <i class="fas fa-crown"></i>Quản lý VIP
                        </a>
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/payments">
                            <i class="fas fa-credit-card"></i>Yêu cầu thanh toán
                        </a>
                        <hr class="text-white-50 my-3">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                            <i class="fas fa-home"></i>Về trang chủ
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i>Đăng xuất
                        </a>
                    </nav>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <div class="main-content">
                    <!-- Page Header -->
                    <div class="page-header">
                        <div class="d-flex justify-content-between align-items-center flex-wrap">
                            <div>
                                <h2 class="mb-1">
                                    <i class="fas fa-file-alt text-primary me-2"></i>
                                    Xem Chi Tiết Chương
                                </h2>
                                <p class="text-muted mb-0">Chi tiết nội dung chương</p>
                            </div>
                            <div class="d-flex gap-2">
                                <a href="chapters?action=edit&id=${chuong.id}" class="btn btn-warning">
                                    <i class="fas fa-edit me-2"></i>Chỉnh sửa
                                </a>
                                <a href="chapters?storyId=${chuong.truyen.id}" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Breadcrumb -->
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="chapters">
                                    <i class="fas fa-book me-1"></i>Danh sách truyện
                                </a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="chapters?storyId=${chuong.truyen.id}">
                                    <i class="fas fa-file-alt me-1"></i>Chương - ${chuong.truyen.tenTruyen}
                                </a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                <i class="fas fa-eye me-1"></i>Xem chương #${chuong.soChuong}
                            </li>
                        </ol>
                    </nav>

                    <!-- Chapter Info -->
                    <div class="chapter-info">
                        <div class="row">
                            <div class="col-md-8">
                                <h3 class="mb-2">
                                    <i class="fas fa-book-open text-primary me-2"></i>
                                    ${chuong.truyen.tenTruyen}
                                </h3>
                                <h4 class="mb-3">
                                    <span class="badge bg-info me-2">#${chuong.soChuong}</span>
                                    ${chuong.tenChuong}
                                </h4>
                                
                                <div class="chapter-stats">
                                    <div class="stat-item">
                                        <i class="fas fa-calendar-alt"></i>
                                        <span>Ngày tạo: ${chuong.ngayTaoFormatted}</span>
                                    </div>
                                    <div class="stat-item">
                                        <i class="fas fa-edit"></i>
                                        <span>Cập nhật: ${chuong.ngayCapNhatFormatted}</span>
                                    </div>
                                    <div class="stat-item">
                                        <i class="fas fa-eye"></i>
                                        <span>Lượt xem: <fmt:formatNumber value="${chuong.luotXem}" pattern="#,###"/></span>
                                    </div>
                                    <div class="stat-item">
                                        <i class="fas fa-font"></i>
                                        <span>Độ dài: ${chuong.noiDung.length()} ký tự</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 text-end">
                                <div class="mb-3">
                                    <c:choose>
                                        <c:when test="${chuong.trangThai == 'CONG_KHAI'}">
                                            <span class="badge-custom bg-success text-white">
                                                <i class="fas fa-eye me-1"></i>Công khai
                                            </span>
                                        </c:when>
                                        <c:when test="${chuong.trangThai == 'NHAP'}">
                                            <span class="badge-custom bg-secondary text-white">
                                                <i class="fas fa-edit me-1"></i>Nháp
                                            </span>
                                        </c:when>
                                        <c:when test="${chuong.trangThai == 'LICH_DANG'}">
                                            <span class="badge-custom bg-warning text-dark">
                                                <i class="fas fa-calendar me-1"></i>Lịch đăng
                                            </span>
                                        </c:when>
                                        <c:when test="${chuong.trangThai == 'AN'}">
                                            <span class="badge-custom bg-danger text-white">
                                                <i class="fas fa-eye-slash me-1"></i>Ẩn
                                            </span>
                                        </c:when>
                                    </c:choose>
                                    
                                    <c:if test="${chuong.chiDanhChoVIP}">
                                        <span class="badge-custom bg-warning text-dark">
                                            <i class="fas fa-crown me-1"></i>VIP
                                        </span>
                                    </c:if>
                                </div>
                                
                                <c:if test="${chuong.trangThai == 'LICH_DANG' && not empty chuong.ngayDangLich}">
                                    <div class="stat-item">
                                        <i class="fas fa-calendar-check"></i>
                                        <span>Đăng lịch: ${chuong.dangLichFormatted}</span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Reading Progress -->
                    <div class="reading-progress">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <small class="text-muted">Tiến độ đọc</small>
                            <small class="text-muted" id="progressText">0%</small>
                        </div>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 0%" id="progressBar"></div>
                        </div>
                    </div>

                    <!-- Chapter Content -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-file-text me-2"></i>
                                Nội dung chương
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="chapter-content" id="chapterContent">
                                ${chuong.noiDung.replace("\\n", "<br>").replace("**", "<strong>").replace("**", "</strong>").replace("*", "<em>").replace("*", "</em>").replace("__", "<u>").replace("__", "</u>").replace("---", "<hr>").replace("***", "<div class='text-center my-3'>* * *</div>")}
                            </div>
                        </div>
                    </div>

                    <!-- Chapter Navigation -->
                    <div class="chapter-navigation">
                        <h6 class="mb-3">
                            <i class="fas fa-navigation me-2"></i>
                            Điều hướng chương
                        </h6>
                        <div class="row">
                            <div class="col-md-4">
                                <c:choose>
                                    <c:when test="${not empty chuongTruoc}">
                                        <a href="chapters?action=view&id=${chuongTruoc.id}" class="btn btn-outline-secondary w-100">
                                            <i class="fas fa-arrow-left me-2"></i>
                                            <div class="d-block">
                                                <small>Chương trước</small>
                                                <div class="fw-bold">#${chuongTruoc.soChuong} - ${chuongTruoc.tenChuong}</div>
                                            </div>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-outline-secondary w-100" disabled>
                                            <i class="fas fa-arrow-left me-2"></i>
                                            <div class="d-block">
                                                <small>Chương đầu tiên</small>
                                            </div>
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-md-4 text-center">
                                <a href="chapters?storyId=${chuong.truyen.id}" class="btn btn-primary w-100">
                                    <i class="fas fa-list me-2"></i>
                                    <div class="d-block">
                                        <small>Danh sách chương</small>
                                        <div class="fw-bold">${chuong.truyen.tenTruyen}</div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-md-4">
                                <c:choose>
                                    <c:when test="${not empty chuongSau}">
                                        <a href="chapters?action=view&id=${chuongSau.id}" class="btn btn-outline-secondary w-100">
                                            <i class="fas fa-arrow-right me-2"></i>
                                            <div class="d-block">
                                                <small>Chương tiếp</small>
                                                <div class="fw-bold">#${chuongSau.soChuong} - ${chuongSau.tenChuong}</div>
                                            </div>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-outline-secondary w-100" disabled>
                                            <i class="fas fa-arrow-right me-2"></i>
                                            <div class="d-block">
                                                <small>Chương cuối</small>
                                            </div>
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Chapter Actions -->
                    <div class="chapter-actions">
                        <a href="chapters?action=edit&id=${chuong.id}" class="btn btn-warning">
                            <i class="fas fa-edit me-2"></i>Chỉnh sửa chương
                        </a>
                        <a href="chapters?action=updateView&id=${chuong.id}&storyId=${chuong.truyen.id}" class="btn btn-success">
                            <i class="fas fa-plus me-2"></i>Tăng lượt xem
                        </a>
                        <a href="${pageContext.request.contextPath}/story/${chuong.truyen.id}/chapter/${chuong.soChuong}" 
                           class="btn btn-info" target="_blank">
                            <i class="fas fa-external-link-alt me-2"></i>Xem trên site
                        </a>
                        <button class="btn btn-outline-secondary" onclick="copyChapterUrl()">
                            <i class="fas fa-copy me-2"></i>Sao chép link
                        </button>
                        <button class="btn btn-outline-secondary" onclick="printChapter()">
                            <i class="fas fa-print me-2"></i>In chương
                        </button>
                        <button class="btn btn-danger" onclick="confirmDelete(${chuong.id}, '${chuong.tenChuong}')">
                            <i class="fas fa-trash me-2"></i>Xóa chương
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="text-center mb-3">
                        <i class="fas fa-trash-alt fa-3x text-danger mb-3"></i>
                        <h6>Bạn có chắc chắn muốn xóa chương?</h6>
                        <p class="text-muted mb-2">
                            <strong id="chapterName"></strong>
                        </p>
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>Cảnh báo:</strong> Hành động này không thể hoàn tác!
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>Hủy
                    </button>
                    <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                        <i class="fas fa-trash me-2"></i>Xóa chương
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Reading progress tracking
        function updateReadingProgress() {
            const content = document.getElementById('chapterContent');
            const progressBar = document.getElementById('progressBar');
            const progressText = document.getElementById('progressText');
            
            const scrollTop = window.scrollY;
            const contentTop = content.offsetTop;
            const contentHeight = content.offsetHeight;
            const windowHeight = window.innerHeight;
            
            if (scrollTop > contentTop) {
                const progress = Math.min(100, ((scrollTop - contentTop) / (contentHeight - windowHeight)) * 100);
                progressBar.style.width = progress + '%';
                progressText.textContent = Math.round(progress) + '%';
            } else {
                progressBar.style.width = '0%';
                progressText.textContent = '0%';
            }
        }

        // Update progress on scroll
        window.addEventListener('scroll', updateReadingProgress);

        // Copy chapter URL
        function copyChapterUrl() {
            const url = window.location.href;
            navigator.clipboard.writeText(url).then(() => {
                alert('Đã sao chép link chương vào clipboard!');
            }).catch(() => {
                alert('Không thể sao chép link. Vui lòng thử lại!');
            });
        }

        // Print chapter
        function printChapter() {
            const printWindow = window.open('', '_blank');
            const chapterContent = document.getElementById('chapterContent').innerHTML;
            const chapterTitle = '${chuong.truyen.tenTruyen} - Chương ${chuong.soChuong}: ${chuong.tenChuong}';
            
            printWindow.document.write(`
                <html>
                <head>
                    <title>${chapterTitle}</title>
                    <style>
                        body { 
                            font-family: 'Times New Roman', serif; 
                            line-height: 1.6; 
                            max-width: 800px; 
                            margin: 0 auto; 
                            padding: 20px;
                        }
                        h1 { 
                            text-align: center; 
                            color: #333; 
                            border-bottom: 2px solid #333;
                            padding-bottom: 10px;
                        }
                        p { 
                            margin-bottom: 15px; 
                            text-align: justify;
                        }
                        hr { 
                            border: none; 
                            height: 1px; 
                            background: #ccc; 
                            margin: 20px 0;
                        }
                        .text-center { 
                            text-align: center; 
                        }
                        strong { 
                            color: #333; 
                        }
                        em { 
                            color: #666; 
                        }
                        blockquote { 
                            border-left: 4px solid #ccc; 
                            padding-left: 15px; 
                            margin: 15px 0;
                            font-style: italic;
                        }
                    </style>
                </head>
                <body>
                    <h1>${chapterTitle}</h1>
                    <div>${chapterContent}</div>
                </body>
                </html>
            `);
            
            printWindow.document.close();
            printWindow.print();
        }

        // Delete confirmation
        function confirmDelete(id, name) {
            document.getElementById('chapterName').textContent = name;
            document.getElementById('confirmDeleteBtn').href = 'chapters?action=delete&id=' + id + '&storyId=${chuong.truyen.id}';
            const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
            modal.show();
        }

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey) {
                switch(e.key) {
                    case 'e':
                        e.preventDefault();
                        window.location.href = 'chapters?action=edit&id=${chuong.id}';
                        break;
                    case 'p':
                        e.preventDefault();
                        printChapter();
                        break;
                    case 'ArrowLeft':
                        e.preventDefault();
                        <c:if test="${not empty chuongTruoc}">
                            window.location.href = 'chapters?action=view&id=${chuongTruoc.id}';
                        </c:if>
                        break;
                    case 'ArrowRight':
                        e.preventDefault();
                        <c:if test="${not empty chuongSau}">
                            window.location.href = 'chapters?action=view&id=${chuongSau.id}';
                        </c:if>
                        break;
                }
            }
        });

        // Format content on load
        document.addEventListener('DOMContentLoaded', function() {
            const content = document.getElementById('chapterContent');
            let html = content.innerHTML;
            
            // Format content
            html = html.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
            html = html.replace(/\*(.*?)\*/g, '<em>$1</em>');
            html = html.replace(/__(.*?)__/g, '<u>$1</u>');
            html = html.replace(/\"(.*?)\"/g, '<blockquote>"$1"</blockquote>');
            html = html.replace(/---/g, '<hr>');
            html = html.replace(/\*\*\*/g, '<div class="text-center my-3">* * *</div>');
            html = html.replace(/\n\n/g, '</p><p>');
            html = html.replace(/\n/g, '<br>');
            
            // Wrap in paragraphs
            if (!html.startsWith('<p>')) {
                html = '<p>' + html;
            }
            if (!html.endsWith('</p>')) {
                html = html + '</p>';
            }
            
            content.innerHTML = html;
            
            // Initialize reading progress
            updateReadingProgress();
        });

        // Auto-scroll to top on page load
        window.addEventListener('load', function() {
            window.scrollTo(0, 0);
        });
    </script>
</body>
</html>