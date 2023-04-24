package controller.client;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.FoundationDAO;
import model.Foundation;

/**
 * Servlet implementation class FoundationController
 */

public class FoundationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FoundationController() {
		super();
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void showFoundation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			FoundationDAO foundationDAO = new FoundationDAO();
			List<Foundation> foundations = foundationDAO.get("Enable");
			
			HttpSession session = request.getSession();
			session.setAttribute("pageActive", "foundation-page");
			
			request.setAttribute("foundationList", foundations);
			
			request.getRequestDispatcher(response.encodeURL("/client/foundation.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
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
			showFoundation(request, response);
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
