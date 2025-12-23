<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý người dùng - TruyenTT</title>
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
        /* CSS styles from Admin template */
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
        .badge-role { padding: 0.5rem 1rem; border-radius: 25px; font-weight: 600; font-size: 0.75rem; }
        .table-hover tbody tr:hover { background-color: rgba(79, 70, 229, 0.05); }
        .sidebar-brand { background: rgba(255, 255, 255, 0.1); border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; text-align: center; backdrop-filter: blur(10px); }
        .sidebar-brand h4 { margin: 0; font-weight: 700; font-size: 1.5rem; }
        .sidebar-brand p { margin: 0.5rem 0 0 0; opacity: 0.8; font-size: 0.9rem; }
        .page-header { background: linear-gradient(135deg, white 0%, #f8fafc 100%); border-radius: 20px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); }
        .search-form { position: relative; }
        .search-form .form-control { border-radius: 50px; padding-left: 3rem; background: white; border: 1px solid #e2e8f0; height: 50px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05); }
        .search-form .search-icon { position: absolute; left: 1.25rem; top: 50%; transform: translateY(-50%); color: #94a3b8; }
        .btn-action { width: 40px; height: 40px; border-radius: 12px; display: inline-flex; align-items: center; justify-content: center; transition: all 0.3s ease; margin: 0 0.2rem; }
        .btn-action:hover { transform: translateY(-3px); }
        .status-badge { padding: 0.5rem 1rem; border-radius: 25px; font-weight: 600; }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
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
                    <div class="page-header d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="fw-bold mb-1">Quản lý người dùng</h2>
                            <p class="text-muted mb-0">
                                <c:choose>
                                    <c:when test="${isSearchResult}">
                                            Kết quả tìm kiếm: ${totalUsers} người dùng
                                    </c:when>
                                    <c:otherwise>
                                            Tổng cộng: ${totalUsers} người dùng<br/>
                                            Tổng cộng: ${totalUsersVIP} người dùng VIP
                                    </c:otherwise>
                                </c:choose>

                            </p>
                        </div>
                        <div>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                <i class="fas fa-user-plus me-2"></i>Thêm người dùng
                            </button>
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

                    <!-- Search and Filter -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <form class="search-form" action="${pageContext.request.contextPath}/admin/users" method="GET">
                                        <input type="hidden" name="action" value="search">
                                        <i class="fas fa-search search-icon"></i>
                                        <input type="text" class="form-control" name="searchTerm" placeholder="Tìm kiếm theo tên, email..." value="${searchTerm}">
                                    </form>
                                </div>
                                <div class="col-md-4 text-md-end mt-3 mt-md-0">
                                    <c:if test="${isSearchResult}">
                                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary">
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
                            <h5 class="mb-0 fw-bold"><i class="fas fa-users me-2"></i>Danh sách người dùng</h5>
                            <div>
                                <div class="dropdown d-inline-block">
                                    <button class="btn btn-sm btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        Số dòng: ${pageSize}
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users?page=1&pageSize=10">10</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users?page=1&pageSize=25">25</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users?page=1&pageSize=50">50</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${empty userList}">
                                    <div class="empty-state">
                                        <i class="fas fa-users"></i>
                                        <h4>Không tìm thấy người dùng nào</h4>
                                        <p class="mb-4">Chưa có người dùng nào trong hệ thống hoặc không tìm thấy kết quả phù hợp.</p>
                                        <c:if test="${isSearchResult}">
                                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary">
                                                <i class="fas fa-list me-2"></i>Xem tất cả người dùng
                                            </a>
                                        </c:if>
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
                                                    <th>Vai trò</th>
                                                    <th>Trạng thái</th>
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
                                                            <span class="badge badge-role ${user.vaiTro == 'ADMIN' ? 'bg-danger' : 'bg-primary'}">
                                                                ${user.vaiTro}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span class="badge status-badge ${user.trangThai ? 'bg-success' : 'bg-secondary'}">
                                                                ${user.trangThai ? 'Hoạt động' : 'Bị khóa'}
                                                            </span>
                                                        </td>
                                                        <td>${user.ngayTaoFormatted}</td>
                                                        <td class="text-center action-buttons">
                                                            <div class="dropdown">
                                                                <button class="btn btn-sm btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                                    <i class="fas fa-ellipsis-h"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li>
                                                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/users?action=view&id=${user.id}">
                                                                            <i class="fas fa-eye text-info"></i> Xem chi tiết
                                                                        </a>
                                                                    </li>
                                                                    <li>
                                                                        <a class="dropdown-item" href="#" onclick="openPasswordModal(${user.id}, '${user.hoTen}')">
                                                                            <i class="fas fa-key text-warning"></i> Đổi mật khẩu
                                                                        </a>
                                                                    </li>
                                                                    <li>
                                                                        <c:choose>
                                                                            <c:when test="${user.trangThai}">
                                                                                <a class="dropdown-item" href="#" onclick="confirmStatusChange(${user.id}, false, '${user.hoTen}')">
                                                                                    <i class="fas fa-lock text-secondary"></i> Khóa tài khoản
                                                                                </a>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <a class="dropdown-item" href="#" onclick="confirmStatusChange(${user.id}, true, '${user.hoTen}')">
                                                                                    <i class="fas fa-unlock text-success"></i> Mở khóa tài khoản
                                                                                </a>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </li>
                                                                    <li><hr class="dropdown-divider"></li>
                                                                    <li>
                                                                        <a class="dropdown-item text-danger" href="#" onclick="confirmDelete(${user.id}, '${user.hoTen}')">
                                                                            <i class="fas fa-trash-alt"></i> Xóa người dùng
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
                                                <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 1}&pageSize=${pageSize}">
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
                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${i}&pageSize=${pageSize}">${i}</a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage + 1}&pageSize=${pageSize}">
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
            </div>
        </div>
    </div>
    
    <!-- Add User Modal -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="fas fa-user-plus me-2"></i>Thêm người dùng mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <form id="addUserForm" action="${pageContext.request.contextPath}/admin/users/add" method="POST">
                        <div class="mb-3">
                            <label for="hoTen" class="form-label">Họ tên <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="hoTen" name="hoTen" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="soDienThoai" class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" id="soDienThoai" name="soDienThoai">
                        </div>
                        <div class="mb-3">
                            <label for="matKhau" class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="matKhau" name="matKhau" required>
                        </div>
                        <div class="mb-3">
                            <label for="vaiTro" class="form-label">Vai trò <span class="text-danger">*</span></label>
                            <select class="form-select" id="vaiTro" name="vaiTro" required>
                                <option value="USER">USER</option>
                                <option value="ADMIN">ADMIN</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="trangThai" class="form-label">Trạng thái tài khoản</label>
                            <select class="form-select" id="trangThai" name="trangThai">
                                <option value="true" selected>Hoạt động</option>
                                <option value="false">Bị khóa</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" form="addUserForm" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Lưu người dùng
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Change Password Modal -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="fas fa-key me-2"></i>Đổi mật khẩu</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <form id="changePasswordForm" action="${pageContext.request.contextPath}/admin/users" method="POST">
                        <input type="hidden" name="action" value="changePassword">
                        <input type="hidden" id="passwordUserId" name="userId" value="">
                        <div class="mb-3">
                            <p>Đổi mật khẩu cho người dùng: <strong id="passwordUserName"></strong></p>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Mật khẩu mới <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                            <div id="passwordError" class="invalid-feedback">Mật khẩu xác nhận không khớp</div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                    <button type="button" onclick="validateAndSubmitPasswordForm()" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Lưu mật khẩu
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Status Change Form (hidden) -->
    <form id="statusForm" action="${pageContext.request.contextPath}/admin/users" method="POST" style="display: none;">
        <input type="hidden" name="action" value="changeStatus">
        <input type="hidden" id="statusUserId" name="userId" value="">
        <input type="hidden" id="statusValue" name="status" value="">
    </form>
    
    <!-- Delete User Form (hidden) -->
    <form id="deleteForm" action="${pageContext.request.contextPath}/admin/users" method="POST" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" id="deleteUserId" name="userId" value="">
    </form>

    <!-- Confirmation Modal -->
    <div class="modal fade" id="confirmationModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="confirmationTitle">Xác nhận</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
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

    <!-- Bootstrap JS và các đoạn script xử lý -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openPasswordModal(userId, userName) {
            document.getElementById("passwordUserId").value = userId;
            document.getElementById("passwordUserName").textContent = userName;
            document.getElementById("newPassword").value = "";
            document.getElementById("confirmPassword").value = "";
            document.getElementById("passwordError").style.display = "none";
            const modal = new bootstrap.Modal(document.getElementById("changePasswordModal"));
            modal.show();
        }

        function validateAndSubmitPasswordForm() {
            const newPassword = document.getElementById("newPassword").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            const errorDiv = document.getElementById("passwordError");

            if (newPassword !== confirmPassword) {
                errorDiv.style.display = "block";
                document.getElementById("confirmPassword").classList.add("is-invalid");
                return;
            }
            errorDiv.style.display = "none";
            document.getElementById("confirmPassword").classList.remove("is-invalid");
            document.getElementById("changePasswordForm").submit();
        }

        function confirmStatusChange(userId, status, userName) {
            const statusText = status ? 'mở khóa' : 'khóa';
            document.getElementById("confirmationTitle").innerText = "Xác nhận thay đổi trạng thái";
            document.getElementById("confirmationBody").innerHTML = `Bạn có chắc chắn muốn <strong>${statusText}</strong> tài khoản của <strong>${userName}</strong>?`;
            const modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
            modal.show();
            document.getElementById("confirmActionBtn").onclick = function () {
                document.getElementById("statusUserId").value = userId;
                document.getElementById("statusValue").value = status;
                document.getElementById("statusForm").submit();
            };
        }

        function confirmDelete(userId, userName) {
            document.getElementById("confirmationTitle").innerText = "Xác nhận xóa người dùng";
            document.getElementById("confirmationBody").innerHTML = `Bạn có chắc chắn muốn <strong>xóa</strong> người dùng <strong>${userName}</strong>? Hành động này không thể hoàn tác.`;
            const modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
            modal.show();
            document.getElementById("confirmActionBtn").onclick = function () {
                document.getElementById("deleteUserId").value = userId;
                document.getElementById("deleteForm").submit();
            };
        }
    </script>
</body>
</html>
