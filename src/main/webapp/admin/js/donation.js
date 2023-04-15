/**
 * 
 */
$(document).ready(function() {
	// search donation
	$(".btn-search").click(function() {
		var pathS = window.location.pathname.split("/");
		var id = $("#search-id").val();
		var username = $("#search-username").val();
		var fundname = $("#search-fundname").val();
		window.location.replace("/" + pathS[1] + "/admin/donation?action=search&donationId=" + id + "&username=" + username + "&fundname=" + fundname);
	})

})

