package controller.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
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
import dao.FundDAO;
import model.Donation;
import model.Fund;
import model.User;

/**
 * Servlet implementation class DonationController
 */
public class DonationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DonationController() {
		super();
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void showFund(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int fundId = Integer.parseInt(request.getParameter("fundId"));
			String fundStatus = request.getParameter("status");
			FundDAO fundDAO = new FundDAO();

			Fund donationFund = fundDAO.get(fundId);
			List<Fund> openFunds = fundDAO.getByCategory(1, donationFund.getCategory().getId(), 0, 3);
			HttpSession session = request.getSession();
			session.setAttribute("pageActive", "home-page");
			session.setAttribute("donationFund", donationFund);
			
			request.setAttribute("openFundList", openFunds);
			request.setAttribute("fundStatus", fundStatus);

			request.getRequestDispatcher(response.encodeURL("/client/donationFund.jsp")).forward(request, response);
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
	private void addDonate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int donationAmount = Integer.parseInt(request.getParameter("amount"));
			String donationMess = request.getParameter("message");

			HttpSession session = request.getSession();
			Fund donationFund = (Fund) session.getAttribute("donationFund");
			User user = (User) session.getAttribute("user");

			Donation donation = new Donation(donationAmount, donationMess, new Date(System.currentTimeMillis()), user,
					donationFund);
			DonationDAO donationDAO = new DonationDAO();
			Donation donationInsert = donationDAO.insert(donation);
			
			PrintWriter out = response.getWriter();
			out.print(donationInsert != null);
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
	private void addRelativeFund(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int currentFunds = Integer.parseInt(request.getParameter("currentFunds"));
			HttpSession session = request.getSession();

			FundDAO fundDAO = new FundDAO();
			Fund donationFund = (Fund) session.getAttribute("donationFund");
			List<Fund> openFunds = fundDAO.getByCategory(1,donationFund.getCategory().getId(), currentFunds, 3);

			// Create a new Locale
			Locale vn = new Locale("vi", "VN");
			// Create a formatter given the Locale
			NumberFormat vndFormat = NumberFormat.getCurrencyInstance(vn);
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			NumberFormat percentFormatter = NumberFormat.getPercentInstance(vn);

			User user = (User) session.getAttribute("user");

			String displayBtn = null;
			if(user != null && user.getRole() == 1) {
				displayBtn = "<a class=\"btn btn-success\"\r\n"
						+ "href=\"#\" role=\"button\">Quyên góp</a>";
			}else {
				displayBtn = "<a class=\"btn btn-success position-relative\"\r\n"
						+ "	style=\"z-index: 2;\" href=\"login\" role=\"button\">Đăng\r\n"
						+ "nhập để quyên góp</a>\r\n";
			}
			
			PrintWriter out = response.getWriter();
			if(openFunds != null) {
				for(Fund f: openFunds) {
					out.println("<div class=\"open-fund col\">\r\n"
							+ "	<div class=\"card h-100\">\r\n"
							+ "		<img src=\"" + f.getImage_url() + "\" class=\"card-img-top\" alt=\"fund image\">\r\n"
							+ "		<div class=\"card-body\">\r\n"
							+ "			<h5 class=\"card-title fund-name pb-2\">" + f.getName() + "</h5>\r\n"
							+ "			<h6 class=\"card-subtitle text-muted  mb-2 pb-2\">\r\n"
							+ "				<em>" + f.getFoundation().getName() + "</em>\r\n"
							+ "			</h6>\r\n"
							+ "			<p class=\"card-text mb-1\">" + f.getDescription() + "</p>\r\n"
							+ "         <a href=\"donation?fundId=" + f.getId() + "&status=opening\" class=\"stretched-link\"></a>"
							+ "		</div>\r\n"
							+ "		<div class=\"card-footer bg-transparent border-top-0\">\r\n"
							+ "			<div class=\"d-flex justify-content-between\">\r\n"
							+ "				<p>\r\n"
							+ "					<span class=\"font-weight-bold\">" + vndFormat.format(f.getTotalDonation()) + "</span> /\r\n"
							+ "					<span class=\"text-secondary\">" + vndFormat.format(f.getExpectedAmount()) + "</span>\r\n"
							+ "				</p>"
							+ "				<p>\r\n"
							+ "					<span class=\"badge rounded-pill bg-success\">" + df.format(f.getEndDate()) + "</span>\r\n"
							+ "				</p>\r\n"
							+ "			</div>\r\n"
							+ "			<div class=\"progress\" style=\"height: 5px\">\r\n"
							+ "				<div class=\"progress-bar bg-success\" role=\"progressbar\"\r\n"
							+ "					aria-valuenow=\"0\" aria-valuemin=\"0\" aria-valuemax=\"100\"\r\n"
							+ "					style=\"width:" + 100.0 * f.getTotalDonation() / f.getExpectedAmount() + "%\"></div>\r\n"
							+ "			</div>\r\n"
							+ "			<div class=\"d-flex justify-content-between align-items-center mt-3\">\r\n"
							+ 				displayBtn 
							+ "				<p class=\"mb-0 text-secondary\">\r\n"
							+ "					Đạt được <br> <span class=\"text-dark font-weight-bold\">" 
							+ percentFormatter.format(f.getTotalDonation() * 1.0 / f.getExpectedAmount()) + "</span>\r\n"
							+ "				</p>\r\n"
							+ "			</div>\r\n"
							+ "		</div>\r\n"
							+ "	</div>\r\n"
							+ "</div>");
				}
			}else {
				out.println("");
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

		if (action == null) {
			showFund(request, response);
		}  else if (action.equals("addRelativeFund")) {
			addRelativeFund(request, response);
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
		if (action.equals("adddonate")) {
			addDonate(request, response);
		} else {
			doGet(request, response);
		}
	}

}
