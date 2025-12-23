<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${action == 'edit'}">Chỉnh sửa chương</c:when>
            <c:otherwise>Thêm chương mới</c:otherwise>
        </c:choose>
        - TruyenTT
    </title>
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
        
        .form-control, .form-select {
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
            background: white;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(79, 70, 229, 0.25);
        }
        
        .form-label {
            font-weight: 600;
            color: #374151;
            margin-bottom: 0.5rem;
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
        
        .alert {
            border-radius: 15px;
            border: none;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .alert-success {
            background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%);
            color: #065f46;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #fef2f2 0%, #fecaca 100%);
            color: #991b1b;
        }
        
        .editor-container {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 1.5rem;
        }
        
        .editor-toolbar {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e2e8f0;
            flex-wrap: wrap;
        }
        
        .editor-btn {
            padding: 0.5rem;
            border: 1px solid #e2e8f0;
            background: white;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            min-width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .editor-btn:hover {
            background: #f8fafc;
            border-color: var(--primary-color);
        }
        
        .editor-btn.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .content-editor {
            min-height: 400px;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 1rem;
            resize: vertical;
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
        }
        
        .story-info {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid #e2e8f0;
        }
        
        .story-info h5 {
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        
        .chapter-counter {
            background: var(--primary-color);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 1rem;
        }
        
        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .form-check-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(79, 70, 229, 0.25);
        }
        
        .datetime-input {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 0.75rem 1rem;
        }
        
        .datetime-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(79, 70, 229, 0.25);
        }
        
        .preview-section {
            background: #f8fafc;
            border-radius: 15px;
            padding: 1.5rem;
            margin-top: 1.5rem;
            border: 1px solid #e2e8f0;
        }
        
        .preview-content {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-top: 1rem;
            border: 1px solid #e2e8f0;
            max-height: 300px;
            overflow-y: auto;
            line-height: 1.6;
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
        
        .toolbar-group {
            display: flex;
            gap: 0.25rem;
            margin-right: 1rem;
            padding-right: 1rem;
            border-right: 1px solid #e2e8f0;
        }
        
        .toolbar-group:last-child {
            border-right: none;
            margin-right: 0;
            padding-right: 0;
        }
        
        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            
            .page-header {
                padding: 1.5rem;
            }
            
            .editor-toolbar {
                flex-wrap: wrap;
                gap: 0.25rem;
            }
            
            .content-editor {
                min-height: 300px;
            }
            
            .toolbar-group {
                margin-right: 0.5rem;
                padding-right: 0.5rem;
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
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h2 class="mb-1">
                                    <i class="fas fa-file-alt text-primary me-2"></i>
                                    <c:choose>
                                        <c:when test="${action == 'edit'}">Chỉnh sửa chương</c:when>
                                        <c:otherwise>Thêm chương mới</c:otherwise>
                                    </c:choose>
                                </h2>
                                <p class="text-muted mb-0">
                                    <c:choose>
                                        <c:when test="${action == 'edit'}">
                                            Chỉnh sửa thông tin và nội dung chương
                                        </c:when>
                                        <c:otherwise>
                                            Tạo chương mới cho truyện
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <div>
                                <a href="chapters?storyId=${not empty chuong ? chuong.truyen.id : truyen.id}" class="btn btn-outline-secondary">
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
                                <a href="chapters?storyId=${not empty chuong ? chuong.truyen.id : truyen.id}">
                                    <i class="fas fa-file-alt me-1"></i>Chương - ${not empty chuong ? chuong.truyen.tenTruyen : truyen.tenTruyen}
                                </a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                <c:choose>
                                    <c:when test="${action == 'edit'}">
                                        <i class="fas fa-edit me-1"></i>Chỉnh sửa
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-plus me-1"></i>Thêm mới
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </ol>
                    </nav>

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

                    <!-- Story Info -->
                    <div class="story-info">
                        <h5>
                            <i class="fas fa-book me-2"></i>
                            Thông tin truyện
                        </h5>
                        <div class="row">
                            <div class="col-md-8">
                                <p class="mb-1">
                                    <strong>Tên truyện:</strong> 
                                    <c:choose>
                                        <c:when test="${not empty chuong}">
                                            ${chuong.truyen.tenTruyen}
                                        </c:when>
                                        <c:otherwise>
                                            ${truyen.tenTruyen}
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <c:if test="${not empty soChuongTiepTheo}">
                                    <p class="mb-0 text-muted">
                                        <i class="fas fa-info-circle me-1"></i>
                                        Đề xuất số chương tiếp theo: <strong>${soChuongTiepTheo}</strong>
                                    </p>
                                </c:if>
                            </div>
                            <div class="col-md-4 text-end">
                                <c:choose>
                                    <c:when test="${action == 'edit'}">
                                        <span class="chapter-counter">
                                            <i class="fas fa-edit me-1"></i>
                                            Chỉnh sửa chương #${chuong.soChuong}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="chapter-counter">
                                            <i class="fas fa-plus me-1"></i>
                                            Thêm chương mới
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Chapter Form -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-edit me-2"></i>
                                <c:choose>
                                    <c:when test="${action == 'edit'}">Chỉnh sửa chương</c:when>
                                    <c:otherwise>Tạo chương mới</c:otherwise>
                                </c:choose>
                            </h5>
                        </div>
                        <div class="card-body">
                            <form method="post" action="chapters" id="chapterForm">
                                <input type="hidden" name="action" value="${action}">
                                <c:if test="${action == 'edit'}">
                                    <input type="hidden" name="id" value="${chuong.id}">
                                </c:if>
                                <input type="hidden" name="truyenId" value="${not empty chuong ? chuong.truyen.id : truyen.id}">
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="tenChuong" class="form-label">
                                                <i class="fas fa-heading me-1"></i>Tên chương *
                                            </label>
                                            <input type="text" class="form-control" id="tenChuong" name="tenChuong" 
                                                   value="${not empty chuong ? chuong.tenChuong : ''}" 
                                                   placeholder="Nhập tên chương..." required>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <label for="soChuong" class="form-label">
                                                <i class="fas fa-sort-numeric-up me-1"></i>Số chương *
                                            </label>
                                            <input type="number" class="form-control" id="soChuong" name="soChuong" 
                                                   value="${not empty chuong ? chuong.soChuong : soChuongTiepTheo}" 
                                                   min="1" required>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="mb-3">
                                            <label for="trangThai" class="form-label">
                                                <i class="fas fa-flag me-1"></i>Trạng thái
                                            </label>
                                            <select class="form-select" id="trangThai" name="trangThai">
                                                <option value="CONG_KHAI" ${not empty chuong && chuong.trangThai == 'CONG_KHAI' ? 'selected' : ''}>
                                                    Công khai
                                                </option>
                                                <option value="NHAP" ${not empty chuong && chuong.trangThai == 'NHAP' ? 'selected' : ''}>
                                                    Nháp
                                                </option>
                                                <option value="LICH_DANG" ${not empty chuong && chuong.trangThai == 'LICH_DANG' ? 'selected' : ''}>
                                                    Lịch đăng
                                                </option>
                                                <option value="AN" ${not empty chuong && chuong.trangThai == 'AN' ? 'selected' : ''}>
                                                    Ẩn
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="chiDanhChoVIP" name="chiDanhChoVIP" value="true"
                                                       ${not empty chuong && chuong.chiDanhChoVIP ? 'checked' : ''}>
                                                <label class="form-check-label" for="chiDanhChoVIP">
                                                    <i class="fas fa-crown text-warning me-1"></i>
                                                    Chương VIP (chỉ dành cho thành viên VIP)
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3" id="scheduleDiv" style="display: none;">
                                            <label for="ngayDangLich" class="form-label">
                                                <i class="fas fa-calendar-alt me-1"></i>Ngày đăng lịch
                                            </label>
                                            <input type="datetime-local" class="form-control datetime-input" id="ngayDangLich" name="ngayDangLich"
                                                   value="${not empty chuong && not empty chuong.ngayDangLich ? chuong.ngayDangLich.format(java.time.format.DateTimeFormatter.ofPattern('yyyy-MM-dd\'T\'HH:mm')) : ''}">
                                        </div>
                                    </div>
                                </div>

                                <!-- Content Editor -->
                                <div class="editor-container">
                                    <label for="noiDung" class="form-label">
                                        <i class="fas fa-edit me-1"></i>Nội dung chương *
                                    </label>
                                    
                                    <div class="editor-toolbar">
                                        <div class="toolbar-group">
                                            <button type="button" class="editor-btn" onclick="formatText('bold')" title="Đậm (Ctrl+B)">
                                                <i class="fas fa-bold"></i>
                                            </button>
                                            <button type="button" class="editor-btn" onclick="formatText('italic')" title="Nghiêng (Ctrl+I)">
                                                <i class="fas fa-italic"></i>
                                            </button>
                                            <button type="button" class="editor-btn" onclick="formatText('underline')" title="Gạch chân (Ctrl+U)">
                                                <i class="fas fa-underline"></i>
                                            </button>
                                        </div>
                                        <div class="toolbar-group">
                                            <button type="button" class="editor-btn" onclick="insertText('\n\n')" title="Xuống dòng">
                                                <i class="fas fa-level-down-alt"></i>
                                            </button>
                                            <button type="button" class="editor-btn" onclick="insertText('    ')" title="Thụt lề">
                                                <i class="fas fa-indent"></i>
                                            </button>
                                            <button type="button" class="editor-btn" onclick="insertText('---\n')" title="Thêm đường kẻ">
                                                <i class="fas fa-minus"></i>
                                            </button>
                                        </div>
                                        <div class="toolbar-group">
                                            <button type="button" class="editor-btn" onclick="insertText('**[Tên nhân vật]**')" title="Thêm tên nhân vật">
                                                <i class="fas fa-user"></i>
                                            </button>
                                            <button type="button" class="editor-btn" onclick="insertText('*[Tâm lý nhân vật]*')" title="Thêm tâm lý">
                                                <i class="fas fa-heart"></i>
                                            </button>
                                            <button type="button" class="editor-btn" onclick="insertText('\"[Lời thoại]\"')" title="Thêm lời thoại">
                                                <i class="fas fa-quote-left"></i>
                                            </button>
                                        </div>
                                        <div class="toolbar-group">
                                            <button type="button" class="editor-btn" onclick="insertText('\n\n***\n\n')" title="Thêm dấu phân cách">
                                                <i class="fas fa-asterisk"></i>
                                            </button>
                                            <button type="button" class="editor-btn" onclick="previewContent()" title="Xem trước">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button type="button" class="editor-btn" onclick="clearContent()" title="Xóa nội dung">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                    
                                    <textarea class="form-control content-editor" id="noiDung" name="noiDung" 
                                              placeholder="Nhập nội dung chương..." required>${not empty chuong ? chuong.noiDung : ''}</textarea>
                                    
                                    <div class="d-flex justify-content-between align-items-center mt-2">
                                        <div>
                                            <button type="button" class="btn btn-outline-secondary btn-sm" onclick="autoFormat()">
                                                <i class="fas fa-magic me-1"></i>Tự động định dạng
                                            </button>
                                            <button type="button" class="btn btn-outline-secondary btn-sm" onclick="insertTemplate()">
                                                <i class="fas fa-file-alt me-1"></i>Chèn mẫu
                                            </button>
                                        </div>
                                        <small class="text-muted">
                                            <i class="fas fa-info-circle me-1"></i>
                                            Số ký tự: <span id="charCount">0</span>
                                        </small>
                                    </div>
                                </div>

                                <!-- Preview Section -->
                                <div class="preview-section" id="previewSection" style="display: none;">
                                    <h6>
                                        <i class="fas fa-eye me-2"></i>Xem trước nội dung
                                        <button type="button" class="btn btn-sm btn-outline-secondary float-end" onclick="hidePreview()">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </h6>
                                    <div class="preview-content" id="previewContent">
                                        <!-- Preview content will be displayed here -->
                                    </div>
                                </div>

                                <!-- Submit Buttons -->
                                <div class="d-flex justify-content-between align-items-center mt-4">
                                    <div>
                                        <button type="button" class="btn btn-outline-secondary" onclick="history.back()">
                                            <i class="fas fa-arrow-left me-2"></i>Hủy
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary" onclick="saveDraft()">
                                            <i class="fas fa-save me-2"></i>Lưu nháp
                                        </button>
                                    </div>
                                    <div>
                                        <c:if test="${action == 'edit'}">
                                            <button type="submit" class="btn btn-success">
                                                <i class="fas fa-save me-2"></i>Cập nhật chương
                                            </button>
                                        </c:if>
                                        <c:if test="${action != 'edit'}">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fas fa-plus me-2"></i>Tạo chương
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Show/hide schedule input based on status
        document.getElementById('trangThai').addEventListener('change', function() {
            const scheduleDiv = document.getElementById('scheduleDiv');
            if (this.value === 'LICH_DANG') {
                scheduleDiv.style.display = 'block';
            } else {
                scheduleDiv.style.display = 'none';
            }
        });

        // Initialize schedule div visibility
        document.addEventListener('DOMContentLoaded', function() {
            const trangThai = document.getElementById('trangThai').value;
            const scheduleDiv = document.getElementById('scheduleDiv');
            if (trangThai === 'LICH_DANG') {
                scheduleDiv.style.display = 'block';
            }
        });

        // Character count
        const noiDungTextarea = document.getElementById('noiDung');
        const charCount = document.getElementById('charCount');
        
        function updateCharCount() {
            charCount.textContent = noiDungTextarea.value.length.toLocaleString();
        }
        
        noiDungTextarea.addEventListener('input', updateCharCount);
        updateCharCount(); // Initialize

        // Text formatting functions
        function formatText(command) {
            const textarea = document.getElementById('noiDung');
            const start = textarea.selectionStart;
            const end = textarea.selectionEnd;
            const selectedText = textarea.value.substring(start, end);
            
            let formattedText = '';
            switch(command) {
                case 'bold':
                    formattedText = '**' + selectedText + '**';
                    break;
                case 'italic':
                    formattedText = '*' + selectedText + '*';
                    break;
                case 'underline':
                    formattedText = '__' + selectedText + '__';
                    break;
            }
            
            textarea.value = textarea.value.substring(0, start) + formattedText + textarea.value.substring(end);
            textarea.focus();
            textarea.setSelectionRange(start + formattedText.length, start + formattedText.length);
            updateCharCount();
        }

        function insertText(text) {
            const textarea = document.getElementById('noiDung');
            const start = textarea.selectionStart;
            const end = textarea.selectionEnd;
            
            textarea.value = textarea.value.substring(0, start) + text + textarea.value.substring(end);
            textarea.focus();
            textarea.setSelectionRange(start + text.length, start + text.length);
            updateCharCount();
        }

        // Auto format function
        function autoFormat() {
            const textarea = document.getElementById('noiDung');
            let content = textarea.value;
            
            // Basic formatting
            content = content.replace(/\n\n+/g, '\n\n'); // Remove multiple line breaks
            content = content.replace(/\s+/g, ' '); // Remove multiple spaces
            content = content.replace(/\n /g, '\n'); // Remove space at start of line
            content = content.trim(); // Remove leading/trailing whitespace
            
            textarea.value = content;
            updateCharCount();
        }

        // Insert template
        function insertTemplate() {
            const templates = [
                'Chương [Số chương]: [Tên chương]\n\n[Nội dung chương]\n\n***\n\n',
                '**[Tên nhân vật]** nghĩ thầm: *[Tâm lý]*\n\n',
                '\"[Lời thoại]\" - **[Tên nhân vật]** nói.\n\n',
                'Thời gian: [Thời gian]\nĐịa điểm: [Địa điểm]\n\n[Nội dung]\n\n'
            ];
            
            const selectedTemplate = templates[Math.floor(Math.random() * templates.length)];
            insertText(selectedTemplate);
        }

        // Clear content
        function clearContent() {
            if (confirm('Bạn có chắc chắn muốn xóa toàn bộ nội dung?')) {
                document.getElementById('noiDung').value = '';
                updateCharCount();
            }
        }

        // Preview content
        function previewContent() {
            const content = document.getElementById('noiDung').value;
            const previewSection = document.getElementById('previewSection');
            const previewContent = document.getElementById('previewContent');
            
            if (content.trim() === '') {
                alert('Vui lòng nhập nội dung để xem trước!');
                return;
            }
            
            // Advanced markdown-like formatting
            let formattedContent = content
                .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
                .replace(/\*(.*?)\*/g, '<em>$1</em>')
                .replace(/__(.*?)__/g, '<u>$1</u>')
                .replace(/\"(.*?)\"/g, '<blockquote>"$1"</blockquote>')
                .replace(/---/g, '<hr>')
                .replace(/\*\*\*/g, '<div class="text-center my-3">* * *</div>')
                .replace(/\n\n/g, '</p><p>')
                .replace(/\n/g, '<br>');
            
            formattedContent = '<p>' + formattedContent + '</p>';
            
            previewContent.innerHTML = formattedContent;
            previewSection.style.display = 'block';
            
            // Scroll to preview
            previewSection.scrollIntoView({ behavior: 'smooth' });
        }

        // Hide preview
        function hidePreview() {
            document.getElementById('previewSection').style.display = 'none';
        }

        // Save draft function
        function saveDraft() {
            const formData = new FormData(document.getElementById('chapterForm'));
            formData.set('trangThai', 'NHAP');
            
            // You can implement auto-save to localStorage here
            localStorage.setItem('chapterDraft', JSON.stringify({
                tenChuong: formData.get('tenChuong'),
                noiDung: formData.get('noiDung'),
                soChuong: formData.get('soChuong'),
                truyenId: formData.get('truyenId'),
                timestamp: new Date().toISOString()
            }));
            
            alert('Đã lưu nháp vào bộ nhớ tạm!');
        }

        // Load draft from localStorage
        function loadDraft() {
            const draft = localStorage.getItem('chapterDraft');
            if (draft) {
                const draftData = JSON.parse(draft);
                if (confirm('Tìm thấy nháp đã lưu. Bạn có muốn khôi phục không?')) {
                    document.getElementById('tenChuong').value = draftData.tenChuong || '';
                    document.getElementById('noiDung').value = draftData.noiDung || '';
                    document.getElementById('soChuong').value = draftData.soChuong || '';
                    document.getElementById('trangThai').value = 'NHAP';
                    updateCharCount();
                }
            }
        }

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey) {
                switch(e.key) {
                    case 'b':
                        e.preventDefault();
                        formatText('bold');
                        break;
                    case 'i':
                        e.preventDefault();
                        formatText('italic');
                        break;
                    case 'u':
                        e.preventDefault();
                        formatText('underline');
                        break;
                    case 's':
                        e.preventDefault();
                        saveDraft();
                        break;
                }
            }
        });

        // Form validation
        document.getElementById('chapterForm').addEventListener('submit', function(e) {
            const tenChuong = document.getElementById('tenChuong').value.trim();
            const noiDung = document.getElementById('noiDung').value.trim();
            const soChuong = document.getElementById('soChuong').value;
            const trangThai = document.getElementById('trangThai').value;
            const ngayDangLich = document.getElementById('ngayDangLich').value;
            
            if (tenChuong === '') {
                e.preventDefault();
                alert('Vui lòng nhập tên chương!');
                document.getElementById('tenChuong').focus();
                return false;
            }
            
            if (noiDung === '') {
                e.preventDefault();
                alert('Vui lòng nhập nội dung chương!');
                document.getElementById('noiDung').focus();
                return false;
            }
            
            if (soChuong <= 0) {
                e.preventDefault();
                alert('Số chương phải lớn hơn 0!');
                document.getElementById('soChuong').focus();
                return false;
            }
            
            if (trangThai === 'LICH_DANG' && ngayDangLich === '') {
                e.preventDefault();
                alert('Vui lòng chọn ngày đăng lịch!');
                document.getElementById('ngayDangLich').focus();
                return false;
            }
            
            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
            submitBtn.disabled = true;
            
            // Clear draft after successful submission
            localStorage.removeItem('chapterDraft');
        });

        // Load draft on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Only load draft for new chapters
            if ('${action}' !== 'edit') {
                loadDraft();
            }
        });

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
    </script>
</body>
</html>