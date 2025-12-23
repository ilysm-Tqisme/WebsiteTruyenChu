<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Tác Giả - TruyenTT</title>
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
        
        body { 
            font-family: 'Inter', sans-serif; 
            background-color: var(--bg-color); 
        }
        
        .sidebar { 
            min-height: 100vh; 
            background: linear-gradient(180deg, var(--primary-color) 0%, var(--secondary-color) 100%); 
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
            transition: all 0.3s ease; 
            display: flex; 
            align-items: center; 
            gap: 0.875rem; 
            font-weight: 500; 
        }
        
        .sidebar .nav-link:hover, .sidebar .nav-link.active { 
            background-color: rgba(255, 255, 255, 0.2); 
            color: white; 
            transform: translateX(8px); 
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); 
        }
        
        .sidebar .nav-link i { 
            width: 20px; 
            text-align: center; 
            font-size: 1.1rem; 
        }
        
        .stat-card { 
            border: none; 
            border-radius: 20px; 
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08); 
            transition: all 0.3s ease; 
            background: white; 
            overflow: hidden; 
            position: relative; 
        }
        
        .stat-card::before { 
            content: ''; 
            position: absolute; 
            top: 0; 
            left: 0; 
            right: 0; 
            height: 4px; 
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color)); 
        }
        
        .stat-card:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15); 
        }
        
        .stat-icon { 
            width: 60px; 
            height: 60px; 
            border-radius: 16px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-size: 1.75rem; 
            color: white; 
            transition: transform 0.3s ease; 
            position: relative; 
        }
        
        .stat-icon::before { 
            content: ''; 
            position: absolute; 
            inset: 0; 
            border-radius: 16px; 
            background: inherit; 
            opacity: 0.1; 
            transform: scale(1.5); 
        }
        
        .stat-card:hover .stat-icon { 
            transform: scale(1.15) rotate(5deg); 
        }
        
        .main-content { 
            padding: 2.5rem; 
            min-height: 100vh; 
        }
        
        .card { 
            border: none; 
            border-radius: 20px; 
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08); 
            transition: all 0.3s ease; 
            overflow: hidden; 
        }
        
        .card:hover { 
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12); 
        }
        
        .card-header { 
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); 
            color: white; 
            border-radius: 20px 20px 0 0; 
            padding: 1.5rem; 
            border: none; 
        }
        
        .table { 
            background: white; 
            border-radius: 15px; 
            overflow: hidden; 
        }
        
        .table th { 
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%); 
            color: #1f2937; 
            font-weight: 600; 
            border: none; 
            padding: 1rem; 
        }
        
        .table td { 
            vertical-align: middle; 
            padding: 1rem; 
            border-color: #f1f5f9; 
        }
        
        .alert-success { 
            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%); 
            border: 1px solid #86efac; 
            border-radius: 15px; 
            color: #166534; 
        }
        
        .quick-action-btn { 
            transition: all 0.3s ease; 
            border-radius: 12px; 
            padding: 0.75rem 1.5rem; 
            font-weight: 600; 
            position: relative; 
            overflow: hidden; 
        }
        
        .quick-action-btn::before { 
            content: ''; 
            position: absolute; 
            top: 0; 
            left: -100%; 
            width: 100%; 
            height: 100%; 
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent); 
            transition: left 0.5s; 
        }
        
        .quick-action-btn:hover::before { 
            left: 100%; 
        }
        
        .quick-action-btn:hover { 
            transform: translateY(-3px); 
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15); 
        }
        
        .chart-filter .btn { 
            margin-right: 0.5rem; 
            margin-bottom: 0.5rem; 
            border-radius: 25px; 
            padding: 0.5rem 1.25rem; 
            font-weight: 500; 
            transition: all 0.3s ease; 
        }
        
        .chart-filter .btn.active { 
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); 
            border-color: var(--primary-color); 
            transform: scale(1.05); 
        }
        
        .sidebar-brand { 
            background: rgba(255, 255, 255, 0.1); 
            border-radius: 15px; 
            padding: 1.5rem; 
            margin-bottom: 2rem; 
            text-align: center; 
            backdrop-filter: blur(10px); 
        }
        
        .sidebar-brand h4 { 
            margin: 0; 
            font-weight: 700; 
            font-size: 1.5rem; 
        }
        
        .sidebar-brand p { 
            margin: 0.5rem 0 0 0; 
            opacity: 0.8; 
            font-size: 0.9rem; 
        }
        
        .welcome-header { 
            background: linear-gradient(135deg, white 0%, #f8fafc 100%); 
            border-radius: 20px; 
            padding: 2rem; 
            margin-bottom: 2rem; 
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); 
        }
        
        .welcome-header h2 { 
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%); 
            -webkit-background-clip: text; 
            -webkit-text-fill-color: transparent; 
            background-clip: text; 
            margin: 0; 
        }
        
        @media (max-width: 768px) {
            .sidebar { 
                position: fixed; 
                z-index: 1000; 
                width: 280px; 
                transform: translateX(-100%); 
                transition: transform 0.3s ease; 
            }
            .sidebar.active { 
                transform: translateX(0); 
            }
            .main-content { 
                padding: 1.5rem; 
            }
            .stat-card { 
                margin-bottom: 1rem; 
            }
        }
        
        .badge-role { 
            padding: 0.5rem 1rem; 
            border-radius: 25px; 
            font-weight: 600; 
            font-size: 0.75rem; 
        }
        
        .table-hover tbody tr:hover { 
            background-color: rgba(79, 70, 229, 0.05); 
        }
        
        .empty-state { 
            padding: 3rem; 
            text-align: center; 
            color: #6b7280; 
        }
        
        .empty-state i { 
            font-size: 3rem; 
            margin-bottom: 1rem; 
            opacity: 0.5; 
        }
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
                    <p class="text-white-50">Admin Panel</p>
                </div>
                <nav class="nav flex-column">
                    <a class="nav-link" href="${pageContext.request.contextPath}/Admin/HomeAdmin.jsp"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i>Quản lý người dùng</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/stories"><i class="fas fa-book"></i>Quản lý truyện</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/chapters"><i class="fas fa-file-alt"></i>Quản lý chương</a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/authors"><i class="fas fa-pen-fancy"></i>Quản lý tác giả</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories"><i class="fas fa-tags"></i>Quản lý thể loại</a>
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

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 main-content">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Danh sách Tác Giả</h5>
                    <button class="btn btn-light text-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#addAuthorModal">
                        <i class="fas fa-plus"></i> Thêm Tác Giả
                    </button>
                </div>
                <div class="card-body">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-success">${errorMessage}</div>
                    </c:if>
                    <c:if test="${not empty message}">
                        <div class="alert alert-success">${message}</div>
                    </c:if>

