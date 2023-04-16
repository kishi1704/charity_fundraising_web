<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<script src="<c:url value="/client/js/userDonation.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<title>Lịch sử quyên góp</title>
</head>
<body>
	<section class="vh-100">
		<div class="container py-3 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col-12">
					<div class="card m-1">
						<img
							src="<c:url value = "/images/background/client_background.jpg"/>"
							class="mx-auto d-none d-md-block" width="600" alt="website logo">
						<div class="card-body fs-5">
							<h4 class="card-title text-uppercase text-center text-success">Lịch
								sử quyên góp</h4>
							<table class="table table-bordered table-sm table-hover px-2">
								<thead class="table-primary">
									<tr class="text-center align-middle">
										<th>Số tiền quyên góp</th>
										<th>Lời nhắn</th>
										<th>Ngày quyên góp</th>
										<th>Quỹ quyên góp</th>
										<th>Chức năng</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty sessionScope.userDonations}">
											<tr class="text-center align-middle">
												<td colspan="6">Không tìm thấy lượt quyên góp</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="donation"
												items="${sessionScope.userDonations}">
												<tr
													class="text-center align-middle row-donation row-donation-${donation.id}">
													<fmt:setLocale value="vi_VN" />
													<fmt:formatNumber var="amount" type="currency"
														value="${donation.donationAmount}" />
													<td class="donation-amount">${amount}</td>
													<td class="donation-message"><span
														class="d-inline-block text-truncate" style="width: 12rem;">
															${donation.donationMessage}</span></td>
													<td class="donation-created-date">${donation.donationDate}</td>
													<td class="donation-fundname"><span
														class="d-inline-block text-truncate" style="width: 12rem;">
															${donation.fundname}</span></td>
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

							<div class="mt-2">
								<a class="btn btn-secondary" href="<c:url value="/home" />">Quay
									lại</a>

							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- Show modal to view detail donation -->
			<div class="donation-modal"></div>
		</div>
	</section>
	<script>
		// view donation
		$(document).ready(function() {

			$(".btn-view").click(function(e) {
				e.stopPropagation();

				var pathS = window.location.pathname.split("/");
				$.ajax({
					url : "/" + pathS[1] + "/user",
					type : "get", //send it through post method
					data : {
						action : "viewDonation",
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