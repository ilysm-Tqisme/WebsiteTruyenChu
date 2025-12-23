<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết yêu cầu thanh toán - TruyenTT</title>
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
        .info-label { color: #64748b; font-size: 0.9rem; font-weight: 500; }
        .info-value { font-weight: 600; color: #0f172a; font-size: 1.05rem; }
        .status-badge { padding: 0.5rem 1rem; border-radius: 25px; font-weight: 600; font-size: 0.9rem; }
        .amount-display { font-size: 1.5rem; font-weight: 700; color: var(--success-color); }
        .action-btn { border-radius: 12px; padding: 0.75rem 1.5rem; font-weight: 500; transition: all 0.3s ease; }
        .action-btn:hover { transform: translateY(-3px); box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); }
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/vip">
                            <i class="fas fa-crown"></i>Quản lý VIP
                        </a>
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/payments">
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
                            <h2 class="fw-bold mb-1">Chi tiết yêu cầu thanh toán</h2>
                            <p class="text-muted mb-0">
                                Xem và xử lý yêu cầu thanh toán VIP
                            </p>
                        </div>
                        <div>
                            <a href="${pageContext.request.contextPath}/admin/payments" class="btn btn-outline-primary">
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

                    <!-- Payment Request Details -->
                    <div class="row">
                        <div class="col-md-8">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0 fw-bold"><i class="fas fa-credit-card me-2"></i>Thông tin yêu cầu thanh toán</h5>
                                </div>
                                <div class="card-body p-4">
                                    <div class="row">
                                        <div class="col-md-6 mb-4">
                                            <div class="info-label">ID yêu cầu</div>
                                            <div class="info-value">#${selectedPaymentRequest.id}</div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="info-label">Trạng thái</div>
                                            <div class="info-value">
                                                <c:choose>
                                                    <c:when test="${selectedPaymentRequest.trangThai == 'PENDING'}">
                                                        <span class="badge status-badge bg-warning">Chờ duyệt</span>
                                                    </c:when>
                                                    <c:when test="${selectedPaymentRequest.trangThai == 'APPROVED'}">
                                                        <span class="badge status-badge bg-success">Đã duyệt</span>
                                                    </c:when>
                                                    <c:when test="${selectedPaymentRequest.trangThai == 'REJECTED'}">
                                                        <span class="badge status-badge bg-danger">Đã từ chối</span>
                                                    </c:when>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="info-label">Gói VIP</div>
                                            <div class="info-value">
                                                <span class="badge bg-info">${vipPackage.tenGoi}</span>
                                                <small class="text-muted d-block">${vipPackage.soThang} tháng</small>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="info-label">Số tiền</div>
                                            <div class="amount-display">${selectedPaymentRequest.soTienFormatted} VNĐ</div>
                                        </div>
                                        <div class="col-md-12 mb-4">
                                            <div class="info-label">Nội dung chuyển khoản</div>
                                            <div class="info-value">
                                                <div class="bg-light p-3 rounded">
                                                    ${selectedPaymentRequest.noiDungChuyenKhoan}
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-4">
                                            <div class="info-label">Ngày tạo</div>
                                            <div class="info-value">${selectedPaymentRequest.ngayTaoFormatted}</div>
                                        </div>
                                        <c:if test="${not empty selectedPaymentRequest.ngayXuLy}">
                                            <div class="col-md-6 mb-4">
                                                <div class="info-label">Ngày xử lý</div>
                                                <div class="info-value">${selectedPaymentRequest.ngayXuLyFormatted}</div>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty selectedPaymentRequest.ghiChu}">
                                            <div class="col-md-12 mb-4">
                                                <div class="info-label">Ghi chú</div>
                                                <div class="info-value">
                                                    <div class="bg-light p-3 rounded">
                                                        ${selectedPaymentRequest.ghiChu}
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <!-- User Information -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0 fw-bold"><i class="fas fa-user me-2"></i>Thông tin người dùng</h5>
                                </div>
                                <div class="card-body p-4">
                                    <div class="text-center mb-3">
                                        <c:choose>
                                            <c:when test="${not empty requestUser.anhDaiDien}">
                                                <img src="${pageContext.request.contextPath}/${requestUser.anhDaiDien}" 
                                                     alt="${requestUser.hoTen}" class="rounded-circle" style="width: 80px; height: 80px; object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bg-secondary rounded-circle d-inline-flex align-items-center justify-content-center" 
                                                     style="width: 80px; height: 80px;">
                                                    <i class="fas fa-user text-white fa-2x"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="text-center mb-3">
                                        <h6 class="fw-bold mb-1">${requestUser.hoTen}</h6>
                                        <p class="text-muted mb-0">${requestUser.email}</p>
                                        <c:if test="${not empty requestUser.soDienThoai}">
                                            <p class="text-muted mb-0">${requestUser.soDienThoai}</p>
                                        </c:if>
                                    </div>
                                    <div class="mb-3">
                                        <div class="info-label">Vai trò</div>
                                        <div class="info-value">
                                            <span class="badge ${requestUser.vaiTro == 'ADMIN' ? 'bg-danger' : 'bg-primary'}">${requestUser.vaiTro}</span>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <div class="info-label">Trạng thái VIP</div>
                                        <div class="info-value">
                                            <c:choose>
                                                <c:when test="${requestUser.trangThaiVIP}">
                                                    <span class="badge bg-warning"><i class="fas fa-crown me-1"></i>VIP</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">Thường</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="d-grid">
                                        <a href="${pageContext.request.contextPath}/admin/users?action=view&id=${requestUser.id}" 
                                           class="btn btn-outline-primary btn-sm">
                                            <i class="fas fa-eye me-2"></i>Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- Actions -->
                            <c:if test="${selectedPaymentRequest.trangThai == 'PENDING'}">
                                <div class="card">
                                    <div class="card-header">
                                        <h5 class="mb-0 fw-bold"><i class="fas fa-cogs me-2"></i>Thao tác</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <div class="d-grid gap-2">
                                            <button type="button" class="btn btn-success action-btn" 
                                                    onclick="openApproveModal(${selectedPaymentRequest.id}, '${requestUser.hoTen}', '${vipPackage.tenGoi}')">
                                                <i class="fas fa-check me-2"></i>Duyệt yêu cầu
                                            </button>
                                            <button type="button" class="btn btn-warning action-btn"
                                                    onclick="openRejectModal(${selectedPaymentRequest.id}, '${requestUser.hoTen}', '${vipPackage.tenGoi}')">
                                                <i class="fas fa-times me-2"></i>Từ chối yêu cầu
                                            </button>
                                            <hr>
                                            <button type="button" class="btn btn-outline-danger action-btn"
                                                    onclick="confirmDelete(${selectedPaymentRequest.id}, '${requestUser.hoTen}')">
                                                <i class="fas fa-trash-alt me-2"></i>Xóa yêu cầu
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Approve Modal -->
    <div class="modal fade" id="approveModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="fas fa-check me-2"></i>Duyệt yêu cầu thanh toán</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <form id="approveForm" action="${pageContext.request.contextPath}/admin/payments" method="POST">
                        <input type="hidden" name="action" value="approve">
                        <input type="hidden" name="fromView" value="true">
                        <input type="hidden" id="approveRequestId" name="requestId" value="">
                        <div class="mb-3">
                            <p>Bạn có chắc chắn muốn <strong>duyệt</strong> yêu cầu thanh toán của:</p>
                            <div class="alert alert-info">
                                <strong id="approveUserName"></strong><br>
                                Gói VIP: <strong id="approvePackageName"></strong>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="approveNote" class="form-label">Ghi chú (tùy chọn)</label>
                            <textarea class="form-control" id="approveNote" name="ghiChu" rows="3" 
                                      placeholder="Nhập ghi chú cho yêu cầu này..."></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" form="approveForm" class="btn btn-success">
                        <i class="fas fa-check me-2"></i>Duyệt yêu cầu
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Reject Modal -->
    <div class="modal fade" id="rejectModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold"><i class="fas fa-times me-2"></i>Từ chối yêu cầu thanh toán</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <form id="rejectForm" action="${pageContext.request.contextPath}/admin/payments" method="POST">
                        <input type="hidden" name="action" value="reject">
                        <input type="hidden" name="fromView" value="true">
                        <input type="hidden" id="rejectRequestId" name="requestId" value="">
                        <div class="mb-3">
                            <p>Bạn có chắc chắn muốn <strong>từ chối</strong> yêu cầu thanh toán của:</p>
                            <div class="alert alert-warning">
                                <strong id="rejectUserName"></strong><br>
                                Gói VIP: <strong id="rejectPackageName"></strong>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="rejectNote" class="form-label">Lý do từ chối <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="rejectNote" name="ghiChu" rows="3" 
                                      placeholder="Nhập lý do từ chối yêu cầu này..." required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" form="rejectForm" class="btn btn-warning">
                        <i class="fas fa-times me-2"></i>Từ chối yêu cầu
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Delete Form (hidden) -->
    <form id="deleteForm" action="${pageContext.request.contextPath}/admin/payments" method="POST" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" id="deleteRequestId" name="requestId" value="">
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openApproveModal(requestId, userName, packageName) {
            document.getElementById("approveRequestId").value = requestId;
            document.getElementById("approveUserName").textContent = userName;
            document.getElementById("approvePackageName").textContent = packageName;
            document.getElementById("approveNote").value = "";
            const modal = new bootstrap.Modal(document.getElementById("approveModal"));
            modal.show();
        }

        function openRejectModal(requestId, userName, packageName) {
            document.getElementById("rejectRequestId").value = requestId;
            document.getElementById("rejectUserName").textContent = userName;
            document.getElementById("rejectPackageName").textContent = packageName;
            document.getElementById("rejectNote").value = "";
            const modal = new bootstrap.Modal(document.getElementById("rejectModal"));
            modal.show();
        }

        function confirmDelete(requestId, userName) {
            document.getElementById("confirmationTitle").innerText = "Xác nhận xóa yêu cầu";
            document.getElementById("confirmationBody").innerHTML = `Bạn có chắc chắn muốn <strong>xóa</strong> yêu cầu thanh toán của <strong>${userName}</strong>? Hành động này không thể hoàn tác.`;
            const modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
            modal.show();
            document.getElementById("confirmActionBtn").onclick = function () {
                document.getElementById("deleteRequestId").value = requestId;
                document.getElementById("deleteForm").submit();
            };
        }
    </script>
</body>
</html>
