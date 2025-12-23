<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý yêu cầu thanh toán - TruyenTT</title>
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
        .status-badge { padding: 0.5rem 1rem; border-radius: 25px; font-weight: 600; font-size: 0.85rem; }
        .amount-display { font-weight: 700; color: var(--success-color); }
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
        .stats-card { background: linear-gradient(135deg, #fff 0%, #f8fafc 100%); border-radius: 15px; padding: 1.5rem; margin-bottom: 1rem; }
        .stats-number { font-size: 2rem; font-weight: 700; margin-bottom: 0.5rem; }
        .stats-label { color: #6b7280; font-size: 0.9rem; }
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
                            <h2 class="fw-bold mb-1">Quản lý yêu cầu thanh toán</h2>
                            <p class="text-muted mb-0">
                                <c:choose>
                                    <c:when test="${searchMode}">
                                        Kết quả tìm kiếm: ${totalRequests} yêu cầu
                                    </c:when>
                                    <c:otherwise>
                                        Tổng cộng: ${totalRequests} yêu cầu thanh toán
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-md-4">
                            <div class="stats-card">
                                <div class="stats-number text-warning">${pendingRequests}</div>
                                <div class="stats-label">Chờ duyệt</div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stats-card">
                                <div class="stats-number text-success">${approvedRequests}</div>
                                <div class="stats-label">Đã duyệt</div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="stats-card">
                                <div class="stats-number text-danger">${rejectedRequests}</div>
                                <div class="stats-label">Đã từ chối</div>
                            </div>
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
                            <form action="${pageContext.request.contextPath}/admin/payments" method="GET">
                                <input type="hidden" name="action" value="search">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="search-form">
                                            <i class="fas fa-search search-icon"></i>
                                            <input type="text" class="form-control" name="searchTerm" 
                                                   placeholder="Tìm kiếm theo tên, email, nội dung..." value="${searchTerm}">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <select class="form-select" name="status" style="height: 50px;">
                                            <option value="">Tất cả trạng thái</option>
                                            <option value="PENDING" ${searchStatus == 'PENDING' ? 'selected' : ''}>Chờ duyệt</option>
                                            <option value="APPROVED" ${searchStatus == 'APPROVED' ? 'selected' : ''}>Đã duyệt</option>
                                            <option value="REJECTED" ${searchStatus == 'REJECTED' ? 'selected' : ''}>Đã từ chối</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <button type="submit" class="btn btn-primary" style="height: 50px; width: 100%;">
                                            <i class="fas fa-search me-2"></i>Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <c:if test="${searchMode}">
                                <div class="mt-3">
                                    <a href="${pageContext.request.contextPath}/admin/payments" class="btn btn-outline-secondary">
                                        <i class="fas fa-undo me-2"></i>Quay lại danh sách
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Payment Requests List -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0 fw-bold"><i class="fas fa-credit-card me-2"></i>Danh sách yêu cầu thanh toán</h5>
                            <div>
                                <div class="dropdown d-inline-block">
                                    <button class="btn btn-sm btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        Số dòng: ${pageSize}
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/payments?page=1&pageSize=10">10</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/payments?page=1&pageSize=25">25</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/payments?page=1&pageSize=50">50</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${empty paymentRequestsWithDetails}">
                                    <div class="empty-state">
                                        <i class="fas fa-credit-card"></i>
                                        <h4>Không tìm thấy yêu cầu thanh toán nào</h4>
                                        <p class="mb-4">Chưa có yêu cầu thanh toán nào trong hệ thống hoặc không tìm thấy kết quả phù hợp.</p>
                                        <c:if test="${searchMode}">
                                            <a href="${pageContext.request.contextPath}/admin/payments" class="btn btn-primary">
                                                <i class="fas fa-list me-2"></i>Xem tất cả yêu cầu
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
                                                    <th>Người dùng</th>
                                                    <th>Gói VIP</th>
                                                    <th>Số tiền</th>
                                                    <th>Trạng thái</th>
                                                    <th>Ngày tạo</th>
                                                    <th class="text-center">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${paymentRequestsWithDetails}" var="item">
                                                    <c:set var="request" value="${item[0]}" />
                                                    <c:set var="user" value="${item[1]}" />
                                                    <c:set var="vipPackage" value="${item[2]}" />
                                                    <tr>
                                                        <td>${request.id}</td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <div>
                                                                    <div class="fw-medium">${user.hoTen}</div>
                                                                    <small class="text-muted">${user.email}</small>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-info">${vipPackage.tenGoi}</span>
                                                        </td>
                                                        <td>
                                                            <span class="amount-display">${request.soTienFormatted} VNĐ</span>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${request.trangThai == 'PENDING'}">
                                                                    <span class="badge status-badge bg-warning">Chờ duyệt</span>
                                                                </c:when>
                                                                <c:when test="${request.trangThai == 'APPROVED'}">
                                                                    <span class="badge status-badge bg-success">Đã duyệt</span>
                                                                </c:when>
                                                                <c:when test="${request.trangThai == 'REJECTED'}">
                                                                    <span class="badge status-badge bg-danger">Đã từ chối</span>
                                                                </c:when>
                                                            </c:choose>
                                                        </td>
                                                        <td>${request.ngayTaoFormatted}</td>
                                                        <td class="text-center action-buttons">
                                                            <div class="dropdown">
                                                                <button class="btn btn-sm btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                                    <i class="fas fa-ellipsis-h"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li>
                                                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/payments?action=view&id=${request.id}">
                                                                            <i class="fas fa-eye text-info"></i> Xem chi tiết
                                                                        </a>
                                                                    </li>
                                                                    <c:if test="${request.trangThai == 'PENDING'}">
                                                                        <li>
                                                                            <a class="dropdown-item" href="#" onclick="openApproveModal(${request.id}, '${user.hoTen}', '${vipPackage.tenGoi}')">
                                                                                <i class="fas fa-check text-success"></i> Duyệt yêu cầu
                                                                            </a>
                                                                        </li>
                                                                        <li>
                                                                            <a class="dropdown-item" href="#" onclick="openRejectModal(${request.id}, '${user.hoTen}', '${vipPackage.tenGoi}')">
                                                                                <i class="fas fa-times text-warning"></i> Từ chối yêu cầu
                                                                            </a>
                                                                        </li>
                                                                    </c:if>
                                                                    <li><hr class="dropdown-divider"></li>
                                                                    <li>
                                                                        <a class="dropdown-item text-danger" href="#" onclick="confirmDelete(${request.id}, '${user.hoTen}')">
                                                                            <i class="fas fa-trash-alt"></i> Xóa yêu cầu
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
                        <c:if test="${not searchMode && totalPages > 1}">
                            <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                                <div class="text-muted small">
                                    Hiển thị ${paymentRequestsWithDetails.size()} / ${totalRequests} yêu cầu
                                </div>
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/admin/payments?page=${currentPage - 1}&pageSize=${pageSize}">
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
                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/payments?page=${i}&pageSize=${pageSize}">${i}</a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="${pageContext.request.contextPath}/admin/payments?page=${currentPage + 1}&pageSize=${pageSize}">
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
