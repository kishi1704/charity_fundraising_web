/**
 * 
 */

$(document).ready(function() {
	// register 
	$(".btn-change-pw").click(function(e) {
		if (!isValid()) {
			e.preventDefault();
			return;
		}

		var pathS = window.location.pathname.split("/");
		
		$("form").attr("action", "/" + pathS[1] + "/user/change_password");
	})

})

// Validate
function isValid() {
	var newPwEl = $("#new-password");
	var newPwREl = $("#new-password-repeat");
	var flag = true;
	if (isBlank($("#password"), 64)) {
		flag = false;
	}
	
	if (isBlank(newPwEl, 64) || isBlank(newPwREl, 64)) {
		flag = false;
	}else if(newPwEl.val() !== newPwREl.val()) {
		flag = false;
		newPwEl.addClass("is-invalid");
		newPwREl.addClass("is-invalid");
	}else {
		newPwEl.removeClass("is-invalid");
		newPwREl.removeClass("is-invalid");
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