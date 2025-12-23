<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết truyện: ${truyen.tenTruyen} - TruyenTT</title>
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
        
        .story-cover {
            width: 100%;
            max-width: 300px;
            height: 400px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            position: relative;
        }
        
        .cover-placeholder {
            width: 100%;
            max-width: 300px;
            height: 400px;
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px dashed #cbd5e1;
            position: relative;
        }
        
        .story-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            padding: 6px 12px;
            border-radius: 25px;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            z-index: 10;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
        }

        .story-badge.vip {
            background: linear-gradient(135deg, #ffd700 0%, #ffb347 100%);
            color: #8b4513;
        }

        .story-badge.hot {
            background: linear-gradient(135deg, #ff4757 0%, #ff3838 100%);
            color: white;
        }

        .story-badge.new {
            background: linear-gradient(135deg, #00d2d3 0%, #54a0ff 100%);
            color: white;
        }

        .story-badge:nth-child(2) {
            top: 12px;
            right: 12px;
        }

        .story-badge:nth-child(3) {
            top: 52px;
            right: 12px;
        }

        .story-badge:nth-child(4) {
            top: 92px;
            right: 12px;
        }
        
        .info-section {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        
        .info-section h5 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.75rem;
            background: white;
            border-radius: 10px;
            border-left: 4px solid var(--primary-color);
        }
        
        .info-item i {
            width: 24px;
            margin-right: 12px;
            color: var(--primary-color);
        }
        
        .info-label {
            font-weight: 600;
            color: #374151;
            min-width: 120px;
        }
        
        .info-value {
            color: #6b7280;
        }
        
        .badge-custom {
            font-size: 0.8rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            margin: 0.2rem;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border-left: 4px solid var(--primary-color);
        }
        
        .stat-card i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        
        .stat-card h4 {
            margin-bottom: 0.5rem;
            font-weight: 700;
        }
        
        .stat-card p {
            color: #6b7280;
            margin: 0;
            font-size: 0.9rem;
        }
        
        .genre-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }
        
        .genre-tag {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        
        .description-box {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 2rem;
        }
        
        .btn-action {
            border-radius: 12px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .image-container {
            position: relative;
            display: inline-block;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/stories">
                            <i class="fas fa-book"></i>Quản lý truyện
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/chapters">
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
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h2 class="mb-1">
                                    <i class="fas fa-book text-primary me-2"></i>
                                    Chi tiết truyện
                                </h2>
                                <p class="text-muted mb-0">Thông tin chi tiết về truyện: <strong>${truyen.tenTruyen}</strong></p>
                            </div>
                            <div class="d-flex gap-2">
                                <a href="stories?action=edit&id=${truyen.id}" class="btn btn-primary">
                                    <i class="fas fa-edit me-2"></i>Chỉnh sửa
                                </a>
                                <a href="stories" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Left Column - Cover & Basic Info -->
                        <div class="col-lg-4">
                            <!-- Ảnh bìa -->
                            <div class="text-center mb-4">
                                <c:if test="${not empty truyen.anhBia}">
                                    <div class="image-container">
                                        <img src="${pageContext.request.contextPath}/${story.anhBia}" 
                                             class="story-cover" alt="Ảnh bìa ${truyen.tenTruyen}">
                                        <!-- Badges overlay -->
                                        <c:if test="${truyen.chiDanhChoVIP}">
                                            <div class="story-badge vip">
                                                <i class="fas fa-crown me-1"></i>VIP
                                            </div>
                                        </c:if>
                                        <c:if test="${truyen.noiBat}">
                                            <div class="story-badge hot">
                                                <i class="fas fa-fire me-1"></i>HOT
                                            </div>
                                        </c:if>
                                        <c:if test="${truyen.truyenMoi}">
                                            <div class="story-badge new">
                                                <i class="fas fa-star me-1"></i>NEW
                                            </div>
                                        </c:if>
                                    </div>
                                </c:if>
                                <c:if test="${empty truyen.anhBia}">
                                    <div class="cover-placeholder">
                                        <i class="fas fa-image fa-4x text-muted"></i>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Thống kê -->
                            <div class="stats-grid">
                                <div class="stat-card">
                                    <i class="fas fa-eye text-info"></i>
                                    <h4>${truyen.luotXemFormatted}</h4>
                                    <p>Lượt xem</p>
                                </div>
                                <div class="stat-card">
                                    <i class="fas fa-star text-warning"></i>
                                    <h4>
                                        <c:if test="${truyen.diemDanhGia > 0}">
                                            ${truyen.danhGiaFormatted}
                                        </c:if>
                                        <c:if test="${truyen.diemDanhGia == 0}">--</c:if>
                                    </h4>
                                    <p>Điểm đánh giá (${truyen.soLuongDanhGia} lượt)</p>
                                </div>
                                <div class="stat-card">
                                    <i class="fas fa-file-alt text-success"></i>
                                    <h4>${truyen.soLuongChuong}</h4>
                                    <p>Số chương</p>
                                </div>
                                <div class="stat-card">
                                    <i class="fas fa-calendar text-primary"></i>
                                    <h4>${truyen.ngayTaoFormatted}</h4>
                                    <p>Ngày tạo</p>
                                </div>
                            </div>

                            <!-- Đặc tính -->
                            <div class="info-section">
                                <h5><i class="fas fa-tags me-2"></i>Đặc tính truyện</h5>
                                <div class="d-flex flex-wrap gap-2">
                                    <c:if test="${truyen.chiDanhChoVIP}">
                                        <span class="badge-custom bg-warning text-dark">
                                            <i class="fas fa-crown me-1"></i>VIP
                                        </span>
                                    </c:if>
                                    <c:if test="${truyen.noiBat}">
                                        <span class="badge-custom bg-danger">
                                            <i class="fas fa-fire me-1"></i>Nổi bật
                                        </span>
                                    </c:if>
                                    <c:if test="${truyen.truyenMoi}">
                                        <span class="badge-custom bg-info">
                                            <i class="fas fa-star me-1"></i>Mới
                                        </span>
                                    </c:if>
                                    <c:if test="${!truyen.chiDanhChoVIP && !truyen.noiBat && !truyen.truyenMoi}">
                                        <span class="text-muted">Không có đặc tính đặc biệt</span>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Right Column - Detailed Info -->
                        <div class="col-lg-8">
                            <!-- Thông tin cơ bản -->
                            <div class="info-section">
                                <h5><i class="fas fa-info-circle me-2"></i>Thông tin cơ bản</h5>
                                
                                <div class="info-item">
                                    <i class="fas fa-book"></i>
                                    <span class="info-label">Tên truyện:</span>
                                    <span class="info-value">${truyen.tenTruyen}</span>
                                </div>
                                
                                <div class="info-item">
                                    <i class="fas fa-user-edit"></i>
                                    <span class="info-label">Tác giả:</span>
                                    <span class="info-value">${truyen.tacGiaTen}</span>
                                </div>
                                
                                <div class="info-item">
                                    <i class="fas fa-user-cog"></i>
                                    <span class="info-label">Người tạo:</span>
                                    <span class="info-value">${truyen.nguoiTaoTen}</span>
                                </div>
                                
                                <div class="info-item">
                                    <i class="fas fa-flag"></i>
                                    <span class="info-label">Trạng thái:</span>
                                    <span class="info-value">
                                        <c:choose>
                                            <c:when test="${truyen.trangThai == 'HOAN_THANH'}">
                                                <span class="badge bg-success">
                                                    <i class="fas fa-check-circle me-1"></i>Hoàn thành
                                                </span>
                                            </c:when>
                                            <c:when test="${truyen.trangThai == 'DANG_TIEN_HANH'}">
                                                <span class="badge bg-primary">
                                                    <i class="fas fa-play-circle me-1"></i>Đang tiến hành
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning">
                                                    <i class="fas fa-pause-circle me-1"></i>Tạm dừng
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                
                                <div class="info-item">
                                    <i class="fas fa-calendar-plus"></i>
                                    <span class="info-label">Ngày tạo:</span>
                                    <span class="info-value">
                                        ${truyen.ngayTaoFormatted}
                                    </span>
                                </div>
                                
                                <div class="info-item">
                                    <i class="fas fa-calendar-check"></i>
                                    <span class="info-label">Cập nhật cuối:</span>
                                    <span class="info-value">
                                        ${truyen.ngayCapNhatFormatted}
                                    </span>
                                </div>
                            </div>

                            <!-- Thể loại -->
                            <div class="info-section">
                                <h5><i class="fas fa-tags me-2"></i>Thể loại</h5>
                                <div class="genre-tags">
                                    <c:if test="${not empty truyen.theLoaiTenList}">
                                        <c:forEach var="theLoai" items="${truyen.theLoaiTenList}">
                                            <span class="genre-tag">${theLoai}</span>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty truyen.theLoaiTenList}">
                                        <span class="text-muted">Chưa có thể loại</span>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Mô tả -->
                            <div class="info-section">
                                <h5><i class="fas fa-align-left me-2"></i>Mô tả truyện</h5>
                                <div class="description-box">
                                    <c:if test="${not empty truyen.moTa}">
                                        <p class="mb-0">${truyen.moTa}</p>
                                    </c:if>
                                    <c:if test="${empty truyen.moTa}">
                                        <p class="text-muted mb-0">
                                            <i class="fas fa-info-circle me-2"></i>
                                            Chưa có mô tả cho truyện này
                                        </p>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="action-buttons">
                                <a href="stories?action=edit&id=${truyen.id}" class="btn btn-primary btn-action">
                                    <i class="fas fa-edit"></i>Chỉnh sửa truyện
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/chapters?truyenId=${truyen.id}" class="btn btn-success btn-action">
                                    <i class="fas fa-file-alt"></i>Quản lý chương
                                </a>
                                <button type="button" class="btn btn-warning btn-action" onclick="updateRating(${truyen.id})">
                                    <i class="fas fa-star"></i>Cập nhật điểm
                                </button>
                                <button type="button" class="btn btn-info btn-action" onclick="updateView(${truyen.id})">
                                    <i class="fas fa-eye"></i>Tăng lượt xem
                                </button>
                                <button type="button" class="btn btn-danger btn-action" onclick="confirmDelete(${truyen.id}, '${truyen.tenTruyen}')">
                                    <i class="fas fa-trash"></i>Xóa truyện
                                </button>
                            </div>
                        </div>
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
                        <h6>Bạn có chắc chắn muốn xóa truyện?</h6>
                        <p class="text-muted mb-2">
                            <strong id="storyName"></strong>
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
                        <i class="fas fa-trash me-2"></i>Xóa truyện
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Rating Update Modal -->
    <div class="modal fade" id="ratingModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-star me-2"></i>Cập nhật điểm đánh giá
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form id="ratingForm" method="post" action="stories">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="updateRating">
                        <input type="hidden" name="id" id="ratingStoryId">
                        
                        <div class="mb-3">
                            <label class="form-label">
                                <i class="fas fa-star text-warning me-2"></i>Điểm đánh giá
                            </label>
                            <input type="number" name="diem" class="form-control" 
                                   min="1" max="10" step="0.1" required 
                                   placeholder="Nhập điểm từ 1-10">
                            <div class="form-text">Điểm đánh giá từ 1.0 đến 10.0</div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">
                                <i class="fas fa-users text-info me-2"></i>Số lượng đánh giá
                            </label>
                            <input type="number" name="soLuong" class="form-control" 
                                   min="1" required 
                                   placeholder="Nhập số lượng người đánh giá">
                            <div class="form-text">Số lượng người đã đánh giá truyện này</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>Hủy
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Cập nhật
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(id, name) {
            document.getElementById('storyName').textContent = name;
            document.getElementById('confirmDeleteBtn').href = 'stories?action=delete&id=' + id;
            const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
            modal.show();
        }

        function updateView(id) {
            if (confirm('Tăng lượt xem cho truyện này?')) {
                window.location.href = 'stories?action=updateView&id=' + id;
            }
        }

        function updateRating(id) {
            document.getElementById('ratingStoryId').value = id;
            const modal = new bootstrap.Modal(document.getElementById('ratingModal'));
            modal.show();
        }

        // Form validation for rating
        document.getElementById('ratingForm').addEventListener('submit', function(e) {
            const diem = parseFloat(this.diem.value);
            const soLuong = parseInt(this.soLuong.value);
            
            if (diem < 1 || diem > 10) {
                e.preventDefault();
                alert('Điểm đánh giá phải từ 1.0 đến 10.0');
                return false;
            }
            
            if (soLuong < 1) {
                e.preventDefault();
                alert('Số lượng đánh giá phải lớn hơn 0');
                return false;
            }
        });
    </script>
</body>
</html>