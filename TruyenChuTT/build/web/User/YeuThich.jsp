<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yêu Thích - TruyenChuTT</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem 0;
            font-family: 'Inter', sans-serif;
        }
        .container {
            max-width: 1200px;
        }
        .header-card {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        .story-card {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(20px);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.18);
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
        }
        .story-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(31, 38, 135, 0.4);
        }
        .story-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
        }
        .btn-action {
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
        }
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: rgba(255, 255, 255, 0.8);
        }
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        .favorite-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: linear-gradient(135deg, #ffd700 0%, #ffb347 100%);
            color: #fff;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header-card">
            <h1 class="text-white mb-3"><i class="fas fa-heart"></i> Truyện Yêu Thích</h1>
            <p class="text-white-50 mb-0">
                <c:if test="${totalItems != null}">
                    Tổng số: <strong>${totalItems}</strong> truyện
                </c:if>
            </p>
        </div>

        <c:choose>
            <c:when test="${empty danhSach}">
                <div class="empty-state">
                    <i class="fas fa-heart"></i>
                    <h3 class="text-white">Chưa có truyện yêu thích</h3>
                    <p class="text-white-50">Hãy thêm truyện vào yêu thích để đọc sau!</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-light btn-action mt-3">
                        <i class="fas fa-search"></i> Tìm truyện
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach var="item" items="${danhSach}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="story-card position-relative">
                                <span class="favorite-badge"><i class="fas fa-heart"></i> Yêu thích</span>
                                <a href="${pageContext.request.contextPath}/story?id=${item.truyen.id}" class="text-decoration-none">
                                    <img src="${item.truyen.anhBia != null && !empty item.truyen.anhBia ? item.truyen.anhBia : 'assets/images/default-cover.jpg'}" 
                                         alt="${item.truyen.tenTruyen}" 
                                         class="story-img mb-3">
                                    <h5 class="text-white mb-2">${item.truyen.tenTruyen}</h5>
                                    <p class="text-white-50 small mb-2">
                                        <i class="fas fa-user"></i> ${item.truyen.tacGiaTen != null ? item.truyen.tacGiaTen : 'Chưa có'}
                                    </p>
                                    <p class="text-white-50 small mb-3">
                                        <i class="fas fa-calendar"></i> ${item.ngayYeuThichFormatted}
                                    </p>
                                </a>
                                <div class="d-flex gap-2">
                                    <a href="${pageContext.request.contextPath}/story?id=${item.truyen.id}" 
                                       class="btn btn-primary btn-sm btn-action flex-fill">
                                        <i class="fas fa-book-open"></i> Đọc tiếp
                                    </a>
                                    <button onclick="removeFromFavorites(${item.truyen.id})" 
                                            class="btn btn-danger btn-sm btn-action">
                                        <i class="fas fa-heart-broken"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${pagination.totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <c:if test="${pagination.hasPreviousPage()}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${pagination.previousPage}">Trước</a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="1" end="${pagination.totalPages}">
                                <li class="page-item ${i == pagination.currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <c:if test="${pagination.hasNextPage()}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${pagination.nextPage}">Sau</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function removeFromFavorites(truyenId) {
            if (!confirm('Bạn có chắc muốn xóa truyện này khỏi yêu thích?')) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/yeuthich/remove', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'truyenId=' + truyenId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    location.reload();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra');
            });
        }
    </script>
</body>
</html>






