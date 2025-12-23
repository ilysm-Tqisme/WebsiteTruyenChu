<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Tác Giả - TruyenTT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #7c3aed;
            --bg-color: #f1f5f9;
        }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-color); }
        .sidebar { min-height: 100vh; background: linear-gradient(180deg, var(--primary-color) 0%, var(--secondary-color) 100%); padding: 1.5rem; position: sticky; top: 0; }
        .sidebar .nav-link { color: rgba(255, 255, 255, 0.9); padding: 0.875rem 1.25rem; border-radius: 12px; margin: 0.25rem 0; display: flex; align-items: center; gap: 0.875rem; font-weight: 500; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: rgba(255, 255, 255, 0.2); color: white; transform: translateX(8px); }
        .main-content { padding: 2.5rem; min-height: 100vh; }
        .card { border: none; border-radius: 20px; box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08); overflow: hidden; }
        .card-header { background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); color: white; border-radius: 20px 20px 0 0; padding: 1.5rem; }
        .author-avatar { width: 120px; height: 120px; border-radius: 50%; overflow: hidden; border: 4px solid white; box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1); margin: 0 auto; }
        .author-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .info-label { color: #64748b; font-size: 0.9rem; font-weight: 500; }
        .info-value { font-weight: 600; color: #0f172a; font-size: 1.05rem; }
        .action-btn { border-radius: 12px; padding: 0.75rem 1.5rem; font-weight: 500; transition: all 0.3s ease; }
        .action-btn:hover { transform: translateY(-3px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 px-0">
            <div class="sidebar">
                <div class="sidebar-brand mb-4 text-center text-white">
                    <h4><i class="fas fa-book-open me-2"></i>TruyenTT</h4>
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/authors">
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

        <!-- Main content -->
        <div class="col-md-9 col-lg-10">
            <div class="main-content">
                <!-- Header -->
                <div class="page-header d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="fw-bold mb-1">Chi tiết Tác Giả</h2>
                        <p class="text-muted mb-0">Xem thông tin và quản lý Tác Giả</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/authors" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                    </a>
                </div>

                <!-- Card -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0 fw-bold"><i class="fas fa-user me-2"></i>Thông tin Tác Giả</h5>
                    </div>
                    <div class="card-body p-4 text-center">
                        <div class="author-avatar mb-3">
                            <c:choose>
<c:when test="${not empty tacGia.anhDaiDien}">
  <img src="${tacGia.anhDaiDien}" alt="${tacGia.tenTacGia}">
</c:when>


                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/assets/images/default-avatar.png" alt="No Avatar">
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <h4 class="fw-bold mb-2">${tacGia.tenTacGia}</h4>
                        <p class="text-muted mb-3">${tacGia.moTa}</p>

                        <div class="row justify-content-center">
                            <div class="col-md-6 text-start">
                                <p class="mb-2"><span class="info-label">ID:</span> <span class="info-value">${tacGia.id}</span></p>
                                <p class="mb-2"><span class="info-label">Ngày tạo:</span>
                                    <span class="info-value">
                                        <td>${tacGia.ngayTaoFormatted}</td>
                                    </span>
                                </p>
                            </div>
                        </div>

                        <!-- Xóa Tác Giả -->
                        <div class="mt-4">
                            <button type="button" class="btn btn-outline-danger action-btn" onclick="confirmDelete(${tacGia.id}, '${tacGia.tenTacGia}')">
                                <i class="fas fa-trash-alt me-2"></i>Xóa Tác Giả
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ✅ FORM XÓA CHUẨN -->
<form id="deleteForm"
      action="${pageContext.request.contextPath}/admin/authors"
      method="POST"
      style="display: none;">
  <input type="hidden" name="action" value="delete">
  <input type="hidden" id="deleteAuthorId" name="id">
</form>


    <!-- Modal xác nhận -->
    <div class="modal fade" id="confirmationModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="confirmationTitle">Xác nhận xóa Tác Giả</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4" id="confirmationBody">
                    Bạn có chắc chắn muốn <strong>xóa</strong> Tác Giả <strong></strong>? Hành động này không thể hoàn tác.
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

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(id, tenTacGia) {
        document.getElementById("confirmationBody").innerHTML =
            `Bạn có chắc chắn muốn <strong>xóa</strong> Tác Giả <strong>${tenTacGia}</strong>? Hành động này không thể hoàn tác.`;
        const modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
        modal.show();
        document.getElementById("confirmActionBtn").onclick = function () {
            document.getElementById("deleteAuthorId").value = id;
            document.getElementById("deleteForm").submit();
        };
    }
</script>
</body>
</html>
