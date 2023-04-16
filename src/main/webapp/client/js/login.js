/**
 * 
 */

$(document).ready(function() {
	// register 
	$(".btn-login").click(function(e) {
		if (!isValid()) {
			e.preventDefault();
			return;
		}

		var pathS = window.location.pathname.split("/");
		
		$("form").attr("action", "/" + pathS[1] + "/login");
	})

})

// Validate
function isValid() {

	var flag = true;
	if (isBlank($("#username"), 50)) {
		flag = false;
	}

	if (isBlank($("#password"), 64)) {
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