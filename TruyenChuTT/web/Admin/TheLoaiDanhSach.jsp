<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Thể Loại - TruyenTT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #7c3aed;
            --bg-color: #f1f5f9;
        }
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
        }
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, var(--primary-color), var(--secondary-color));
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
            display: flex;
            align-items: center;
            gap: 0.875rem;
            font-weight: 500;
        }
        .sidebar .nav-link:hover, .sidebar .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
        }
        .sidebar .nav-link i {
            width: 20px;
            text-align: center;
        }
        .main-content {
            padding: 2rem;
        }
        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                z-index: 1000;
                width: 260px;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }
            .sidebar.active {
                transform: translateX(0);
            }
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 px-0">
            <div class="sidebar text-white">
                <div class="sidebar-brand mb-4 text-center">
                    <h4><i class="fas fa-book-open me-2"></i>TruyenTT</h4>
                    <p class="text-white-50">Admin Panel</p>
                </div>
                <nav class="nav flex-column">
                    <a class="nav-link" href="${pageContext.request.contextPath}/Admin/HomeAdmin.jsp"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i>Quản lý người dùng</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/stories"><i class="fas fa-book"></i>Quản lý truyện</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/chapters"><i class="fas fa-file-alt"></i>Quản lý chương</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/authors"><i class="fas fa-pen-fancy"></i>Quản lý tác giả</a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/categories"><i class="fas fa-tags"></i>Quản lý thể loại</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/comments"><i class="fas fa-comments"></i>Quản lý bình luận</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/ads"><i class="fas fa-ad"></i>Quản lý quảng cáo</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/vip"><i class="fas fa-crown"></i>Quản lý VIP</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/payments">
                            <i class="fas fa-credit-card"></i>Yêu cầu thanh toán
                        </a>
                    <hr class="text-white-50 my-3">
                    <a class="nav-link" href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i>Về trang chủ</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i>Đăng xuất</a>
                </nav>
            </div>
        </div>

        <!-- Main content -->
        <div class="col-md-9 col-lg-10">
            <div class="main-content">
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Danh sách Thể Loại</h5>
                        <button class="btn btn-light text-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                            <i class="fas fa-plus"></i> Thêm Thể Loại
                        </button>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty message}">
    <div class="alert alert-info">${message}</div>
</c:if>


                        <!-- Search -->
                        <form class="row g-3 mb-4" action="${pageContext.request.contextPath}/admin/categories" method="GET">
                            <input type="hidden" name="action" value="search">
                            <div class="col-md-10">
                                <input type="text" name="searchTerm" value="${searchTerm}" class="form-control" placeholder="Tìm kiếm theo tên thể loại...">
                            </div>
                            <div class="col-md-2 text-end">
                                <button class="btn btn-outline-secondary w-100"><i class="fas fa-search"></i></button>
                            </div>
                        </form>

                        <c:if test="${isSearchResult}">
                            <div class="text-end mb-3">
                                <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-sm btn-outline-dark">
                                    <i class="fas fa-undo"></i> Quay lại danh sách
                                </a>
                            </div>
                        </c:if>

                        <table class="table table-hover">
                            <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Tên</th>
                                <th>Mô Tả</th>
                                <th>Màu</th>
                                <th>Ngày Tạo</th>
                                <th>Trạng Thái</th>
                                <th>Hành Động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="tl" items="${dsTheLoai}">
                                <tr>
                                    <td>${tl.id}</td>
                                    <td>${tl.tenTheLoai}</td>
                                    <td>${tl.moTa}</td>
                                    <td><span class="badge" style="background-color: ${tl.mauSac};">${tl.mauSac}</span></td>
                                    <td>${tl.ngayTao}</td>
                                    <td>
                                        <span class="badge bg-${tl.trangThai ? 'success' : 'secondary'}">
                                            ${tl.trangThai ? 'Hiển thị' : 'Ẩn'}
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-danger" onclick="confirmDelete(${tl.id}, '${tl.tenTheLoai}')">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${empty dsTheLoai}">
                            <div class="alert alert-warning text-center">Không có thể loại nào được tìm thấy.</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Thêm -->
<div class="modal fade" id="addCategoryModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin/categories" method="POST">
                <input type="hidden" name="action" value="create">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm Thể Loại</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <label class="form-label">Tên Thể Loại</label>
                    <input type="text" name="tenTheLoai" class="form-control mb-3" required>
                    <label class="form-label">Mô Tả</label>
                    <textarea name="moTa" class="form-control mb-3"></textarea>
                    <label class="form-label">Màu Sắc (#HEX)</label>
                    <input type="text" name="mauSac" class="form-control" value="#4f46e5">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Tạo Mới</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Form Xóa -->
<form id="deleteForm" action="${pageContext.request.contextPath}/admin/categories" method="POST" style="display: none;">
    <input type="hidden" name="action" value="delete">
    <input type="hidden" id="deleteId" name="id">
</form>

<!-- Modal Xác Nhận Xóa -->
<div class="modal fade" id="confirmationModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="confirmationBody">Bạn có chắc chắn muốn xóa thể loại này?</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button class="btn btn-danger" id="confirmDeleteBtn">Xác nhận</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(id, name) {
        document.getElementById("confirmationBody").innerHTML =
            `Bạn có chắc chắn muốn <strong>xóa</strong> thể loại <strong>${name}</strong>?`;
        const modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
        modal.show();
        document.getElementById("confirmDeleteBtn").onclick = function () {
            document.getElementById("deleteId").value = id;
            document.getElementById("deleteForm").submit();
        };
    }
</script>
</body>
</html>
