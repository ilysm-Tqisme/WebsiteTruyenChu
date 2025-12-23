<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${truyen != null ? 'Sửa' : 'Thêm'} Truyện - TruyenTT</title>
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
        
        .form-section {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        
        .form-section h5 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .form-control, .form-select {
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
            background: white;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(79, 70, 229, 0.25);
        }
        
        .preview-image {
            max-width: 200px;
            max-height: 250px;
            object-fit: cover;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: relative;
        }
        
        .image-placeholder {
            width: 200px;
            height: 250px;
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px dashed #cbd5e1;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .image-placeholder:hover {
            border-color: var(--primary-color);
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        }
        
        .checkbox-group {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
            margin-top: 0.5rem;
        }
        
        .form-check {
            background: white;
            padding: 0.75rem 1rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
        }
        
        .form-check:hover {
            border-color: var(--primary-color);
            box-shadow: 0 2px 8px rgba(79, 70, 229, 0.1);
        }
        
        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .genre-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }
        
        .genre-item {
            background: white;
            padding: 0.75rem 1rem;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
        }
        
        .genre-item:hover {
            border-color: var(--primary-color);
            box-shadow: 0 2px 8px rgba(79, 70, 229, 0.1);
        }
        
        .genre-item input:checked + label {
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border: none;
            border-radius: 12px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.3);
        }
        
        .btn-secondary {
            border-radius: 12px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-secondary:hover {
            transform: translateY(-2px);
        }
        
        .author-section {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            border-radius: 12px;
            padding: 1.5rem;
            border: 1px solid #e2e8f0;
        }
        
        .author-toggle {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .author-toggle .btn {
            border-radius: 25px;
            padding: 0.5rem 1.5rem;
            font-size: 0.875rem;
            font-weight: 600;
        }
        
        .required-field {
            color: var(--danger-color);
        }
        
        .form-text {
            color: #6b7280;
            font-size: 0.875rem;
        }
        
        .upload-area {
            border: 2px dashed #cbd5e1;
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            background: white;
        }
        
        .upload-area:hover {
            border-color: var(--primary-color);
            background: #f8fafc;
        }
        
        .upload-area.dragover {
            border-color: var(--primary-color);
            background: rgba(79, 70, 229, 0.05);
        }

        /* ✅ THÊM: CSS cho logo overlay */
        .image-container {
            position: relative;
            display: inline-block;
        }

        .story-badge {
            position: absolute;
            top: 8px;
            right: 8px;
            padding: 4px 8px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: none;
            z-index: 10;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
        }

        .story-badge.vip {
            background: linear-gradient(135deg, #ffd700 0%, #ffb347 100%);
            color: #8b4513;
            display: flex;
            align-items: center;
            gap: 3px;
        }

        .story-badge.hot {
            background: linear-gradient(135deg, #ff4757 0%, #ff3838 100%);
            color: white;
            display: flex;
            align-items: center;
            gap: 3px;
        }

        .story-badge.new {
            background: linear-gradient(135deg, #00d2d3 0%, #54a0ff 100%);
            color: white;
            display: flex;
            align-items: center;
            gap: 3px;
        }

        .badge-icon {
            font-size: 0.8rem;
        }

        /* Multiple badges positioning */
        .story-badge:nth-child(2) {
            top: 8px;
            right: 8px;
        }

        .story-badge:nth-child(3) {
            top: 38px;
            right: 8px;
        }

        .story-badge:nth-child(4) {
            top: 68px;
            right: 8px;
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
                                    ${truyen != null ? 'Sửa' : 'Thêm'} Truyện
                                </h2>
                                <p class="text-muted mb-0">
                                    ${truyen != null ? 'Cập nhật thông tin truyện' : 'Thêm truyện mới vào hệ thống'}
                                </p>
                            </div>
                            <a href="stories" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Quay lại
                            </a>
                        </div>
                    </div>

                                                    <!-- Messages -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>Lỗi!</strong> ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            <strong>Thành công!</strong> ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                                                    
                    <!-- Form -->
                    <form method="post" action="stories" enctype="multipart/form-data" id="storyForm">
                        <input type="hidden" name="action" value="${truyen != null ? 'update' : 'insert'}">
                        <c:if test="${truyen != null}">
                            <input type="hidden" name="id" value="${truyen.id}">
                        </c:if>

                        <div class="row">
                            <!-- Left Column -->
                            <div class="col-lg-8">
                                <!-- Thông tin cơ bản -->
                                <div class="form-section">
                                    <h5><i class="fas fa-info-circle me-2"></i>Thông tin cơ bản</h5>
                                    
                                    <div class="mb-3">
                                        <label for="tenTruyen" class="form-label">
                                            Tên truyện <span class="required-field">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="tenTruyen" name="tenTruyen" 
                                               value="${truyen.tenTruyen}" required 
                                               placeholder="Nhập tên truyện...">
                                    </div>

                                    <div class="mb-3">
                                        <label for="moTa" class="form-label">Mô tả truyện</label>
                                        <textarea class="form-control" id="moTa" name="moTa" rows="5" 
                                                  placeholder="Nhập mô tả nội dung truyện...">${truyen.moTa}</textarea>
                                        <div class="form-text">Mô tả ngắn gọn về nội dung, cốt truyện</div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="trangThai" class="form-label">
                                                    Trạng thái <span class="required-field">*</span>
                                                </label>
                                                <select class="form-select" id="trangThai" name="trangThai" required>
                                                    <option value="">Chọn trạng thái</option>
                                                    <option value="DANG_TIEN_HANH" ${truyen.trangThai == 'DANG_TIEN_HANH' ? 'selected' : ''}>
                                                        Đang tiến hành
                                                    </option>
                                                    <option value="HOAN_THANH" ${truyen.trangThai == 'HOAN_THANH' ? 'selected' : ''}>
                                                        Hoàn thành
                                                    </option>
                                                    <option value="TAM_DUNG" ${truyen.trangThai == 'TAM_DUNG' ? 'selected' : ''}>
                                                        Tạm dừng
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Đặc tính truyện</label>
                                                <div class="checkbox-group">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" id="vip" name="vip" 
                                                               ${truyen.chiDanhChoVIP ? 'checked' : ''} onchange="updateBadges()">
                                                        <label class="form-check-label" for="vip">
                                                            <i class="fas fa-crown text-warning me-1"></i>VIP
                                                        </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" id="noiBat" name="noiBat" 
                                                               ${truyen.noiBat ? 'checked' : ''} onchange="updateBadges()">
                                                        <label class="form-check-label" for="noiBat">
                                                            <i class="fas fa-fire text-danger me-1"></i>Nổi bật
                                                        </label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" id="truyenMoi" name="truyenMoi" 
                                                               ${truyen.truyenMoi ? 'checked' : ''} onchange="updateBadges()">
                                                        <label class="form-check-label" for="truyenMoi">
                                                            <i class="fas fa-star text-info me-1"></i>Mới
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Tác giả -->
                                <div class="form-section">
                                    <h5><i class="fas fa-user-edit me-2"></i>Thông tin tác giả</h5>
                                    
                                    <div class="author-section">
                                        <div class="author-toggle">
                                            <button type="button" class="btn btn-outline-primary" id="existingAuthorBtn">
                                                <i class="fas fa-user me-1"></i>Chọn tác giả có sẵn
                                            </button>
                                            <button type="button" class="btn btn-outline-success" id="newAuthorBtn">
                                                <i class="fas fa-user-plus me-1"></i>Thêm tác giả mới
                                            </button>
                                        </div>
                                        
                                        <div id="existingAuthorSection">
                                            <label for="tacGiaID" class="form-label">Chọn tác giả</label>
                                            <select class="form-select" id="tacGiaID" name="tacGiaID">
                                                <option value="">-- Chọn tác giả --</option>
                                                <c:forEach var="tg" items="${dsTacGia}">
                                                    <option value="${tg.id}" ${truyen.tacGiaId == tg.id ? 'selected' : ''}>
                                                        ${tg.tenTacGia}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        
                                        <div id="newAuthorSection" style="display: none;">
                                            <label for="tacGiaMoi" class="form-label">Tên tác giả mới</label>
                                            <input type="text" class="form-control" id="tacGiaMoi" name="tacGiaMoi" 
                                                   placeholder="Nhập tên tác giả mới...">
                                            <div class="form-text">Tác giả mới sẽ được tự động thêm vào hệ thống</div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Thể loại -->
                                <div class="form-section">
                                    <h5><i class="fas fa-tags me-2"></i>Thể loại truyện</h5>
                                    <p class="text-muted mb-3">Chọn ít nhất một thể loại cho truyện</p>
                                    
                                    <div class="genre-grid">
                                        <c:forEach var="tl" items="${dsTheLoai}">
                                            <div class="genre-item">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" id="theLoai${tl.id}" 
                                                           name="theLoaiID" value="${tl.id}"
                                                           <c:if test="${listTheLoaiGan != null}">
                                                               <c:forEach var="ganId" items="${listTheLoaiGan}">
                                                                   ${ganId == tl.id ? 'checked' : ''}
                                                               </c:forEach>
                                                           </c:if>>
                                                    <label class="form-check-label" for="theLoai${tl.id}">
                                                        ${tl.tenTheLoai}
                                                    </label>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>

                            <!-- Right Column -->
                            <div class="col-lg-4">
                                <!-- Ảnh bìa -->
                                <div class="form-section">
                                    <h5><i class="fas fa-image me-2"></i>Ảnh bìa</h5>
                                    
                                    <div class="upload-area" id="uploadArea">
                                        <input type="file" class="d-none" id="anhBia" name="anhBia" 
                                               accept="image/*" onchange="previewImage(this)">
                                        <c:if test="${truyen != null && not empty truyen.anhBia}">
                                            <input type="hidden" name="currentImage" value="${truyen.anhBia}">
                                        </c:if>
                                        
                                        <div class="text-center" id="uploadContent">
                                            <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                                            <p class="mb-2">Kéo thả ảnh vào đây hoặc</p>
                                            <button type="button" class="btn btn-outline-primary" onclick="document.getElementById('anhBia').click()">
                                                <i class="fas fa-folder-open me-1"></i>Chọn ảnh
                                            </button>
                                            <div class="form-text mt-2">
                                                Định dạng: JPG, PNG, GIF<br>
                                                Kích thước tối đa: 5MB
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="text-center mt-3" id="imagePreviewContainer">
                                        <c:if test="${truyen != null && not empty truyen.anhBia}">
                                            <div class="image-container">
                                                <img src="${pageContext.request.contextPath}/${truyen.anhBia}" 
                                                        class="preview-image" id="imagePreview" alt="Ảnh bìa hiện tại">
                                                <!-- ✅ Badges overlay -->
                                                <div class="story-badge vip" id="vipBadge" style="display: ${truyen.chiDanhChoVIP ? 'flex' : 'none'};">
                                                    <i class="fas fa-crown badge-icon"></i>VIP
                                                </div>
                                                <div class="story-badge hot" id="hotBadge" style="display: ${truyen.noiBat ? 'flex' : 'none'};">
                                                    <i class="fas fa-fire badge-icon"></i>HOT
                                                </div>
                                                <div class="story-badge new" id="newBadge" style="display: ${truyen.truyenMoi ? 'flex' : 'none'};">
                                                    <i class="fas fa-star badge-icon"></i>NEW
                                                </div>
                                            </div>
                                            <div class="mt-2">
                                                <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeImage()">
                                                    <i class="fas fa-trash me-1"></i>Xóa ảnh
                                                </button>
                                            </div>
                                        </c:if>
                                        <c:if test="${truyen == null || empty truyen.anhBia}">
                                            <div class="image-container">
                                                <div class="image-placeholder" id="imagePlaceholder">
                                                    <i class="fas fa-image fa-3x text-muted"></i>
                                                </div>
                                                <!-- ✅ Badges overlay for placeholder -->
                                                <div class="story-badge vip" id="vipBadgePlaceholder" style="display: none;">
                                                    <i class="fas fa-crown badge-icon"></i>VIP
                                                </div>
                                                <div class="story-badge hot" id="hotBadgePlaceholder" style="display: none;">
                                                    <i class="fas fa-fire badge-icon"></i>HOT
                                                </div>
                                                <div class="story-badge new" id="newBadgePlaceholder" style="display: none;">
                                                    <i class="fas fa-star badge-icon"></i>NEW
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Thống kê (chỉ hiện khi sửa) -->
                                <c:if test="${truyen != null}">
                                    <div class="form-section">
                                        <h5><i class="fas fa-chart-bar me-2"></i>Thống kê</h5>
                                        
                                        <div class="row text-center">
                                            <div class="col-6">
                                                <div class="p-3 bg-white rounded">
                                                    <i class="fas fa-eye fa-2x text-info mb-2"></i>
                                                    <h6 class="mb-0">
                                                        <fmt:formatNumber value="${truyen.luotXem}" pattern="#,###"/>
                                                    </h6>
                                                    <small class="text-muted">Lượt xem</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="p-3 bg-white rounded">
                                                    <i class="fas fa-star fa-2x text-warning mb-2"></i>
                                                    <h6 class="mb-0">
                                                        <c:if test="${truyen.diemDanhGia > 0}">
                                                            ${truyen.danhGiaFormatted}
                                                        </c:if>
                                                        <c:if test="${truyen.diemDanhGia == 0}">--</c:if>
                                                    </h6>
                                                    <small class="text-muted">Điểm đánh giá</small>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="mt-3 p-3 bg-white rounded">
                                            <small class="text-muted">
                                                <i class="fas fa-calendar me-1"></i>
                                                Ngày tạo: ${truyen.ngayTaoFormatted}
                                            </small>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Submit Buttons -->
                        <div class="text-center mt-4">
                            <button type="submit" class="btn btn-primary btn-lg me-3">
                                <i class="fas fa-save me-2"></i>
                                ${truyen != null ? 'Cập nhật truyện' : 'Thêm truyện'}
                            </button>
                            <a href="stories" class="btn btn-secondary btn-lg">
                                <i class="fas fa-times me-2"></i>Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Author section toggle
        document.getElementById('existingAuthorBtn').addEventListener('click', function() {
            document.getElementById('existingAuthorSection').style.display = 'block';
            document.getElementById('newAuthorSection').style.display = 'none';
            this.classList.add('btn-primary');
            this.classList.remove('btn-outline-primary');
            document.getElementById('newAuthorBtn').classList.add('btn-outline-success');
            document.getElementById('newAuthorBtn').classList.remove('btn-success');
            document.getElementById('tacGiaMoi').value = '';
        });

        document.getElementById('newAuthorBtn').addEventListener('click', function() {
            document.getElementById('existingAuthorSection').style.display = 'none';
            document.getElementById('newAuthorSection').style.display = 'block';
            this.classList.add('btn-success');
            this.classList.remove('btn-outline-success');
            document.getElementById('existingAuthorBtn').classList.add('btn-outline-primary');
            document.getElementById('existingAuthorBtn').classList.remove('btn-primary');
            document.getElementById('tacGiaID').value = '';
        });

        // ✅ SỬA: Image preview với badges
        function previewImage(input) {
            const container = document.getElementById('imagePreviewContainer');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    container.innerHTML = `
                        <div class="image-container">
                            <img src="${e.target.result}" class="preview-image" alt="Preview">
                            <div class="story-badge vip" id="vipBadge" style="display: none;">
                                <i class="fas fa-crown badge-icon"></i>VIP
                            </div>
                            <div class="story-badge hot" id="hotBadge" style="display: none;">
                                <i class="fas fa-fire badge-icon"></i>HOT
                            </div>
                            <div class="story-badge new" id="newBadge" style="display: none;">
                                <i class="fas fa-star badge-icon"></i>NEW
                            </div>
                        </div>
                        <div class="mt-2">
                            <button type="button" class="btn btn-sm btn-outline-danger" onclick="removeImage()">
                                <i class="fas fa-trash me-1"></i>Xóa ảnh
                            </button>
                        </div>
                    `;
                    
                    // Update badges after creating preview
                    updateBadges();
                }
                
                reader.readAsDataURL(input.files[0]);
            }
        }

        function removeImage() {
            document.getElementById('anhBia').value = '';
            const container = document.getElementById('imagePreviewContainer');
            container.innerHTML = `
                <div class="image-container">
                    <div class="image-placeholder" id="imagePlaceholder">
                        <i class="fas fa-image fa-3x text-muted"></i>
                    </div>
                    <div class="story-badge vip" id="vipBadgePlaceholder" style="display: none;">
                        <i class="fas fa-crown badge-icon"></i>VIP
                    </div>
                    <div class="story-badge hot" id="hotBadgePlaceholder" style="display: none;">
                        <i class="fas fa-fire badge-icon"></i>HOT
                    </div>
                    <div class="story-badge new" id="newBadgePlaceholder" style="display: none;">
                        <i class="fas fa-star badge-icon"></i>NEW
                    </div>
                </div>
            `;
            updateBadges();
        }

        // ✅ THÊM: Hàm cập nhật badges
        function updateBadges() {
            const vipChecked = document.getElementById('vip').checked;
            const hotChecked = document.getElementById('noiBat').checked;
            const newChecked = document.getElementById('truyenMoi').checked;
            
            // Find badge elements (có thể là trên image hoặc placeholder)
            const vipBadge = document.getElementById('vipBadge') || document.getElementById('vipBadgePlaceholder');
            const hotBadge = document.getElementById('hotBadge') || document.getElementById('hotBadgePlaceholder');
            const newBadge = document.getElementById('newBadge') || document.getElementById('newBadgePlaceholder');
            
            if (vipBadge) {
                vipBadge.style.display = vipChecked ? 'flex' : 'none';
            }
            
            if (hotBadge) {
                hotBadge.style.display = hotChecked ? 'flex' : 'none';
            }
            
            if (newBadge) {
                newBadge.style.display = newChecked ? 'flex' : 'none';
            }
        }

        // Drag and drop
        const uploadArea = document.getElementById('uploadArea');
        const fileInput = document.getElementById('anhBia');

        uploadArea.addEventListener('dragover', function(e) {
            e.preventDefault();
            this.classList.add('dragover');
        });

        uploadArea.addEventListener('dragleave', function(e) {
            e.preventDefault();
            this.classList.remove('dragover');
        });

        uploadArea.addEventListener('drop', function(e) {
            e.preventDefault();
            this.classList.remove('dragover');
            
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                fileInput.files = files;
                previewImage(fileInput);
            }
        });

        // Form validation
        document.getElementById('storyForm').addEventListener('submit', function(e) {
            const tacGiaSelect = document.getElementById('tacGiaID').value;
            const tacGiaMoi = document.getElementById('tacGiaMoi').value.trim();
            
            if (!tacGiaSelect && !tacGiaMoi) {
                e.preventDefault();
                alert('Vui lòng chọn tác giả có sẵn hoặc nhập tác giả mới!');
                return false;
            }

            const theLoaiChecked = document.querySelectorAll('input[name="theLoaiID"]:checked');
            if (theLoaiChecked.length === 0) {
                e.preventDefault();
                alert('Vui lòng chọn ít nhất một thể loại!');
                return false;
            }
        });

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            const tacGiaSelect = document.getElementById('tacGiaID');
            const tacGiaMoi = document.getElementById('tacGiaMoi');
            
            if (tacGiaSelect.value) {
                document.getElementById('existingAuthorBtn').click();
            } else if (tacGiaMoi.value) {
                document.getElementById('newAuthorBtn').click();
            } else {
                document.getElementById('existingAuthorBtn').click();
            }
            
            // ✅ THÊM: Initialize badges on page load
            updateBadges();
        });
    </script>
</body>
</html>