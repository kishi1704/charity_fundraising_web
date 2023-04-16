/**
 * 
 */

$(document).ready(function() {
	// change to update
	$(".btn-edit").click(function(e) {
		e.stopPropagation();
		$("#info-field").removeAttr("disabled");
		$(e.target).addClass("d-none");
		$(".btn-update").removeClass("d-none");
	})

	$(".btn-update").click(function(e) {
		e.stopPropagation();
		if (!isValid()) {
			e.preventDefault();
			return;
		}
		$("form").submit();
	})
})

// Validate
function isValid() {
	var regexMail = /^\S+@\S+\.\S+$/;
	var regexPhone = /^([0-9]{10})$/;
	var phoneEl = $("#user-phone-number");
	var emailEl = $("#user-email");

	var flag = true;
	if (isBlank($("#username"), 50)) {
		flag = false;
	}

	if (isBlank($("#user-fullname"), 100)) {
		flag = false;
	}

	if ((phoneEl.val() === "") || (!regexPhone.test(phoneEl.val()))) {
		flag = false;
		phoneEl.addClass("is-invalid");
	} else {
		phoneEl.removeClass("is-invalid");
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