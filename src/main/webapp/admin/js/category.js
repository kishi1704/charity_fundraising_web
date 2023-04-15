/**
 * 
 */
$(document).ready(function() {
	// search category
	$(".btn-search").click(function() {
		var pathS = window.location.pathname.split("/");
		var id = $("#search-id").val();
		var name = $("#search-name").val();
		window.location.replace("/" + pathS[1] + "/admin/category?action=search&categoryId=" + id + "&categoryName=" + name);
	})


	// edit category
	$(".btn-edit").click(function(e) {
		e.stopPropagation();
		var pathS = window.location.pathname.split("/");
		var id = $(e.target).val();
		window.location.replace("/" + pathS[1] + "/admin/category?action=edit&categoryId=" + id);
	})

	// add new category
	$(".btn-add").click(function() {
		var pathS = window.location.pathname.split("/");
		window.location.replace("/" + pathS[1] + "/admin/category?action=add");
	})

	// delete category
	$(".btn-delete").click(function(e) {
		e.stopPropagation();
		var id = $(e.target).val();
		$(".btn-confirm-ok").attr("onclick", `deleteOne(${id})`);

	})

	// delete more category
	$("#btn-selected-delete").click(function() {
		$(".btn-confirm-ok").attr("onclick", "deleteMany()");
	})

})

function deleteOne(id) {

	var pathS = window.location.pathname.split("/");
	$.ajax({
		url: "/" + pathS[1] + "/admin/category",
		type: "post", //send it through post method
		data: {
			action: "delete",
			deleteCategories: id,
		},
		success: function(data) {
			var dataArr = data.split(",");
			if (dataArr[0] === 'true') {
				$(".row-category-" + id).hide();
				if ($(".row-category:visible").length === 0) {
					window.location.replace("/" + pathS[1] + "/admin/category?index=" + dataArr[1]);
				}
			}else {
				$(".error-message").html(`
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<strong>Hành động xóa thất bại!</strong> Đã xảy ra lỗi. Vui lòng xóa dữ liệu quỹ liên quan và thực hiện lại!
					<button type="button" class="btn-close" data-bs-dismiss="alert"
						aria-label="Close"></button>
				</div>`);
			}
			
		},
		error: function() {
			// Do something to handle
		}
	});
}

function deleteMany() {
	var idStr = "";
	$(".category-check").each(function() {
		if ($(this).is(":checked")) {
			if(idStr.length > 0) {
				idStr += ",";
			}
			
			idStr += $(this).val();
		}
	});
	
	if(idStr.length === 0) {
		return;
	}
	var pathS = window.location.pathname.split("/");
	$.ajax({
		url: "/" + pathS[1] + "/admin/category",
		type: "post", //send it through post method
		data: {
			action: "delete",
			deleteCategories:  idStr,
		},
		success: function(data) {
			var dataArr = data.split(",");
			if (dataArr[0] === 'true') {
				var ids = idStr.split(",");
				ids.forEach((id) => {
					$(".row-category-" + id).hide();
				});
				if ($(".row-category:visible").length === 0) {
					window.location.replace("/" + pathS[1] + "/admin/category?index=" + dataArr[1]);
				}
			}else {
				$(".error-message").html(`
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<strong>Hành động xóa thất bại!</strong>  Đã xảy ra lỗi. Vui lòng xóa dữ liệu quỹ liên quan và thực hiện lại!
					<button type="button" class="btn-close" data-bs-dismiss="alert"
						aria-label="Close"></button>
				</div>`);
			}
			
		},
		error: function() {
			// Do something to handle
		}
	});
}