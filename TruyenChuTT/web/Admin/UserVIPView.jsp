<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết người dùng VIP - TruyenTT</title>
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
        .main-content { padding: 2.5rem; min-height: 100vh; }
        .sidebar-brand { background: rgba(255, 255, 255, 0.1); border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; text-align: center; backdrop-filter: blur(10px); }
        .sidebar-brand h4 { margin: 0; font-weight: 700; font-size: 1.5rem; }
        .sidebar-brand p { margin: 0.5rem 0 0 0; opacity: 0.8; font-size: 0.9rem; }
        .page-header { background: linear-gradient(135deg, white 0%, #f8fafc 100%); border-radius: 20px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); }
        .user-avatar { width: 120px; height: 120px; border-radius: 50%; overflow: hidden; border: 4px solid white; box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1); margin: 0 auto; }
        .user-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .user-info-label { color: #64748b; font-size: 0.9rem; font-weight: 500; }
        .user-info-value { font-weight: 600; color: #0f172a; font-size: 1.05rem; }
        .vip-badge { background: linear-gradient(135deg, var(--vip-color) 0%, #ffed4e 100%); color: #92400e; padding: 0.5rem 1rem; border-radius: 15px; font-weight: 600; }
        .vip-info-card { background: linear-gradient(135deg, #fffbeb 0%, #fef3c7 100%); border-left: 5px solid var(--vip-color); }
        .modal-content { border-radius: 20px; border: none; overflow: hidden; }
        .modal-header { background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); color: white; border: none; padding: 1.5rem; }
        .modal-footer { border-top: 1px solid #f1f5f9; padding: 1.25rem; }
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
                            <h2 class="fw-bold mb-1">Chi tiết người dùng VIP</h2>
                            <p class="text-muted mb-0">Xem và quản lý thông tin VIP của người dùng</p>
                        </div>
                        <div>
                            <a href="${pageContext.request.contextPath}/admin/vip?tab=users" class="btn btn-outline-primary">
                                <i class="fas fa-arrow-left me-2"></i>Quay lại
                            </a>
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

                    <!-- User Info Card -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0 fw-bold">
                                <i class="fas fa-user me-2"></i>Thông tin người dùng
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4 text-center mb-4 mb-md-0">
                                    <div class="user-avatar mb-3">
                                        <c:choose>
                                            <c:when test="${not empty selectedUser.anhDaiDien}">
                                                <img src="${pageContext.request.contextPath}/${selectedUser.anhDaiDien}" 
                                                     alt="${selectedUser.hoTen}" class="img-fluid">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png" 
                                                     alt="Default Avatar" class="img-fluid">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <h4 class="fw-bold mb-1">${selectedUser.hoTen}</h4>
                                    <p class="text-muted mb-2">${selectedUser.email}</p>
                                    
                                    <!-- VIP Status -->
                                    <c:choose>
                                        <c:when test="${selectedUser.trangThaiVIP}">
                                            <span class="vip-badge mb-3 d-inline-block">
                                                <i class="fas fa-crown me-1"></i>VIP
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary mb-3">Thường</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <div class="user-info-label">ID</div>
                                            <div class="user-info-value">${selectedUser.id}</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="user-info-label">Họ và tên</div>
                                            <div class="user-info-value">${selectedUser.hoTen}</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="user-info-label">Email</div>
                                            <div class="user-info-value">${selectedUser.email}</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="user-info-label">Số điện thoại</div>
                                            <div class="user-info-value">${empty selectedUser.soDienThoai ? 'Chưa cập nhật' : selectedUser.soDienThoai}</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="user-info-label">Ngày đăng ký</div>
                                            <div class="user-info-value">${selectedUser.ngayTaoFormatted}</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="user-info-label">Trạng thái VIP</div>
                                            <div class="user-info-value">
                                                <c:choose>
                                                    <c:when test="${selectedUser.trangThaiVIP}">
                                                        <span class="text-warning fw-bold">
                                                            <i class="fas fa-crown me-1"></i>VIP
                                                        </span>
                                                        <c:if test="${selectedUser.ngayHetHanVIP != null}">
                                                            <br><small class="text-muted">Hết hạn: ${selectedUser.ngayHetHanVIPFormatted}</small>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Thường</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- VIP Info Card -->
                    <c:choose>
                        <c:when test="${currentVIP != null}">
                            <!-- Current VIP Info -->
                            <div class="card vip-info-card mb-4">
                                <div class="card-header bg-transparent">
                                    <h5 class="mb-0 fw-bold text-warning">
                                        <i class="fas fa-crown me-2"></i>Thông tin VIP hiện tại
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-3 mb-3">
                                            <div class="user-info-label">Loại VIP</div>
                                            <div class="user-info-value">${currentVIP.loaiVIP}</div>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <div class="user-info-label">Ngày bắt đầu</div>
                                            <div class="user-info-value">${currentVIP.ngayBatDauFormatted}</div>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <div class="user-info-label">Ngày kết thúc</div>
                                            <div class="user-info-value">${currentVIP.ngayKetThucFormatted}</div>
                                        </div>
                                        <div class="col-md-3 mb-3">
                                            <div class="user-info-label">Giá VIP</div>
                                            <div class="user-info-value">${currentVIP.giaVIPFormatted}</div>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-3">
                                        <button type="button" class="btn btn-danger" onclick="confirmRevokeVIP(${selectedUser.id}, '${selectedUser.hoTen}')">
                                            <i class="fas fa-times me-2"></i>Thu hồi VIP
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Grant VIP Card -->
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0 fw-bold">
                                        <i class="fas fa-crown me-2"></i>Cấp VIP cho người dùng
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/admin/vip" method="POST">
                                        <input type="hidden" name="action" value="grantVIP">
                                        <input type="hidden" name="userId" value="${selectedUser.id}">
                                        
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Chọn gói VIP <span class="text-danger">*</span></label>
                                                <select class="form-select" name="packageId" required onchange="updateEndDate()">
                                                    <option value="">-- Chọn gói VIP --</option>
                                                    <c:forEach items="${vipPackages}" var="pkg">
                                                        <option value="${pkg.id}" data-months="${pkg.soThang}">
                                                            ${pkg.tenGoi} - ${pkg.soThang} tháng - ${pkg.giaFormatted} ₫
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Ngày bắt đầu <span class="text-danger">*</span></label>
                                                <input type="date" class="form-control" name="startDate" id="startDate" required onchange="updateEndDate()">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Ngày kết thúc (tự động tính)</label>
                                                <input type="text" class="form-control" id="endDate" readonly 
                                                       placeholder="Sẽ được tính tự động">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Giá VIP</label>
                                                <input type="text" class="form-control" id="packagePrice" readonly 
                                                       placeholder="Chọn gói để xem giá">
                                            </div>
                                        </div>
                                        
                                        <div class="text-end">
                                            <button type="submit" class="btn btn-warning">
                                                <i class="fas fa-crown me-2"></i>Cấp VIP
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
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

    <!-- Hidden Form -->
    <form id="revokeVIPForm" action="${pageContext.request.contextPath}/admin/vip" method="POST" style="display: none;">
        <input type="hidden" name="action" value="revokeVIP">
        <input type="hidden" name="userId" id="revokeUserId">
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

        function updateEndDate() {
            const packageSelect = document.querySelector('select[name="packageId"]');
            const startDateInput = document.getElementById('startDate');
            const endDateInput = document.getElementById('endDate');
            const priceInput = document.getElementById('packagePrice');
            
            if (packageSelect.value && startDateInput.value) {
                const selectedOption = packageSelect.options[packageSelect.selectedIndex];
                const months = parseInt(selectedOption.getAttribute('data-months'));
                const startDate = new Date(startDateInput.value);
                
                // Add months to start date
                const endDate = new Date(startDate.getFullYear(), startDate.getMonth() + months, startDate.getDate());
                
                // Format date as YYYY-MM-DD
                const year = endDate.getFullYear();
                const month = String(endDate.getMonth() + 1).padStart(2, '0');
                const day = String(endDate.getDate()).padStart(2, '0');
                const formattedEndDate = year + '-' + month + '-' + day;
                endDateInput.value = formattedEndDate;
                
                // Update price display
                const packageText = selectedOption.text;
                const priceMatch = packageText.match(/(\d+(?:[,\.]\d+)*)/);
                if (priceMatch) {
                    priceInput.value = priceMatch[1] + ' ₫';
                }
            } else {
                endDateInput.value = '';
                priceInput.value = '';
            }
        }

        // Initialize date calculation on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Set default start date to today
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('startDate').value = today;
            updateEndDate();
        });
    </script>
</body>
</html>