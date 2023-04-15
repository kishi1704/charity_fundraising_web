<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Foundation</title>

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
<script src="<c:url value="/admin/js/foundation.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
<!-- Custom css -->
<link rel="stylesheet" href="<c:url value="/admin/css/foundation.css"/>">
</head>

<body>
	<div class="container-fluid p-0">
		<!-- Import header layout -->
		<c:import url="../layout/header.jsp"></c:import>
		<div class="content min-vh-100">
			<div class="content-header px-2">
				<h4 class="mb-0 ms-2 py-3">Quản Lý Nhà Tổ Chức Qũy</h4>
				<hr class="m-1">
				<div class="input-group mt-3">
					<input id="search-id" type="text" name="id"
						value="${sessionScope.foundationSId}" class="form-control"
						placeholder="ID"> <input id="search-name" type="text"
						name="name" value="${sessionScope.foundationSName}"
						class="form-control w-25" placeholder="Tên nhà tổ chức"><input
						id="search-email" type="text" name="email"
						value="${sessionScope.foundationSEmail}" class="form-control w-25"
						placeholder="Email">
					<button type="button"
						class="btn-search btn btn-success btn-sm me-1">
						<i class="fa-solid fa-magnifying-glass"></i> Tìm Kiếm
					</button>
					<button type="button" class="btn-add btn btn-primary btn-sm mx-1">
						<i class="fa-solid fa-plus"></i> Thêm Mới
					</button>
				</div>
			</div>
			<div class="foundation-list px-2 mt-2">
				<table class="table table-bordered table-sm table-hover">
					<thead class="table-primary">
						<tr class="text-center align-middle">
							<th><button type="button"
									class="btn btn-danger btn-sm text-center"
									id="btn-selected-delete" data-bs-target="#confirmModal"
									data-bs-toggle="modal">
									<i class="fa-solid fa-trash"></i>
								</button></th>
							<th>ID</th>
							<th>Tên nhà tổ chức</th>
							<th>Mô tả</th>
							<th>Email</th>
							<th>Trạng thái</th>
							<th>Chức năng</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty sessionScope.foundations}">
								<tr class="text-center align-middle">
									<td colspan="7">Không tìm thấy nhà tổ chức</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="foundation" items="${sessionScope.foundations}">
									<tr
										class="text-center align-middle row-foundation row-foundation-${foundation.id}">
										<td style="width: 2rem;"><input type="checkbox"
											class="foundation-check" name="deleteFoundations"
											value="${foundation.id}"></td>
										<td class="foundation-id" style="width: 2rem;">${foundation.id}</td>
										<td class="foundation-name"><span
											class="d-inline-block text-truncate" style="width: 12rem;">
												${foundation.name}</span></td>
										<td class="foundation-description"><span
											class="d-inline-block text-truncate" style="width: 12rem;">
												${foundation.description}</span></td>
										<td class="foundation-email"><i
											class="fa-solid fa-envelope"></i> ${foundation.email}</td>
										<td class="foundation-status">${foundation.status}</td>
										<td class="function">
											<button type="button" class="btn-view btn btn-info btn-sm"
												value="${foundation.id}">Xem</button>
											<button type="button" class="btn-edit btn btn-warning btn-sm"
												value="${foundation.id}">Sửa</button>
											<button type="button"
												class="btn btn-danger btn-sm btn-delete"
												value="${foundation.id}" data-bs-target="#confirmModal"
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
				<div class="foundation-modal"></div>
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
									href="<c:url value="/admin/foundation?index=${sessionScope.index - 1}&action=${sessionScope.foundationAction}
								&foundationId=${sessionScope.foundationSId}&foundationName=${sessionScope.foundationSName}&foundationEmail=${sessionScope.foundationSEmail}"/>"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach var="i" begin="1" end="${sessionScope.endPage}">
							<li id="${i}" class="page-item"><a class="page-link"
								href="<c:url value="/admin/foundation?index=${i}&action=${sessionScope.foundationAction}&foundationId=${sessionScope.foundationSId}
							&foundationName=${sessionScope.foundationSName}&foundationEmail=${sessionScope.foundationSEmail}"/>">${i}</a></li>
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
									href="<c:url value="/admin/foundation?index=${sessionScope.index + 1}
								&action=${sessionScope.foundationAction}&foundationId=${sessionScope.foundationSId}&foundationName=${sessionScope.foundationSName}&foundationEmail=${sessionScope.foundationSEmail}"/>"
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

		// view foundation
		$(document).ready(function() {

			$(".btn-view").click(function(e) {
				e.stopPropagation();

				var pathS = window.location.pathname.split("/");
				$.ajax({
					url : "/" + pathS[1] + "/admin/foundation",
					type : "get", //send it through post method
					data : {
						action : "view",
						foundationId : $(e.target).val(),
					},
					success : function(data) {

						$(".foundation-modal").html(data);

						$("#foundation-modal-view").modal('show');

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