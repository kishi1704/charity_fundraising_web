<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

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
<script src="<c:url value="/client/js/donationFund.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- Custom css -->
<link rel="stylesheet" href="<c:url value="/client/css/general.css"/>">

<title>Website quyên góp từ thiện FX17953</title>
</head>
<body>

	<div class="container-xxl p-0">
		<!-- Import header layout -->
		<c:import url="./layout/header.jsp"></c:import>

		<div class="content container-xxl p-0">
			<nav class="bg-light py-2" aria-label="breadcrumb">
				<ol class="breadcrumb m-0">
					<li class="breadcrumb-item ms-4"><a
						href="<c:url value="/home"/>" class="link-success"><i
							class="fa-solid fa-house"></i></a></li>
					<li class="breadcrumb-item active"><a
						class="text-decoration-none text-success"
						href="<c:url value="/home"/>">${sessionScope.donationFund.category.name}</a></li>
					<li class="breadcrumb-item active" aria-current="page">Quỹ
						quyên góp</li>
				</ol>
			</nav>
			<section class="px-4">
				<div class="row">
					<div class="fund-story col-12 col-lg-8 mt-3">
						<div class="fund-background px-3">
							<h3 class="fund-name">${sessionScope.donationFund.name}</h3>
							<p class="text-muted mb-0">${sessionScope.donationFund.description}</p>
							<p class="text-muted text-right">${sessionScope.donationFund.createdDate}</p>
						</div>
						<div class="fund-content border border-success rounded p-3">${sessionScope.donationFund.content}</div>
					</div>
					<div class="col-12 col-lg-4 position-relative mt-5">
						<div class="card border-success position-sticky top-50">
							<div class="card-header">
								<h5 class="text-center">Thông tin quyên góp của quỹ</h5>
							</div>
							<div class="card-body">
								<div class="d-flex justify-content-between">
									<p>
										<fmt:setLocale value="vi_VN" />
										<span class="font-weight-bold"> <fmt:formatNumber
												type="currency"
												value="${sessionScope.donationFund.getTotalDonation()}" /></span>
										/<span class="text-secondary"><fmt:formatNumber
												type="currency"
												value="${sessionScope.donationFund.expectedAmount}" /></span>
									</p>
									<p>
										<fmt:parseDate var="date"
											value="${sessionScope.donationFund.endDate}"
											pattern="yyyy-MM-dd" />
										<span class="badge rounded-pill bg-success"><fmt:formatDate
												value="${date}" pattern="dd-MM-yyyy" /></span>
									</p>
								</div>
								<div class="progress" style="height: 5px">
									<div class="progress-bar bg-success" role="progressbar"
										aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"
										style="width:${100.0 * sessionScope.donationFund.getTotalDonation() / sessionScope.donationFund.expectedAmount}%"></div>
								</div>
								<div
									class="d-flex justify-content-between align-items-center mt-3">
									<c:choose>
										<c:when test="${requestScope.fundStatus == 'opening'}">
											<c:choose>
												<c:when test="${sessionScope.user.role == 1}">
													<button type="button" class="btn btn-success"
														data-bs-toggle="modal" data-bs-target="#donationModal">
														Quyên góp</button>
												</c:when>
												<c:otherwise>
													<a class="btn btn-success position-relative"
														style="z-index: 2;" href="login" role="button">Đăng
														nhập để quyên góp</a>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${requestScope.fundStatus == 'closed'}">
											<a class="btn btn-success disabled" role="button">Hoàn
												thành</a>
										</c:when>
									</c:choose>

									<p class="mb-0 text-secondary">
										Đạt được <br> <span class="text-dark font-weight-bold"><fmt:formatNumber
												value="${sessionScope.donationFund.getTotalDonation() / sessionScope.donationFund.expectedAmount}"
												type="percent" maxFractionDigits="1" /></span>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${requestScope.fundStatus == 'opening'}">
					<div class="modal fade" id="donationModal" role="dialog"
						data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
						<div
							class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title mx-auto text-uppercase">Thông tin
										quyên góp</h5>
								</div>
								<div class="modal-body">
									<form action="#" method="post" novalidate>
										<div class="form-group">
											<input id="fund-id" type="hidden" name="fund-id"
												value="${sessionScope.donationFund.id}"> <label
												class="form-label">Quỹ quyên góp</label> <input
												id="fund-name" type="text" class="form-control"
												value="${sessionScope.donationFund.name}" readonly
												name="fundName" />
										</div>

										<div class="form-group has-validation">
											<label class="form-label">Số tiền quyên góp</label>
											<div class="input-group">
												<input id="donation-amount" type="text" class="form-control"
													value="" name="donationAmount"> <span
													class="input-group-text">&nbsp;₫</span>
												<div class="invalid-feedback">Dữ liệu không đúng!</div>
											</div>
										</div>
										<div class="form-group">
											<label class="form-label">Lời nhắn</label>
											<textarea id="donation-message" rows="5" class="form-control"
												name="donationMess"></textarea>
											<div class="invalid-feedback">Dữ liệu không đúng!</div>
										</div>

										<div class="form-group mt-3 mb-2">
											<button type="button" class="btn-donate btn btn-success me-1">
												Gửi quyên góp <i class="fa-sharp fa-solid fa-heart"></i>
											</button>
											<button type="button" class="btn btn-secondary mx-1"
												data-bs-target="#donationModal" data-bs-toggle="modal"
												data-bs-dismiss="modal">Hủy bỏ</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>

					<div class="modal fade" id="successDonationModal" role="dialog"
						data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
						<div
							class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
							<div class="modal-content">
								<div class="modal-body text-center">
									<h6>Quyên góp thành công!</h6>
									<h6 class="text-danger">
										Cảm ơn tấm lòng cuả bạn. Chúc bạn gặp nhiều may mắn trong cuộc
										sống <i class="fa-sharp fa-solid fa-heart"></i>
									</h6>
									<div class="mt-4">
										<button type="button" class="btn btn-secondary mx-1"
											data-bs-target="#successDonationModal" data-bs-toggle="modal"
											data-bs-dismiss="modal">Đóng</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal fade" id="failedDonationModal" role="dialog"
						data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
						<div
							class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
							<div class="modal-content">
								<div class="modal-body text-center">
									<h6>Quyên góp thất bại!</h6>
									<h6 class="text-danger">Đã có lỗi xảy ra. Xin vui lòng thử
										lại.</h6>
									<div class="mt-4">
										<button type="button" class="btn btn-secondary mx-1"
											data-bs-target="#failedDonationModal" data-bs-toggle="modal"
											data-bs-dismiss="modal">Đóng</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:if>
			</section>
			<section class="fund-opening my-5">
				<div class="content-header">
					<h3 class="content-title text-center">CÁC HOẠT ĐỘNG LIÊN QUAN</h3>
					<hr class="w-50 mx-auto border border-1 border-dark">
					<c:set var="fundList" value="${requestScope.openFundList}"
						scope="request" />
					<c:import url="./layout/displayFundList.jsp">
						<c:param name="typeList" value="opening"></c:param>
					</c:import>

				</div>
			</section>
		</div>
		<!-- Import header layout -->
		<c:import url="./layout/footer.jsp"></c:import>
	</div>
</body>
</html>