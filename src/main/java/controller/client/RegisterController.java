package controller.client;

import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;
import util.PasswordCreation;
import util.UserAction;

/**
 * Servlet implementation class RegisterController
 */
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterController() {
		super();
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void doRegister(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String username = request.getParameter("username");
			String userFullName = request.getParameter("userFullName");
			String userPhoneNumber = request.getParameter("userPhoneNumber");
			String userEmail = request.getParameter("userEmail");
			String userAddress = request.getParameter("userAddress");
			
			UserDAO userDAO = new UserDAO();
			User user = new User(username, 1, userFullName, userEmail, userAddress, userPhoneNumber,
					"Enable");
			
			if(userDAO.isExistUser(username, userEmail)) {
				request.setAttribute("registerStatus", 0);
			}else {
				String password = PasswordCreation.generateRandomPassword(8);
				user.setPassword(PasswordCreation.encodePassword(password));
				
				File registerForm=new File(getServletContext().getRealPath("/document/registerform.txt"));
				boolean isSuccessSending = UserAction.sendRegisterMail(user, password, registerForm);
				
				if(isSuccessSending && userDAO.insert(user) != null) {
					request.setAttribute("verifyModalAction", "show");
					
				}else {
					request.setAttribute("registerStatus", 0);
				}
			}
			
			request.setAttribute("userFullName", userFullName);
			request.setAttribute("username", username);
			request.setAttribute("userPhoneNumber", userPhoneNumber);
			request.setAttribute("userEmail", userEmail);
			request.setAttribute("userAddress", userAddress);
			request.getRequestDispatcher(response.encodeURL("/client/register.jsp")).forward(request, response);
			
		} catch (Exception e) {
			Logger.getLogger(RegisterController.class.getName()).log(Level.SEVERE, null, e);
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

		request.getRequestDispatcher(response.encodeURL("/client/register.jsp")).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		doRegister(request, response);

	}

}
