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
<link rel="stylesheet"
	href="<c:url value="/admin/css/index.css"/>">

<title>Trang quản lí dự án từ thiện</title>
</head>
<body>
	<div class="container-fluid p-0">
		<!-- Import header layout -->
		<c:import url="./layout/header.jsp"></c:import>
		<div class="content min-vh-100">
			<div class="welcome">
				<img
					src="${pageContext.request.contextPath}/images/background/home_background.jpg"
					class="w-100" alt="background image">
				<h3 class="text-uppercase text-center text-primary">Chào mừng
					đến với website quản lý dự án từ thiện</h3>
				<p class="text-center lead fw-normal">Vui lòng chọn chức năng để
					tiếp tục.</p>
			</div>
		</div>
		<!-- Import footer layout -->
		<c:import url="./layout/footer.jsp"></c:import>
	</div>
</body>
</html>