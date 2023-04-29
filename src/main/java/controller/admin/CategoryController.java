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

import dao.CategoryDAO;
import model.Category;

/**
 * Servlet implementation class CategoryController
 */

public class CategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CategoryController() {
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
	private void showCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String indexString = request.getParameter("index");
			if (indexString == null) {
				indexString = "1";
			}

			int index = Integer.parseInt(indexString);

			CategoryDAO categoryDAO = new CategoryDAO();

			int count = categoryDAO.countC();
			int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));
			int endPage = 0;

			endPage = count / pageSize;
			if (count % pageSize != 0) {
				endPage++;
			}

			HttpSession session = request.getSession();

			if (session.getAttribute("categoryAction") != null
					&& ((String) session.getAttribute("categoryAction")).equals("add")) {
				index = endPage;
			}

			List<Category> categories = categoryDAO.search(index, pageSize);

			session.setAttribute("endPage", endPage);
			session.setAttribute("categories", categories);
			session.setAttribute("index", index);
			session.setAttribute("categoryAction", "home");
			session.setAttribute("categorySName", "");
			session.setAttribute("categorySId", "");

			request.getRequestDispatcher(response.encodeURL("/admin/category/category.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void searchCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String indexString = request.getParameter("index");
			String idString = request.getParameter("categoryId");
			String categoryName = request.getParameter("categoryName");

			if (indexString == null || indexString.isEmpty()) {
				indexString = "1";
			}

			if (idString == null || idString.isEmpty()) {
				idString = "-1";
			}

			int index = Integer.parseInt(indexString);
			int categoryId = Integer.parseInt(idString);

			CategoryDAO categoryDAO = new CategoryDAO();

			int count = categoryDAO.countC(categoryId, categoryName);
			int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));
			int endPage = 0;

			endPage = count / pageSize;
			if (count % pageSize != 0) {
				endPage++;
			}

			List<Category> categories = categoryDAO.search(categoryId, categoryName, index, pageSize);

			HttpSession session = request.getSession();
			session.setAttribute("endPage", endPage);
			session.setAttribute("categories", categories);
			session.setAttribute("index", index);
			session.setAttribute("categoryAction", "search");
			session.setAttribute("categorySName", categoryName);
			session.setAttribute("categorySId", categoryId == -1 ? "" : categoryId);
			request.getRequestDispatcher(response.encodeURL("/admin/category/category.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void editCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String categoryIdStr = request.getParameter("categoryId");
			int categoryId = Integer.parseInt(categoryIdStr);

			CategoryDAO categoryDAO = new CategoryDAO();
			Category category = categoryDAO.get(categoryId);

			HttpSession session = request.getSession();
			session.setAttribute("CSResult", "true");
			session.setAttribute("category", category);
			session.setAttribute("categoryAction", "edit");
			session.setAttribute("statusList", new String[] { "Enable", "Disable" });

			request.getRequestDispatcher(response.encodeURL("/admin/category/categoryForm.jsp")).forward(request,
					response);
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void addCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			HttpSession session = request.getSession();
			session.setAttribute("CSResult", "true");
			session.setAttribute("categoryAction", "add");
			session.setAttribute("category", null);
			session.setAttribute("statusList", new String[] { "Enable", "Disable" });
			request.getRequestDispatcher(response.encodeURL("/admin/category/categoryForm.jsp")).forward(request,
					response);
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void updateCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			HttpSession session = request.getSession();
			Category categoryEdit = (Category) session.getAttribute("category");

			String categoryName = request.getParameter("categoryName");
			String categoryDescription = request.getParameter("categoryDescription");
			String categoryStatus = request.getParameter("categoryStatus");

			CategoryDAO categoryDAO = new CategoryDAO();
			Category category = new Category(categoryEdit.getId(), categoryName, categoryDescription, categoryStatus);

			boolean isUpdated = categoryDAO.update(category);

			if (isUpdated) {
				int index = (Integer) session.getAttribute("index");
				int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));

				List<Category> categories = categoryDAO.search(index, pageSize);

				session.setAttribute("categories", categories);
				session.setAttribute("categoryAction", "home");
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/category?action=update"));
			} else {
				session.setAttribute("CSResult", "false");
				session.setAttribute("category", category);
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/category?action=errorF"));
			}

		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void insertCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String categoryName = request.getParameter("categoryName");
			String categoryDescription = request.getParameter("categoryDescription");
			String categoryStatus = request.getParameter("categoryStatus");

			CategoryDAO categoryDAO = new CategoryDAO();
			Category category = new Category(categoryName, categoryDescription, categoryStatus);

			Category insertedCategory = categoryDAO.insert(category);

			HttpSession session = request.getSession();
			if (insertedCategory != null) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/category"));
			} else {
				session.setAttribute("CSResult", "false");
				session.setAttribute("category", category);
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/category?action=errorF"));
			}
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String deleteCategoriesStr = request.getParameter("deleteCategories");

			CategoryDAO categoryDAO = new CategoryDAO();

			boolean isDeleted = categoryDAO.delete(deleteCategoriesStr);

			HttpSession session = request.getSession();
			int index = (Integer) session.getAttribute("index") - 1;

			PrintWriter out = response.getWriter();
			out.println(isDeleted + "," + index);
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewCategory(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String categoryIdStr = request.getParameter("categoryId");
			int categoryId = Integer.parseInt(categoryIdStr);

			CategoryDAO categoryDAO = new CategoryDAO();
			Category category = categoryDAO.get(categoryId);

			PrintWriter out = response.getWriter();
			if(category != null) {
				out.println("<div class=\"modal fade\" id=\"category-modal-view\"\r\n"
						+ "		data-bs-backdrop=\"static\" data-bs-keyboard=\"false\" tabindex=\"-1\"\r\n"
						+ "		aria-hidden=\"true\">\r\n"
						+ "		<div\r\n"
						+ "			class=\"modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable\">\r\n"
						+ "			<div class=\"modal-content\">\r\n"
						+ "				<div class=\"modal-header\">\r\n"
						+ "					<h5 class=\"modal-title\">Xem danh mục</h5>\r\n"
						+ "				</div>\r\n"
						+ "				<div class=\"modal-body\">\r\n"
						+ "					<form action=\"\" method=\"post\">\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">ID</label> <input id=\"category-id\"\r\n"
						+ "								type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\"" + category.getId() + "\" readonly name=\"categoryId\" />\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group has-validation\">\r\n"
						+ "							<label class=\"form-label\">Tên danh mục</label> <input\r\n"
						+ "								id=\"category-name\" type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\"" + category.getName() + "\" readonly\r\n"
						+ "								name=\"categoryName\">\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Mô tả</label>\r\n"
						+ "							<textarea id=\"category-description\" rows=\"3\" class=\"form-control\"\r\n"
						+ "								name=\"categoryDescription\" readonly>" + category.getDescription() + "</textarea>\r\n"
						+ "						</div>\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Trạng thái</label> <input\r\n"
						+ "								id=\"category-status\" type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\""+ category.getStatus() + "\" readonly\r\n"
						+ "								name=\"categoryStatus\" />\r\n"
						+ "						</div>\r\n"
						+ "					</form>\r\n"
						+ "				</div>\r\n"
						+ "				<div class=\"modal-footer\">\r\n"
						+ "					<button type=\"button\" class=\"btn btn-secondary\"\r\n"
						+ "						data-bs-dismiss=\"modal\">Đóng</button>\r\n"
						+ "				</div>\r\n"
						+ "			</div>\r\n"
						+ "		</div>\r\n"
						+ "	</div>");
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
						+ "						data-bs-dismiss=\"modal\">Đóng</button>\r\n"
						+ "				</div>\r\n"
						+ "			</div>\r\n"
						+ "		</div>\r\n"
						+ "	</div>");
			}
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
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
		session.setAttribute("pageActive", "admin-category");

		String action = request.getParameter("action");

		if (action == null || action.equals("home")) {
			showCategory(request, response);
		} else if (action.equals("search")) {
			searchCategory(request, response);
		} else if (action.equals("edit")) {
			editCategory(request, response);
		} else if (action.equals("add")) {
			addCategory(request, response);
		} else if (action.equals("update")) {
			request.getRequestDispatcher(response.encodeURL("/admin/category/category.jsp")).forward(request, response);
		} else if (action.equals("errorF")) {
			request.getRequestDispatcher(response.encodeURL("/admin/category/categoryForm.jsp")).forward(request,
					response);
		} else if(action.equals("cancel")) {
			session.setAttribute("categoryAction", "home");
			showCategory(request, response);
		}else if(action.equals("view")) {
			viewCategory(request, response);
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
		session.setAttribute("pageActive", "admin-category");

		String action = request.getParameter("action");

		if (action.equals("save") && session.getAttribute("categoryAction").equals("edit")) {
			updateCategory(request, response);
		} else if (action.equals("save") && session.getAttribute("categoryAction").equals("add")) {
			insertCategory(request, response);
		} else if (action.equals("delete")) {
			deleteCategory(request, response);
		} else {
			doGet(request, response);
		}

	}

}
