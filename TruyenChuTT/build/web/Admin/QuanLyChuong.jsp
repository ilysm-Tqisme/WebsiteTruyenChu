<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý chương - TruyenTT</title>
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
        
        .chapter-content {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .feature-badges {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
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
        
        .bulk-actions {
            background: #fff;
            border-radius: 15px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        
        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            
            .page-header {
                padding: 1.5rem;
            }
            
            .filter-section {
                padding: 1rem;
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
                                    Quản Lý Chương
                                    <c:if test="${viewMode == 'chapters' && not empty selectedTruyen}">
                                        - ${selectedTruyen.tenTruyen}
                                    </c:if>
                                </h2>
                                <p class="text-muted mb-0">
                                    <c:choose>
                                        <c:when test="${viewMode == 'chapters' && not empty selectedTruyen}">
                                            Quản lý chương của truyện "${selectedTruyen.tenTruyen}"
                                        </c:when>
                                        <c:otherwise>
                                            Chọn truyện để quản lý chương
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <div class="d-flex gap-2">
                                <c:if test="${viewMode == 'chapters' && not empty selectedTruyen}">
                                    <a href="chapters?action=create&storyId=${selectedTruyen.id}" class="btn btn-primary">
                                        <i class="fas fa-plus me-2"></i>Thêm Chương
                                    </a>
                                </c:if>
                                <c:if test="${viewMode == 'chapters'}">
                                    <a href="chapters" class="btn btn-outline-primary">
                                        <i class="fas fa-arrow-left me-2"></i>Quay lại
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Breadcrumb -->
                    <c:if test="${viewMode == 'chapters' && not empty selectedTruyen}">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="chapters">
                                        <i class="fas fa-book me-1"></i>Danh sách truyện
                                    </a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">
                                    <i class="fas fa-file-alt me-1"></i>Chương - ${selectedTruyen.tenTruyen}
                                </li>
                            </ol>
                        </nav>
                    </c:if>

                    <!-- Messages -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Statistics Cards for Chapters -->
                    <c:if test="${viewMode == 'chapters' && not empty chapterStats}">
                        <div class="row mb-4">
                            <div class="col-md-2">
                                <div class="stats-card">
                                    <div class="text-center">
                                        <i class="fas fa-file-alt fa-2x mb-2"></i>
                                        <h5 class="mb-0">${chapterStats[0]}</h5>
                                        <small>Tổng chương</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="stats-card">
                                    <div class="text-center">
                                        <i class="fas fa-eye fa-2x mb-2"></i>
                                        <h5 class="mb-0">${chapterStats[1]}</h5>
                                        <small>Công khai</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="stats-card">
                                    <div class="text-center">
                                        <i class="fas fa-edit fa-2x mb-2"></i>
                                        <h5 class="mb-0">${chapterStats[2]}</h5>
                                        <small>Nháp</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="stats-card">
                                    <div class="text-center">
                                        <i class="fas fa-calendar fa-2x mb-2"></i>
                                        <h5 class="mb-0">${chapterStats[3]}</h5>
                                        <small>Lịch đăng</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="stats-card">
                                    <div class="text-center">
                                        <i class="fas fa-crown fa-2x mb-2"></i>
                                        <h5 class="mb-0">${chapterStats[4]}</h5>
                                        <small>VIP</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="stats-card">
                                    <div class="text-center">
                                        <i class="fas fa-chart-line fa-2x mb-2"></i>
                                        <h5 class="mb-0">
                                            <fmt:formatNumber value="${chapterStats[5]}" pattern="#,###"/>
                                        </h5>
                                        <small>Lượt xem</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Statistics Cards for Stories -->
                    <c:if test="${viewMode != 'chapters' && not empty listStories}">
                        <div class="row mb-4">
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-book fa-2x me-3"></i>
                                        <div>
                                            <h5 class="mb-0">${listStories.size()}</h5>
                                            <small>Tổng truyện</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-crown fa-2x me-3"></i>
                                        <div>
                                            <h5 class="mb-0">
                                                <c:set var="vipCount" value="0"/>
                                                <c:forEach var="story" items="${listStories}">
                                                    <c:if test="${story.chiDanhChoVIP}">
                                                        <c:set var="vipCount" value="${vipCount + 1}"/>
                                                    </c:if>
                                                </c:forEach>
                                                ${vipCount}
                                            </h5>
                                            <small>Truyện VIP</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-fire fa-2x me-3"></i>
                                        <div>
                                            <h5 class="mb-0">
                                                <c:set var="hotCount" value="0"/>
                                                <c:forEach var="story" items="${listStories}">
                                                    <c:if test="${story.noiBat}">
                                                        <c:set var="hotCount" value="${hotCount + 1}"/>
                                                    </c:if>
                                                </c:forEach>
                                                ${hotCount}
                                            </h5>
                                            <small>Truyện nổi bật</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="stats-card">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-star fa-2x me-3"></i>
                                        <div>
                                            <h5 class="mb-0">
                                                <c:set var="newCount" value="0"/>
                                                <c:forEach var="story" items="${listStories}">
                                                    <c:if test="${story.truyenMoi}">
                                                        <c:set var="newCount" value="${newCount + 1}"/>
                                                    </c:if>
                                                </c:forEach>
                                                ${newCount}
                                            </h5>
                                            <small>Truyện mới</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Filter Section -->
                    <div class="filter-section">
                        <h6 class="mb-3"><i class="fas fa-filter me-2"></i>Bộ lọc và tìm kiếm</h6>
                        
                        <c:choose>
                            <c:when test="${viewMode == 'chapters'}">
                                <!-- Filter cho chương -->
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <form method="get" action="chapters" class="search-form">
                                            <input type="hidden" name="action" value="search">
                                            <input type="hidden" name="storyId" value="${currentStoryId}">
                                            <div class="position-relative">
                                                <i class="fas fa-search search-icon"></i>
                                                <input type="text" name="keyword" class="form-control" 
                                                       placeholder="Tìm kiếm chương..." value="${searchKeyword}">
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col-md-8">
                                        <form method="get" action="chapters" class="d-flex gap-2">
                                            <input type="hidden" name="action" value="filter">
                                            <input type="hidden" name="storyId" value="${currentStoryId}">
                                            
                                            <select name="trangThai" class="form-select">
                                                <option value="">Tất cả trạng thái</option>
                                                <option value="CONG_KHAI" ${filterTrangThai == 'CONG_KHAI' ? 'selected' : ''}>Công khai</option>
                                                <option value="NHAP" ${filterTrangThai == 'NHAP' ? 'selected' : ''}>Nháp</option>
                                                <option value="LICH_DANG" ${filterTrangThai == 'LICH_DANG' ? 'selected' : ''}>Lịch đăng</option>
                                                <option value="AN" ${filterTrangThai == 'AN' ? 'selected' : ''}>Ẩn</option>
                                            </select>
                                            
                                            <select name="vip" class="form-select">
                                                <option value="">Tất cả loại</option>
                                                <option value="true" ${filterVip == 'true' ? 'selected' : ''}>Chỉ VIP</option>
                                                <option value="false" ${filterVip == 'false' ? 'selected' : ''}>Miễn phí</option>
                                            </select>
                                            
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-filter"></i> Lọc
                                            </button>
                                            
                                            <a href="chapters?storyId=${currentStoryId}" class="btn btn-outline-secondary">
                                                <i class="fas fa-refresh"></i> Reset
                                            </a>
                                        </form>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Filter cho truyện -->
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <form method="get" action="chapters" class="search-form">
                                            <input type="hidden" name="action" value="search">
                                            <div class="position-relative">
                                                <i class="fas fa-search search-icon"></i>
                                                <input type="text" name="keyword" class="form-control" 
                                                       placeholder="Tìm kiếm truyện..." value="${searchKeyword}">
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col-md-8">
                                        <form method="get" action="chapters" class="d-flex gap-2">
                                            <input type="hidden" name="action" value="filter">
                                            
                                            <select name="theLoaiId" class="form-select">
                                                <option value="">Tất cả thể loại</option>
                                                <c:forEach var="tl" items="${dsTheLoai}">
                                                    <option value="${tl.id}" ${param.theLoaiId == tl.id ? 'selected' : ''}>
                                                        ${tl.tenTheLoai}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            
                                            <select name="trangThai" class="form-select">
                                                <option value="">Tất cả trạng thái</option>
                                                <option value="DANG_TIEN_HANH" ${param.trangThai == 'DANG_TIEN_HANH' ? 'selected' : ''}>Đang tiến hành</option>
                                                <option value="HOAN_THANH" ${param.trangThai == 'HOAN_THANH' ? 'selected' : ''}>Hoàn thành</option>
                                                <option value="TAM_DUNG" ${param.trangThai == 'TAM_DUNG' ? 'selected' : ''}>Tạm dừng</option>
                                            </select>
                                            
                                            <select name="vip" class="form-select">
                                                <option value="">Tất cả loại</option>
                                                <option value="true" ${param.vip == 'true' ? 'selected' : ''}>Chỉ VIP</option>
                                                <option value="false" ${param.vip == 'false' ? 'selected' : ''}>Miễn phí</option>
                                            </select>
                                            
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-filter"></i> Lọc
                                            </button>
                                            
                                            <a href="chapters" class="btn btn-outline-secondary">
                                                <i class="fas fa-refresh"></i> Reset
                                            </a>
                                        </form>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Bulk Actions for Chapters -->
                    <c:if test="${viewMode == 'chapters' && not empty listChuong}">
                        <div class="bulk-actions">
                            <form method="post" action="chapters" id="bulkForm">
                                <input type="hidden" name="storyId" value="${currentStoryId}">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="selectAll">
                                        <label class="form-check-label" for="selectAll">
                                            Chọn tất cả
                                        </label>
                                    </div>
                                    <select name="newStatus" class="form-select" style="width: 200px;">
                                        <option value="">Chọn trạng thái</option>
                                        <option value="CONG_KHAI">Công khai</option>
                                        <option value="NHAP">Nháp</option>
                                        <option value="LICH_DANG">Lịch đăng</option>
                                        <option value="AN">Ẩn</option>
                                    </select>
                                    <button type="submit" name="action" value="bulkUpdateStatus" class="btn btn-primary">
                                        <i class="fas fa-edit"></i> Cập nhật trạng thái
                                    </button>
                                    <button type="submit" name="action" value="bulkDelete" class="btn btn-danger" 
                                            onclick="return confirm('Bạn có chắc chắn muốn xóa các chương đã chọn?')">
                                        <i class="fas fa-trash"></i> Xóa đã chọn
                                    </button>
                                </div>
                            </form>
                        </div>
                    </c:if>

                    <!-- Main Content Table -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <c:choose>
                                    <c:when test="${viewMode == 'chapters'}">
                                        <i class="fas fa-list me-2"></i>
                                        Danh sách chương
                                        <c:if test="${not empty listChuong}">
                                            <span class="badge bg-light text-dark ms-2">${listChuong.size()} chương</span>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-book me-2"></i>
                                        Danh sách truyện
                                        <c:if test="${not empty listStories}">
                                            <span class="badge bg-light text-dark ms-2">${listStories.size()} truyện</span>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                        </div>
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${viewMode == 'chapters'}">
                                    <!-- Chapters Table -->
                                    <c:choose>
                                        <c:when test="${empty listChuong}">
                                            <div class="empty-state">
                                                <i class="fas fa-file-alt"></i>
                                                <h5 class="text-muted">Không có chương nào</h5>
                                                <p class="text-muted">Truyện này chưa có chương nào. Hãy thêm chương đầu tiên!</p>
                                                <a href="chapters?action=create&storyId=${selectedTruyen.id}" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Thêm chương đầu tiên
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="table-responsive">
                                                <table class="table table-hover mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 50px;">
                                                                <input type="checkbox" class="form-check-input" id="masterCheckbox">
                                                            </th>
                                                            <th style="width: 60px;">ID</th>
                                                            <th style="width: 100px;">Số chương</th>
                                                            <th style="min-width: 200px;">Tên chương</th>
                                                            <th style="width: 250px;">Nội dung</th>
                                                            <th style="width: 120px;">Trạng thái</th>
                                                            <th style="width: 80px;">Đặc tính</th>
                                                            <th style="width: 100px;">Lượt xem</th>
                                                            <th style="width: 120px;">Ngày tạo</th>
                                                            <th style="width: 120px;">Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="chapter" items="${listChuong}">
                                                            <tr>
                                                                <td>
                                                                    <input type="checkbox" class="form-check-input row-checkbox" 
                                                                           name="selectedIds" value="${chapter.id}">
                                                                </td>
                                                                <td>
                                                                    <span class="badge bg-light text-dark">#${chapter.id}</span>
                                                                </td>
                                                                <td>
                                                                    <span class="badge bg-info">${chapter.soChuong}</span>
                                                                </td>
                                                                <td>
                                                                    <h6 class="mb-0 text-primary">${chapter.tenChuong}</h6>
                                                                </td>
                                                                <td>
                                                                    <div class="chapter-content" title="${chapter.noiDung}">
                                                                        ${chapter.noiDung.length() > 100 ? chapter.noiDung.substring(0, 100).concat('...') : chapter.noiDung}
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${chapter.trangThai == 'CONG_KHAI'}">
                                                                            <span class="badge bg-success">
                                                                                <i class="fas fa-eye me-1"></i>Công khai
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${chapter.trangThai == 'NHAP'}">
                                                                            <span class="badge bg-secondary">
                                                                                <i class="fas fa-edit me-1"></i>Nháp
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${chapter.trangThai == 'LICH_DANG'}">
                                                                            <span class="badge bg-warning">
                                                                                <i class="fas fa-calendar me-1"></i>Lịch đăng
                                                                            </span>
                                                                        </c:when>
                                                                        <c:when test="${chapter.trangThai == 'AN'}">
                                                                            <span class="badge bg-danger">
                                                                                <i class="fas fa-eye-slash me-1"></i>Ẩn
                                                                            </span>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <c:if test="${chapter.chiDanhChoVIP}">
                                                                        <span class="badge-custom bg-warning text-dark">
                                                                            <i class="fas fa-crown"></i> VIP
                                                                        </span>
                                                                    </c:if>
                                                                </td>
                                                                <td>
                                                                    <span class="text-info">
                                                                        <i class="fas fa-eye"></i> 
                                                                        <fmt:formatNumber value="${chapter.luotXem}" pattern="#,###"/>
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <small class="text-muted">
                                                                        ${chapter.ngayTaoFormatted}
                                                                    </small>
                                                                </td>
                                                                <td class="text-center action-buttons">
                                                                    <div class="dropdown">
                                                                        <button class="btn btn-sm btn-light dropdown-toggle" 
                                                                                type="button" data-bs-toggle="dropdown">
                                                                            <i class="fas fa-ellipsis-h"></i>
                                                                        </button>
                                                                        <ul class="dropdown-menu dropdown-menu-end">
                                                                            <li>
                                                                                <a class="dropdown-item" href="chapters?action=view&id=${chapter.id}">
                                                                                    <i class="fas fa-eye text-info"></i> Xem chi tiết
                                                                                </a>
                                                                            </li>
                                                                            <li>
                                                                                <a class="dropdown-item" href="chapters?action=edit&id=${chapter.id}">
                                                                                    <i class="fas fa-edit text-primary"></i> Chỉnh sửa
                                                                                </a>
                                                                            </li>
                                                                            <li><hr class="dropdown-divider"></li>
                                                                            <li>
                                                                                <a class="dropdown-item" href="#" onclick="updateView(${chapter.id})">
                                                                                    <i class="fas fa-plus text-success"></i> Tăng lượt xem
                                                                                </a>
                                                                            </li>
                                                                            <li><hr class="dropdown-divider"></li>
                                                                            <li>
                                                                                <a class="dropdown-item text-danger" href="#" 
                                                                                   onclick="confirmDelete(${chapter.id}, '${chapter.tenChuong}')">
                                                                                    <i class="fas fa-trash-alt"></i> Xóa chương
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
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <!-- Stories Table -->
                                    <c:choose>
                                        <c:when test="${empty listStories}">
                                            <div class="empty-state">
                                                <i class="fas fa-book-open"></i>
                                                <h5 class="text-muted">Không có truyện nào</h5>
                                                <p class="text-muted">Hãy thêm truyện mới hoặc thay đổi bộ lọc</p>
                                                <a href="${pageContext.request.contextPath}/admin/stories?action=create" class="btn btn-primary">
                                                    <i class="fas fa-plus me-2"></i>Thêm truyện mới
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="table-responsive">
                                                <table class="table table-hover mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th style="width: 60px;">ID</th>
                                                            <th style="width: 80px;">Ảnh bìa</th>
                                                            <th style="min-width: 250px;">Thông tin truyện</th>
                                                            <th style="width: 120px;">Tác giả</th>
                                                            <th style="width: 120px;">Trạng thái</th>
                                                            <th style="width: 120px;">Thống kê</th>
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
                                                                                <a class="dropdown-item" href="chapters?storyId=${story.id}">
                                                                                    <i class="fas fa-file-alt text-success"></i> Quản lý chương
                                                                                </a>
                                                                            </li>
                                                                            <li>
                                                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/stories?action=view&id=${story.id}">
                                                                                    <i class="fas fa-eye text-info"></i> Xem chi tiết
                                                                                </a>
                                                                            </li>
                                                                            <li>
                                                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/stories?action=edit&id=${story.id}">
                                                                                    <i class="fas fa-edit text-primary"></i> Chỉnh sửa
                                                                                </a>
                                                                            </li>
                                                                            <li><hr class="dropdown-divider"></li>
                                                                            <li>
                                                                                <a class="dropdown-item" href="${pageContext.request.contextPath}/story/${story.id}" target="_blank">
                                                                                    <i class="fas fa-external-link-alt text-success"></i> Xem truyện
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
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
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
        // Delete confirmation
        function confirmDelete(id, name) {
            document.getElementById('chapterName').textContent = name;
            document.getElementById('confirmDeleteBtn').href = 'chapters?action=delete&id=' + id + '&storyId=${currentStoryId}';
            const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
            modal.show();
        }

        // Update view count
        function updateView(id) {
            if (confirm('Tăng lượt xem cho chương này?')) {
                window.location.href = 'chapters?action=updateView&id=' + id + '&storyId=${currentStoryId}';
            }
        }

        // Checkbox handling
        document.addEventListener('DOMContentLoaded', function() {
            const masterCheckbox = document.getElementById('masterCheckbox');
            const selectAllCheckbox = document.getElementById('selectAll');
            const rowCheckboxes = document.querySelectorAll('.row-checkbox');
            
            // Master checkbox functionality
            if (masterCheckbox) {
                masterCheckbox.addEventListener('change', function() {
                    rowCheckboxes.forEach(checkbox => {
                        checkbox.checked = this.checked;
                    });
                });
            }
            
            // Select all functionality
            if (selectAllCheckbox) {
                selectAllCheckbox.addEventListener('change', function() {
                    rowCheckboxes.forEach(checkbox => {
                        checkbox.checked = this.checked;
                    });
                });
            }
            
            // Individual checkbox handling
            rowCheckboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    const allChecked = Array.from(rowCheckboxes).every(cb => cb.checked);
                    const anyChecked = Array.from(rowCheckboxes).some(cb => cb.checked);
                    
                    if (masterCheckbox) {
                        masterCheckbox.checked = allChecked;
                        masterCheckbox.indeterminate = anyChecked && !allChecked;
                    }
                    
                    if (selectAllCheckbox) {
                        selectAllCheckbox.checked = allChecked;
                    }
                });
            });
        });

        // Form validation for bulk actions
        const bulkForm = document.getElementById('bulkForm');
        if (bulkForm) {
            bulkForm.addEventListener('submit', function(e) {
                const checkedBoxes = document.querySelectorAll('.row-checkbox:checked');
                if (checkedBoxes.length === 0) {
                    e.preventDefault();
                    alert('Vui lòng chọn ít nhất một chương!');
                    return false;
                }
            });
        }

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    if (alert.classList.contains('show')) {
                        const bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    }
                }, 5000);
            });
        });

        // Handle session messages
        <c:if test="${not empty sessionScope.successMessage}">
            <c:set var="successMessage" value="${sessionScope.successMessage}" scope="request"/>
            <c:remove var="successMessage" scope="session"/>
        </c:if>
        
        <c:if test="${not empty sessionScope.errorMessage}">
            <c:set var="errorMessage" value="${sessionScope.errorMessage}" scope="request"/>
            <c:remove var="errorMessage" scope="session"/>
        </c:if>
    </script>
</body>
</html>