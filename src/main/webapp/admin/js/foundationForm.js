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
		window.location.replace("/" + pathS[1] + "/admin/foundation?action=cancel&index=" + index);
	})

	// save edit
	$(".btn-save").click(function(e) {
		if (!isValid()) {
			e.preventDefault();
			return;
		}

		var pathS = window.location.pathname.split("/");
		$("form").attr("action", "/" + pathS[1] + "/admin/foundation?action=save");
	})



})

// Validate
function isValid() {
	var regexMail = /^\S+@\S+\.\S+$/;
	var emailEl = $("#foundation-email");
	
	var flag = true;
	if (isBlank($("#foundation-name"), 100)) {
		flag = false;
	}

	if (isBlank($("#foundation-description"), 1000)) {
		flag = false;
	}
	
	if((emailEl.val() === "")|| (emailEl.val().length > 120) || (!regexMail.test(emailEl.val()))) {
		flag = false;
		emailEl.addClass("is-invalid");
	}else {
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