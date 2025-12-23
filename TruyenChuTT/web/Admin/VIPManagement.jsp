<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý VIP - TruyenTT</title>
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
            --vip-color: #ffd700;
        }
        
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-color); }
        .sidebar { min-height: 100vh; background: linear-gradient(180deg, var(--primary-color) 0%, var(--secondary-color) 100%); padding: 1.5rem; position: sticky; top: 0; box-shadow: 2px 0 15px rgba(0, 0, 0, 0.1); }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.9); padding: 0.875rem 1.25rem; border-radius: 12px; margin: 0.25rem 0; transition: all 0.3s ease; display: flex; align-items: center; gap: 0.875rem; font-weight: 500; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: rgba(255, 255, 255, 0.2); color: white; transform: translateX(8px); box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); }
        .sidebar .nav-link i { width: 20px; text-align: center; font-size: 1.1rem; }
        .card { border: none; border-radius: 20px; box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08); transition: all 0.3s ease; overflow: hidden; }
        .card:hover { box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12); }
        .card-header { background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); color: white; border-radius: 20px 20px 0 0; padding: 1.5rem; border: none; }
        .table { background: white; border-radius: 15px; overflow: hidden; }
        .table th { background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%); color: #1f2937; font-weight: 600; border: none; padding: 1rem; }
        .table td { vertical-align: middle; padding: 1rem; border-color: #f1f5f9; }
        .main-content { padding: 2.5rem; min-height: 100vh; }
        .table-hover tbody tr:hover { background-color: rgba(79, 70, 229, 0.05); }
        .sidebar-brand { background: rgba(255, 255, 255, 0.1); border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; text-align: center; backdrop-filter: blur(10px); }
        .sidebar-brand h4 { margin: 0; font-weight: 700; font-size: 1.5rem; }
        .sidebar-brand p { margin: 0.5rem 0 0 0; opacity: 0.8; font-size: 0.9rem; }
        .page-header { background: linear-gradient(135deg, white 0%, #f8fafc 100%); border-radius: 20px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); }
        .search-form { position: relative; }
        .search-form .form-control { border-radius: 50px; padding-left: 3rem; background: white; border: 1px solid #e2e8f0; height: 50px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05); }
        .search-form .search-icon { position: absolute; left: 1.25rem; top: 50%; transform: translateY(-50%); color: #94a3b8; }
        .pagination { margin-bottom: 0; }
        .pagination .page-item .page-link { border: none; margin: 0 3px; border-radius: 10px; color: #1f2937; font-weight: 500; padding: 0.5rem 1rem; background-color: white; box-shadow: 0 2px 6px rgba(0,0,0,0.05); }
        .pagination .page-item.active .page-link { background-color: var(--primary-color); color: white; }
        .pagination .page-item .page-link:hover { background-color: #f1f5f9; }
        .pagination .page-item.active .page-link:hover { background-color: var(--primary-color); }
        .action-buttons .dropdown-menu { border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); border: none; padding: 1rem; }
        .action-buttons .dropdown-item { border-radius: 10px; padding: 0.75rem 1.25rem; transition: all 0.2s ease; }
        .action-buttons .dropdown-item:hover { background-color: #f1f5f9; }
        .action-buttons .dropdown-item i { margin-right: 10px; width: 18px; }
        .modal-content { border-radius: 20px; border: none; overflow: hidden; }
        .modal-header { background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); color: white; border: none; padding: 1.5rem; }
        .modal-footer { border-top: 1px solid #f1f5f9; padding: 1.25rem; }
        .empty-state { padding: 3rem; text-align: center; color: #6b7280; }
        .empty-state i { font-size: 4rem; margin-bottom: 1.5rem; opacity: 0.3; }
        .vip-badge { background: linear-gradient(135deg, var(--vip-color) 0%, #ffed4e 100%); color: #92400e; padding: 0.4rem 0.8rem; border-radius: 15px; font-weight: 600; font-size: 0.8rem; }
        .package-card { border: 2px solid #e2e8f0; border-radius: 15px; transition: all 0.3s ease; }
        .package-card:hover { border-color: var(--primary-color); transform: translateY(-5px); }
        .package-card.featured { border-color: var(--vip-color); background: linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%); }
        .nav-tabs .nav-link { border: none; border-radius: 10px 10px 0 0; margin-right: 0.5rem; padding: 1rem 1.5rem; background: white; color: #6b7280; transition: all 0.3s ease; }
        .nav-tabs .nav-link.active { background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); color: white; }
        .nav-tabs { border-bottom: none; margin-bottom: 1.5rem; }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/vip">
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
                    <div class="page-header d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="fw-bold mb-1">
                                <i class="fas fa-crown text-warning me-2"></i>Quản lý VIP
                            </h2>
                            <p class="text-muted mb-0">Quản lý người dùng VIP và gói VIP</p>
                        </div>
                    </div>

                    <!-- Messages -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>Lỗi!</strong> ${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            <strong>Thành công!</strong> ${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Navigation Tabs -->
                    <ul class="nav nav-tabs" id="vipTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${activeTab == 'users' ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/admin/vip?tab=users">
                                <i class="fas fa-users me-2"></i>Người dùng VIP
                            </a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${activeTab == 'packages' ? 'active' : ''}" 
                               href="${pageContext.request.contextPath}/admin/vip?tab=packages">
                                <i class="fas fa-box me-2"></i>Gói VIP
                            </a>
                        </li>
                    </ul>

                    <!-- Tab Content -->
                    <div class="tab-content" id="vipTabsContent">
                        <!-- User Management Tab -->
                        <c:if test="${activeTab == 'users'}">
                            <div class="tab-pane fade show active">
                                <!-- Search Users -->
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <form class="search-form" action="${pageContext.request.contextPath}/admin/vip" method="GET">
                                                    <input type="hidden" name="action" value="searchUsers">
                                                    <input type="hidden" name="tab" value="users">
                                                    <i class="fas fa-search search-icon"></i>
                                                    <input type="text" class="form-control" name="searchTerm" 
                                                           placeholder="Tìm kiếm người dùng..." value="${searchTerm}">
                                                </form>
                                            </div>
                                            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                                                <c:if test="${isSearchResult}">
                                                    <a href="${pageContext.request.contextPath}/admin/vip?tab=users" class="btn btn-outline-secondary">
                                                        <i class="fas fa-undo me-2"></i>Quay lại danh sách
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- User List -->
                                <div class="card">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <h5 class="mb-0 fw-bold">
                                            <i class="fas fa-users me-2"></i>Danh sách người dùng
                                        </h5>
                                        <span class="badge bg-light text-dark">
                                            Tổng: ${totalUsers} người dùng
                                        </span>
                                    </div>
                                    <div class="card-body p-0">
                                        <c:choose>
                                            <c:when test="${empty userList}">
                                                <div class="empty-state">
                                                    <i class="fas fa-users"></i>
                                                    <h4>Không tìm thấy người dùng nào</h4>
                                                    <p class="mb-4">Chưa có người dùng nào trong hệ thống hoặc không tìm thấy kết quả phù hợp.</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="table-responsive">
                                                    <table class="table table-hover mb-0">
                                                        <thead>
                                                            <tr>
                                                                <th>ID</th>
                                                                <th>Tên người dùng</th>
                                                                <th>Email</th>
                                                                <th>Trạng thái VIP</th>
                                                                <th>Ngày đăng ký</th>
                                                                <th class="text-center">Thao tác</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${userList}" var="user">
                                                                <tr>
                                                                    <td>${user.id}</td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <div>
                                                                                <div class="fw-medium">${user.hoTen}</div>
                                                                                <small class="text-muted">${user.soDienThoai}</small>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td>${user.email}</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${user.trangThaiVIP}">
                                                                                <span class="vip-badge">
                                                                                    <i class="fas fa-crown me-1"></i>VIP
                                                                                </span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="badge bg-secondary">Thường</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>${user.ngayTaoFormatted}</td>
                                                                    <td class="text-center action-buttons">
                                                                        <div class="dropdown">
                                                                            <button class="btn btn-sm btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                                                <i class="fas fa-ellipsis-h"></i>
                                                                            </button>
                                                                            <ul class="dropdown-menu dropdown-menu-end">
                                                                                <li>
                                                                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/vip?action=viewUser&id=${user.id}">
                                                                                        <i class="fas fa-eye text-info"></i> Xem chi tiết
                                                                                    </a>
                                                                                </li>
                                                                                <c:choose>
                                                                                    <c:when test="${user.trangThaiVIP}">
                                                                                        <li>
                                                                                            <a class="dropdown-item" href="#" onclick="confirmRevokeVIP(${user.id}, '${user.hoTen}')">
                                                                                                <i class="fas fa-times text-danger"></i> Thu hồi VIP
                                                                                            </a>
                                                                                        </li>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <li>
                                                                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/vip?action=viewUser&id=${user.id}">
                                                                                                <i class="fas fa-crown text-warning"></i> Cấp VIP
                                                                                            </a>
                                                                                        </li>
                                                                                    </c:otherwise>
                                                                                </c:choose>
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
                                    </div>
                                    
                                    <!-- Pagination -->
                                    <c:if test="${not isSearchResult && totalPages > 1}">
                                        <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                                            <div class="text-muted small">
                                                Hiển thị ${userList.size()} / ${totalUsers} người dùng
                                            </div>
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination">
                                                    <c:if test="${currentPage > 1}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/vip?tab=users&page=${currentPage - 1}&pageSize=${pageSize}">
                                                                <i class="fas fa-chevron-left small"></i>
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                    
                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                        <c:choose>
                                                            <c:when test="${i == currentPage}">
                                                                <li class="page-item active">
                                                                    <span class="page-link">${i}</span>
                                                                </li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li class="page-item">
                                                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/vip?tab=users&page=${i}&pageSize=${pageSize}">${i}</a>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                    
                                                    <c:if test="${currentPage < totalPages}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/vip?tab=users&page=${currentPage + 1}&pageSize=${pageSize}">
                                                                <i class="fas fa-chevron-right small"></i>
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </nav>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>

                        <!-- Package Management Tab -->
                        <c:if test="${activeTab == 'packages'}">
                            <div class="tab-pane fade show active">
                                <!-- Add Package Button -->
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h5 class="mb-0">Danh sách gói VIP</h5>
                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPackageModal">
                                        <i class="fas fa-plus me-2"></i>Thêm gói VIP
                                    </button>
                                </div>

                                <!-- Package List -->
                                <c:choose>
                                    <c:when test="${empty packageList}">
                                        <div class="empty-state">
                                            <i class="fas fa-box"></i>
                                            <h4>Chưa có gói VIP nào</h4>
                                            <p class="mb-4">Hãy thêm gói VIP đầu tiên để bắt đầu.</p>
                                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPackageModal">
                                                <i class="fas fa-plus me-2"></i>Thêm gói VIP
                                            </button>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="row">
                                            <c:forEach items="${packageList}" var="pkg">
                                                <div class="col-md-6 col-lg-4 mb-4">
                                                    <div class="package-card card h-100 ${pkg.noiBat ? 'featured' : ''}">
                                                        <div class="card-body">
                                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                                <div>
                                                                    <h6 class="card-title fw-bold">${pkg.tenGoi}</h6>
                                                                    <c:if test="${pkg.noiBat}">
                                                                        <span class="badge bg-warning text-dark">
                                                                            <i class="fas fa-star me-1"></i>Nổi bật
                                                                        </span>
                                                                    </c:if>
                                                                </div>
                                                                <div class="dropdown">
                                                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                                        <i class="fas fa-ellipsis-h"></i>
                                                                    </button>
                                                                    <ul class="dropdown-menu">
                                                                        <li>
                                                                            <a class="dropdown-item" href="#" onclick="editPackage(${pkg.id}, '${pkg.tenGoi}', '${pkg.moTa}', ${pkg.soThang}, ${pkg.gia}, ${pkg.giaGoc != null ? pkg.giaGoc : 'null'}, '${pkg.mauSac}', '${pkg.icon}', ${pkg.trangThai}, ${pkg.thuTu}, ${pkg.noiBat})">
                                                                                <i class="fas fa-edit text-warning"></i> Sửa
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a class="dropdown-item" href="#" onclick="confirmDeletePackage(${pkg.id}, '${pkg.tenGoi}')">
                                                                                <i class="fas fa-trash text-danger"></i> Xóa
                                                                            </a>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            
                                                            <p class="text-muted small">${pkg.moTa}</p>
                                                            
                                                            <div class="mb-3">
                                                                <div class="d-flex align-items-center justify-content-between">
                                                                    <div>
                                                                        <span class="h5 fw-bold text-primary">${pkg.giaFormatted} ₫</span>
                                                                        <c:if test="${pkg.giaGoc != null && pkg.giaGoc > pkg.gia}">
                                                                            <span class="text-muted text-decoration-line-through ms-2">${pkg.giaGocFormatted} ₫</span>
                                                                            <span class="badge bg-danger ms-1">-${pkg.phanTramGiamGia}%</span>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                                <small class="text-muted">${pkg.soThang} tháng</small>
                                                            </div>
                                                            
                                                            <div class="d-flex justify-content-between align-items-center">
                                                                <span class="badge ${pkg.trangThai ? 'bg-success' : 'bg-secondary'}">
                                                                    ${pkg.trangThai ? 'Hoạt động' : 'Tạm dừng'}
                                                                </span>
                                                                <small class="text-muted">Thứ tự: ${pkg.thuTu}</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Package Modal -->
    <div class="modal fade" id="addPackageModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="fas fa-plus me-2"></i>Thêm gói VIP</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/vip" method="POST">
                    <input type="hidden" name="action" value="addPackage">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên gói <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="tenGoi" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số tháng <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="soThang" min="1" required>
                            </div>
                            <div class="col-12 mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea class="form-control" name="moTa" rows="3"></textarea>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Giá bán <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="gia" min="0" step="0.01" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Giá gốc</label>
                                <input type="number" class="form-control" name="giaGoc" min="0" step="0.01">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Màu sắc</label>
                                <input type="color" class="form-control" name="mauSac" value="#ffd700">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Icon</label>
                                <input type="text" class="form-control" name="icon" value="fas fa-crown">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Thứ tự</label>
                                <input type="number" class="form-control" name="thuTu" value="0">
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-check mt-4">
                                    <input class="form-check-input" type="checkbox" name="trangThai" value="true" checked>
                                    <label class="form-check-label">Hoạt động</label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-check mt-4">
                                    <input class="form-check-input" type="checkbox" name="noiBat" value="true">
                                    <label class="form-check-label">Nổi bật</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Lưu gói VIP
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Edit Package Modal -->
    <div class="modal fade" id="editPackageModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="fas fa-edit me-2"></i>Sửa gói VIP</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/vip" method="POST">
                    <input type="hidden" name="action" value="editPackage">
                    <input type="hidden" name="id" id="edit_id">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên gói <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="tenGoi" id="edit_tenGoi" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số tháng <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="soThang" id="edit_soThang" min="1" required>
                            </div>
                            <div class="col-12 mb-3">
                                <label class="form-label">Mô tả</label>
                                <textarea class="form-control" name="moTa" id="edit_moTa" rows="3"></textarea>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Giá bán <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" name="gia" id="edit_gia" min="0" step="0.01" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Giá gốc</label>
                                <input type="number" class="form-control" name="giaGoc" id="edit_giaGoc" min="0" step="0.01">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Màu sắc</label>
                                <input type="color" class="form-control" name="mauSac" id="edit_mauSac">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Icon</label>
                                <input type="text" class="form-control" name="icon" id="edit_icon">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Thứ tự</label>
                                <input type="number" class="form-control" name="thuTu" id="edit_thuTu">
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-check mt-4">
                                    <input class="form-check-input" type="checkbox" name="trangThai" id="edit_trangThai" value="true">
                                    <label class="form-check-label">Hoạt động</label>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="form-check mt-4">
                                    <input class="form-check-input" type="checkbox" name="noiBat" id="edit_noiBat" value="true">
                                    <label class="form-check-label">Nổi bật</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Cập nhật
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div class="modal fade" id="confirmationModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="confirmationTitle">Xác nhận</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4" id="confirmationBody">
                    Bạn có chắc chắn muốn thực hiện hành động này?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-danger" id="confirmActionBtn">
                        <i class="fas fa-check me-2"></i>Xác nhận
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Hidden Forms -->
    <form id="revokeVIPForm" action="${pageContext.request.contextPath}/admin/vip" method="POST" style="display: none;">
        <input type="hidden" name="action" value="revokeVIP">
        <input type="hidden" name="userId" id="revokeUserId">
    </form>

    <form id="deletePackageForm" action="${pageContext.request.contextPath}/admin/vip" method="POST" style="display: none;">
        <input type="hidden" name="action" value="deletePackage">
        <input type="hidden" name="id" id="deletePackageId">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmRevokeVIP(userId, userName) {
            document.getElementById("confirmationTitle").innerText = "Xác nhận thu hồi VIP";
            document.getElementById("confirmationBody").innerHTML = 'Bạn có chắc chắn muốn <strong>thu hồi VIP</strong> của người dùng <strong>' + userName + '</strong>?';
            const modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
            modal.show();
            document.getElementById("confirmActionBtn").onclick = function () {
                document.getElementById("revokeUserId").value = userId;
                document.getElementById("revokeVIPForm").submit();
            };
        }

        function confirmDeletePackage(packageId, packageName) {
            document.getElementById("confirmationTitle").innerText = "Xác nhận xóa gói VIP";
            document.getElementById("confirmationBody").innerHTML = 'Bạn có chắc chắn muốn <strong>xóa</strong> gói VIP <strong>' + packageName + '</strong>?';
            const modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
            modal.show();
            document.getElementById("confirmActionBtn").onclick = function () {
                document.getElementById("deletePackageId").value = packageId;
                document.getElementById("deletePackageForm").submit();
            };
        }

        function editPackage(id, tenGoi, moTa, soThang, gia, giaGoc, mauSac, icon, trangThai, thuTu, noiBat) {
            document.getElementById("edit_id").value = id;
            document.getElementById("edit_tenGoi").value = tenGoi;
            document.getElementById("edit_moTa").value = moTa;
            document.getElementById("edit_soThang").value = soThang;
            document.getElementById("edit_gia").value = gia;
            document.getElementById("edit_giaGoc").value = giaGoc !== 'null' ? giaGoc : '';
            document.getElementById("edit_mauSac").value = mauSac;
            document.getElementById("edit_icon").value = icon;
            document.getElementById("edit_thuTu").value = thuTu;
            document.getElementById("edit_trangThai").checked = trangThai;
            document.getElementById("edit_noiBat").checked = noiBat;
            
            const modal = new bootstrap.Modal(document.getElementById("editPackageModal"));
            modal.show();
        }
    </script>
</body>
</html>