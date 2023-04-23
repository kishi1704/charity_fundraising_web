/**
 * 
 */

$(document).ready(function() {
	// add more open fund
	$(".btn-view-more-openf").click(function(e) {

		var currentOpenFunds = $(".open-fund").length;

		var pathS = window.location.pathname.split("/");
		$.ajax({
			url: "/" + pathS[1] + "/home",
			type: "get", //send it through get method
			data: {
				action: "addOpenFund",
				currentOpenFunds: currentOpenFunds,
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
	
	// add more open fund
	$(".btn-view-more-closedf").click(function(e) {

		var currentClosedFunds = $(".closed-fund").length;

		var pathS = window.location.pathname.split("/");
		$.ajax({
			url: "/" + pathS[1] + "/home",
			type: "get", //send it through post method
			data: {
				action: "addClosedFund",
				currentClosedFunds: currentClosedFunds,
			},
			success: function(data) {
				if (data !== "") {
					$(".closed-fund-content").append(data);
				} else {
					$(e.target).addClass("d-none");
				}
			},
			error: function() {
				// Do something to handle
			}
		});
	})

})
