<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="fund-list">
	<div
		class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
		<c:choose>
			<c:when test="${empty sessionScope.list}">
				<p class="text-wrap fs-4 mx-auto">
					<i class="fa-solid fa-empty-set"></i>Không tìm thấy quỹ quyên góp
				</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="product" items="${sessionScope.list}">
					<div class="item col">
						<div class="card h-100 pt-3" style="max-width: 18rem;">
							<img src="${product.src}" alt="${product.name} image">
							<div class="card-body">
								<h5 class="card-title text-uppercase text-muted">${product.type}</h5>
								<h6 class="card-subtitle mb-2">${product.name}</h6>
								<p class="card-text fw-bold text-danger">$${product.price}</p>
								<a
									href="${pageContext.request.contextPath}/home?action=showproduct&productid=${product.id}"
									class="stretched-link"></a>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</div>