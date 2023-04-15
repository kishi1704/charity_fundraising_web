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
 * Servlet implementation class EntryController
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		request.getRequestDispatcher(response.encodeURL("/client/login.jsp")).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		try {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			UserDAO userDAO = new UserDAO();
			User user = userDAO.get(username, PasswordCreation.encodePassword(password));
			
			HttpSession session = request.getSession();
			if(user != null) {
				session.setAttribute("user", user);
				if(user.getRole() == 1) {
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath()));
				}else {
					response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin"));
				}
			}else {
				request.setAttribute("username", username);
				request.setAttribute("password", password);
				request.setAttribute("loginStatus", 0);
				request.getRequestDispatcher(response.encodeURL("/client/login.jsp")).forward(request, response);
			}

		} catch (Exception e) {
			Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

}
