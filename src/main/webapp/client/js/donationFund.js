/**
 * 
 */

$(document).ready(function() {
	// add more open fund
	$(".btn-view-more-openf").click(function(e) {

		var currentFunds = $(".open-fund").length;

		var pathS = window.location.pathname.split("/");
		$.ajax({
			url: "/" + pathS[1] + "/donation",
			type: "get", //send it through get method
			data: {
				action: "addRelativeFund",
				currentFunds: currentFunds,
			},
			success: function(data) {
				if (data !== "") {
					$(".open-fund-content").append(data);
				} else {
					$(e.target).addClass("d-none");
				}
			},
			error: function() {
				// Do something to handle
			}
		});
	})

	// save edit
	$(".btn-donate").click(function(e) {
		if (!isValid()) {
			e.preventDefault();
			return;
		}

		var pathS = window.location.pathname.split("/");
		$.ajax({
			url: "/" + pathS[1] + "/donation",
			type: "post", //send it through get method
			data: {
				action: "adddonate",
				amount: $("#donation-amount").val(),
				message: $("#donation-message").val()
			},
			success: function(data) {
				if(data === 'true') {
					$("#donationModal").modal('hide');
					$("#successDonationModal").modal('show');
				}else {
					$("#failedDonationModal").modal('show');
				}
			},
			error: function() {
				$("#failedDonationModal").modal('show');
			}
		});
	})

})

// Validate
function isValid() {
	var amountEl = $("#donation-amount");
	var regexNumber = /^\d+$/;
	var flag = true;
	if (amountEl.val() === "" || amountEl.val().length < 4 || !regexNumber.test(amountEl.val())) {
		flag = false;
		amountEl.addClass("is-invalid");
	} else {
		amountEl.removeClass("is-invalid");
	}

	return flag;
}
