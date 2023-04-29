package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class CategoryController
 */

public class FoundationController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FoundationController() {
		super();
		// TODO Auto-generated constructor stub
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
			String indexString = request.getParameter("index");
			if (indexString == null) {
				indexString = "1";
			}

			int index = Integer.parseInt(indexString);

			FoundationDAO foundationDAO = new FoundationDAO();

			int count = foundationDAO.countF();
			int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));
			int endPage = 0;

			endPage = count / pageSize;
			if (count % pageSize != 0) {
				endPage++;
			}

			HttpSession session = request.getSession();

			if (session.getAttribute("foundationAction") != null
					&& ((String) session.getAttribute("foundationAction")).equals("add")) {
				index = endPage;
			}

			List<Foundation> foundations = foundationDAO.search(index, pageSize);

			session.setAttribute("endPage", endPage);
			session.setAttribute("foundations", foundations);
			session.setAttribute("index", index);
			session.setAttribute("foundationAction", "home");
			session.setAttribute("foundationSName", "");
			session.setAttribute("foundationSId", "");
			session.setAttribute("foundationSEmail", "");

			request.getRequestDispatcher(response.encodeURL("/admin/foundation/foundation.jsp")).forward(request,
					response);
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void searchFoundation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String indexString = request.getParameter("index");
			String idString = request.getParameter("foundationId");
			String foundationName = request.getParameter("foundationName");
			String foundationEmail = request.getParameter("foundationEmail");

			if (indexString == null || indexString.isEmpty()) {
				indexString = "1";
			}

			if (idString == null || idString.isEmpty()) {
				idString = "-1";
			}

			int index = Integer.parseInt(indexString);
			int foundationId = Integer.parseInt(idString);

			FoundationDAO foundationDAO = new FoundationDAO();

			int count = foundationDAO.countF(foundationId, foundationName, foundationEmail);
			int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));
			int endPage = 0;

			endPage = count / pageSize;
			if (count % pageSize != 0) {
				endPage++;
			}

			List<Foundation> foundations = foundationDAO.search(foundationId, foundationName, foundationEmail, index,
					pageSize);

			HttpSession session = request.getSession();
			session.setAttribute("endPage", endPage);
			session.setAttribute("foundations", foundations);
			session.setAttribute("index", index);
			session.setAttribute("foundationAction", "search");
			session.setAttribute("foundationSName", foundationName);
			session.setAttribute("foundationSId", foundationId == -1 ? "" : foundationId);
			session.setAttribute("foundationSEmail", foundationEmail);
			request.getRequestDispatcher(response.encodeURL("/admin/foundation/foundation.jsp")).forward(request,
					response);
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void editFoundation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String foundationIdStr = request.getParameter("foundationId");
			int foundationId = Integer.parseInt(foundationIdStr);

			FoundationDAO foundationDAO = new FoundationDAO();
			Foundation foundation = foundationDAO.get(foundationId);

			HttpSession session = request.getSession();
			session.setAttribute("FSResult", "true");
			session.setAttribute("foundation", foundation);
			session.setAttribute("foundationAction", "edit");
			session.setAttribute("statusList", new String[] { "Enable", "Disable" });

			request.getRequestDispatcher(response.encodeURL("/admin/foundation/foundationForm.jsp")).forward(request,
					response);
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void updateFoundation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Foundation foundationEdit =(Foundation) session.getAttribute("foundation");

			String foundationName = request.getParameter("foundationName");
			String foundationDescription = request.getParameter("foundationDescription");
			String foundationEmail = request.getParameter("foundationEmail");
			String foundationStatus = request.getParameter("foundationStatus");

			FoundationDAO foundationDAO = new FoundationDAO();
			Foundation foundation = new Foundation(foundationEdit.getId(), foundationName, foundationDescription, foundationEmail,
					foundationStatus);

			boolean isUpdated = foundationDAO.update(foundation);

			if (isUpdated) {
				int index = (Integer) session.getAttribute("index");
				int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));

				List<Foundation> foundations = foundationDAO.search(index, pageSize);

				session.setAttribute("foundations", foundations);
				session.setAttribute("foundationAction", "home");
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/foundation?action=update"));
			} else {
				session.setAttribute("FSResult", "false");
				session.setAttribute("foundation", foundation);
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/foundation?action=errorF"));
			}

		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void addFoundation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			HttpSession session = request.getSession();
			session.setAttribute("FSResult", "true");
			session.setAttribute("foundationAction", "add");
			session.setAttribute("foundation", null);
			session.setAttribute("statusList", new String[] { "Enable", "Disable" });
			request.getRequestDispatcher(response.encodeURL("/admin/foundation/foundationForm.jsp")).forward(request,
					response);
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void insertFoundation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String foundationName = request.getParameter("foundationName");
			String foundationDescription = request.getParameter("foundationDescription");
			String foundationEmail = request.getParameter("foundationEmail");
			String foundationStatus = request.getParameter("foundationStatus");

			FoundationDAO foundationDAO = new FoundationDAO();
			Foundation foundation = new Foundation(foundationName, foundationDescription, foundationEmail,
					foundationStatus);

			Foundation insertedFoundation = foundationDAO.insert(foundation);

			HttpSession session = request.getSession();
			if (insertedFoundation != null) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/foundation"));
			} else {
				session.setAttribute("FSResult", "false");
				session.setAttribute("foundation", foundation);
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/foundation?action=errorF"));
			}
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteFoundation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String deleteFoundationStr = request.getParameter("deleteFoundations");

			FoundationDAO foundationDAO = new FoundationDAO();

			boolean isDeleted = foundationDAO.delete(deleteFoundationStr);

			HttpSession session = request.getSession();
			int index = (Integer) session.getAttribute("index") - 1;

			PrintWriter out = response.getWriter();
			out.println(isDeleted + "," + index);
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewFoundation(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String foundationIdStr = request.getParameter("foundationId");
			int foundationId = Integer.parseInt(foundationIdStr);

			FoundationDAO foundationDAO = new FoundationDAO();
			Foundation foundation = foundationDAO.get(foundationId);


			PrintWriter out = response.getWriter();
			if(foundation != null) {
				out.println("<div class=\"modal fade\" id=\"foundation-modal-view\"\r\n"
						+ "		data-bs-backdrop=\"static\" data-bs-keyboard=\"false\" tabindex=\"-1\"\r\n"
						+ "		aria-hidden=\"true\">\r\n"
						+ "		<div\r\n"
						+ "			class=\"modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable\">\r\n"
						+ "			<div class=\"modal-content\">\r\n"
						+ "				<div class=\"modal-header\">\r\n"
						+ "					<h5 class=\"modal-title\">Xem nhà tổ chức quỹ</h5>\r\n"
						+ "				</div>\r\n"
						+ "				<div class=\"modal-body\">\r\n"
						+ "					<form action=\"\" method=\"post\" novalidate>\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">ID</label> <input id=\"foundation-id\"\r\n"
						+ "								type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\"" + foundation.getId() + "\" readonly\r\n"
						+ "								name=\"foundationId\" />\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group has-validation\">\r\n"
						+ "							<label class=\"form-label\">Tên nhà tổ chức</label> <input\r\n"
						+ "								id=\"foundation-name\" type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\"" + foundation.getName() + "\" readonly\r\n"
						+ "								name=\"foundationName\">\r\n"
						+ "\r\n"
						+ "						</div>\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Mô tả</label>\r\n"
						+ "							<textarea id=\"foundation-description\" rows=\"5\"\r\n"
						+ "								class=\"form-control\" readonly name=\"foundationDescription\">" + foundation.getDescription() +  "</textarea>\r\n"
						+ "						</div>\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Email</label> <input\r\n"
						+ "								id=\"foundation-email\" type=\"text\" class=\"form-control\"\r\n"
						+ "								name=\"foundationEmail\" readonly\r\n"
						+ "								value=\"" + foundation.getEmail() + "\">\r\n"
						+ "						</div>\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Trạng thái</label><input\r\n"
						+ "								id=\"foundation-status\" type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\"" + foundation.getStatus() + "\" readonly\r\n"
						+ "								name=\"foundationStatus\" />\r\n"
						+ "						</div>\r\n"
						+ "					</form>\r\n"
						+ "				</div>\r\n"
						+ "				<div class=\"modal-footer\">\r\n"
						+ "					<button type=\"button\" class=\"btn btn-secondary\"\r\n"
						+ "						data-bs-dismiss=\"modal\">Đóng</button>\r\n"
						+ "				</div>\r\n"
						+ "			</div>\r\n"
						+ "		</div>\r\n"
						+ "	</div>\r\n"
						+ "");
			}else {
				out.println("<div class=\"modal fade\" id=\"category-modal-view\"\r\n"
						+ "		data-bs-backdrop=\"static\" data-bs-keyboard=\"false\" tabindex=\"-1\"\r\n"
						+ "		aria-hidden=\"true\">\r\n"
						+ "		<div\r\n"
						+ "			class=\"modal-dialog modal-dialog-centered modal-dialog-scrollable\">\r\n"
						+ "			<div class=\"modal-content\">\r\n"
						+ "				<div class=\"modal-header\">\r\n"
						+ "					<h5 class=\"modal-title\">Xem danh mục</h5>\r\n"
						+ "				</div>\r\n"
						+ "				<div class=\"modal-body\">\r\n"
						+ "					<h6>Lỗi! Không có thông tin để hiển thị</h6>\r\n"
						+ "				</div>\r\n"
						+ "				<div class=\"modal-footer\">\r\n"
						+ "					<button type=\"button\" class=\"btn btn-secondary\"\r\n"
						+ "						data-bs-dismiss=\"modal\">Close</button>\r\n"
						+ "				</div>\r\n"
						+ "			</div>\r\n"
						+ "		</div>\r\n"
						+ "	</div>");
			}
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
		HttpSession session = request.getSession();
		session.setAttribute("pageActive", "admin-foundation");

		String action = request.getParameter("action");

		if (action == null || action.equals("home")) {
			showFoundation(request, response);
		} else if (action.equals("search")) {
			searchFoundation(request, response);
		} else if (action.equals("edit")) {
			editFoundation(request, response);
		} else if (action.equals("add")) {
			addFoundation(request, response);
		} else if (action.equals("update")) {
			request.getRequestDispatcher(response.encodeURL("/admin/foundation/foundation.jsp")).forward(request,
					response);
		} else if (action.equals("errorF")) {
			request.getRequestDispatcher(response.encodeURL("/admin/foundation/foundationForm.jsp")).forward(request,
					response);
		} else if (action.equals("cancel")) {
			session.setAttribute("foundationAction", "home");
			showFoundation(request, response);
		} else if (action.equals("view")) {
			viewFoundation(request, response);
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
		session.setAttribute("pageActive", "admin-foundation");

		String action = request.getParameter("action");

		if (action.equals("save") && session.getAttribute("foundationAction").equals("edit")) {
			updateFoundation(request, response);
		} else if (action.equals("save") && session.getAttribute("foundationAction").equals("add")) {
			insertFoundation(request, response);
		} else if (action.equals("delete")) {
			deleteFoundation(request, response);
		} else {
			doGet(request, response);
		}

	}

}
