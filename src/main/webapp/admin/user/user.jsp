<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User</title>

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
<script src="<c:url value="/admin/js/user.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- Custom css -->
<link rel="stylesheet" href="<c:url value="/admin/css/user.css"/>">
</head>
<body>
	<div class="container-fluid p-0">
		<c:import url="../layout/header.jsp"></c:import>
		<div class="content min-vh-100">
			<div class="content-header px-2">
				<h4 class="mb-0 ms-2 py-3">Quản Lý Người Dùng</h4>
				<hr class="m-1">
				<div class="input-group mt-3">
					<input id="search-name" type="text" name="username"
						value="${sessionScope.userSUsername}" class="form-control w-25"
						placeholder="Tên người dùng"> <input id="search-email"
						type="text" name="email" value="${sessionScope.userSEmail}"
						class="form-control w-25" placeholder="Email"><select
						id="filter-user" name="userRole" class="form-select w-20">
						<option value="" selected>Vai trò</option>
						<c:forEach var="role" items="${sessionScope.roleList}">
							<c:choose>
								<c:when test="${role.key == sessionScope.userSRole}">
									<option value="${role.key}" selected>${role.value}</option>
								</c:when>
								<c:otherwise>
									<option value="${role.key}">${role.value}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
					<button type="button"
						class="btn-search btn btn-success btn-sm me-1">
						<i class="fa-solid fa-magnifying-glass"></i> Tìm Kiếm
					</button>
					<button type="button" class="btn-add btn btn-primary btn-sm mx-1">
						<i class="fa-solid fa-plus"></i> Thêm Mới
					</button>
				</div>
			</div>
			<div class="user-list px-2 mt-2">
				<table class="table table-bordered table-sm table-hover px-2">
					<thead class="table-primary">
						<tr class="text-center align-middle">
							<th>ID</th>
							<th>Tên đăng nhập</th>
							<th>Vai trò</th>
							<th>Họ và tên</th>
							<th>SĐT</th>
							<th>Email</th>
							<th>Địa chỉ</th>
							<th>Trạng thái</th>
							<th>Chức năng</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty sessionScope.users}">
								<tr class="text-center align-middle">
									<td colspan="9">Không tìm thấy người dùng</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="user" items="${sessionScope.users}">
									<tr
										class="text-center align-middle row-user row-user-${user.id}">
										<td class="user-id">${user.id}</td>
										<td class="username">${user.username}</td>
										<td class="user-role">${user.role == 1 ? 'User' : 'Admin'}</td>
										<td class="user-fullname">${user.fullName}</td>
										<td class="user-phonenumber">${user.phoneNumber}</td>
										<td class="user-phonenumber">${user.email}</td>
										<td class="user-address"><span
											class="d-inline-block text-truncate" style="width: 8rem;">
												${user.address}</span></td>
										<td class="user-status">${user.status}</td>
										<td class="function">
											<button type="button" class="btn-view btn btn-info btn-sm"
												value="${user.id}">Xem</button>
											<button type="button" class="btn-edit btn btn-warning btn-sm"
												value="${user.id}">Sửa</button> <c:if
												test="${sessionScope.user.id != user.id && user.status == 'Disable'}">
												<button type="button"
													class="btn btn-danger btn-sm btn-delete" value="${user.id}"
													data-bs-target="#confirmModal" data-bs-toggle="modal">Xóa</button>
											</c:if>
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
				<div class="user-modal"></div>
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
									href="${pageContext.request.contextPath}/admin/user?index=${sessionScope.index - 1}&action=${sessionScope.userAction}
								&username=${sessionScope.SUsername}&email=${sessionScope.userSEmail}&userRole=${sessionScope.userSRole}"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach var="i" begin="1" end="${sessionScope.endPage}">
							<li id="${i}" class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/admin/user?index=${i}&action=${sessionScope.userAction}
								&username=${sessionScope.SUsername}&email=${sessionScope.userSEmail}&userRole=${sessionScope.userSRole}">${i}</a></li>
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
									href="${pageContext.request.contextPath}/admin/user?index=${sessionScope.index + 1}&action=${sessionScope.userAction}
								&username=${sessionScope.SUsername}&email=${sessionScope.userSEmail}&userRole=${sessionScope.userSRole}"
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

		// view user
		$(document).ready(function() {

			$(".btn-view").click(function(e) {
				e.stopPropagation();

				var pathS = window.location.pathname.split("/");
				$.ajax({
					url : "/" + pathS[1] + "/admin/user",
					type : "get", //send it through post method
					data : {
						action : "view",
						userId : $(e.target).val(),
					},
					success : function(data) {

						$(".user-modal").html(data);

						$("#user-modal-view").modal('show');

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