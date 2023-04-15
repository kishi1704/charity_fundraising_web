<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Foundation Form</title>

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
<script
	src="<c:url value="/admin/js/foundationForm.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- Custom css -->
<link rel="stylesheet"
	href="<c:url value="/admin/css/foundation.css"/>">
</head>
<body>
	<div class="container-fluid p-0">
		<c:import url="../layout/header.jsp"></c:import>
		<div class="content min-vh-100">
			<div class="content-header px-2">
				<c:choose>
					<c:when test="${sessionScope.foundationAction == 'edit'}">
						<h4 class="mb-0 ms-2 py-3">Chỉnh sửa nhà tổ chức</h4>
					</c:when>
					<c:when test="${sessionScope.foundationAction == 'add'}">
						<h4 class="mb-0 ms-2 py-3">Thêm nhà tổ chức mới</h4>
					</c:when>
				</c:choose>
				<hr class="m-1">
			</div>
			<div class="foundation-form px-2 mt-2">
				<form action="" method="post" novalidate>
					<c:if test="${sessionScope.foundationAction == 'edit'}">
						<div class="form-group">
							<label class="form-label">ID</label> <input id="foundation-id"
								type="text" class="form-control"
								value="${sessionScope.foundation.id}" readonly
								name="foundationId" />
						</div>
					</c:if>
					<div class="form-group has-validation">
						<label class="form-label">Tên nhà tổ chức</label> <input
							id="foundation-name" type="text" class="form-control"
							value="${sessionScope.foundation.name}" name="foundationName">
						<div class="invalid-feedback">Dữ liệu không đúng!</div>

					</div>
					<div class="form-group">
						<label class="form-label">Mô tả</label>
						<textarea id="foundation-description" rows="5"
							class="form-control" name="foundationDescription">${sessionScope.foundation.description}</textarea>
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>
					<div class="form-group">
						<label class="form-label">Email</label> <input
							id="foundation-email" type="text" class="form-control"
							name="foundationEmail" value="${sessionScope.foundation.email}">
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>
					<div class="form-group">
						<label class="form-label">Trạng thái</label> <select
							id="foundation-status" class="form-select w-15"
							name="foundationStatus">
							<c:forEach var="status" items="${sessionScope.statusList}">
								<c:if test="${sessionScope.foundation.status == status}">
									<option selected>${status}</option>
								</c:if>
								<c:if test="${sessionScope.foundation.status != status}">
									<option class="">${status}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
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

				<!-- Import confirm modal -->
				<c:import url="../layout/confirmModal.jsp"></c:import>
			</div>
			<c:if test="${sessionScope.FSResult == 'false'}">
				<div class="alert alert-danger mx-2 mt-3" role="alert">
					<h5 class="alert-heading">Cập nhật thất bại!</h5>
					<p>Vui lòng kiểm tra lại dữ liệu và thử lại!</p>
					<hr class="m-1">
					<p class="mb-0 fst-italic">
						<i class="fa-solid fa-circle-exclamation"></i> Tên nhà tổ chức
						không được trùng lặp.
					</p>
					<p class="mb-0 fst-italic">
						<i class="fa-solid fa-circle-exclamation"></i> Email nhà tổ chức
						không được trùng lặp.
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
	</script>
</body>

</html>