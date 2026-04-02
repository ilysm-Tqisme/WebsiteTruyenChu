<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý truyện - TruyenTT</title>
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
        
        .table { 
            background: white; 
            border-radius: 15px; 
            overflow: hidden; 
        }
        
        .table th { 
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%); 
            color: #1f2937; 
            font-weight: 600; 
            border: none; 
            padding: 1rem; 
        }
        
        .table td { 
            vertical-align: middle; 
            padding: 1rem; 
            border-color: #f1f5f9; 
        }
        
        .main-content { 
            padding: 2.5rem; 
            min-height: 100vh; 
        }
        
        .table-hover tbody tr:hover { 
            background-color: rgba(79, 70, 229, 0.05); 
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
        
        .filter-section {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        
        .story-image {
            width: 60px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .story-placeholder {
            width: 60px;
            height: 80px;
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .badge-custom {
            font-size: 0.7rem;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 600;
            margin: 0.1rem;
            display: inline-block;
        }
        
        .search-form {
            position: relative;
        }
        
        .search-form .form-control {
            border-radius: 25px;
            padding-left: 3rem;
            background: white;
            border: 1px solid #e2e8f0;
            height: 45px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .search-form .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
        }
        
        .modal-content {
            border-radius: 20px;
            border: none;
            overflow: hidden;
        }
        
        .modal-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border: none;
            padding: 1.5rem;
        }
        
        .modal-footer {
            border-top: 1px solid #f1f5f9;
            padding: 1.25rem;
        }
        
        .empty-state {
            padding: 4rem 2rem;
            text-align: center;
            color: #6b7280;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            opacity: 0.3;
            color: var(--primary-color);
        }
        
        .stats-card {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
        }
        
        .dropdown-menu {
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: none;
            padding: 1rem;
        }
        
        .dropdown-item {
            border-radius: 10px;
            padding: 0.75rem 1.25rem;
            transition: all 0.2s ease;
        }
        
        .dropdown-item:hover {
            background-color: #f1f5f9;
        }
        
        .dropdown-item i {
            margin-right: 10px;
            width: 18px;
        }
        
        .feature-badges {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }
        
        .stats-info {
            font-size: 0.85rem;
        }
        
        .genre-list {
            font-size: 0.8rem;
            color: #6b7280;
            margin-top: 0.25rem;
        }
        
        .action-buttons .dropdown-toggle {
            border: none;
            background: #f8f9fa;
            color: #6c757d;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        
        .action-buttons .dropdown-toggle:hover {
            background: #e9ecef;
            color: #495057;
        }

        /* Pagination Footer Styling */
        .pagination-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1.5rem 1.25rem;
            background-color: white;
            border-top: 1px solid #e5e7eb;
            border-radius: 0 0 0.375rem 0.375rem;
            margin-top: -1px;
        }

        .pagination-left {
            font-size: 0.875rem;
            color: #6b7280;
        }

        .pagination-info {
            font-weight: 500;
            color: #374151;
        }

        .pagination-nav {
            margin: 0;
        }

        /* Custom Pagination Styling */
        .pagination-custom {
            margin: 0;
            gap: 6px;
            display: flex;
        }

        .pagination-custom .page-link {
            border: none;
            margin: 0;
            border-radius: 6px;
            color: #1f2937;
            font-weight: 600;
            padding: 0.5rem 0.75rem;
            background-color: white;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            min-width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            transition: all 0.2s ease;
            font-size: 0.95rem;
        }

        .pagination-custom .page-item.active .page-link {
            background-color: #5b3edb;
            color: white;
            box-shadow: 0 4px 12px rgba(91, 62, 219, 0.4);
        }

        .pagination-custom .page-link:hover:not(.disabled .page-link) {
            background-color: #f3f4f6;
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
        }

        .pagination-custom .page-item.active .page-link:hover {
            background-color: #4c2ba3;
            box-shadow: 0 6px 15px rgba(91, 62, 219, 0.5);
        }

        .pagination-custom .page-item.disabled .page-link {
            color: #d1d5db;
            background-color: #f9fafb;
            box-shadow: none;
            cursor: not-allowed;
        }

        .card-header.bg-primary {
            background: linear-gradient(135deg, #5b3edb 0%, #4c2ba3 100%) !important;
        }

        .card-header.bg-primary .form-select {
            border: 1px solid #e5e7eb;
            padding: 0.375rem 2rem 0.375rem 0.75rem;
        }

        .card-header.bg-primary .form-select:focus {
            border-color: #5b3edb;
            box-shadow: 0 0 0 0.2rem rgba(91, 62, 219, 0.25);
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
                                    Quản Lý Truyện
                                </h2>
                                <p class="text-muted mb-0">Quản lý toàn bộ truyện trong hệ thống</p>
                            </div>
                            <a href="stories?action=create" class="btn btn-primary btn-lg">
                                <i class="fas fa-plus me-2"></i>Thêm Truyện Mới
                            </a>
                        </div>
                    </div>

                    <!-- Messages -->
                    <c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger">${errorMessage}</div>
</c:if>


                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-book fa-2x me-3"></i>
                                    <div>
                                        <h5 class="mb-0">${totalStories}</h5>
                                        <small>Tổng truyện</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-list fa-2x me-3"></i>
                                    <div>
                                        <h5 class="mb-0">${currentPage}</h5>
                                        <small>Trang hiện tại</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-fire fa-2x me-3"></i>
                                    <div>
                                        <h5 class="mb-0">${totalPages}</h5>
                                        <small>Tổng trang</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-eye fa-2x me-3"></i>
                                    <div>
                                        <h5 class="mb-0">${pageSize}</h5>
                                        <small>Truyện/trang</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Filter Section -->
                    <div class="filter-section">
                        <h6 class="mb-3"><i class="fas fa-filter me-2"></i>Bộ lọc và tìm kiếm</h6>
                        <form method="get" action="stories" class="row g-3">
                            <input type="hidden" name="action" value="filter">
                            
                            <div class="col-md-3">
                                <label class="form-label">Thể Loại</label>
                                <select name="theLoaiId" class="form-select">
                                    <option value="">Tất cả thể loại</option>
                                    <c:forEach var="tl" items="${dsTheLoai}">
                                        <option value="${tl.id}" ${param.theLoaiId == tl.id ? 'selected' : ''}>
                                            ${tl.tenTheLoai}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="col-md-3">
                                <label class="form-label">Trạng Thái</label>
                                <select name="trangThai" class="form-select">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="DANG_TIEN_HANH" ${param.trangThai == 'DANG_TIEN_HANH' ? 'selected' : ''}>Đang tiến hành</option>
                                    <option value="HOAN_THANH" ${param.trangThai == 'HOAN_THANH' ? 'selected' : ''}>Hoàn thành</option>
                                    <option value="TAM_DUNG" ${param.trangThai == 'TAM_DUNG' ? 'selected' : ''}>Tạm dừng</option>
                                    <option value="DA_XOA" ${param.trangThai == 'DA_XOA' ? 'selected' : ''}>Đã xóa</option>
                                </select>
                            </div>
                            
                           <div class="col-md-2">
                                <label class="form-label">Đặc tính</label>
                                <div class="form-check mt-2">
                                    <input class="form-check-input" type="checkbox" name="vip" value="true" ${param.vip == 'true' ? 'checked' : ''}>
                                    <label class="form-check-label">
                                        <i class="fas fa-crown text-warning"></i> Chỉ VIP
                                    </label>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <label class="form-label">&nbsp;</label>
                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-filter"></i> Lọc
                                    </button>
                                    <a href="stories" class="btn btn-outline-secondary">
                                        <i class="fas fa-refresh"></i> Reset
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Search and Top Section -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="search-form">
                                <form method="get" action="stories" class="d-flex">
                                    <input type="hidden" name="action" value="search">
                                    <input type="hidden" name="offset" value="0">
                                    <input type="hidden" name="limit" value="20">
                                    <div class="position-relative flex-grow-1">
                                        <i class="fas fa-search search-icon"></i>
                                        <input type="text" name="keyword" class="form-control" 
                                               placeholder="Tìm kiếm truyện theo tên..." value="${param.keyword}">
                                    </div>
                                    <button type="submit" class="btn btn-primary ms-2">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <form method="get" action="stories" class="d-flex">
                                <input type="hidden" name="action" value="top">
                                <select name="tieuChi" class="form-select me-2">
                                    <option value="luotXem">Top lượt xem</option>
                                    <option value="diemDanhGia">Top điểm đánh giá</option>
                                    <option value="ngayTao">Mới nhất</option>
                                </select>
                                <input type="number" name="limit" class="form-control me-2" 
                                       value="10" min="1" max="100" style="width: 80px;">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-trophy"></i> Top
                                </button>
                            </form>
                        </div>
                    </div>

                    <!-- Stories Table -->
                    <div class="card">
                        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                            <div>
                                <h5 class="mb-0">
                                    <i class="fas fa-list me-2"></i>
                                    Danh sách truyện
                                <c:if test="${not empty listStories}">
                                    <span class="badge bg-light text-dark ms-2">${listStories.size()} truyện</span>
                                </c:if>
                                </h5>
                            </div>
                            <div>
                                <label for="pageSizeSelect" class="form-label mb-0 me-2" style="display: inline; color: white;">Số dòng:</label>
                                <select id="pageSizeSelect" class="form-select d-inline-block" style="width: auto; background-color: white;" onchange="changePageSize(this.value)">
                                    <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                                    <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                    <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                                    <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                                </select>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <c:if test="${empty listStories}">
                                <div class="empty-state">
                                    <i class="fas fa-book-open"></i>
                                    <h5 class="text-muted">Không có truyện nào</h5>
                                    <p class="text-muted">Hãy thêm truyện mới hoặc thay đổi bộ lọc</p>
                                    <a href="stories?action=create" class="btn btn-primary">
                                        <i class="fas fa-plus me-2"></i>Thêm truyện đầu tiên
                                    </a>
                                </div>
                            </c:if>

                            <c:if test="${not empty listStories}">
                                <div class="table-responsive">
                                    <table class="table table-hover mb-0">
                                        <thead>
                                            <tr>
                                                <th style="width: 60px;">ID</th>
                                                <th style="width: 80px;">Ảnh bìa</th>
                                                <th style="min-width: 250px;">Thông tin truyện</th>
                                                <th style="width: 120px;">Tác giả</th>
                                                <th style="width: 120px;">Trạng thái</th>
                                                <th style="width: 120px;">Thông kê</th>
                                                <th style="width: 100px;">Đặc tính</th>
                                                <th style="width: 120px;">Ngày tạo</th>
                                                <th style="width: 120px;">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="story" items="${listStories}">
                                                <tr>
                                                    <td>
                                                        <span class="badge bg-light text-dark">#${story.id}</span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty story.anhBia}">
                                                                <img src="${pageContext.request.contextPath}/${story.anhBia}" 
                                                                     class="story-image" alt="Ảnh bìa" 
                                                                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                                <div class="story-placeholder" style="display: none;">
                                                                    <i class="fas fa-image text-muted"></i>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="story-placeholder">
                                                                    <i class="fas fa-image text-muted"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <h6 class="mb-1 text-primary">${story.tenTruyen}</h6>
                                                            <c:if test="${not empty story.moTa}">
                                                                <small class="text-muted d-block">
                                                                    ${story.moTa.length() > 80 ? story.moTa.substring(0, 80).concat('...') : story.moTa}
                                                                </small>
                                                            </c:if>
                                                            <c:if test="${not empty story.theLoaiTenList}">
                                                                <div class="genre-list">
                                                                    <i class="fas fa-tags me-1"></i>
                                                                    <c:forEach var="genre" items="${story.theLoaiTenList}" varStatus="status">
                                                                        ${genre}<c:if test="${!status.last}">, </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-info">
                                                            ${not empty story.tacGiaTen ? story.tacGiaTen : 'Chưa có'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${story.trangThai == 'HOAN_THANH'}">
                                                                <span class="badge bg-success">
                                                                    <i class="fas fa-check-circle me-1"></i>Hoàn thành
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${story.trangThai == 'DANG_TIEN_HANH'}">
                                                                <span class="badge bg-primary">
                                                                    <i class="fas fa-play-circle me-1"></i>Đang tiến hành
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${story.trangThai == 'TAM_DUNG'}">
                                                                <span class="badge bg-warning">
                                                                    <i class="fas fa-pause-circle me-1"></i>Tạm dừng
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${story.trangThai == 'DA_XOA'}">
                                                                <span class="badge bg-danger">
                                                                    <i class="fas fa-trash me-1"></i>Đã xóa
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">
                                                                    <i class="fas fa-question-circle me-1"></i>${story.trangThai}
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="stats-info">
                                                            <div class="text-info mb-1">
                                                                <i class="fas fa-eye"></i> 
                                                                <fmt:formatNumber value="${story.luotXem != null ? story.luotXem : 0}" pattern="#,###"/>
                                                            </div>
                                                            <div class="text-warning mb-1">
                                                                <c:choose>
                                                                    <c:when test="${story.diemDanhGia != null && story.diemDanhGia > 0}">
                                                                        <i class="fas fa-star"></i> 
                                                                        ${story.danhGiaFormatted}
                                                                        <small>(${story.soLuongDanhGia != null ? story.soLuongDanhGia : 0})</small>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa có</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="text-success">
                                                                <i class="fas fa-book-open"></i> 
                                                                ${story.soLuongChuong != null ? story.soLuongChuong : 0} chương
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="feature-badges">
                                                            <c:if test="${story.chiDanhChoVIP}">
                                                                <span class="badge-custom bg-warning text-dark">
                                                                    <i class="fas fa-crown"></i> VIP
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${story.noiBat}">
                                                                <span class="badge-custom bg-danger">
                                                                    <i class="fas fa-fire"></i> Hot
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${story.truyenMoi}">
                                                                <span class="badge-custom bg-info">
                                                                    <i class="fas fa-star"></i> New
                                                                </span>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <small class="text-muted">
                                                            <c:choose>
                                                                <c:when test="${story.ngayTao != null}">
                                                                    ${story.ngayTaoFormatted}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Chưa có
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </small>
                                                    </td>
                                                    <td class="text-center action-buttons">
                                                        <div class="dropdown">
                                                            <button class="btn btn-sm btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                                <i class="fas fa-ellipsis-h"></i>
                                                            </button>
                                                            <ul class="dropdown-menu dropdown-menu-end">
                                                                <li>
                                                                    <a class="dropdown-item" href="stories?action=view&id=${story.id}">
                                                                        <i class="fas fa-eye text-info"></i> Xem chi tiết
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a class="dropdown-item" href="stories?action=edit&id=${story.id}">
                                                                        <i class="fas fa-edit text-primary"></i> Chỉnh sửa
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/chapters?storyId=${story.id}">
                                                                        <i class="fas fa-file-alt text-success"></i> Quản lý chương
                                                                    </a>
                                                                </li>
                                                                <li><hr class="dropdown-divider"></li>
                                                                <li>
                                                                    <a class="dropdown-item" href="#" onclick="updateView(${story.id})">
                                                                        <i class="fas fa-eye text-info"></i> Tăng lượt xem
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a class="dropdown-item" href="#" onclick="updateRating(${story.id})">
                                                                        <i class="fas fa-star text-warning"></i> Cập nhật điểm
                                                                    </a>
                                                                </li>
                                                                <li><hr class="dropdown-divider"></li>
                                                                <li>
                                                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/story/${story.id}" target="_blank">
                                                                        <i class="fas fa-external-link-alt text-success"></i> Xem truyện
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <a class="dropdown-item text-danger" href="#" onclick="confirmDelete(${story.id}, '${story.tenTruyen}')">
                                                                        <i class="fas fa-trash-alt"></i> Xóa truyện
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                            <!-- Pagination Section (Footer) -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination-footer">
                            <div class="pagination-left">
                                <span class="pagination-info">Hiển thị ${pageSize} / ${totalStories} truyện</span>
                            </div>
                            <nav aria-label="Page navigation" class="pagination-nav">
                                <ul class="pagination pagination-custom">
                                    <!-- Page Numbers -->
                                    <c:set var="startPage" value="${currentPage > 3 ? currentPage - 2 : 1}"/>
                                    <c:set var="endPage" value="${startPage + 4 > totalPages ? totalPages : startPage + 4}"/>
                                    <c:if test="${endPage - startPage < 4 && totalPages >= 5}">
                                        <c:set var="startPage" value="${totalPages - 4}"/>
                                    </c:if>

                                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}&pageSize=${pageSize}">${i}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Next Button -->
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage + 1}&pageSize=${pageSize}" aria-label="Next">
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </c:if>
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
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
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
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
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
                    

                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Change page size
        function changePageSize(pageSize) {
            window.location.href = '?page=1&pageSize=' + pageSize;
        }

        // Rating form validation
        document.getElementById('ratingForm').addEventListener('submit', function(e) {
            const diem = parseFloat(document.querySelector('input[name="diem"]').value);
            const soLuong = parseInt(document.querySelector('input[name="soLuong"]').value);
            
            if (diem < 1.0 || diem > 10.0) {
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

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });
        });

        // Search form enhancement
        const keywordInput = document.querySelector('input[name="keyword"]');
        if (keywordInput) {
            keywordInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    this.closest('form').submit();
                }
            });
        }
    </script>
</body>
</html>
