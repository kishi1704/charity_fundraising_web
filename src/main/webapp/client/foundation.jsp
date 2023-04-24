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
<script src="<c:url value="/client/js/index.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- Custom css -->
<link rel="stylesheet" href="<c:url value="/client/css/general.css"/>">

<title>Nhà tổ chức quỹ</title>
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
						sách nhà tổ chức gây quỹ</li>
				</ol>
			</nav>
			<header class="text-center mt-3">
				<div class="badge rounded-pill bg-success p-3">
					<h3>Danh sách các tổ chức đồng hành cùng chúng tôi</h3>
				</div>
			</header>
			<section class="foundation-list container my-5">
				<c:choose>
					<c:when test="${empty requestScope.foundationList}">
						<p class="text-wrap text-center fs-4 mx-auto">Không tìm thấy nhà tổ chức
							gây quỹ</p>
					</c:when>
					<c:otherwise>
						<div
							class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 justify-content-center">
							<c:forEach var="foundation"
								items="${requestScope.foundationList}">
								<div class="col">
									<div class="card border-success h-100">
										<div class="card-header fw-bold text-success text-center">${foundation.name}</div>
										<div class="card-body text-dark">
											<p class="card-text mb-1">${foundation.description}</p>
											<a href="#" class="stretched-link"></a>
										</div>
										<div class="card-footer text-center text-success">
											<p class="card-text mb-1">Email:${foundation.email}</p>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:otherwise>
				</c:choose>
			</section>
		</div>

		<!-- Import header layout -->
		<c:import url="./layout/footer.jsp"></c:import>
	</div>
</body>
</html>