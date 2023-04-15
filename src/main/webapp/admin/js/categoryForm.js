/**
 * 
 */


$(document).ready(function() {
	// disabled link header
	$(".list-group-item").addClass("disabled");
	// cancel edit
	$(".btn-confirm-ok").click(function(e) {
		var pathS = window.location.pathname.split("/");
		var index = $(e.target).val();
		window.location.replace("/" + pathS[1] + "/admin/category?action=cancel&index=" + index);
	})

	// save edit
	$(".btn-save").click(function(e) {
		if (!isValid()) {
			e.preventDefault();
			return;
		}

		var pathS = window.location.pathname.split("/");
		$("form").attr("action", "/" + pathS[1] + "/admin/category?action=save");
	})



})

// Validate
function isValid() {
	var flag = true;
	if (isBlank($("#category-name"), 100)) {
		flag = false;
	}

	if (isBlank($("#category-description"), 500)) {
		flag = false;
	}

	return flag;
}

const isBlank = (el, len) => {

	if (el.val() === "" || el.val().length > len) {
		el.addClass("is-invalid");
		return true;
	} else {
		el.removeClass("is-invalid");
		return false;
	}
}