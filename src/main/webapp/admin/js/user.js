/**
 * 
 */
$(document).ready(function() {
	// search user
	$(".btn-search").click(function() {
		var pathS = window.location.pathname.split("/");
		var role = $("#filter-user").val();
		var username = $("#search-name").val();
		var userEmail = $("#search-email").val();
		window.location.replace("/" + pathS[1] + "/admin/user?action=search&username=" + username + "&email=" + userEmail + "&userRole=" + role);
	})


	// edit user
	$(".btn-edit").click(function(e) {
		e.stopPropagation();
		var pathS = window.location.pathname.split("/");
		var id = $(e.target).val();
		window.location.replace("/" + pathS[1] + "/admin/user?action=edit&userId=" + id);
	})

	// add new user
	$(".btn-add").click(function() {
		var pathS = window.location.pathname.split("/");
		window.location.replace("/" + pathS[1] + "/admin/user?action=add");
	})

	// delete user
	$(".btn-delete").click(function(e) {
		e.stopPropagation();
		var id = $(e.target).val();
		$(".btn-confirm-ok").attr("onclick", `deleteOne(${id})`);

	})

	
})

function deleteOne(id) {

	var pathS = window.location.pathname.split("/");
	$.ajax({
		url: "/" + pathS[1] + "/admin/user",
		type: "post", //send it through post method
		data: {
			action: "delete",
			deletedUserId: id,
		},
		success: function(data) {
			var dataArr = data.split(",");
			if (dataArr[0] === 'true') {
				$(".row-user-" + id).hide();
				if ($(".row-user:visible").length === 0) {
					window.location.replace("/" + pathS[1] + "/admin/user?index=" + dataArr[1]);
				}
			}else {
				$(".error-message").html(`
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<strong>Hành động xóa thất bại!</strong> Đã xảy ra lỗi. Vui lòng thực hiện lại!
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

