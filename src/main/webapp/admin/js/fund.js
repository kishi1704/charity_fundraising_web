/**
 * 
 */
$(document).ready(function() {
	// search fund
	$(".btn-search").click(function() {
		var pathS = window.location.pathname.split("/");
		var id = $("#search-id").val();
		var name = $("#search-name").val();
		var foundation = $("#search-foundation").val();
		var category = $("#filter-category").val();
		window.location.replace("/" + pathS[1] + "/admin/fund?action=search&fundId=" + id + "&fundName=" + name + "&foundation=" + foundation + "&category=" + category);
	});


	// edit fund
	$(".btn-edit").click(function(e) {
		e.stopPropagation();
		var pathS = window.location.pathname.split("/");
		var id = $(e.target).val();
		window.location.replace("/" + pathS[1] + "/admin/fund?action=edit&fundId=" + id);
	})

	// add new fund
	$(".btn-add").click(function() {
		var pathS = window.location.pathname.split("/");
		window.location.replace("/" + pathS[1] + "/admin/fund?action=add");
	})

	// delete fund
	$(".btn-delete").click(function(e) {
		e.stopPropagation();
		var id = $(e.target).val();
		$(".btn-confirm-ok").attr("onclick", `deleteOne(${id})`);

	})

	// delete more fund
	$("#btn-selected-delete").click(function() {
		$(".btn-confirm-ok").attr("onclick", "deleteMany()");
	})

})

function deleteOne(id) {

	var pathS = window.location.pathname.split("/");
	$.ajax({
		url: "/" + pathS[1] + "/admin/fund",
		type: "post", //send it through post method
		data: {
			action: "delete",
			deleteFunds: id,
		},
		success: function(data) {
			var dataArr = data.split(",");
			if (dataArr[0] === 'true') {
				$(".row-fund-" + id).hide();
				if ($(".row-fund:visible").length === 0) {
					window.location.replace("/" + pathS[1] + "/admin/fund?index=" + dataArr[1]);
				}
			} else {
				$(".error-message").html(`
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<strong>Hành động xóa thất bại!</strong>  Đã xảy ra lỗi. Vui lòng xóa dữ liệu lượt quyên góp liên quan và thực hiện lại!
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
	$(".fund-check").each(function() {
		if ($(this).is(":checked")) {
			if (idStr.length > 0) {
				idStr += ",";
			}

			idStr += $(this).val();
		}
	});

	if (idStr.length === 0) {
		return;
	}
	var pathS = window.location.pathname.split("/");
	$.ajax({
		url: "/" + pathS[1] + "/admin/fund",
		type: "post", //send it through post method
		data: {
			action: "delete",
			deleteFunds: idStr,
		},
		success: function(data) {
			var dataArr = data.split(",");
			if (dataArr[0] === 'true') {
				var ids = idStr.split(",");
				ids.forEach((id) => {
					$(".row-fund-" + id).hide();
				});
				if ($(".row-fund:visible").length === 0) {
					window.location.replace("/" + pathS[1] + "/admin/fund?index=" + dataArr[1]);
				}
			} else {
				$(".error-message").html(`
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<strong>Hành động xóa thất bại!</strong>  Đã xảy ra lỗi. Vui lòng xóa dữ liệu lượt quyên góp liên quan và thực hiện lại!
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