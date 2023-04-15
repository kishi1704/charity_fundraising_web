/**
 * 
 */


$(document).ready(function() {
	// disabled link header
	$(".list-group-item").addClass("disabled");

	// limit date input for end date
	var startDEl = $("#fund-created-date");
	var endDEl = $("#fund-end-date");

	var today = new Date().toISOString().slice(0, 10);
	endDEl.attr({ "min": today });

	// limit date input for start date
	if (startDEl.val() === "") {
		startDEl.val(today);
	}

	startDEl.on("input", function() {
		isValidDate();

	});

	endDEl.on("input", function() {
		startDEl.attr({ "max": endDEl.val() });
		isValidDate();

	});

	const isValidDate = () => {
		var startDate = new Date(startDEl.val()).getTime();
		var endDate = new Date(endDEl.val()).getTime();
		if (startDate < endDate) {
			startDEl.removeClass("is-invalid");
			endDEl.removeClass("is-invalid");
			return true;
		} else {
			startDEl.addClass("is-invalid");
			endDEl.addClass("is-invalid");
			return false;
		}

	}


	// cancel edit
	$(".btn-confirm-ok").click(function(e) {
		var pathS = window.location.pathname.split("/");
		var index = $(e.target).val();
		window.location.replace("/" + pathS[1] + "/admin/fund?action=cancel&index=" + index);
	})

	// save edit
	$(".btn-save").click(function(e) {
		if (!isValid() || !isValidDate()) {
			e.preventDefault();
			return;
		}

		var pathS = window.location.pathname.split("/");
		$("form").attr("action", "/" + pathS[1] + "/admin/fund?action=save");
	})


})

// Validate
function isValid() {
	var flag = true;
	var content = CKEDITOR.instances["fund-content"].getData();
	var amountEl = $("#fund-expected-result");
	var regexNumber = /^\d+$/;

	if (isBlank($("#fund-name"), 200)) {
		flag = false;
	}

	if (isBlank($("#fund-description"), 500)) {
		flag = false;
	}

	if (isBlank($("#fund-end-date"), 0)) {
		flag = false;
	}

	if (content === "") {
		flag = false;
		$("#fund-content").addClass("is-invalid");
	} else {
		$("#fund-content").removeClass("is-invalid");
	}

	if (isBlank(amountEl, 0)) {
		flag = false;
	}

	if (!regexNumber.test(amountEl.val())) {
		flag = false;
		amountEl.addClass("is-invalid");
	} else {
		amountEl.removeClass("is-invalid");
	}

	if (isBlank($("#fund-category"), 0)) {
		flag = false;
	}

	if (isBlank($("#fund-foundation"), 0)) {
		flag = false;
	}

	return flag;
}

const isBlank = (el, len) => {

	if ((el.val() === null) || (el.val() === "") || ((len !== 0) && (el.val().length > len))) {
		el.addClass("is-invalid");
		return true;
	} else {
		el.removeClass("is-invalid");
		return false;
	}
}



