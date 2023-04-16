/**
 * 
 */

$(document).ready(function() {
	// register 
	$(".btn-reset-pw").click(function(e) {
		if (!isValid()) {
			e.preventDefault();
			return;
		}

		var pathS = window.location.pathname.split("/");
		
		$("form").attr("action", "/" + pathS[1] + "/login?action=resetpw");
	})

})

// Validate
function isValid() {
	var regexMail = /^\S+@\S+\.\S+$/;
	var emailEl = $("#user-email");

	var flag = true;
	if (isBlank($("#username"), 50)) {
		flag = false;
	}

	if ((emailEl.val() === "") || (emailEl.val().length > 120) || (!regexMail.test(emailEl.val()))) {
		flag = false;
		emailEl.addClass("is-invalid");
	} else {
		emailEl.removeClass("is-invalid");
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