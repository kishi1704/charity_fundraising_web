<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Form</title>

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
<script src="<c:url value="/admin/js/userForm.js"/>"></script>

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
				<c:choose>
					<c:when test="${sessionScope.userAction == 'edit'}">
						<h4 class="mb-0 ms-2 py-3">Chỉnh sửa tài khoản</h4>
					</c:when>
					<c:when test="${sessionScope.userAction == 'add'}">
						<h4 class="mb-0 ms-2 py-3">Thêm tài khoản Admin mới</h4>
					</c:when>
				</c:choose>
				<hr class="m-1">
			</div>
			<div class="user-form px-2 mt-2">
				<form action="" method="post" novalidate>
					<c:if test="${sessionScope.userAction == 'edit'}">
						<div class="form-group">
							<label class="form-label">ID</label> <input id="user-id"
								type="text" class="form-control"
								value="${sessionScope.userEdit.id}" readonly name="userId" />
						</div>
					</c:if>

					<div class="form-group has-validation">
						<label class="form-label">Tên đăng nhập</label> <input
							id="username" type="text" class="form-control"
							value="${sessionScope.userEdit.username}" name="username">
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>

					<c:if test="${sessionScope.userAction == 'edit'}">
						<div class="form-group">
							<label class="form-label">Vai trò</label> <select id="user-role"
								class="form-select w-15" name="userRole"
								${sessionScope.userEdit.role == 2 ? 'disabled' : ''}>
								<c:forEach var="role" items="${sessionScope.roleList}">
									<c:choose>
										<c:when test="${role.key == sessionScope.userEdit.role}">
											<option value="${role.key}" selected>${role.value}</option>
										</c:when>
										<c:otherwise>
											<option value="${role.key}">${role.value}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
						</div>
					</c:if>

					<div class="form-group has-validation">
						<label class="form-label">Họ và tên</label> <input
							id="user-fullname" type="text" class="form-control"
							value="${sessionScope.userEdit.fullName}" name="userFullName">
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>

					<div class="form-group has-validation">
						<label class="form-label">Số điện thoại</label> <input
							id="user-phone-number" type="text" class="form-control"
							value="${sessionScope.userEdit.phoneNumber}"
							name="userPhoneNumber">
						<div class="invalid-feedback">Số điện thoại gồm 10 chữ số!</div>
					</div>

					<div class="form-group has-validation">
						<label class="form-label">Email</label> <input id="user-email"
							type="text" class="form-control"
							value="${sessionScope.userEdit.email}" name="userEmail">
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>

					<div class="form-group has-validation">
						<label class="form-label">Địa chỉ</label> <input id="user-address"
							type="text" class="form-control"
							value="${sessionScope.userEdit.address}" name="userAddress">
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>

					<c:if test="${sessionScope.userAction == 'edit'}">
						<div class="form-group">
							<label class="form-label">Trạng thái</label> <select
								id="user-status" class="form-select w-15" name="userStatus"
								${sessionScope.user.username == sessionScope.userEdit.username ? 'disabled' : ''}>
								<c:forEach var="status" items="${sessionScope.statusList}">
									<c:if test="${sessionScope.userEdit.status == status}">
										<option selected>${status}</option>
									</c:if>
									<c:if test="${sessionScope.userEdit.status != status}">
										<option class="">${status}</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
					</c:if>
					<div class="form-group my-5">
						<button type="submit" class="btn-save btn btn-primary me-1">
							<i class="fa-solid fa-floppy-disk"></i> Lưu
						</button>
						<button type="button" class="btn btn-secondary mx-1"
							data-bs-target="#confirmModal" data-bs-toggle="modal"
							data-bs-dismiss="modal">
							<i class="fa-solid fa-rotate-left"></i> Hủy bỏ
						</button>
					</div>
				</form>

				<div class="modal fade" id="verifyModal" role="dialog"
					data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
					<div
						class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
						<div class="modal-content">
							<div class="modal-body text-center">
								<h6>Thêm tài khoản Admin thành công!</h6>
								<h6 class="text-danger">Mật khẩu tài khoản được gửi thông
									qua mail đăng ký. Vui lòng kiểm tra mail để lấy mật khẩu</h6>
								<div class="mt-4">
									<a href="${pageContext.request.contextPath}/admin/user"
										class="btn btn-primary" tabindex="-1" role="button">Đóng</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Import confirm modal -->
				<c:import url="../layout/confirmModal.jsp"></c:import>
			</div>
			<c:if test="${sessionScope.USResult == 'false'}">
				<div class="alert alert-danger mx-2 mt-3" role="alert">
					<h5 class="alert-heading">Cập nhật thất bại!</h5>
					<p>Vui lòng kiểm tra lại dữ liệu và thử lại!</p>
					<hr class="m-1">
					<p class="mb-0 fst-italic">
						<i class="fa-solid fa-circle-exclamation"></i> Tên đăng nhập không
						được trùng lặp.
					</p>
					<p class="mb-0 fst-italic">
						<i class="fa-solid fa-circle-exclamation"></i> Email không được
						trùng lặp.
					</p>
				</div>
			</c:if>
		</div>

		<!-- Import footer layout -->
		<c:import url="../layout/footer.jsp"></c:import>
	</div>
	<script>
	    // Set index to value of btn-confirm-ok
		$(".btn-confirm-ok").val(${sessionScope.index});
	    
	    // Verify when add new Admin account
	    $(document).ready(function() {
			$("#verifyModal").modal(`${requestScope.verifyModalAction}`);
	    });
	</script>
</body>

</html>