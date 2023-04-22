package controller.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.admin.DonationController;
import dao.DonationDAO;
import dao.UserDAO;
import model.Donation;
import model.User;

/**
 * Servlet implementation class UserController
 */

public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserController() {
		super();
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void getInfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.getRequestDispatcher(response.encodeURL("/client/userInfo.jsp")).forward(request, response);
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			HttpSession session = request.getSession();

			String username = request.getParameter("username");
			String userFullName = request.getParameter("userFullName");
			String userPhoneNumber = request.getParameter("userPhoneNumber");
			String userEmail = request.getParameter("userEmail");
			String userAddress = request.getParameter("userAddress");

			UserDAO userDAO = new UserDAO();
			User user = (User) session.getAttribute("user");

			User userUpdate = new User(user.getId(), username, user.getRole(), userFullName, userEmail, userAddress,
					userPhoneNumber, user.getStatus());

			if (!userDAO.isExistUser(username, userEmail, user.getId()) && userDAO.update(userUpdate)) {
				user.setUsername(username);
				user.setAddress(userAddress);
				user.setFullName(userFullName);
				user.setEmail(userEmail);
				user.setPhoneNumber(userPhoneNumber);

				session.setAttribute("user", user);
				request.setAttribute("verifyModalAction", "show");
			} else {
				request.setAttribute("updateStatus", 0);
			}

			request.getRequestDispatcher(response.encodeURL("/client/userInfo.jsp")).forward(request, response);

		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	
	private void getDonation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		DonationDAO donationDAO = new DonationDAO();
		
		List<Donation> userDonations = donationDAO.getUserDonation(user.getId());
		
		session.setAttribute("userDonations", userDonations);
		
		request.getRequestDispatcher(response.encodeURL("/client/userDonation.jsp")).forward(request, response);
	}
	
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewDonation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String donationIdStr = request.getParameter("donationId");
			int donationId = Integer.parseInt(donationIdStr);

			DonationDAO donationDAO = new DonationDAO();
			Donation donation = donationDAO.get(donationId);

			// Create a new Locale
			Locale vn = new Locale("vi", "VN");
			// Create a formatter given the Locale
			NumberFormat vndFormat = NumberFormat.getCurrencyInstance(vn);
			
			

			PrintWriter out = response.getWriter();
			if (donation != null) {
				out.println("<div class=\"modal fade\" id=\"donation-modal-view\"\r\n"
						+ "		data-bs-backdrop=\"static\" data-bs-keyboard=\"false\" tabindex=\"-1\"\r\n"
						+ "		aria-hidden=\"true\">\r\n"
						+ "		<div\r\n"
						+ "			class=\"modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable\">\r\n"
						+ "			<div class=\"modal-content\">\r\n"
						+ "				<div class=\"modal-header\">\r\n"
						+ "					<h5 class=\"modal-title\">Xem lượt quyên góp</h5>\r\n"
						+ "				</div>\r\n"
						+ "				<div class=\"modal-body\">\r\n"
						+ "					<form action=\"\" method=\"post\" novalidate>\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Số tiền quyên góp</label> <input\r\n"
						+ "								id=\"donation-amount\" type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\"" + vndFormat.format(donation.getDonationAmount()) + "\" readonly\r\n"
						+ "								name=\"donationAmount\">\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Lời nhắn</label>\r\n"
						+ "							<textarea id=\"donation-message\" rows=\"5\" class=\"form-control\"\r\n"
						+ "								readonly name=\"donationMessage\">" + donation.getDonationMessage() + "</textarea>\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Ngày quyên góp</label> <input\r\n"
						+ "								id=\"donation-created-date\" type=\"text\" class=\"form-control\"\r\n"
						+ "								name=\"donationCDate\" readonly value=\"" + donation.getDonationDate() +"\">\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Quỹ quyên góp</label> <input\r\n"
						+ "								id=\"donation-fundname\" type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\"" + donation.getFund().getName() + "\" readonly\r\n"
						+ "								name=\"donationFundname\">\r\n"
						+ "						</div>\r\n"
						+ "					</form>\r\n"
						+ "				</div>\r\n"
						+ "				<div class=\"modal-footer\">\r\n"
						+ "					<button type=\"button\" class=\"btn btn-secondary\"\r\n"
						+ "						data-bs-dismiss=\"modal\">Đóng</button>\r\n"
						+ "				</div>\r\n"
						+ "			</div>\r\n"
						+ "		</div>\r\n"
						+ "	</div>\r\n"
						+ "");
			} else {
				out.println("<div class=\"modal fade\" id=\"category-modal-view\"\r\n"
						+ "		data-bs-backdrop=\"static\" data-bs-keyboard=\"false\" tabindex=\"-1\"\r\n"
						+ "		aria-hidden=\"true\">\r\n" + "		<div\r\n"
						+ "			class=\"modal-dialog modal-dialog-centered modal-dialog-scrollable\">\r\n"
						+ "			<div class=\"modal-content\">\r\n"
						+ "				<div class=\"modal-header\">\r\n"
						+ "					<h5 class=\"modal-title\">Xem danh mục</h5>\r\n"
						+ "				</div>\r\n" + "				<div class=\"modal-body\">\r\n"
						+ "					<h6>Lỗi! Không có thông tin để hiển thị</h6>\r\n"
						+ "				</div>\r\n" + "				<div class=\"modal-footer\">\r\n"
						+ "					<button type=\"button\" class=\"btn btn-secondary\"\r\n"
						+ "						data-bs-dismiss=\"modal\">Close</button>\r\n"
						+ "				</div>\r\n" + "			</div>\r\n" + "		</div>\r\n" + "	</div>");
			}
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		String action = request.getParameter("action");
		if (action.equals("getInfo")) {
			getInfo(request, response);
		}else if(action.equals("getDonation")) {
			getDonation(request, response);
		}else if(action.equals("viewDonation")) {
			viewDonation(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		String action = request.getParameter("action");
		if (action.equals("doUpdate")) {
			doUpdate(request, response);
		}
	}

}
