package controller.client;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CategoryDAO;
import dao.DonationDAO;
import model.Category;
import model.Donation;

/**
 * Servlet implementation class Navigator
 */
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HomeController() {
		super();

	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void goHome(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		CategoryDAO categoryDAO = new CategoryDAO();
		DonationDAO donationDAO = new DonationDAO();
		
		List<Category> categories = categoryDAO.get("Enable");
		List<Donation> donations = donationDAO.getRecentDonation(8);
		
		HttpSession session = request.getSession();
		session.setAttribute("categoryList", categories);
		session.setAttribute("pageActive", "home-page");
		
		request.setAttribute("recentDonationList", donations);
		
		request.getRequestDispatcher(response.encodeURL("/client/index.jsp")).forward(request, response);
	}
	

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void goAbout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.getRequestDispatcher(response.encodeURL("/client/aboutOur.jsp")).forward(request, response);
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

		if (action == null || action.equals("home")) {
			goHome(request, response);
		}else if(action.equals("about")) {
			goAbout(request, response);
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
