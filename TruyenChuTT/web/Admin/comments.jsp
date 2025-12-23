<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý bình luận - TruyenTT</title>
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
        .comment-content { max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .user-avatar { width: 32px; height: 32px; border-radius: 50%; }
        .vip-badge { font-size: 0.7rem; }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/comments">
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
                            <h2 class="fw-bold mb-1">Quản lý bình luận</h2>
                            <p class="text-muted mb-0">
                                <c:choose>
                                    <c:when test="${not empty keyword or not empty truyenId}">
                                        Kết quả tìm kiếm: ${totalRecords} bình luận
                                    </c:when>
                                    <c:otherwise>
                                        Tổng cộng: ${totalRecords} bình luận
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <div>
                            <button type="button" class="btn btn-primary" onclick="location.reload()">
                                <i class="fas fa-sync-alt me-2"></i>Làm mới
                            </button>
                        </div>
                    </div>

                    <!-- Messages -->
                    <c:if test="${param.success != null}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            <strong>Thành công!</strong> ${param.success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${param.error != null}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <strong>Lỗi!</strong> ${param.error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <c:if test="${error != null}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <strong>Lỗi!</strong> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Search and Filter -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <form method="GET" action="${pageContext.request.contextPath}/admin/comments">
                                <input type="hidden" name="action" value="search">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="search-form">
                                            <i class="fas fa-search search-icon"></i>
                                            <input type="text" name="keyword" class="form-control" 
                                                   placeholder="Tìm theo nội dung bình luận..." value="${keyword}">
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="number" name="truyenId" class="form-control" 
                                               placeholder="ID truyện..." value="${truyenId}">
                                    </div>
                                    <div class="col-md-2">
                                        <select name="records" class="form-select">
                                            <option value="20" ${recordsPerPage == 20 ? 'selected' : ''}>20</option>
                                            <option value="50" ${recordsPerPage == 50 ? 'selected' : ''}>50</option>
                                            <option value="100" ${recordsPerPage == 100 ? 'selected' : ''}>100</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3 d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-search me-1"></i> Tìm kiếm
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/comments" class="btn btn-outline-secondary">
                                            <i class="fas fa-times me-1"></i> Reset
                                        </a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Comments List -->
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0 fw-bold">
                                <i class="fas fa-comments me-2"></i>Danh sách bình luận
                                <span class="badge bg-light text-dark ms-2">${totalRecords}</span>
                            </h5>
                            <div>
                                <button type="button" class="btn btn-sm btn-danger" onclick="deleteSelected()" id="deleteBtn" disabled>
                                    <i class="fas fa-trash me-1"></i> Xóa đã chọn
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${empty danhSachBinhLuan}">
                                    <div class="empty-state">
                                        <i class="fas fa-comments"></i>
                                        <h4>Không có bình luận nào</h4>
                                        <p class="mb-4">Chưa có bình luận nào trong hệ thống hoặc không tìm thấy kết quả phù hợp.</p>
                                        <c:if test="${not empty keyword or not empty truyenId}">
                                            <a href="${pageContext.request.contextPath}/admin/comments" class="btn btn-primary">
                                                <i class="fas fa-list me-2"></i>Xem tất cả bình luận
                                            </a>
                                        </c:if>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                            <thead>
                                                <tr>
                                                    <th width="50">
                                                        <input type="checkbox" id="selectAll" class="form-check-input">
                                                    </th>
                                                    <th>ID</th>
                                                    <th>Người dùng</th>
                                                    <th>Truyện</th>
                                                    <th>Nội dung</th>
                                                    <th>Ngày tạo</th>
                                                    <th>Trạng thái</th>
                                                    <th class="text-center">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="binhLuan" items="${danhSachBinhLuan}">
                                                    <tr>
                                                        <td>
                                                            <input type="checkbox" name="commentId" value="${binhLuan.id}" 
                                                                   class="form-check-input comment-checkbox">
                                                        </td>
                                                        <td>
                                                            <strong class="text-primary">#${binhLuan.id}</strong>
                                                        </td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <c:choose>
                                                                    <c:when test="${not empty binhLuan.nguoiDung.anhDaiDien}">
                                                                        <img src="${binhLuan.nguoiDung.anhDaiDien}" 
                                                                             class="user-avatar me-2" alt="Avatar">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="bg-secondary rounded-circle d-flex align-items-center justify-content-center me-2 user-avatar">
                                                                            <i class="fas fa-user text-white" style="font-size: 12px;"></i>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <div>
                                                                    <div class="fw-medium">${binhLuan.nguoiDung.hoTen}</div>
                                                                    <c:if test="${binhLuan.nguoiDung.trangThaiVIP}">
                                                                        <span class="badge bg-warning text-dark vip-badge">VIP</span>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="fw-medium text-truncate" style="max-width: 150px;">
                                                                ${binhLuan.truyen.tenTruyen}
                                                            </div>
                                                            <small class="text-muted">ID: ${binhLuan.truyen.id}</small>
                                                        </td>
                                                        <td>
                                                            <div class="comment-content" title="${binhLuan.noiDung}">
                                                                ${binhLuan.noiDung}
                                                            </div>
                                                            <c:if test="${not empty binhLuan.binhLuanCon && binhLuan.binhLuanCon.size() > 0}">
                                                                <small class="text-muted">
                                                                    <i class="fas fa-reply"></i> ${binhLuan.binhLuanCon.size()} trả lời
                                                                </small>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <div class="fw-medium">${binhLuan.ngayTaoFormatted}</div>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${binhLuan.trangThai}">
                                                                    <span class="badge status-badge bg-success">
                                                                        <i class="fas fa-check me-1"></i>Hiển thị
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge status-badge bg-danger">
                                                                        <i class="fas fa-eye-slash me-1"></i>Đã ẩn
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="text-center action-buttons">
                                                            <div class="dropdown">
                                                                <button class="btn btn-sm btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                                                    <i class="fas fa-ellipsis-h"></i>
                                                                </button>
                                                                <ul class="dropdown-menu dropdown-menu-end">
                                                                    <li>
                                                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/comments?action=detail&id=${binhLuan.id}">
                                                                            <i class="fas fa-eye text-info"></i> Xem chi tiết
                                                                        </a>
                                                                    </li>
                                                                    <li><hr class="dropdown-divider"></li>
                                                                    <li>
                                                                        <a class="dropdown-item text-danger" href="#" onclick="confirmDelete(${binhLuan.id}, '${binhLuan.nguoiDung.hoTen}')">
                                                                            <i class="fas fa-trash-alt"></i> Xóa vĩnh viễn
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
                        <c:if test="${totalPages > 1}">
                            <div class="card-footer bg-white d-flex justify-content-between align-items-center">
                                <div class="text-muted small">
                                    Hiển thị ${(currentPage-1)*recordsPerPage + 1} - 
                                    ${currentPage*recordsPerPage > totalRecords ? totalRecords : currentPage*recordsPerPage} 
                                    trong tổng số ${totalRecords} bình luận
                                </div>
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage-1}&records=${recordsPerPage}${not empty keyword ? '&action=search&keyword='.concat(keyword) : ''}${not empty truyenId ? '&truyenId='.concat(truyenId) : ''}">
                                                    <i class="fas fa-chevron-left small"></i>
                                                </a>
                                            </li>
                                        </c:if>
                                        
                                        <c:forEach begin="${currentPage > 3 ? currentPage - 2 : 1}" 
                                                   end="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" 
                                                   var="i">
                                            <c:choose>
                                                <c:when test="${i == currentPage}">
                                                    <li class="page-item active">
                                                        <span class="page-link">${i}</span>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="page-item">
                                                        <a class="page-link" href="?page=${i}&records=${recordsPerPage}${not empty keyword ? '&action=search&keyword='.concat(keyword) : ''}${not empty truyenId ? '&truyenId='.concat(truyenId) : ''}">${i}</a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage+1}&records=${recordsPerPage}${not empty keyword ? '&action=search&keyword='.concat(keyword) : ''}${not empty truyenId ? '&truyenId='.concat(truyenId) : ''}">
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

    <!-- Delete Form -->
    <form id="deleteForm" method="POST" action="${pageContext.request.contextPath}/admin/comments" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" id="deleteId">
    </form>

    <!-- Bulk Delete Form -->
    <form id="bulkDeleteForm" method="POST" action="${pageContext.request.contextPath}/admin/comments" style="display: none;">
        <input type="hidden" name="action" value="bulk-delete">
        <div id="selectedIdsContainer"></div>
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
        // Select all checkbox functionality
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('.comment-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
            toggleDeleteButton();
        });

        // Individual checkbox change
        document.querySelectorAll('.comment-checkbox').forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                toggleDeleteButton();
                
                // Update select all checkbox
                const allCheckboxes = document.querySelectorAll('.comment-checkbox');
                const checkedCheckboxes = document.querySelectorAll('.comment-checkbox:checked');
                const selectAllCheckbox = document.getElementById('selectAll');
                
                if (checkedCheckboxes.length === 0) {
                    selectAllCheckbox.indeterminate = false;
                    selectAllCheckbox.checked = false;
                } else if (checkedCheckboxes.length === allCheckboxes.length) {
                    selectAllCheckbox.indeterminate = false;
                    selectAllCheckbox.checked = true;
                } else {
                    selectAllCheckbox.indeterminate = true;
                }
            });
        });

        function toggleDeleteButton() {
            const checkedCheckboxes = document.querySelectorAll('.comment-checkbox:checked');
            const deleteBtn = document.getElementById('deleteBtn');
            deleteBtn.disabled = checkedCheckboxes.length === 0;
        }

        function confirmDelete(id, userName) {
            document.getElementById("confirmationTitle").innerText = "Xác nhận xóa bình luận";
            document.getElementById("confirmationBody").innerHTML = `
                <div class="text-center">
                    <i class="fas fa-exclamation-triangle text-warning fa-3x mb-3"></i>
                    <p>Bạn có chắc chắn muốn <strong class="text-danger">xóa vĩnh viễn</strong> bình luận của <strong>${userName}</strong>?</p>
                    <div class="alert alert-danger">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Cảnh báo:</strong> Hành động này sẽ xóa bình luận và <strong>tất cả các bình luận trả lời</strong> khỏi cơ sở dữ liệu và không thể hoàn tác!
                    </div>
                </div>
            `;
            const modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
            modal.show();
            document.getElementById("confirmActionBtn").onclick = function () {
                document.getElementById('deleteId').value = id;
                document.getElementById('deleteForm').submit();
            };
        }

        function deleteSelected() {
            const checkedCheckboxes = document.querySelectorAll('.comment-checkbox:checked');
            if (checkedCheckboxes.length === 0) {
                alert('Vui lòng chọn ít nhất một bình luận để xóa!');
                return;
            }

            document.getElementById("confirmationTitle").innerText = "Xác nhận xóa bình luận";
            document.getElementById("confirmationBody").innerHTML = `
                <div class="text-center">
                    <i class="fas fa-exclamation-triangle text-warning fa-3x mb-3"></i>
                    <p>Bạn có chắc chắn muốn <strong class="text-danger">xóa vĩnh viễn ${checkedCheckboxes.length} bình luận</strong> đã chọn?</p>
                    <div class="alert alert-danger">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Cảnh báo:</strong> Hành động này sẽ xóa tất cả bình luận đã chọn và <strong>các bình luận trả lời</strong> khỏi cơ sở dữ liệu và không thể hoàn tác!
                    </div>
                </div>
            `;
            const modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
            modal.show();
            document.getElementById("confirmActionBtn").onclick = function () {
                const container = document.getElementById('selectedIdsContainer');
                container.innerHTML = '';
                
                checkedCheckboxes.forEach(checkbox => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'selectedIds';
                    input.value = checkbox.value;
                    container.appendChild(input);
                });
                
                document.getElementById('bulkDeleteForm').submit();
            };
        }

        // Auto dismiss alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>