<!-- Search and Filter -->
<div class="card mb-4">
  <div class="card-body">
    <div class="row">
      <div class="col-md-8">
        <form class="search-form" action="${pageContext.request.contextPath}/admin/authors" method="GET">
          <input type="hidden" name="action" value="search">
          <div class="input-group">
            <span class="input-group-text bg-white border-end-0">
              <i class="fas fa-search"></i>
            </span>
            <input type="text" class="form-control border-start-0" name="searchTerm" placeholder="Tìm kiếm theo tên tác giả..." value="${searchTerm}">
          </div>
        </form>
      </div>
      <div class="col-md-4 text-md-end mt-3 mt-md-0">
        <c:if test="${isSearchResult}">
          <a href="${pageContext.request.contextPath}/admin/authors" class="btn btn-outline-secondary">
            <i class="fas fa-undo me-2"></i>Quay lại danh sách
          </a>
        </c:if>
      </div>
    </div>
  </div>
</div>


                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Mô Tả</th>
                            <th>Ảnh</th>
                            <th>Ngày Tạo</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="tg" items="${dsTacGia}">
                            <tr>
                                <td>${tg.id}</td>
                                <td>${tg.tenTacGia}</td>
                                <td>${tg.moTa}</td>
                            <td>
                            <c:if test="${not empty tg.anhDaiDien}">
                                <img src="${tg.anhDaiDien}" width="50" class="rounded-circle">
                            </c:if>
                            </td>


                                 <td>${tg.ngayTaoFormatted}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/authors?action=view&id=${tg.id}
" class="btn btn-sm btn-info">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <button type="button" class="btn btn-sm btn-danger" onclick="confirmDelete(${tg.id}, '${tg.tenTacGia}')">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
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

    <!-- Modal Thêm Tác Giả -->
<div class="modal fade" id="addAuthorModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin/authors" method="POST">
                <input type="hidden" name="action" value="create">
                <div class="modal-header">
                    <h5 class="modal-title">Thêm Tác Giả</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <label class="form-label">Tên Tác Giả</label>
                    <input type="text" name="tenTacGia" class="form-control mb-3" required>
                    <label class="form-label">Mô Tả</label>
                    <textarea name="moTa" class="form-control mb-3"></textarea>
                    <label class="form-label">Ảnh (URL)</label>
                    <input type="text" name="anhDaiDien" class="form-control">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Tạo Mới</button>
                </div>
            </form>
        </div>
    </div>
</div>


    <!-- Modal Xác nhận Xóa -->
    <div class="modal fade" id="confirmationModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xóa Tác Giả</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="confirmationBody">
                    Bạn có chắc chắn muốn xóa Tác Giả này?
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button class="btn btn-danger" id="confirmDeleteBtn">Xác nhận</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(id, name) {
        document.getElementById("confirmationBody").innerHTML =
            `Bạn có chắc chắn muốn <strong>xóa</strong> Tác Giả <strong>${name}</strong>?`;
        const modal = new bootstrap.Modal(document.getElementById("confirmationModal"));
        modal.show();
        document.getElementById("confirmDeleteBtn").onclick = function () {
            document.getElementById("deleteAuthorId").value = id;
            document.getElementById("deleteForm").submit();
        };
    }
</script>
</body>
</html>
