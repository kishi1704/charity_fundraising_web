<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Category Form</title>

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
<script src="<c:url value="/admin/js/categoryForm.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- Custom css -->
<link rel="stylesheet" href="<c:url value="/admin/css/category.css"/>">
</head>
<body>
	<div class="container-fluid p-0">
		<c:import url="../layout/header.jsp"></c:import>
		<div class="content min-vh-100">
			<div class="content-header px-2">
				<c:choose>
					<c:when test="${sessionScope.categoryAction == 'edit'}">
						<h4 class="mb-0 ms-2 py-3">Chỉnh sửa danh mục</h4>
					</c:when>
					<c:when test="${sessionScope.categoryAction == 'add'}">
						<h4 class="mb-0 ms-2 py-3">Thêm danh mục mới</h4>
					</c:when>
				</c:choose>
				<hr class="m-1">
			</div>
			<div class="category-form px-2 mt-2">
				<form action="" method="post" novalidate>
					<c:if test="${sessionScope.categoryAction == 'edit'}">
						<div class="form-group">
							<label class="form-label">ID</label> <input id="category-id"
								type="text" class="form-control"
								value="${sessionScope.category.id}" readonly name="categoryId" />
						</div>
					</c:if>
					<div class="form-group has-validation">
						<label class="form-label">Tên danh mục</label> <input
							id="category-name" type="text" class="form-control"
							value="${sessionScope.category.name}" name="categoryName">
						<div class="invalid-feedback">Dữ liệu không đúng!</div>

					</div>
					<div class="form-group">
						<label class="form-label">Mô tả</label>
						<textarea id="category-description" rows="3" class="form-control"
							name="categoryDescription">${sessionScope.category.description}</textarea>
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>
					<div class="form-group">
						<label class="form-label">Trạng thái</label> <select
							id="category-status" class="form-select w-15"
							name="categoryStatus">
							<c:forEach var="status" items="${sessionScope.statusList}">
								<c:if test="${sessionScope.category.status==status}">
									<option selected>${status}</option>
								</c:if>
								<c:if test="${sessionScope.category.status!=status}">
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
			<c:if test="${sessionScope.CSResult == 'false'}">
				<div class="alert alert-danger mx-2 mt-3" role="alert">
					<h5 class="alert-heading">Cập nhật thất bại!</h5>
					<p>Vui lòng kiểm tra lại dữ liệu và thử lại!</p>
					<hr class="m-1">
					<p class="mb-0 fst-italic">
						<i class="fa-solid fa-circle-exclamation"></i> Tên danh mục không
						được trùng lặp.
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