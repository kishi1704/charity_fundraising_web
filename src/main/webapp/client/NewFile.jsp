<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="open-fund col">
	<div class="card h-100">
		<img src="${fund.image_url}" class="card-img-top" alt="fund image">
		<div class="card-body">
			<h5 class="card-title fund-name pb-2">${fund.name}</h5>
			<h6 class="card-subtitle text-muted  mb-2 pb-2">
				<em>${fund.foundation.name}</em>
			</h6>
			<p class="card-text mb-1">${fund.description}</p>
			<a href="#" class="stretched-link"></a>
		</div>
		<div class="card-footer bg-transparent border-top-0">
			<div class="d-flex justify-content-between">
				<p>
					<span class="font-weight-bold"></span> / <span
						class="text-secondary"></span>
				</p>
				<p>
					<span class="badge rounded-pill bg-success"><fmt:formatDate
							value="${date}" pattern="dd-MM-yyyy" /></span>
				</p>
			</div>
			<div class="progress" style="height: 5px">
				<div class="progress-bar bg-success" role="progressbar"
					aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"
					style="width:${100.0 * fund.getTotalDonation() / fund.expectedAmount}%"></div>
			</div>
			<div class="d-flex justify-content-between align-items-center mt-3">
				<c:choose>
					<c:when test="${sessionScope.user.role == 1}">
						<a class="btn btn-success position-relative" style="z-index: 2;"
							href="https://www.google.com/?hl=vi" role="button">Quyên góp</a>
					</c:when>
					<c:otherwise>
						<a class="btn btn-success position-relative" style="z-index: 2;"
							href="/login" role="button">Đăng nhập để quyên góp</a>
					</c:otherwise>
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