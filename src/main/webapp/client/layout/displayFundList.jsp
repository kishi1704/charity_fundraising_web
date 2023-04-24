<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="fund-list container">
	<c:choose>
		<c:when test="${empty requestScope.fundList}">
			<p class="text-wrap fs-4 mx-auto">Không tìm thấy quỹ quyên góp</p>
		</c:when>
		<c:otherwise>
			<div
				class="${param.typeList == 'opening' ? 'open-fund-content' : 'closed-fund-content'} row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 justify-content-center">
				<c:forEach var="fund" items="${requestScope.fundList}">
					<div
						class="${param.typeList == 'opening' ? 'open-fund' : 'closed-fund'} col">
						<div class="card h-100">
							<img src="${fund.image_url}" class="card-img-top"
								alt="fund image">
							<div class="card-body">
								<h5 class="card-title fund-name pb-2">${fund.name}</h5>
								<h6 class="card-subtitle text-muted  mb-2 pb-2">
									<em>${fund.foundation.name}</em>
								</h6>
								<p class="card-text mb-1">${fund.description}</p>
								<a href="donation?fundId=${fund.id}&status=${param.typeList}" class="stretched-link"></a>
							</div>
							<div class="card-footer bg-transparent border-top-0">
								<div class="d-flex justify-content-between">
									<p>
										<fmt:setLocale value="vi_VN" />
										<span class="font-weight-bold"> <fmt:formatNumber
												type="currency" value="${fund.getTotalDonation()}" /></span> /<span
											class="text-secondary"><fmt:formatNumber
												type="currency" value="${fund.expectedAmount}" /></span>
									</p>
									<p>
										<fmt:parseDate var="date" value="${fund.endDate}"
											pattern="yyyy-MM-dd" />
										<span class="badge rounded-pill bg-success"><fmt:formatDate
												value="${date}" pattern="dd-MM-yyyy" /></span>
									</p>
								</div>
								<div class="progress" style="height: 5px">
									<div class="progress-bar bg-success" role="progressbar"
										aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"
										style="width:${100.0 * fund.getTotalDonation() / fund.expectedAmount}%"></div>
								</div>
								<div
									class="d-flex justify-content-between align-items-center mt-3">
									<c:choose>
										<c:when test="${param.typeList == 'opening'}">
											<c:choose>
												<c:when test="${sessionScope.user.role == 1}">
													<a class="btn btn-success" href="#" role="button">Quyên
														góp</a>
												</c:when>
												<c:otherwise>
													<a class="btn btn-success position-relative"
														style="z-index: 2;" href="login" role="button">Đăng
														nhập để quyên góp</a>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${param.typeList == 'closed'}">
											<a class="btn btn-success disabled" role="button">Hoàn
												thành</a>
										</c:when>
									</c:choose>

									<p class="mb-0 text-secondary">
										Đạt được <br> <span class="text-dark font-weight-bold"><fmt:formatNumber
												value="${fund.getTotalDonation() / fund.expectedAmount}"
												type="percent" maxFractionDigits="1" /></span>
									</p>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<c:choose>
				<c:when test="${param.typeList == 'opening'}">
					<button
						class="btn-view-more-openf btn btn-outline-success btn-lg mt-3">Xem
						thêm</button>
				</c:when>
				<c:when test="${param.typeList == 'closed'}">
					<button
						class="btn-view-more-closedf btn btn-outline-success btn-lg mt-3">Xem
						thêm</button>
				</c:when>
			</c:choose>
		</c:otherwise>
	</c:choose>
</div>