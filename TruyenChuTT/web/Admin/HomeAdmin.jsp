<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - TruyenTT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
     <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>📚</text></svg>">

    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.2/dist/chart.umd.min.js"></script>
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
                    <div class="sidebar-brand">
                        <h4 class="text-white d-flex align-items-center justify-content-center">
                            <i class="fas fa-book-open me-2"></i>TruyenTT
                        </h4>
                        <p class="text-white-50 mb-0">Admin Panel</p>
                    </div>
                    <nav class="nav flex-column">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/Admin/HomeAdmin.jsp">
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
                    <!-- Welcome Header -->
                    <div class="welcome-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h2 class="fw-bold mb-2">🎉 Chào mừng trở lại, ${sessionScope.user.hoTen}!</h2>
                                <p class="text-muted mb-0 fs-5">Quản lý hệ thống TruyenMoiMoi một cách hiệu quả</p>
                            </div>
                            <div class="text-muted fs-5">
                                <i class="fas fa-calendar me-2"></i>
                                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd/MM/yyyy HH:mm" />
                            </div>
                        </div>
                    </div>
                    
                    <!-- Success Message -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success d-flex align-items-center mb-4">
                            <i class="fas fa-check-circle me-3 fs-4"></i>
                            <div>
                                <strong>Thành công!</strong> ${success}
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger d-flex align-items-center mb-4">
                            <i class="fas fa-exclamation-circle me-3 fs-4"></i>
                            <div>
                                <strong>Lỗi!</strong> ${error}
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${empty success && empty error}">
                        <div class="alert alert-success d-flex align-items-center mb-4">
                            <i class="fas fa-check-circle me-3 fs-4"></i>
                            <div>
                                <strong>Thành công!</strong> Bạn đã đăng nhập admin thành công và có thể quản lý toàn bộ hệ thống!
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- Quick Actions -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0 fw-bold"><i class="fas fa-bolt me-2"></i>Hành động nhanh</h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-3 col-sm-6">
                                    <a href="${pageContext.request.contextPath}/admin/stories/add" class="btn btn-primary quick-action-btn w-100" data-bs-toggle="tooltip" title="Thêm truyện mới">
                                        <i class="fas fa-plus me-2"></i>Thêm truyện
                                    </a>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <a href="${pageContext.request.contextPath}/admin/chapters/add" class="btn btn-success quick-action-btn w-100" data-bs-toggle="tooltip" title="Thêm chương mới">
                                        <i class="fas fa-file-plus me-2"></i>Thêm chương
                                    </a>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <a href="${pageContext.request.contextPath}/admin/authors/add" class="btn btn-info quick-action-btn w-100" data-bs-toggle="tooltip" title="Thêm tác giả mới">
                                        <i class="fas fa-user-edit me-2"></i>Thêm tác giả
                                    </a>
                                </div>
                                <div class="col-md-3 col-sm-6">
                                    <a href="${pageContext.request.contextPath}/admin/categories/add" class="btn btn-warning quick-action-btn w-100" data-bs-toggle="tooltip" title="Thêm thể loại mới">
                                        <i class="fas fa-tag me-2"></i>Thêm thể loại
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Statistics Cards -->
                    <div class="row mb-4 g-4">
                        <div class="col-md-3 col-sm-6">
                            <div class="card stat-card">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-primary me-3">
                                            <i class="fas fa-users"></i>
                                        </div>
                                        <div>
                                            <h3 class="card-title mb-0 fw-bold">${tongNguoiDung != null ? tongNguoiDung : 0}</h3>
                                            <p class="card-text text-muted mb-0">Người dùng</p>
                                            <small class="text-success"><i class="fas fa-arrow-up me-1"></i>+12% tháng này</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="card stat-card">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-success me-3">
                                            <i class="fas fa-book"></i>
                                        </div>
                                        <div>
                                            <h3 class="card-title mb-0 fw-bold">${tongTruyen != null ? tongTruyen : 0}</h3>
                                            <p class="card-text text-muted mb-0">Truyện</p>
                                            <small class="text-success"><i class="fas fa-arrow-up me-1"></i>+8% tháng này</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="card stat-card">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-warning me-3">
                                            <i class="fas fa-file-alt"></i>
                                        </div>
                                        <div>
                                            <h3 class="card-title mb-0 fw-bold">${tongChuong != null ? tongChuong : 0}</h3>
                                            <p class="card-text text-muted mb-0">Chương</p>
                                            <small class="text-success"><i class="fas fa-arrow-up me-1"></i>+25% tháng này</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="card stat-card">
                                <div class="card-body p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="stat-icon bg-info me-3">
                                            <i class="fas fa-crown"></i>
                                        </div>
                                        <div>
                                            <h3 class="card-title mb-0 fw-bold">${tongTaiKhoanVIP != null ? tongTaiKhoanVIP : 0}</h3>
                                            <p class="card-text text-muted mb-0">Tài khoản VIP</p>
                                            <small class="text-success"><i class="fas fa-arrow-up me-1"></i>+5% tháng này</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Analytics Chart -->
                    <div class="card mb-4">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="mb-0 fw-bold"><i class="fas fa-chart-line me-2"></i>Thống kê hoạt động</h5>
                            <div class="chart-filter">
                                <button class="btn btn-sm btn-outline-primary active" data-chart="views">Lượt xem</button>
                                <button class="btn btn-sm btn-outline-primary" data-chart="comments">Bình luận</button>
                                <button class="btn btn-sm btn-outline-primary" data-chart="users">Người dùng</button>
                            </div>
                        </div>
                        <div class="card-body">
                            <canvas id="analyticsChart" height="100"></canvas>
                        </div>
                    </div>
                    
                    <!-- Recent Activities -->
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0 fw-bold"><i class="fas fa-user-plus me-2"></i>Người dùng mới nhất</h5>
                                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-outline-light">Xem tất cả</a>
                                </div>
                                <div class="card-body p-0">
                                    <c:choose>
                                        <c:when test="${not empty nguoiDungMoi}">
                                            <div class="table-responsive">
                                                <table class="table table-hover mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th class="ps-4">ID</th>
                                                            <th>Họ tên</th>
                                                            <th>Email</th>
                                                            <th>Vai trò</th>
                                                            <th>Ngày đăng ký</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="user" items="${nguoiDungMoi}">
                                                            <tr>
                                                                <td class="ps-4">${user.id}</td>
                                                                <td>${user.hoTen}</td>
                                                                <td>${user.email}</td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${user.vaiTro == 'ADMIN'}">
                                                                            <span class="badge badge-role bg-danger">Admin</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="badge badge-role bg-primary">User</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td>
                                                                    <fmt:formatDate value="${user.ngayTao}" pattern="dd/MM/yyyy HH:mm" />
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="empty-state">
                                                <i class="fas fa-users"></i>
                                                <p class="fs-5">Chưa có người dùng nào</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="mb-0 fw-bold"><i class="fas fa-book me-2"></i>Truyện mới nhất</h5>
                                    <a href="${pageContext.request.contextPath}/admin/stories" class="btn btn-sm btn-outline-light">Xem tất cả</a>
                                </div>
                                <div class="card-body p-0">
                                    <c:choose>
                                        <c:when test="${not empty truyenMoi}">
                                            <div class="table-responsive">
                                                <table class="table table-hover mb-0">
                                                    <thead>
                                                        <tr>
                                                            <th class="ps-4">ID</th>
                                                            <th>Tên truyện</th>
                                                            <th>Tác giả</th>
                                                            <th>Ngày tạo</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="truyen" items="${truyenMoi}">
                                                            <tr>
                                                                <td class="ps-4">${truyen.id}</td>
                                                                <td>${truyen.tenTruyen}</td>
                                                                <td>${truyen.tacGia}</td>
                                                                <td>
                                                                    <fmt:formatDate value="${truyen.ngayTao}" pattern="dd/MM/yyyy HH:mm" />
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="empty-state">
                                                <i class="fas fa-book"></i>
                                                <p class="fs-5">Chưa có truyện nào</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Toggle sidebar on mobile
            const sidebar = document.querySelector('.sidebar');
            const toggleBtn = document.createElement('button');
            toggleBtn.className = 'btn btn-primary d-md-none position-fixed top-0 start-0 m-2';
            toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
            toggleBtn.style.zIndex = '1001';
            document.body.appendChild(toggleBtn);
            
            toggleBtn.addEventListener('click', () => {
                sidebar.classList.toggle('active');
            });
            
            // Initialize tooltips
            const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
            const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
            
            // Chart.js for analytics
            const ctx = document.getElementById('analyticsChart').getContext('2d');
            const chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'],
                    datasets: [{
                        label: 'Lượt xem',
                        data: [120, 190, 300, 500, 200, 300, 450],
                        borderColor: 'var(--primary-color)',
                        backgroundColor: 'rgba(79, 70, 229, 0.1)',
                        fill: true,
                        tension: 0.4,
                        pointBackgroundColor: 'var(--primary-color)',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    plugins: { 
                        legend: { display: false }, 
                        title: { display: false } 
                    },
                    scales: {
                        y: { 
                            beginAtZero: true, 
                            grid: { color: 'rgba(0,0,0,0.05)' } 
                        },
                        x: { 
                            grid: { color: 'rgba(0,0,0,0.05)' } 
                        }
                    },
                    elements: { 
                        line: { borderWidth: 3 } 
                    }
                }
            });
            
            // Chart filter handling
            const filterButtons = document.querySelectorAll('.chart-filter .btn');
            filterButtons.forEach(button => {
                button.addEventListener('click', () => {
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    button.classList.add('active');
                    
                    const chartType = button.getAttribute('data-chart');
                    let data, label;
                    
                    if (chartType === 'views') {
                        data = [120, 190, 300, 500, 200, 300, 450];
                        label = 'Lượt xem';
                    } else if (chartType === 'comments') {
                        data = [50, 80, 120, 200, 100, 150, 180];
                        label  {
                        data = [50, 80, 120, 200, 100, 150, 180];
                        label = 'Bình luận';
                    } else if (chartType === 'users') {
                        data = [10, 15, 25, 30, 20, 35, 40];
                        label = 'Người dùng mới';
                    }
                    
                    chart.data.datasets[0].data = data;
                    chart.data.datasets[0].label = label;
                    chart.update();
                });
            });
        });
    </script>
</body>
</html>
