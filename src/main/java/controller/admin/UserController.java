package controller.admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
	private void showUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String indexString = request.getParameter("index");
			if (indexString == null) {
				indexString = "1";
			}

			int index = Integer.parseInt(indexString);

			UserDAO userDAO = new UserDAO();

			int count = userDAO.countU();
			int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));
			int endPage = 0;

			endPage = count / pageSize;
			if (count % pageSize != 0) {
				endPage++;
			}

			HttpSession session = request.getSession();

			if (session.getAttribute("userAction") != null
					&& ((String) session.getAttribute("userAction")).equals("add")) {
				index = endPage;
			}

			List<User> users = userDAO.search(index, pageSize);
			Map<Integer, String> roleList = new HashMap<>();
			roleList.put(1, "User");
			roleList.put(2, "Admin");

			session.setAttribute("roleList", roleList);
			session.setAttribute("endPage", endPage);
			session.setAttribute("users", users);
			session.setAttribute("index", index);
			session.setAttribute("userAction", "home");
			session.setAttribute("SUsername", "");
			session.setAttribute("userSEmail", "");
			session.setAttribute("userSRole", "");

			request.getRequestDispatcher(response.encodeURL("/admin/user/user.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void searchUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String indexString = request.getParameter("index");
			String roleString = request.getParameter("userRole");
			String username = request.getParameter("username");
			String userEmail = request.getParameter("email");

			if (indexString == null || indexString.isEmpty()) {
				indexString = "1";
			}

			if (roleString == null || roleString.isEmpty()) {
				roleString = "-1";
			}

			int index = Integer.parseInt(indexString);
			int userRole = Integer.parseInt(roleString);

			UserDAO userDAO = new UserDAO();

			int count = userDAO.countU(userRole, username, userEmail);
			int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));
			int endPage = 0;

			endPage = count / pageSize;
			if (count % pageSize != 0) {
				endPage++;
			}

			List<User> users = userDAO.search(userRole, username, userEmail, index, pageSize);

			HttpSession session = request.getSession();
			session.setAttribute("endPage", endPage);
			session.setAttribute("users", users);
			session.setAttribute("index", index);
			session.setAttribute("userAction", "search");
			session.setAttribute("SUsername", username);
			session.setAttribute("userSRole", userRole == -1 ? "" : userRole);
			session.setAttribute("userSEmail", userEmail);
			request.getRequestDispatcher(response.encodeURL("/admin/user/user.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void editUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String userIdStr = request.getParameter("userId");
			int userId = Integer.parseInt(userIdStr);

			UserDAO userDAO = new UserDAO();
			User user = userDAO.get(userId);

			HttpSession session = request.getSession();
			session.setAttribute("USResult", "true");
			session.setAttribute("userEdit", user);
			session.setAttribute("userAction", "edit");
			session.setAttribute("statusList", new String[] { "Enable", "Disable" });

			request.getRequestDispatcher(response.encodeURL("/admin/user/userForm.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void updateUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			User userEdit = (User) session.getAttribute("userEdit");
			User currentUser = (User) session.getAttribute("user");

			String username = request.getParameter("username");
			String userRoleStr = request.getParameter("userRole");
			int userRole = userEdit.getRole() == 1 ? Integer.parseInt(userRoleStr) : 2;

			String userFullName = request.getParameter("userFullName");
			String userPhoneNumber = request.getParameter("userPhoneNumber");
			String userEmail = request.getParameter("userEmail");
			String userAddress = request.getParameter("userAddress");
			String userStatus = userEdit.getId() != currentUser.getId() ? request.getParameter("userStatus")
					: currentUser.getStatus();

			UserDAO userDAO = new UserDAO();
			User user = new User(userEdit.getId(), username, userRole, userFullName, userEmail, userAddress,
					userPhoneNumber, userStatus);

			boolean isUpdated = userDAO.update(user);

			if (isUpdated) {
				int index = (Integer) session.getAttribute("index");
				int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));

				List<User> users = userDAO.search(index, pageSize);

				session.setAttribute("users", users);
				session.setAttribute("userAction", "home");
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/user?action=update"));
			} else {
				session.setAttribute("USResult", "false");
				session.setAttribute("userEdit", user);
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/user?action=errorU"));
			}

		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void addUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			HttpSession session = request.getSession();
			session.setAttribute("USResult", "true");
			session.setAttribute("userAction", "add");
			session.setAttribute("userEdit", null);
			session.setAttribute("statusList", new String[] { "Enable", "Disable" });
			request.getRequestDispatcher(response.encodeURL("/admin/user/userForm.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void insertUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String username = request.getParameter("username");
			String userFullName = request.getParameter("userFullName");
			String userPhoneNumber = request.getParameter("userPhoneNumber");
			String userEmail = request.getParameter("userEmail");
			String userAddress = request.getParameter("userAddress");

			UserDAO userDAO = new UserDAO();
			User user = new User(username, 2, userFullName, userEmail, userAddress, userPhoneNumber, "Enable");

			HttpSession session = request.getSession();
			if (userDAO.isExistUser(username, userEmail)) {
				session.setAttribute("USResult", "false");
				session.setAttribute("userEdit", user);
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/user?action=errorU"));
			} else {
				String password = PasswordCreation.generateRandomPassword(8);
				user.setPassword(PasswordCreation.encodePassword(password));

				File registerForm = new File(getServletContext().getRealPath("/document/registerform.txt"));
				boolean isSuccessSending = UserAction.sendRegisterMail(user, password, registerForm);

				if (isSuccessSending && userDAO.insert(user) != null) {
					session.setAttribute("USResult", "true");
					session.setAttribute("userEdit", user);
					request.setAttribute("verifyModalAction", "show");
					request.getRequestDispatcher(response.encodeURL("/admin/user/userForm.jsp")).forward(request,
							response);
				} else {
					session.setAttribute("USResult", "false");
					session.setAttribute("userEdit", user);
					response.sendRedirect(
							response.encodeRedirectURL(request.getContextPath() + "/admin/user?action=errorU"));
				}
			}

		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String deletedUserIdStr = request.getParameter("deletedUserId");
			int deletedUserId = Integer.parseInt(deletedUserIdStr);

			UserDAO userDAO = new UserDAO();

			boolean isDeleted = userDAO.delete(deletedUserId);

			HttpSession session = request.getSession();
			int index = (Integer) session.getAttribute("index") - 1;

			PrintWriter out = response.getWriter();
			out.println(isDeleted + "," + index);
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String userIdStr = request.getParameter("userId");
			int userId = Integer.parseInt(userIdStr);

			UserDAO userDAO = new UserDAO();
			User user = userDAO.get(userId);

			PrintWriter out = response.getWriter();
			if (user != null) {
				out.println("<div class=\"modal fade\" id=\"user-modal-view\" data-bs-backdrop=\"static\"\r\n"
						+ "	data-bs-keyboard=\"false\" tabindex=\"-1\" aria-hiden=\"true\">\r\n" + "	<div\r\n"
						+ "		class=\"modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable\">\r\n"
						+ "		<div class=\"modal-content\">\r\n" + "			<div class=\"modal-header\">\r\n"
						+ "				<h5 class=\"modal-title\">Xem tài khoản</h5>\r\n" + "			</div>\r\n"
						+ "			<div class=\"modal-body\">\r\n"
						+ "				<form action=\"#\" method=\"post\">\r\n"
						+ "					<div class=\"form-group\">\r\n"
						+ "						<label class=\"form-label\">ID</label> <input id=\"user-id\"\r\n"
						+ "							type=\"text\" class=\"form-control\" value=\"" + user.getId()
						+ "\" readonly name=\"userId\" />\r\n" + "					</div>\r\n" + "\r\n"
						+ "					<div class=\"form-group\">\r\n"
						+ "						<label class=\"form-label\">Tên đăng nhập</label> <input\r\n"
						+ "							id=\"username\" type=\"text\" class=\"form-control\" value=\""
						+ user.getUsername() + "\"\r\n" + "							name=\"username\" readonly>\r\n"
						+ "					</div>\r\n" + "\r\n" + "					<div class=\"form-group\">\r\n"
						+ "						<label class=\"form-label\">Vai trò</label> <input id=\"user-role\"\r\n"
						+ "							type=\"text\" class=\"form-control\" value=\""
						+ (user.getRole() == 1 ? "User" : "Admin") + "\" readonly\r\n"
						+ "							name=\"userRole\" />\r\n" + "					</div>\r\n" + "\r\n"
						+ "					<div class=\"form-group\">\r\n"
						+ "						<label class=\"form-label\">Họ và tên</label> <input\r\n"
						+ "							id=\"user-fullname\" type=\"text\" class=\"form-control\" value=\""
						+ user.getFullName() + "\"\r\n" + "							name=\"userFullName\" readonly>\r\n"
						+ "\r\n" + "					</div>\r\n" + "\r\n"
						+ "					<div class=\"form-group\">\r\n"
						+ "						<label class=\"form-label\">Số điện thoại</label> <input\r\n"
						+ "							id=\"user-phone-number\" type=\"text\" class=\"form-control\" value=\""
						+ user.getPhoneNumber() + "\"\r\n"
						+ "							name=\"userPhoneNumber\" readonly>\r\n" + "\r\n"
						+ "					</div>\r\n" + "\r\n" + "					<div class=\"form-group \">\r\n"
						+ "						<label class=\"form-label\">Email</label> <input id=\"user-email\"\r\n"
						+ "							type=\"text\" class=\"form-control\" value=\"" + user.getEmail()
						+ "\" name=\"userEmail\"\r\n" + "							readonly>\r\n" + "\r\n"
						+ "					</div>\r\n" + "\r\n" + "					<div class=\"form-group\">\r\n"
						+ "						<label class=\"form-label\">Địa chỉ</label> <input id=\"user-address\"\r\n"
						+ "							type=\"text\" class=\"form-control\" value=\"" + user.getAddress()
						+ "\" name=\"userAddress\"\r\n" + "							readonly>\r\n" + "\r\n"
						+ "					</div>\r\n" + "\r\n" + "					<div class=\"form-group\">\r\n"
						+ "						<label class=\"form-label\">Trạng thái</label> <input\r\n"
						+ "							id=\"user-status\" type=\"text\" class=\"form-control\" value=\""
						+ user.getStatus() + "\"\r\n" + "							readonly name=\"userStatus\" />\r\n"
						+ "					</div>\r\n" + "				</form>\r\n" + "			</div>\r\n"
						+ "			<div class=\"modal-footer\">\r\n"
						+ "				<button type=\"button\" class=\"btn btn-secondary\" data-bs-dismiss=\"modal\">Đóng</button>\r\n"
						+ "			</div>\r\n" + "		</div>\r\n" + "	</div>\r\n" + "</div>");
			} else {
				out.println("<div class=\"modal fade\" id=\"user-modal-view\"\r\n"
						+ "		data-bs-backdrop=\"static\" data-bs-keyboard=\"false\" tabindex=\"-1\"\r\n"
						+ "		aria-hidden=\"true\">\r\n" + "		<div\r\n"
						+ "			class=\"modal-dialog modal-dialog-centered modal-dialog-scrollable\">\r\n"
						+ "			<div class=\"modal-content\">\r\n"
						+ "				<div class=\"modal-header\">\r\n"
						+ "					<h5 class=\"modal-title\">Xem tài khoản</h5>\r\n"
						+ "				</div>\r\n" + "				<div class=\"modal-body\">\r\n"
						+ "					<h6>Lỗi! Không có thông tin để hiển thị</h6>\r\n"
						+ "				</div>\r\n" + "				<div class=\"modal-footer\">\r\n"
						+ "					<button type=\"button\" class=\"btn btn-secondary\"\r\n"
						+ "						data-bs-dismiss=\"modal\">Đóng</button>\r\n"
						+ "				</div>\r\n" + "			</div>\r\n" + "		</div>\r\n" + "	</div>");
			}
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
		HttpSession session = request.getSession();
		session.setAttribute("pageActive", "admin-user");

		String action = request.getParameter("action");

		if (action == null || action.equals("home")) {
			showUser(request, response);
		} else if (action.equals("search")) {
			searchUser(request, response);
		} else if (action.equals("edit")) {
			editUser(request, response);
		} else if (action.equals("add")) {
			addUser(request, response);
		} else if (action.equals("update")) {
			request.getRequestDispatcher(response.encodeURL("/admin/user/user.jsp")).forward(request, response);
		} else if (action.equals("errorU")) {
			request.getRequestDispatcher(response.encodeURL("/admin/user/userForm.jsp")).forward(request, response);
		} else if (action.equals("cancel")) {
			session.setAttribute("userAction", "home");
			showUser(request, response);
		} else if (action.equals("view")) {
			viewUser(request, response);
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

		HttpSession session = request.getSession();
		session.setAttribute("pageActive", "admin-user");

		String action = request.getParameter("action");

		if (action.equals("save") && session.getAttribute("userAction").equals("edit")) {
			updateUser(request, response);
		} else if (action.equals("save") && session.getAttribute("userAction").equals("add")) {
			insertUser(request, response);
		} else if (action.equals("delete")) {
			deleteUser(request, response);
		} else {
			doGet(request, response);
		}
	}

}
