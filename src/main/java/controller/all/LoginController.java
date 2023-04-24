package controller.all;

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
import util.PasswordCreation;
import util.UserAction;

/**
 * Servlet implementation class EntryController
 */
public class LogInController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LogInController() {
		super();
		// TODO Auto-generated constructor stub
	}

	private void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String username = request.getParameter("username");
			String password = request.getParameter("password");

			UserDAO userDAO = new UserDAO();
			User user = userDAO.get(username, PasswordCreation.encodePassword(password), "Enable");

			HttpSession session = request.getSession();
			if (user != null) {
				session.setAttribute("user", user);
				if (user.getRole() == 1) {
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath()));
				} else {
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin"));
				}
			} else {
				request.setAttribute("username", username);
				request.setAttribute("password", password);
				request.setAttribute("loginStatus", 0);
				request.getRequestDispatcher(response.encodeURL("/client/login.jsp")).forward(request, response);
			}

		} catch (Exception e) {
			Logger.getLogger(LogInController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	private void doResetPw(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String username = request.getParameter("username");
			String userEmail = request.getParameter("userEmail");
			
			UserDAO userDAO = new UserDAO();
			
			if(userDAO.isExistUser(username, userEmail)) {
				String password = PasswordCreation.generateRandomPassword(8);
				User user = new User(username, PasswordCreation.encodePassword(password), userEmail);
				
				boolean isSuccessSending = UserAction.sendPasswordResetMail(user, password);
				
				if(isSuccessSending && userDAO.updatePassword(user)) {
					request.setAttribute("verifyModalAction", "show");
					
				}else {
					request.setAttribute("resetPwStatus", 0);
				}
			}else {
				request.setAttribute("resetPwStatus", 0);
			}
			
			request.setAttribute("username", username);
			request.setAttribute("userEmail", userEmail);
			request.getRequestDispatcher(response.encodeURL("/client/forgetPassword.jsp")).forward(request, response);
			
		} catch (Exception e) {
			Logger.getLogger(LogInController.class.getName()).log(Level.SEVERE, null, e);
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
		if(action == null) {
			request.getRequestDispatcher(response.encodeURL("/client/login.jsp")).forward(request, response);
		}else if(action.equals("resetpw")) {
			request.getRequestDispatcher(response.encodeURL("/client/forgetPassword.jsp")).forward(request, response);
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
		if(action == null) {
			doLogin(request, response);
		}else if(action.equals("resetpw")) {
			doResetPw(request, response);
		}
	}

}
