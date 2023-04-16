<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
			<div class="bg-light">
				<div class="container py-5">
					<div class="row h-100 align-items-center py-3">
						<div class="col-lg-8">
							<h1 class="display-4">Về chúng tôi</h1>
							<p class="lead text-muted mb-0">Với mong muốn lan tỏa tình
								người và giúp đỡ những người cần sự giúp đỡ, chúng tôi đã tạo ra
								trang web quyên góp này để kêu gọi các bạn hãy cùng chúng tôi
								chung tay để giúp đỡ những hoàn cảnh khó khăn.</p>

						</div>
						<div class="col-lg-4 d-none d-lg-block">
							<img src='<c:url value="/images/about_us.jpg"></c:url>' alt=""
								class="img-fluid">
						</div>
					</div>
				</div>
			</div>

			<div class="bg-white py-5">
				<div class="container py-3">
					<div class="row align-items-center mb-5">
						<div class="col-lg-6 order-2 order-lg-1">
							<i class="fa fa-bar-chart fa-2x mb-3 text-primary"></i>
							<h2 class="font-weight-light">Thực hiện quyên góp nhanh
								chóng</h2>
							<p class="font-italic text-muted mb-4">Chúng tôi cung cấp
								dịch vụ quyên góp trực tuyến, giúp các nhà hảo tâm có thể tiếp
								cận các Quỹ, các Tổ chức từ thiện và thực hiện quyên góp cho các
								hoàn cảnh khó khăn 1 cách nhanh chóng và thuận tiện</p>
							<a href="<c:url value="/"></c:url>"
								class="btn btn-light px-5 rounded-pill shadow-sm">Tìm hiểu</a>
						</div>
						<div class="col-lg-5 px-5 mx-auto order-1 order-lg-2">
							<img src="<c:url value="/images/about_us_donate.jpg"></c:url>"
								alt="" class="img-fluid mb-4 mb-lg-0">
						</div>
					</div>
					<div class="row align-items-center">
						<div class="col-lg-5 px-5 mx-auto">
							<img src="<c:url value="/images/about_us_category.jpg"></c:url>"
								alt="" class="img-fluid mb-4 mb-lg-0">
						</div>
						<div class="col-lg-6">
							<i class="fa fa-leaf fa-2x mb-3 text-success"></i>
							<h2 class="font-weight-light">Xem các Quỹ quyên góp theo
								danh mục</h2>
							<p class="font-italic text-muted mb-4">Dễ dàng theo dõi, cập
								nhật thông tin về các hoạt động quyên góp đang diễn ra theo từng
								danh mục đã được phân loại như: Vì trẻ em, Giúp đỡ người già,
								người khuyết tật, Cứu trợ động vật, Bảo vệ môi trường...</p>
							<a href="<c:url value="/categories"></c:url>"
								class="btn btn-light px-5 rounded-pill shadow-sm">Tìm hiểu</a>
						</div>
					</div>
				</div>
			</div>

		</div>

		<!-- Import header layout -->
		<c:import url="./layout/footer.jsp"></c:import>


	</div>
</body>
</html>