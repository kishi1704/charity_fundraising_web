<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Category</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
	integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
	integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
	crossorigin="anonymous"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<!--Custom javascript -->
<script src="<c:url value="/admin/js/category.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- Custom css -->
<link rel="stylesheet"
	href="<c:url value="/admin/css/category.css"/>">
</head>
<body>
	<div class="container-fluid p-0">
		<c:import url="../layout/header.jsp"></c:import>
		<div class="content min-vh-100">
			<div class="content-header px-2">
				<h4 class="mb-0 ms-2 py-3">Quản Lý Danh Mục</h4>
				<hr class="m-1">
				<div class="input-group mt-3">
					<input id="search-id" type="text" name="id"
						value="${sessionScope.categorySId}" class="form-control"
						placeholder="ID"> <input id="search-name" type="text"
						name="name" value="${sessionScope.categorySName}"
						class="form-control w-50" placeholder="Tên danh mục">
					<button type="button"
						class="btn-search btn btn-success btn-sm me-1">
						<i class="fa-solid fa-magnifying-glass"></i> Tìm Kiếm
					</button>
					<button type="button" class="btn-add btn btn-primary btn-sm mx-1">
						<i class="fa-solid fa-plus"></i> Thêm Mới
					</button>
				</div>
			</div>
			<div class="category-list px-2 mt-2">
				<table class="table table-bordered table-sm table-hover px-2">
					<thead class="table-primary">
						<tr class="text-center align-middle">
							<th><button type="button"
									class="btn btn-danger btn-sm text-center"
									id="btn-selected-delete" data-bs-target="#confirmModal"
									data-bs-toggle="modal">
									<i class="fa-solid fa-trash"></i>
								</button></th>
							<th>ID</th>
							<th>Tên danh mục</th>
							<th>Mô tả</th>
							<th>Trạng thái</th>
							<th>Chức năng</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty sessionScope.categories}">
								<tr class="text-center align-middle">
									<td colspan="6">Không tìm thấy danh mục</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="category" items="${sessionScope.categories}">
									<tr
										class="text-center align-middle row-category row-category-${category.id}">
										<td style="width: 2rem;"><input type="checkbox"
											class="category-check" name="deleteCategories"
											value="${category.id}"></td>
										<td class="category-id">${category.id}</td>
										<td class="category-name">${category.name}</td>
										<td class="category-description"><span
											class="d-inline-block text-truncate" style="width: 15rem;">
												${category.description}</span></td>
										<td class="category-status">${category.status}</td>
										<td class="function">
											<button type="button" class="btn-view btn btn-info btn-sm"
												value="${category.id}">Xem</button>
											<button type="button" class="btn-edit btn btn-warning btn-sm"
												value="${category.id}">Sửa</button>
											<button type="button"
												class="btn btn-danger btn-sm btn-delete"
												value="${category.id}" data-bs-target="#confirmModal"
												data-bs-toggle="modal">Xóa</button>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<!-- Display erorr message when delete failed -->
				<div class="error-message"></div>
				<!-- Show modal to view detail category -->
				<div class="category-modal"></div>
			</div>

			<!-- Import confirm modal -->
			<c:import url="../layout/confirmModal.jsp"></c:import>

			<div class="Page-navigation mt-4">
				<nav>
					<ul class="pagination justify-content-center">
						<c:choose>
							<c:when test="${sessionScope.index == 1}">
								<li class="page-item disabled"><a class="page-link"
									href="#" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link"
									href="<c:url value="/admin/category?index=${sessionScope.index - 1}&action=${sessionScope.categoryAction}
								&categoryId=${sessionScope.categorySId}&categoryName=${sessionScope.categorySName}"/>"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach var="i" begin="1" end="${sessionScope.endPage}">
							<li id="${i}" class="page-item"><a class="page-link"
								href="<c:url value="/admin/category?index=${i}&action=${sessionScope.categoryAction}&categoryId=${sessionScope.categorySId}
							&categoryName=${sessionScope.categorySName}"/>">${i}</a></li>
						</c:forEach>

						<c:choose>
							<c:when
								test="${sessionScope.index == sessionScope.endPage || sessionScope.endPage == 0}">
								<li class="page-item disabled"><a class="page-link"
									href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link"
									href="<c:url value="/admin/category?index=${sessionScope.index + 1}
								&action=${sessionScope.categoryAction}&categoryId=${sessionScope.categorySId}&categoryName=${sessionScope.categorySName}"/>"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</nav>
			</div>

		</div>

		<!-- Import footer layout -->
		<c:import url="../layout/footer.jsp"></c:import>
	</div>

	<script>
		// active page index
		$("#${sessionScope.index}").addClass('active');

		// view category
		$(document).ready(function() {

			$(".btn-view").click(function(e) {
				e.stopPropagation();

				var pathS = window.location.pathname.split("/");
				$.ajax({
					url : "/" + pathS[1] + "/admin/category",
					type : "get", //send it through post method
					data : {
						action : "view",
						categoryId : $(e.target).val(),
					},
					success : function(data) {

						$(".category-modal").html(data);

						$("#category-modal-view").modal('show');

					},
					error : function() {
						// Do something to handle
					}
				});
			})

		})
	</script>
</body>

</html>