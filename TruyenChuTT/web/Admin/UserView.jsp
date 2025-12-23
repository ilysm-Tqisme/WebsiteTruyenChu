<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết người dùng - TruyenTT</title>
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
        .main-content { padding: 2.5rem; min-height: 100vh; }
        .badge-role { padding: 0.5rem 1rem; border-radius: 25px; font-weight: 600; font-size: 0.75rem; }
        .sidebar-brand { background: rgba(255, 255, 255, 0.1); border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; text-align: center; backdrop-filter: blur(10px); }
        .sidebar-brand h4 { margin: 0; font-weight: 700; font-size: 1.5rem; }
        .sidebar-brand p { margin: 0.5rem 0 0 0; opacity: 0.8; font-size: 0.9rem; }
        .page-header { background: linear-gradient(135deg, white 0%, #f8fafc 100%); border-radius: 20px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); }
        .user-avatar { width: 120px; height: 120px; border-radius: 50%; overflow: hidden; border: 4px solid white; box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1); margin: 0 auto; }
        .user-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .user-info-label { color: #64748b; font-size: 0.9rem; font-weight: 500; }
        .user-info-value { font-weight: 600; color: #0f172a; font-size: 1.05rem; }
        .user-action-btn { border-radius: 12px; padding: 0.75rem 1.5rem; font-weight: 500; transition: all 0.3s ease; }
        .user-action-btn:hover { transform: translateY(-3px); box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); }
        .status-badge { padding: 0.5rem 1rem; border-radius: 25px; font-weight: 600; font-size: 0.9rem; }
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
                            <h2 class="fw-bold mb-1">Chi tiết người dùng</h2>
                            <p class="text-muted mb-0">
                                Xem và quản lý thông tin người dùng
                            </p>
                        </div>
                        <div>
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-primary">
                                <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
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

                    <!-- User Details -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0 fw-bold"><i class="fas fa-user me-2"></i>Thông tin người dùng</h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="row">
                                <div class="col-md-4 text-center mb-4 mb-md-0">
                                    <div class="user-avatar mb-3 text-center">
    <c:choose>
        <c:when test="${not empty selectedUser.anhDaiDien}">
    <img src="${pageContext.request.contextPath}/${selectedUser.anhDaiDien}" 
         alt="${selectedUser.hoTen}" class="img-fluid rounded-circle" style="width: 150px; height: 150px;">
</c:when>

        <c:otherwise>
            <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png" 
                 alt="Default Avatar" class="img-fluid rounded-circle" style="width: 150px; height: 150px;">
        </c:otherwise>
    </c:choose>
</div>

                                    <h4 class="fw-bold mb-1">${selectedUser.hoTen}</h4>
                                    <p class="text-muted mb-2">${selectedUser.email}</p>
                                    <span class="badge badge-role ${selectedUser.vaiTro == 'ADMIN' ? 'bg-danger' : 'bg-primary'} mb-3">
                                        ${selectedUser.vaiTro}
                                    </span>
                                    <p>
                                        <span class="badge status-badge ${selectedUser.trangThai ? 'bg-success' : 'bg-secondary'}">
                                            ${selectedUser.trangThai ? 'Hoạt động' : 'Bị khóa'}
                                        </span>
                                    </p>
                                    
                                    <!-- Quick action buttons -->
                                    <div class="mt-4 d-flex flex-column gap-2">
                                        <button type="button" class="btn btn-outline-primary user-action-btn" 
                                                onclick="openPasswordModal(${selectedUser.id}, '${selectedUser.hoTen}')">
                                            <i class="fas fa-key me-2"></i>Đổi mật khẩu
                                        </button>
                                        
                                        <c:choose>
                                            <c:when test="${selectedUser.trangThai}">
                                                <button type="button" class="btn btn-outline-secondary user-action-btn"
                                                        onclick="confirmStatusChange(${selectedUser.id}, false, '${selectedUser.hoTen}')">
                                                    <i class="fas fa-lock me-2"></i>Khóa tài khoản
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn btn-outline-success user-action-btn"
                                                        onclick="confirmStatusChange(${selectedUser.id}, true, '${selectedUser.hoTen}')">
                                                    <i class="fas fa-unlock me-2"></i>Mở khóa tài khoản
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <button type="button" class="btn btn-outline-danger user-action-btn"
                                                onclick="confirmDelete(${selectedUser.id}, '${selectedUser.hoTen}')">
                                            <i class="fas fa-trash-alt me-2"></i>Xóa người dùng
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-md-6 mb-4">
                                            <div class="user-info-label">ID</div>
                                            <div class="user-info-value">${selectedUser.id}</div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="user-info-label">Họ và tên</div>
                                            <div class="user-info-value">${selectedUser.hoTen}</div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="user-info-label">Email</div>
                                            <div class="user-info-value">${selectedUser.email}</div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="user-info-label">Số điện thoại</div>
                                            <div class="user-info-value">${empty selectedUser.soDienThoai ? 'Chưa cập nhật' : selectedUser.soDienThoai}</div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="user-info-label">Vai trò</div>
                                            <div class="user-info-value">${selectedUser.vaiTro}</div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="user-info-label">Trạng thái</div>
                                            <div class="user-info-value">${selectedUser.trangThai ? 'Hoạt động' : 'Bị khóa'}</div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="user-info-label">Ngày đăng ký</div>
                                            <div class="user-info-value">
                                               ${selectedUser.ngayTaoFormatted}
                                            </div>
                                        </div>
                                            <div class="col-md-6 mb-4">
                                            <div class="user-info-label">Trạng thái VIP</div>
                                            <div class="user-info-value">
                                               ${selectedUser.ngayTaoFormatted}
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-4">
                                        <h6 class="fw-bold">Hoạt động gần đây</h6>
                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item px-0">
                                                <p class="mb-0 text-muted">Chức năng thống kê hoạt động gần đây sẽ được cập nhật trong phiên bản tiếp theo.</p>
                                            </li>
                                        </ul>
                                    </div>
                        
                                </div>
                            </div>
                        </div>
                    </div>
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
            console.log("Gửi vào modal:", userName); // 👈 kiểm tra đầu vào
            
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