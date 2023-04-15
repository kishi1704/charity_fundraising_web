<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fund Form</title>

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

<!-- Text area editor -->
<script src="<c:url value="/plugins/ckeditor/ckeditor.js"/>"></script>

<script src="<c:url value="/plugins/ckfinder/ckfinder.js"/>"></script>


<!--Custom javascript -->
<script src="<c:url value="/admin/js/fundForm.js"/>"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">

<!-- Custom css -->
<link rel="stylesheet" href="<c:url value="/admin/css/fund.css"/>">
</head>
<body>
	<div class="container-fluid p-0">
		<c:import url="../layout/header.jsp"></c:import>
		<div class="content min-vh-100">
			<div class="content-header px-2">
				<c:choose>
					<c:when test="${sessionScope.fundAction == 'edit'}">
						<h4 class="mb-0 ms-2 py-3">Chỉnh sửa quỹ quyên góp</h4>
					</c:when>
					<c:when test="${sessionScope.fundAction == 'add'}">
						<h4 class="mb-0 ms-2 py-3">Thêm quỹ quyên góp mới</h4>
					</c:when>
				</c:choose>
				<hr class="m-1">
			</div>
			<div class="fund-form px-2 mt-2">
				<form action="" method="post" novalidate>
					<c:if test="${sessionScope.fundAction == 'edit'}">
						<div class="form-group">
							<label class="form-label">ID</label> <input id="fund-id"
								type="text" class="form-control" value="${sessionScope.fund.id}"
								readonly name="fundId" />
						</div>
					</c:if>
					<div class="form-group has-validation">
						<label class="form-label">Tên quỹ từ thiện</label> <input
							id="fund-name" type="text" class="form-control"
							value="${sessionScope.fund.name}" name="fundName">
						<div class="invalid-feedback">Dữ liệu không đúng!</div>

					</div>

					<div class="form-group">
						<label class="form-label">Mô tả</label>
						<textarea id="fund-description" rows="5" class="form-control"
							name="fundDescription">${sessionScope.fund.description}</textarea>
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>

					<div class="form-group">
						<label class="form-label">Nội dung</label>
						<textarea rows="50" id="fund-content" name="fundContent"
							class="ckeditor form-control">${sessionScope.fund.content}</textarea>
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>

					<div class="form-group">
						<label class="form-label">Đường dẫn hình ảnh</label>
						<div class="input-group">
							<button class="btn btn-secondary" type="button" id="btn-add-url">
								Thêm đường dẫn <i class="fa-solid fa-link"></i>
							</button>
							<input id="fund-image-url" type="text" class="form-control"
								name="fundImage_url" value="${sessionScope.fund.image_url}">
							<div class="invalid-feedback">Dữ liệu không đúng!</div>
						</div>
					</div>

					<div class="form-group input-expected-result">
						<label class="form-label">Số tiền dự định</label> <input
							id="fund-expected-result" type="text" class="form-control"
							name="fundEAmount" value="${sessionScope.fund.expectedAmount}">
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>

					<div class="form-group">
						<label class="form-label">Ngày bắt đầu</label> <input
							id="fund-created-date" type="date" class="form-control w-15"
							name="fundCDate" value="${sessionScope.fund.createdDate}">
						<div class="invalid-feedback">Ngày kết thúc phải lớn hơn
							ngày bắt đầu!</div>
					</div>

					<div class="form-group">
						<label class="form-label">Ngày kết thúc</label> <input
							id="fund-end-date" type="date" class="form-control w-15"
							name="fundEDate" value="${sessionScope.fund.endDate}">
						<div class="invalid-feedback">Ngày kết thúc phải lớn hơn
							ngày bắt đầu!</div>
					</div>

					<div class="form-group">
						<label class="form-label">Danh mục</label> <select
							id="fund-category" class="form-select  w-25" name="fundCategory">
							<option disabled value="" selected>Danh mục</option>
							<c:forEach var="category" items="${sessionScope.categoryList}">
								<c:choose>
									<c:when
										test="${category.name == sessionScope.fund.categoryName}">
										<option value="${category.id}" selected>${category.name}</option>
									</c:when>
									<c:otherwise>
										<option value="${category.id}">${category.name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>
					<div class="form-group">
						<label class="form-label">Nhà tổ chức</label> <select
							id="fund-foundation" class="form-select w-50"
							name="fundFoundation">
							<option disabled value="" selected>Nhà tổ chức</option>
							<c:forEach var="foundation"
								items="${sessionScope.foundationList}">
								<c:choose>
									<c:when
										test="${foundation.name == sessionScope.fund.foundationName}">
										<option value="${foundation.id}" selected>${foundation.name}</option>
									</c:when>
									<c:otherwise>
										<option value="${foundation.id}">${foundation.name}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
						<div class="invalid-feedback">Dữ liệu không đúng!</div>
					</div>
					<div class="form-group">
						<label class="form-label">Trạng thái</label> <select
							id="fund-status" class="form-select w-15" name="fundStatus">
							<c:forEach var="status" items="${sessionScope.statusList}">
								<c:if test="${sessionScope.fund.status == status}">
									<option selected>${status}</option>
								</c:if>
								<c:if test="${sessionScope.fund.status != status}">
									<option class="">${status}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div class="form-group my-5">
						<button type="submit" class="btn-save btn btn-primary me-1">
							<i class="fa-solid fa-floppy-disk"></i> Lưu
						</button>
						<button type="button" class="btn btn-secondary mx-1"
							data-bs-target="#confirmModal" data-bs-toggle="modal"
							data-bs-dismiss="modal">
							<i class="fa-solid fa-rotate-left"></i> Hủy bỏ
						</button>
					</div>
				</form>

				<!-- Import confirm modal -->
				<c:import url="../layout/confirmModal.jsp"></c:import>
			</div>
			<c:if test="${sessionScope.FuSResult == 'false'}">
				<div class="alert alert-danger mx-2 mt-3" role="alert">
					<h5 class="alert-heading">Cập nhật thất bại!</h5>
					<p>Vui lòng kiểm tra lại dữ liệu và thử lại!</p>
					<hr class="m-1">
					<p class="mb-0 fst-italic">
						<i class="fa-solid fa-circle-exclamation"></i> Tên quỹ từ thiện
						không được trùng lặp
					</p>
				</div>
			</c:if>
		</div>

		<!-- Import footer layout -->
		<c:import url="../layout/footer.jsp"></c:import>
	</div>
	<script>
	    // Set index to value of btn-confirm-ok
		$(".btn-confirm-ok").val(${sessionScope.index});
	    
	    // ckeditor font
	    CKEDITOR.replace( 'fund-content', {
    		language: 'vi',
    		htmlEncodeOuput: false,
    		ProcessHTMLEntities: false,
    		entities: false,
    		entities_latin: false,
    		ForceSimpleAmpersand: true,
		}); 
	    
	   CKEDITOR.on('dialogDefinition', function(ev) {
	        var dialogName = ev.data.name;
	        var dialogDefinition = ev.data.definition;

	        if (dialogName == 'image') {
	            // Remove tab Link
	            dialogDefinition.removeContents( 'Link' );
	            
	            // Remove tab advanced
	            dialogDefinition.removeContents( 'advanced' );
	        }
	    });   
	   
	    var editor = CKEDITOR.replace( 'fund-content' );
	    CKFinder.setupCKEditor(editor, '../plugins/ckfinder/');
	    
	    // CKFinder upload link
	    $(document).ready(function() {
	    	$("#btn-add-url").click(function() {
        		CKFinder.popup({
         			chooseFiles: true,
         			selectActionFunction: function(fileUrl) {
        		     	// Set the value of the input text field to the selected file URL
        		        $('#fund-image-url').val(fileUrl);
	            	 }
       			 });
     		 });
   		 });
	 	
	    
	</script>
</body>

</html>