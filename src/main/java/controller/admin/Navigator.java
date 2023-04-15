package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Navigator
 */
public class Navigator extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Navigator() {
		super();
		// TODO Auto-generated constructor stub
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
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/home"));
		}else if (action.equals("category")) {
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/category"));
		}else if (action.equals("foundation")) {
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/foundation"));
		}else if (action.equals("fund")) {
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/fund"));
		}else if (action.equals("donation")) {
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/donation"));
		}else if (action.equals("user")) {
			response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/user"));
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
