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
<script src="<c:url value="/client/js/category.js"/>"></script>

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
					<li class="breadcrumb-item active" aria-current="page">Danh
						sách quỹ từ thiện</li>
				</ol>
			</nav>
			<section class="recent-donation px-3">
				<div class="content-header">
					<h3 class="content-title text-center">LƯỢT QUYÊN GÓP GẦN ĐÂY</h3>
					<hr class="w-50 mx-auto border border-1 border-dark">
				</div>

				<div id="carouselRecentDonationControls"
					class="carousel slide m-md-5" data-bs-ride="carousel">
					<div class="carousel-inner">
						<c:forEach var="donation"
							items="${requestScope.recentDonationList}" varStatus="status">
							<div class="carousel-item ${status.first ? 'active' : ''}">
								<img src="${donation.fund.image_url}"
									class="d-block w-100 rounded" alt="fund image">
								<div class="carousel-caption bg-warning p-2 rounded">
									<p class="lead fw-normal m-0">${donation.user.username}<span>
											đã quyên góp </span>${donation.donationAmount} <span>vnđ</span>
									</p>
									<p class="lead m-0">
										<q>${donation.donationMessage}</q>
									</p>
									<p class="m-0">${donation.donationDate}</p>
								</div>
							</div>
						</c:forEach>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselRecentDonationControls"
						data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselRecentDonationControls"
						data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</section>

			<section class="fund-opening mt-5">
				<div class="content-header">
					<h3 class="content-title text-center">CÁC HOẠT ĐỘNG ĐANG DIỄN
						RA</h3>
					<hr class="w-50 mx-auto border border-1 border-dark">
					<c:set var="fundList" value="${requestScope.openFundList}"
						scope="request" />
					<c:import url="./layout/displayFundList.jsp">
						<c:param name="typeList" value="opening"></c:param>
					</c:import>

				</div>
			</section>

			<section class="fund-completed my-5">
				<div class="content-header">
					<h3 class="content-title text-center">CÁC HOẠT ĐỘNG ĐÃ HOÀN
						THÀNH</h3>
					<hr class="w-50 mx-auto border border-1 border-dark">
					<c:set var="fundList" value="${requestScope.closedFundList}"
						scope="request" />
					<c:import url="./layout/displayFundList.jsp">
						<c:param name="typeList" value="closed"></c:param>
					</c:import>
				</div>
			</section>

		</div>

		<!-- Import header layout -->
		<c:import url="./layout/footer.jsp"></c:import>
	</div>
</body>
</html>