<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
<title>Đăng ký tài khoản</title>
</head>
<body>
	<section class="vh-100">
		<div class="container py-3 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col col-xl-10">
					<div class="card" style="border-radius: 1rem;">
						<div class="row g-0 align-items-center">
							<div class="col-md-6 col-lg-5 d-none d-md-block">
								<img src="<c:url value = "/images/login.jpg"/>" alt="login form"
									class="img-fluid" style="border-radius: 1rem 0 0 1rem;" />
							</div>
							<div class="col-md-6 col-lg-7 d-flex">
								<div class="card-body p-3 text-black">
									<form method="post" action="${registerAction}"
										accept-charset="UTF-8">

										<div class="mb-2">
											<img
												src='<c:url value = "/images/background/client_background.jpg"/>'
												alt="login form" class="img-fluid" />
										</div>

										<div class="form-outline mb-2">
											<label class="form-label" for="username">Họ và tên</label> <input
												type="text" name="username"
												class="form-control form-control-lg" />
										</div>
										
										<div class="form-outline mb-2">
											<label class="form-label" for="username">Tên hiển thị</label> <input
												type="text" name="username"
												class="form-control form-control-lg" />
										</div>
										
										<div class="form-outline mb-2">
											<label class="form-label">Email</label> <input type="text"
												name="username" class="form-control form-control-lg" />
										</div>
										<div class="form-outline mb-2">
											<label class="form-label">Số điện thoại</label> <input
												type="text" name="username"
												class="form-control form-control-lg" />
										</div>
										<div class="form-outline mb-2">
											<label class="form-label">Địa chỉ</label> <input type="text"
												name="username" class="form-control form-control-lg" />
										</div>

										<div class="pt-1 mb-4">
											<button class="btn btn-success btn-block" type="submit"
												value="Login">Đăng ký</button>
										</div>
										
										<div>
						
											<p class="mb-2" style="color: #393f81;">
												Đã có tài khoản? <a class="text-decoration-none"
													href="<c:url value="/register" />">Đăng nhập ở đây.</a>
											</p>
										</div>
									</form>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>