<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fund</title>

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
<script src="<c:url value="/admin/js/fund.js"/>"></script>

<!-- Text area editor -->
<script src="<c:url value="/plugins/ckeditor/ckeditor.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
<!-- Custom css -->
<link rel="stylesheet" href="<c:url value="/admin/css/fund.css"/>">
</head>

<body>
	<div class="container-fluid p-0">
		<!-- Import header layout -->
		<c:import url="../layout/header.jsp"></c:import>
		<div class="content min-vh-100">
			<div class="content-header px-2">
				<h4 class="mb-0 ms-2 py-3">Quản Lý Quỹ Quyên Góp</h4>
				<hr class="m-1">
				<div class="input-group mt-3">
					<input id="search-id" type="text" name="id"
						value="${sessionScope.fundSId}" class="form-control w-5"
						placeholder="ID"> <input id="search-name" type="text"
						name="name" value="${sessionScope.fundSName}"
						class="form-control w-25" placeholder="Tên quỹ từ thiện"><input
						id="search-foundation" type="text" name="foundation"
						value="${sessionScope.fundSFoundation}" class="form-control w-25"
						placeholder="Tên tổ chức quỹ"> <select
						id="filter-category" name="category" class="form-select w-20">
						<option value="" selected>Danh mục</option>
						<c:forEach var="category" items="${sessionScope.categoryList}">
							<c:choose>
								<c:when test="${category.name == sessionScope.fundSCategory}">
									<option selected>${category.name}</option>
								</c:when>
								<c:otherwise>
									<option>${category.name}</option>
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
			<div class="fund-list px-2 mt-2">
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
							<th>Tên quỹ từ thiện</th>
							<th>Số tiền dự tính</th>
							<th>Ngày bắt đầu</th>
							<th>Ngày kết thúc</th>
							<th>Danh mục</th>
							<th>Tổ chức</th>
							<th>Trạng thái</th>
							<th>Chức năng</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty sessionScope.funds}">
								<tr class="text-center align-middle">
									<td colspan="10">Không tìm thấy quỹ từ thiện</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="fund" items="${sessionScope.funds}">
									<tr
										class="text-center align-middle row-fund row-fund-${fund.id}">
										<td style="width: 2rem;"><input type="checkbox"
											class="fund-check" name="deleteFunds" value="${fund.id}"></td>
										<td class="fund-id" style="width: 2rem;">${fund.id}</td>
										<td class="fund-name"><span
											class="d-inline-block text-truncate" style="width: 5rem;">
												${fund.name}</span></td>
										<fmt:setLocale value="vi_VN" />
										<fmt:formatNumber var="amount" type="currency"
											value="${fund.expectedAmount}" />
										<td class="fund-expected-amount">${amount}</td>
										<td class="fund-created-date">${fund.createdDate}</td>
										<td class="fund-created-date">${fund.endDate}</td>
										<td class="fund-foundation"><span
											class="d-inline-block text-truncate" style="width: 5rem;">
												${fund.categoryName}</span></td>
										<td class="fund-category"><span
											class="d-inline-block text-truncate" style="width: 5rem;">
												${fund.foundationName}</span></td>
										<td class="fund-status">${fund.status}</td>
										<td class="function">
											<button type="button" class="btn-view btn btn-info btn-sm"
												value="${fund.id}">Xem</button>
											<button type="button" class="btn-edit btn btn-warning btn-sm"
												value="${fund.id}">Sửa</button>
											<button type="button"
												class="btn btn-danger btn-sm btn-delete" value="${fund.id}"
												data-bs-target="#confirmModal" data-bs-toggle="modal">Xóa</button>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>

				<!-- Display erorr message when delete failed -->
				<div class="error-message"></div>
				<!-- Show modal to view detail fund -->
				<div class="fund-modal"></div>
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
									href="<c:url value="/admin/fund?index=${sessionScope.index - 1}&action=${sessionScope.fundAction}
								&fundId=${sessionScope.fundSId}&fundName=${sessionScope.fundSName}&foundation=${sessionScope.fundSFoundation}&category=${sessionScope.fundSCategory}"/>"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach var="i" begin="1" end="${sessionScope.endPage}">
							<li id="${i}" class="page-item"><a class="page-link"
								href="<c:url value="/admin/fund?index=${i}&action=${sessionScope.fundAction}&fundId=${sessionScope.fundSId}
							&fundName=${sessionScope.fundSName}&foundation=${sessionScope.fundSFoundation}&category=${sessionScope.fundSCategory}"/>">${i}</a></li>
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
									href="<c:url value="/admin/fund?index=${sessionScope.index + 1}
								&action=${sessionScope.fundAction}&fundId=${sessionScope.fundSId}&fundName=${sessionScope.fundSName}&foundation=${sessionScope.fundSFoundation}&category=${sessionScope.fundSCategory}"/>"
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
					url : "/" + pathS[1] + "/admin/fund",
					type : "get", //send it through post method
					data : {
						action : "view",
						fundId : $(e.target).val(),
					},
					success : function(data) {

						$(".fund-modal").html(data);

						// ckeditor font
						CKEDITOR.replace('fund-content', {
							language : 'vi',
							htmlEncodeOuput : false,
							ProcessHTMLEntities : false,
							entities : false,
							entities_latin : false,
							ForceSimpleAmpersand : true,
						});

						$("#fund-modal-view").modal('show');

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