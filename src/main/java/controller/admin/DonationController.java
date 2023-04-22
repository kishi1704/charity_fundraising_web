package controller.admin;

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

import dao.DonationDAO;
import model.Donation;

/**
 * Servlet implementation class CategoryController
 */

public class DonationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DonationController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void showDonation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String indexString = request.getParameter("index");
			if (indexString == null) {
				indexString = "1";
			}

			int index = Integer.parseInt(indexString);

			DonationDAO donationDAO = new DonationDAO();

			int count = donationDAO.countD();
			int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));
			int endPage = 0;

			endPage = count / pageSize;
			if (count % pageSize != 0) {
				endPage++;
			}

			HttpSession session = request.getSession();

			List<Donation> donations = donationDAO.search(index, pageSize);

			session.setAttribute("endPage", endPage);
			session.setAttribute("donations", donations);
			session.setAttribute("index", index);
			session.setAttribute("donationAction", "home");
			session.setAttribute("donationSUsername", "");
			session.setAttribute("donationSId", "");
			session.setAttribute("donationSFund", "");

			request.getRequestDispatcher(response.encodeURL("/admin/donation/donation.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void searchDonation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String indexString = request.getParameter("index");
			String idString = request.getParameter("donationId");
			String username = request.getParameter("username");
			String fundname = request.getParameter("fundname");

			if (indexString == null || indexString.isEmpty()) {
				indexString = "1";
			}

			if (idString == null || idString.isEmpty()) {
				idString = "-1";
			}

			int index = Integer.parseInt(indexString);
			int donationId = Integer.parseInt(idString);

			DonationDAO donationDAO = new DonationDAO();

			int count = donationDAO.countD(donationId, username, fundname);
			int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));
			int endPage = 0;

			endPage = count / pageSize;
			if (count % pageSize != 0) {
				endPage++;
			}

			List<Donation> donations = donationDAO.search(donationId, username, fundname, index, pageSize);

			HttpSession session = request.getSession();
			session.setAttribute("endPage", endPage);
			session.setAttribute("donations", donations);
			session.setAttribute("index", index);
			session.setAttribute("donationAction", "search");
			session.setAttribute("donationSUsername", username);
			session.setAttribute("donationSId", donationId == -1 ? "" : donationId);
			session.setAttribute("donationSFund", fundname);
			request.getRequestDispatcher(response.encodeURL("/admin/donation/donation.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
		}
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
						+ "							<label class=\"form-label\">ID</label> <input id=\"donation-id\"\r\n"
						+ "								type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\"" + donation.getId() + "\" readonly name=\"donationId\" />\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
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
						+ "							<label class=\"form-label\">Người quyên góp</label> <input\r\n"
						+ "								id=\"donation-username\" type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\"" + donation.getUser().getUsername() + "\" readonly\r\n"
						+ "								name=\"donationUsername\">\r\n"
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
		HttpSession session = request.getSession();
		session.setAttribute("pageActive", "admin-donation");

		String action = request.getParameter("action");

		if (action == null || action.equals("home")) {
			showDonation(request, response);
		} else if (action.equals("search")) {
			searchDonation(request, response);
		} else if (action.equals("view")) {
			viewDonation(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
