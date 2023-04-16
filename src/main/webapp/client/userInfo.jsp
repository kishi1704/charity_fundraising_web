<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

<!-- Customer JavaScript -->
<script src="<c:url value="/client/js/userInfo.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<title>Thông tin cá nhân</title>
</head>
<body>
	<section class="vh-100">
		<div class="container py-3 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col col-xl-10">
					<div class="card m-1">
						<img
							src="<c:url value = "/images/background/client_background.jpg"/>"
							class="card-img-top" alt="website logo">
						<div class="card-body fs-5">
							<h4 class="card-title text-uppercase text-center text-success">Thông
								tin cá nhân</h4>
							<form method="post" action="user?action=doUpdate"
								accept-charset="UTF-8">
								<fieldset id="info-field" disabled>
									<div class="form-outline mb-2">
										<label class="form-label" for="username">Họ và tên</label> <input
											type="text" name="userFullName"
											value="${sessionScope.user.fullName}" id="user-fullname"
											class="form-control form-control-lg" />
										<div class="invalid-feedback">Dữ liệu không đúng!</div>
									</div>

									<div class="form-outline mb-2">
										<label class="form-label" for="username">Tên đăng nhập</label>
										<input type="text" name="username"
											value="${sessionScope.user.username}" id="username"
											class="form-control form-control-lg" />
										<div class="invalid-feedback">Dữ liệu không đúng!</div>
									</div>

									<div class="form-outline mb-2">
										<label class="form-label">Email</label> <input type="text"
											name="userEmail" value="${sessionScope.user.email}"
											id="user-email" class="form-control form-control-lg" />
										<div class="invalid-feedback">Dữ liệu không đúng!</div>
									</div>
									<div class="form-outline mb-2">
										<label class="form-label">Số điện thoại</label> <input
											type="text" name="userPhoneNumber"
											value="${sessionScope.user.phoneNumber}"
											id="user-phone-number" class="form-control form-control-lg" />
										<div class="invalid-feedback">Dữ liệu không đúng!</div>
									</div>
									<div class="form-outline mb-2">
										<label class="form-label">Địa chỉ</label> <input type="text"
											name="userAddress" value="${sessionScope.user.address}"
											id="user-address" class="form-control form-control-lg" />
										<div class="invalid-feedback">Dữ liệu không đúng!</div>
									</div>
								</fieldset>
							</form>

							<div class="d-grid gap-2 d-md-block my-3">
								<button class="btn-edit btn btn-success">Chỉnh sửa</button>
								<button class="btn-update btn btn-primary d-none">Cập
									nhật</button>
								<button type="button" class="btn btn-secondary"
									data-bs-toggle="modal" data-bs-target="#confirmModal">
								Quay lại</button>
							</div>

							<c:if test="${requestScope.updateStatus == 0}">
								<div class="alert alert-danger mx-2 mt-3" role="alert">
									<h5 class="alert-heading">Cập nhật thất bại!</h5>
									<p>Vui lòng kiểm tra lại dữ liệu và thử lại!</p>
									<hr class="m-1">
									<p class="mb-0 fst-italic">
										<i class="fa-solid fa-circle-exclamation"></i> Tên đăng nhập
										không được trùng lặp.
									</p>
									<p class="mb-0 fst-italic">
										<i class="fa-solid fa-circle-exclamation"></i> Email không
										được trùng lặp.
									</p>
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="verifyModal" role="dialog"
			data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
			<div
				class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-body text-center">
						<h6>Cập nhật thông tin thành công!</h6>
						<div class="mt-4">
							<button type="button" class="btn btn-primary"
								data-bs-dismiss="modal">Đóng</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="confirmModal" role="dialog"
			data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
			<div
				class="modal-dialog modal-sm modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-body text-center">
						<h6>Bạn có chắc không?</h6>
						<div class="mt-4">
							<a class="btn btn-primary btn-sm" href="<c:url value="/home" />">Có</a>
							<button type="button" class="btn btn-secondary btn-sm"
								data-bs-dismiss="modal">Không</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<script>
		// Verify when register success
		$(document).ready(function() {
			$("#verifyModal").modal(`${requestScope.verifyModalAction}`);
		});
	</script>
</body>
</html>