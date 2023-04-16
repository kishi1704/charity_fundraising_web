package controller.client;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;
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
