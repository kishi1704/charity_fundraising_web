<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Donation</title>

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
<script src="<c:url value="/admin/js/donation.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- Custom css -->
<link rel="stylesheet" href="<c:url value="/admin/css/donation.css"/>">
</head>
<body>
	<div class="container-fluid p-0">
		<c:import url="../layout/header.jsp"></c:import>
		<div class="content min-vh-100">
			<div class="content-header px-2">
				<h4 class="mb-0 ms-2 py-3">Quản Lý Lượt Quyên Góp</h4>
				<hr class="m-1">
				<div class="input-group mt-3">
					<input id="search-id" type="text" name="id"
						value="${sessionScope.donationSId}" class="form-control"
						placeholder="ID"> <input id="search-username" type="text"
						name="username" value="${sessionScope.donationSUsername}"
						class="form-control w-25" placeholder="Tên người quyên góp"><input
						id="search-fundname" type="text" name="fundname"
						value="${sessionScope.donationSFund}" class="form-control w-25"
						placeholder="Tên quỹ quyên góp">
					<button type="button"
						class="btn-search btn btn-success btn-sm me-1">
						<i class="fa-solid fa-magnifying-glass"></i> Tìm Kiếm
					</button>
				</div>
			</div>
			<div class="donation-list px-2 mt-2">
				<table class="table table-bordered table-sm table-hover px-2">
					<thead class="table-primary">
						<tr class="text-center align-middle">
							<th>ID</th>
							<th>Số tiền quyên góp</th>
							<th>Lời nhắn</th>
							<th>Ngày quyên góp</th>
							<th>Người quyên góp</th>
							<th>Quỹ quyên góp</th>
							<th>Chức năng</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty sessionScope.donations}">
								<tr class="text-center align-middle">
									<td colspan="6">Không tìm thấy lượt quyên góp</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="donation" items="${sessionScope.donations}">
									<tr
										class="text-center align-middle row-donation row-donation-${donation.id}">
										<td class="donation-id">${donation.id}</td>
										<fmt:setLocale value="vi_VN" />
										<fmt:formatNumber var="amount" type="currency"
											value="${donation.donationAmount}" />
										<td class="donation-amount">${amount}</td>
										<td class="donation-message"><span
											class="d-inline-block text-truncate" style="width: 12rem;">
												${donation.donationMessage}</span></td>
										<td class="donation-created-date"><fmt:formatDate
												pattern="dd-MM-yyyy" value="${donation.donationDate}" /></td>
										<td class="donation-username">${donation.user.username}</td>
										<td class="donation-fundname"><span
											class="d-inline-block text-truncate" style="width: 12rem;">
												${donation.fund.name}</span></td>
										<td class="function">
											<button type="button" class="btn-view btn btn-info btn-sm"
												value="${donation.id}">Xem</button>

										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>

				<!-- Show modal to view detail donation -->
				<div class="donation-modal"></div>
			</div>

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
									href="<c:url value="/admin/donation?index=${sessionScope.index - 1}&action=${sessionScope.donationAction}
								&donationId=${sessionScope.donationSId}&username=${sessionScope.donationSUsername}&fundname=${sessionScope.donationSFund}" />"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach var="i" begin="1" end="${sessionScope.endPage}">
							<li id="${i}" class="page-item"><a class="page-link"
								href="<c:url value="/admin/donation?index=${i}&action=${sessionScope.donationAction}&donationId=${sessionScope.donationSId}&username=${sessionScope.donationSUsername}&fundname=${sessionScope.donationSFund}"/>">${i}</a></li>
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
									href="<c:url value="/admin/donation?index=${sessionScope.index + 1}
								&action=${sessionScope.donationAction}&donationId=${sessionScope.donationSId}&username=${sessionScope.donationSUsername}&fundname=${sessionScope.donationSFund}"/>"
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

		// view donation
		$(document).ready(function() {

			$(".btn-view").click(function(e) {
				e.stopPropagation();

				var pathS = window.location.pathname.split("/");
				$.ajax({
					url : "/" + pathS[1] + "/admin/donation",
					type : "get", //send it through post method
					data : {
						action : "view",
						donationId : $(e.target).val(),
					},
					success : function(data) {

						$(".donation-modal").html(data);

						$("#donation-modal-view").modal('show');

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