<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="container-xxl bg-white p-0 top-bar fixed-top">
	<header class="row row-cols-2 mx-2 align-items-center">
		<div class="col d-none d-md-block">
			<img
				src="<c:url value = "/images/background/client_background.jpg"/>"
				alt="website background image" width="500rem">
		</div>
		<c:choose>
			<c:when test="${empty sessionScope.user || sessionScope.user.role == 2 }">
				<nav
					class="nav col-12 col-md-6 justify-content-center justify-content-md-end fs-5">
					<a href="<c:url value="/login"/>"
						class="nav-link text-dark">Đăng nhập</a> <a
						href="<c:url value="/register" />"
						class="nav-link text-dark">Đăng ký</a>
				</nav>
			</c:when>
			<c:when test="${sessionScope.user.role == 1}">
				<div class="dropdown col-12 col-md-6 text-center text-md-end fs-5">
					<button class="btn btn-light dropdown-toggle" type="button"
						id="userDropdownMenu" data-bs-toggle="dropdown"
						aria-expanded="false">
						<i class="fa-solid fa-user text-success"></i> <span>${sessionScope.user.username}</span>
					</button>
					<ul class="dropdown-menu" aria-labelledby="userDropdownMenu">
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/user">Thông tin cá
								nhân</a></li>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/donationhistory">Lịch
								sử quyên góp</a></li>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/password?action=changepassword">Thay
								đổi mật khẩu</a></li>
						<li><a class="dropdown-item"
							href="<c:url value="/logout"/>">Đăng xuất</a></li>
					</ul>
				</div>
			</c:when>
		</c:choose>
	</header>
	<nav class="navbar navbar-expand-lg navbar-dark bg-success">
		<div class="container-fluid">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarTogglerMenu"
				aria-controls="navbarTogglerMenu" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarTogglerMenu">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item "><a class="nav-link"
						href="<c:url value="/home"/>"><i
							class="fa-solid fa-house"></i> Trang chủ </a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="categoryDropdownList" role="button" data-bs-toggle="dropdown"
						aria-expanded="false"><i class="fa-solid fa-layer-group"></i>
							Danh mục</a>
						<ul class="dropdown-menu" aria-labelledby="categoryDropdownList">
							<c:forEach var="category" items="${sessionScope.categoryList}">
								<li><a class="dropdown-item"
									href="${pageContext.request.contextPath}/category?id=${category.id}">${category.name}</a></li>
							</c:forEach>
						</ul></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/foundation"><i
							class="fa-solid fa-people-group"></i> Nhà tổ chức</a></li>
					<li class="nav-item"><a class="nav-link " href="#our-contact"><i
							class="fa-sharp fa-solid fa-address-card"></i> Liên hệ</a></li>
					<li class="nav-item"><a class="nav-link " href="<c:url value="/home?action=about"/>"><i
							class="fa-solid fa-circle-info"></i> Về chúng tôi</a></li>
				</ul>
				<form class="d-flex w-auto">
					<input class="form-control me-2" type="text"
						placeholder="Tìm kiếm quỹ" aria-label="Recipient's username"
						value="${param.keyword}">
					<button class="btn btn-outline-dark" type="submit">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</form>
			</div>
		</div>
	</nav>
</div>