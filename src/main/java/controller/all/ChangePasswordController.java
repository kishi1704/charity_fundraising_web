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

/**
 * Servlet implementation class ChangePasswordController
 */
public class ChangePasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePasswordController() {
        super();
        
    }
    
    private void doChangePassword(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
		
			String password = request.getParameter("password");
			String newPassword = request.getParameter("newPassword");

			
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("user");
			
			if (user != null && user.getPassword().equals(PasswordCreation.encodePassword(password))) {
				user.setPassword(PasswordCreation.encodePassword(newPassword));
				UserDAO userDAO = new UserDAO();
				
				boolean isUpdate = userDAO.updatePassword(user);
				if(isUpdate) {
					request.setAttribute("verifyModalAction", "show");
				}else {
					request.setAttribute("changePwStatus", 0);
				}
				
			} else {
				request.setAttribute("changePwStatus", 0);
			}
			request.setAttribute("password", password);
			request.setAttribute("newPassword", newPassword);
			request.getRequestDispatcher(response.encodeURL("/client/changePassword.jsp")).forward(request, response);

		} catch (Exception e) {
			Logger.getLogger(LogInController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		request.getRequestDispatcher(response.encodeURL("/client/changePassword.jsp")).forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		doChangePassword(request, response);
	}

}
