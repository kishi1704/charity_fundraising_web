<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
/* Side bar*/
.sidebar {
	background-color: #34495e;
	height: 100%;
	width: 4rem;
	position: fixed;
	z-index: 1;
	top: 0;
	left: 0;
	overflow-y: auto;
}

.list-group-item {
	background-color: transparent;
	color: #f1f3f5
}

.sidebar .list-group-item.active {
	background-color: #73c2fb;
	color: #000;
	border-color: #73c2fb;
}

.bg-dark {
	background-color: #2a3439 !important;
}

@media ( min-width : 768px) {
	.sidebar {
		width: 14rem;
	}
}

/* width */
::-webkit-scrollbar {
	width: 10px;
}

/* Track */
::-webkit-scrollbar-track {
	background: #f1f1f1;
}

/* Handle */
::-webkit-scrollbar-thumb {
	background: #888;
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
	background: #555;
}
</style>

<aside class="sidebar text-white fs-5">
	<div class="list-group list-group-flush">
		<h3 class="text-center bg-dark py-3 mb-0 d-none d-md-inline">
			Trang quản trị</h3>
		<h5
			class="py-3 ps-3 mb-0 d-none d-md-inline border-bottom border-dark">
			<i class="fa-solid fa-user"></i><span class="ms-2">${sessionScope.user.username}</span>
		</h5>
		<a title="Trang chủ admin" href="${pageContext.request.contextPath}/admin" id="admin-home"
			class="list-group-item list-group-item-action py-3"> <i
			class="fa-solid fa-house"></i> <span class="ms-1 d-none d-md-inline">Trang
				chủ</span>
		</a><a title="Quản lý danh mục" href="${pageContext.request.contextPath}/admin?action=category"
			id="admin-category"
			class="list-group-item list-group-item-action py-3"> <i
			class="fa-solid fa-layer-group"></i> <span
			class="ms-1 d-none d-md-inline">Danh mục</span>
		</a><a title="Quản lý nhà tổ chức quỹ" href="${pageContext.request.contextPath}/admin?action=foundation"
			id="admin-foundation"
			class="list-group-item list-group-item-action py-3"> <i
			class="fa-solid fa-people-group"></i> <span
			class="ms-1 d-none d-md-inline">Nhà tổ chức</span>
		</a><a title="Quản lý quỹ quyên góp" href="${pageContext.request.contextPath}/admin?action=fund"
			id="admin-fund" class="list-group-item list-group-item-action py-3">
			<i class="fa-solid fa-sack-dollar"></i> <span
			class="ms-1 d-none d-md-inline">Quỹ quyên góp</span>
		</a><a title="Quản lý lượt quyên góp" href="${pageContext.request.contextPath}/admin?action=donation"
			id="admin-donation"
			class="list-group-item list-group-item-action py-3"><i
			class="fa-solid fa-hand-holding-heart"></i> <span
			class="ms-1 d-none d-md-inline">Lượt quyên góp</span> </a><a title="Quản lý danh sách tài khoản"
			href="${pageContext.request.contextPath}/admin?action=user"
			id="admin-user" class="list-group-item list-group-item-action py-3"><i
			class="fa-solid fa-users"></i> <span class="ms-1 d-none d-md-inline">Tài
				khoản</span></a> <a href="${pageContext.request.contextPath}/user/change_password"
			class="list-group-item list-group-item-action py-3 fs-6"><i class="fa-solid fa-key"></i> <span
			class="ms-1 d-none d-md-inline">Thay đổi mật khẩu</span></a> <a
			href="${pageContext.request.contextPath}/logout"
			class="list-group-item list-group-item-action py-3 fs-6"><i
			class="fa-solid fa-right-from-bracket"></i> <span
			class="ms-1 d-none d-md-inline">Đăng xuất</span></a>
	</div>
	</div>
</aside>

<script>
	$("#${sessionScope.pageActive}").addClass('active');
</script>