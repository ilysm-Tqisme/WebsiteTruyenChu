<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết bình luận - TruyenTT</title>
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
        .sidebar-brand { background: rgba(255, 255, 255, 0.1); border-radius: 15px; padding: 1.5rem; margin-bottom: 2rem; text-align: center; backdrop-filter: blur(10px); }
        .sidebar-brand h4 { margin: 0; font-weight: 700; font-size: 1.5rem; }
        .sidebar-brand p { margin: 0.5rem 0 0 0; opacity: 0.8; font-size: 0.9rem; }
        .page-header { background: linear-gradient(135deg, white 0%, #f8fafc 100%); border-radius: 20px; padding: 2rem; margin-bottom: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); }
        .modal-content { border-radius: 20px; border: none; overflow: hidden; }
        .modal-header { background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); color: white; border: none; padding: 1.5rem; }
        .modal-footer { border-top: 1px solid #f1f5f9; padding: 1.25rem; }
        .empty-state { padding: 3rem; text-align: center; color: #6b7280; }
        .empty-state i { font-size: 4rem; margin-bottom: 1.5rem; opacity: 0.3; }
        .comment-main { background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); color: white; border-radius: 20px; }
        .comment-content { background: white; border-radius: 15px; padding: 1.5rem; margin-top: 1rem; box-shadow: inset 0 2px 4px rgba(0,0,0,0.1); }
        .comment-meta { background: rgba(255,255,255,0.1); border-radius: 15px; padding: 1rem; margin-top: 1rem; }
        .reply-comment { background: #f8f9fa; border-left: 4px solid var(--primary-color); border-radius: 0 15px 15px 0; margin: 0.5rem 0; padding: 1rem; margin-left: 2rem; }
        .user-avatar { width: 60px; height: 60px; border-radius: 50%; border: 3px solid rgba(255,255,255,0.3); }
        .status-badge { padding: 0.5rem 1rem; border-radius: 25px; font-weight: 600; }
        .story-info { background: linear-gradient(135deg, var(--accent-color) 0%, var(--warning-color) 100%); color: white; border-radius: 20px; padding: 1.5rem; }
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
                            <h2 class="fw-bold mb-1">Chi tiết bình luận</h2>
                            <p class="text-muted mb-0">Xem thông tin chi tiết và quản lý bình luận</p>
                        </div>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/admin/comments" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-1"></i> Quay lại
                            </a>
                            <button type="button" class="btn btn-danger" onclick="confirmDelete(${binhLuan.id}, '${binhLuan.nguoiDung.hoTen}')">
                                <i class="fas fa-trash me-1"></i> Xóa vĩnh viễn
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

                    <c:choose>
                        <c:when test="${binhLuan != null}">
                            <div class="row">
                                <!-- Main Comment -->
                                <div class="col-md-8">
                                    <div class="card comment-main">
                                        <div class="card-body">
                                            <div class="d-flex align-items-start">
                                                <c:choose>
                                                    <c:when test="${not empty binhLuan.nguoiDung.anhDaiDien}">
                                                        <img src="${binhLuan.nguoiDung.anhDaiDien}" 
                                                             class="user-avatar me-3" alt="Avatar">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="user-avatar me-3 bg-light d-flex align-items-center justify-content-center">
                                                            <i class="fas fa-user text-muted fa-2x"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="flex-grow-1">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <h5 class="mb-1">${binhLuan.nguoiDung.hoTen}</h5>
                                                            <div class="mb-2">
                                                                <c:if test="${binhLuan.nguoiDung.trangThaiVIP}">
                                                                    <span class="badge bg-warning text-dark me-2 vip-badge">
                                                                        <i class="fas fa-crown me-1"></i>VIP
                                                                    </span>
                                                                </c:if>
                                                                <span class="badge bg-light text-dark">
                                                                    ID: ${binhLuan.nguoiDung.id}
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <div class="text-end">
                                                            <c:choose>
                                                                <c:when test="${binhLuan.trangThai}">
                                                                    <span class="status-badge bg-success">
                                                                        <i class="fas fa-check me-1"></i>Hiển thị
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="status-badge bg-danger">
                                                                        <i class="fas fa-eye-slash me-1"></i>Đã ẩn
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="comment-content">
                                                <h6 class="text-dark mb-2">Nội dung bình luận:</h6>
                                                <div class="text-dark" style="line-height: 1.6; white-space: pre-wrap;">${binhLuan.noiDung}</div>
                                            </div>

                                            <div class="comment-meta">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <small>
                                                            <i class="fas fa-clock me-1"></i>
                                                            Ngày tạo: ${binhLuan.ngayTaoFormatted}
                                                        </small>
                                                    </div>
                                                    <div class="col-md-6 text-end">
                                                        <small>
                                                            <i class="fas fa-hashtag me-1"></i>
                                                            ID: ${binhLuan.id}
                                                        </small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Reply Comments -->
                                    <c:if test="${not empty binhLuan.binhLuanCon}">
                                        <div class="mt-4">
                                            <h5>
                                                <i class="fas fa-reply me-2 text-primary"></i>
                                                Bình luận trả lời (${binhLuan.binhLuanCon.size()})
                                            </h5>
                                            <c:forEach var="reply" items="${binhLuan.binhLuanCon}">
                                                <div class="reply-comment">
                                                    <div class="d-flex align-items-start">
                                                        <c:choose>
                                                            <c:when test="${not empty reply.nguoiDung.anhDaiDien}">
                                                                <img src="${reply.nguoiDung.anhDaiDien}" 
                                                                     class="rounded-circle me-3" width="40" height="40" alt="Avatar">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="bg-secondary rounded-circle d-flex align-items-center justify-content-center me-3" 
                                                                     style="width: 40px; height: 40px;">
                                                                    <i class="fas fa-user text-white" style="font-size: 14px;"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div class="flex-grow-1">
                                                            <div class="d-flex justify-content-between align-items-start">
                                                                <div>
                                                                    <h6 class="mb-1">${reply.nguoiDung.hoTen}</h6>
                                                                    <div class="mb-2">
                                                                        <c:if test="${reply.nguoiDung.trangThaiVIP}">
                                                                            <span class="badge bg-warning text-dark me-2 vip-badge">VIP</span>
                                                                        </c:if>
                                                                        <small class="text-muted">
                                                                            <i class="fas fa-clock me-1"></i>
                                                                            ${reply.ngayTaoFormatted}
                                                                        </small>
                                                                    </div>
                                                                </div>
                                                                <div>
                                                                    <c:choose>
                                                                        <c:when test="${reply.trangThai}">
                                                                            <span class="badge bg-success vip-badge">Hiển thị</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="badge bg-danger vip-badge">Đã ẩn</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                            <div class="mt-2" style="white-space: pre-wrap;">${reply.noiDung}</div>
                                                            <div class="mt-2">
                                                                <small class="text-muted">ID: ${reply.id}</small>
                                                                <button type="button" class="btn btn-outline-danger btn-sm ms-2" 
                                                                        onclick="confirmDelete(${reply.id}, '${reply.nguoiDung.hoTen}')" style="font-size: 0.75rem;">
                                                                    <i class="fas fa-trash"></i> Xóa vĩnh viễn
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </div>

                                <!-- Story Info Sidebar -->
                                <div class="col-md-4">
                                    <div class="story-info">
                                        <h5 class="mb-3">
                                            <i class="fas fa-book me-2"></i>
                                            Thông tin truyện
                                        </h5>
                                        <div class="mb-3">
                                            <strong>Tên truyện:</strong>
                                            <div class="mt-1">${binhLuan.truyen.tenTruyen}</div>
                                        </div>
                                        <div class="mb-3">
                                            <strong>ID Truyện:</strong>
                                            <div class="mt-1">
                                                <span class="badge bg-light text-dark">${binhLuan.truyen.id}</span>
                                            </div>
                                        </div>
                                        <c:if test="${binhLuan.chuong != null}">
                                            <div class="mb-3">
                                                <strong>Chương:</strong>
                                                <div class="mt-1">
                                                    ${binhLuan.chuong.tenChuong}
                                                    <br>
                                                    <small>ID: ${binhLuan.chuong.id}</small>
                                                </div>
                                            </div>
                                        </c:if>
                                        <div class="mt-3 pt-3" style="border-top: 1px solid rgba(255,255,255,0.2);">
                                            <a href="${pageContext.request.contextPath}/admin/stories?action=detail&id=${binhLuan.truyen.id}" 
                                               class="btn btn-light btn-sm">
                                                <i class="fas fa-external-link-alt me-1"></i>
                                                Xem truyện
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Comment Statistics -->
                                    <div class="card mt-3">
                                        <div class="card-header">
                                            <h6 class="mb-0 fw-bold">
                                                <i class="fas fa-chart-bar me-2"></i>
                                                Thống kê
                                            </h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="mb-3">
                                                <div class="d-flex justify-content-between">
                                                    <span>Bình luận gốc:</span>
                                                    <strong>1</strong>
                                                </div>
                                            </div>
                                            <c:if test="${not empty binhLuan.binhLuanCon}">
                                                <div class="mb-3">
                                                    <div class="d-flex justify-content-between">
                                                        <span>Bình luận trả lời:</span>
                                                        <strong>${binhLuan.binhLuanCon.size()}</strong>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <div class="d-flex justify-content-between">
                                                        <span>Tổng cộng:</span>
                                                        <strong class="text-primary">${binhLuan.binhLuanCon.size() + 1}</strong>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-comment-slash"></i>
                                <h4>Không tìm thấy bình luận</h4>
                                <p class="mb-4">Bình luận này có thể đã bị xóa hoặc không tồn tại</p>
                                <a href="${pageContext.request.contextPath}/admin/comments" class="btn btn-primary">
                                    <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Form -->
    <form id="deleteForm" method="POST" action="${pageContext.request.contextPath}/admin/comments" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="id" id="deleteId">
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
        function confirmDelete(id, userName) {
            document.getElementById("confirmationTitle").innerText = "Xác nhận xóa bình luận";
            document.getElementById("confirmationBody").innerHTML = `
                <div class="text-center">
                    <i class="fas fa-exclamation-triangle text-warning fa-3x mb-3"></i>
                    <p>Bạn có chắc chắn muốn <strong class="text-danger">xóa vĩnh viễn</strong> bình luận của <strong>${userName}</strong>?</p>
                    <div class="alert alert-danger">
                        <i class="fas fa-info-circle me-2"></i>
                        <strong>Cảnh báo:</strong> Hành động này sẽ xóa bình luận khỏi cơ sở dữ liệu và không thể hoàn tác!
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