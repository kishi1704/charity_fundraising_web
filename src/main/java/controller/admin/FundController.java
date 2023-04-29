package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CategoryDAO;
import dao.FoundationDAO;
import dao.FundDAO;
import model.Category;
import model.Foundation;
import model.Fund;

/**
 * Servlet implementation class CategoryController
 */

public class FundController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FundController() {
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
	private void showFund(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String indexString = request.getParameter("index");
			if (indexString == null) {
				indexString = "1";
			}

			int index = Integer.parseInt(indexString);

			FundDAO fundDAO = new FundDAO();
			CategoryDAO categoryDAO = new CategoryDAO();
			FoundationDAO foundationDAO = new FoundationDAO();

			int count = fundDAO.countF();
			int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));
			int endPage = 0;

			endPage = count / pageSize;
			if (count % pageSize != 0) {
				endPage++;
			}

			HttpSession session = request.getSession();

			if (session.getAttribute("fundAction") != null
					&& ((String) session.getAttribute("fundAction")).equals("add")) {
				index = endPage;
			}

			List<Fund> funds = fundDAO.search(index, pageSize);

			List<Category> categories = categoryDAO.get();
			List<Foundation> foundations = foundationDAO.get();

			session.setAttribute("categoryList", categories);
			session.setAttribute("foundationList", foundations);
			session.setAttribute("endPage", endPage);
			session.setAttribute("funds", funds);
			session.setAttribute("index", index);
			session.setAttribute("fundAction", "home");
			session.setAttribute("fundSId", "");
			session.setAttribute("fundSName", "");
			session.setAttribute("fundSFoundation", "");
			session.setAttribute("fundSCategory", "");

			request.getRequestDispatcher(response.encodeURL("/admin/fund/fund.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(FundController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void searchFund(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String indexString = request.getParameter("index");
			String idString = request.getParameter("fundId");
			String fundName = request.getParameter("fundName");
			String foundation = request.getParameter("foundation");
			String category = request.getParameter("category");

			if (indexString == null || indexString.isEmpty()) {
				indexString = "1";
			}

			if (idString == null || idString.isEmpty()) {
				idString = "-1";
			}

			int index = Integer.parseInt(indexString);
			int fundId = Integer.parseInt(idString);

			FundDAO fundDAO = new FundDAO();

			int count = fundDAO.countF(fundId, fundName, foundation, category);
			int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));
			int endPage = 0;

			endPage = count / pageSize;
			if (count % pageSize != 0) {
				endPage++;
			}

			List<Fund> funds = fundDAO.search(fundId, fundName, foundation, category, index, pageSize);

			HttpSession session = request.getSession();
			session.setAttribute("endPage", endPage);
			session.setAttribute("funds", funds);
			session.setAttribute("index", index);
			session.setAttribute("fundAction", "search");
			session.setAttribute("fundSName", fundName);
			session.setAttribute("fundSId", fundId == -1 ? "" : fundId);
			session.setAttribute("fundSFoundation", foundation);
			session.setAttribute("fundSCategory", category);
			request.getRequestDispatcher(response.encodeURL("/admin/fund/fund.jsp")).forward(request, response);
		} catch (Exception e) {
			Logger.getLogger(FundController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void editFund(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String fundIdStr = request.getParameter("fundId");
			int fundId = Integer.parseInt(fundIdStr);

			FundDAO fundDAO = new FundDAO();
			Fund fund = fundDAO.get(fundId);

			HttpSession session = request.getSession();
			session.setAttribute("FuSResult", "true");
			session.setAttribute("fund", fund);
			session.setAttribute("fundAction", "edit");
			session.setAttribute("statusList", new String[] { "Enable", "Disable" });

			request.getRequestDispatcher(response.encodeURL("/admin/fund/fundForm.jsp")).forward(request, response);
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
	private void updateFund(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			HttpSession session = request.getSession();
			Fund fundEdit = (Fund) session.getAttribute("fund");

			String fundName = request.getParameter("fundName");
			String fundDescription = request.getParameter("fundDescription");
			String fundContent = request.getParameter("fundContent");
			String fundImage_url = request.getParameter("fundImage_url");

			String fundEAmountStr = request.getParameter("fundEAmount");
			int fundEAmount = Integer.parseInt(fundEAmountStr);

			String createdDateStr = request.getParameter("fundCDate");
			Date createdDate = Date.valueOf(createdDateStr);

			String endDateStr = request.getParameter("fundEDate");
			Date endDate = Date.valueOf(endDateStr);

			String categoryIdStr = request.getParameter("fundCategory");
			int categoryId = Integer.parseInt(categoryIdStr);

			String foundationIdStr = request.getParameter("fundFoundation");
			int foundationId = Integer.parseInt(foundationIdStr);

			String fundStatus = request.getParameter("fundStatus");

			FundDAO fundDAO = new FundDAO();
			Fund fund = new Fund(fundEdit.getId(), fundName, fundDescription, fundContent, fundImage_url, fundEAmount,
					createdDate, endDate, new Category(categoryId, null), new Foundation(foundationId, null), fundStatus);

			boolean isUpdated = fundDAO.update(fund);

			if (isUpdated) {
				int index = (Integer) session.getAttribute("index");
				int pageSize = Integer.parseInt(getServletConfig().getInitParameter("pageSize"));

				List<Fund> funds = fundDAO.search(index, pageSize);

				session.setAttribute("funds", funds);
				session.setAttribute("fundAction", "home");
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/fund?action=update"));
			} else {
				session.setAttribute("FuSResult", "false");
				session.setAttribute("fund", fund);
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/fund?action=errorF"));
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
	private void addFund(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			HttpSession session = request.getSession();
			session.setAttribute("FuSResult", "true");
			session.setAttribute("fundAction", "add");
			session.setAttribute("fund", null);
			session.setAttribute("statusList", new String[] { "Enable", "Disable" });
			request.getRequestDispatcher(response.encodeURL("/admin/fund/fundForm.jsp")).forward(request, response);
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
	private void insertFund(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {


			String fundName = request.getParameter("fundName");
			String fundDescription = request.getParameter("fundDescription");
			String fundContent = request.getParameter("fundContent");
			String fundImage_url = request.getParameter("fundImage_url");

			String fundEAmountStr = request.getParameter("fundEAmount");
			int fundEAmount =  Integer.parseInt(fundEAmountStr);

			String createdDateStr = request.getParameter("fundCDate");
			Date createdDate = Date.valueOf(createdDateStr);

			String endDateStr = request.getParameter("fundEDate");
			Date endDate = Date.valueOf(endDateStr);

			String categoryIdStr = request.getParameter("fundCategory");
			int categoryId = Integer.parseInt(categoryIdStr);

			String foundationIdStr = request.getParameter("fundFoundation");
			int foundationId = Integer.parseInt(foundationIdStr);

			String fundStatus = request.getParameter("fundStatus");

			FundDAO fundDAO = new FundDAO();
			Fund fund = new Fund(fundName, fundDescription, fundContent, fundImage_url, fundEAmount,
					createdDate, endDate, new Category(categoryId, null), new Foundation(foundationId, null), fundStatus);
			
			Fund insertedFund = fundDAO.insert(fund);

			HttpSession session = request.getSession();
			if (insertedFund != null) {
				response.sendRedirect(response.encodeRedirectURL(request.getContextPath() + "/admin/fund"));
			} else {
				session.setAttribute("FuSResult", "false");
				session.setAttribute("fund", fund);
				response.sendRedirect(
						response.encodeRedirectURL(request.getContextPath() + "/admin/fund?action=errorF"));
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
	private void deleteFund(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String deleteFundStr = request.getParameter("deleteFunds");

			FundDAO fundDAO = new FundDAO();

			boolean isDeleted = fundDAO.delete(deleteFundStr);

			HttpSession session = request.getSession();
			int index = (Integer) session.getAttribute("index") - 1;

			PrintWriter out = response.getWriter();
			out.println(isDeleted + "," + index);
		} catch (Exception e) {
			Logger.getLogger(FundController.class.getName()).log(Level.SEVERE, null, e);
		}
	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewFund(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			String fundIdStr = request.getParameter("fundId");
			int fundId = Integer.parseInt(fundIdStr);

			FundDAO fundDAO = new FundDAO();
			Fund fund = fundDAO.get(fundId);

			// Create a new Locale
			Locale vn = new Locale("vi", "VN");
			// Create a formatter given the Locale
			NumberFormat vndFormat = NumberFormat.getCurrencyInstance(vn);
			DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
			
			PrintWriter out = response.getWriter();
			if(fund != null) {
				out.println("<div class=\"modal fade\" id=\"fund-modal-view\" data-bs-backdrop=\"static\"\r\n"
						+ "		data-bs-keyboard=\"false\" tabindex=\"-1\" aria-hidden=\"true\">\r\n"
						+ "		<div\r\n"
						+ "			class=\"modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable\">\r\n"
						+ "			<div class=\"modal-content\">\r\n"
						+ "				<div class=\"modal-header\">\r\n"
						+ "					<h5 class=\"modal-title\">Xem quỹ quyên góp</h5>\r\n"
						+ "				</div>\r\n"
						+ "				<div class=\"modal-body\">\r\n"
						+ "					<form action=\"\" method=\"post\">\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">ID</label> <input id=\"fund-id\"\r\n"
						+ "								type=\"text\" class=\"form-control\" value=\"" + fund.getId() + "\"\r\n"
						+ "								readonly name=\"fundId\" />\r\n"
						+ "						</div>\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Tên quỹ từ thiện</label> <input\r\n"
						+ "								id=\"fund-name\" type=\"text\" class=\"form-control\"\r\n"
						+ "								value=\"" + fund.getName() + "\" readonly name=\"fundName\">\r\n"
						+ "\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Mô tả</label>\r\n"
						+ "							<textarea id=\"fund-description\" rows=\"5\" class=\"form-control\"\r\n"
						+ "								readonly name=\"fundDescription\">" + fund.getDescription() + "</textarea>\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Nội dung</label>\r\n"
						+ "							<textarea rows=\"50\" id=\"fund-content\" readonly name=\"fundContent\"\r\n"
						+ "								class=\"ckeditor form-control\">" + fund.getContent()+ "</textarea>\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Đường dẫn hình ảnh</label> <input\r\n"
						+ "								id=\"fund-image-url\" type=\"text\" class=\"form-control\"\r\n"
						+ "								name=\"fundImage_url\" readonly\r\n"
						+ "								value=\"" + fund.getImage_url() + "\">\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group input-expected-result\">\r\n"
						+ "							<label class=\"form-label\">Số tiền dự định</label> <input\r\n"
						+ "								id=\"fund-expected-result\" type=\"text\" class=\"form-control\"\r\n"
						+ "								name=\"fundEAmount\" readonly\r\n"
						+ "								value=\"" + vndFormat.format(fund.getExpectedAmount()) + "\">\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Ngày bắt đầu</label> <input\r\n"
						+ "								id=\"fund-created-date\" type=\"text\" class=\"form-control\"\r\n"
						+ "								name=\"fundCDate\" readonly\r\n"
						+ "								value=\"" + df.format(fund.getCreatedDate()) + "\">\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Ngày kết thúc</label> <input\r\n"
						+ "								id=\"fund-end-date\" type=\"text\" class=\"form-control \"\r\n"
						+ "								name=\"fundEDate\" readonly value=\"" + df.format(fund.getEndDate()) + "\">\r\n"
						+ "						</div>\r\n"
						+ "\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Danh mục</label> <input\r\n"
						+ "								id=\"fund-category\" type=\"text\" class=\"form-control\"\r\n"
						+ "								name=\"fundCategory\" readonly\r\n"
						+ "								value=\"" + fund.getCategory().getName() + "\">\r\n"
						+ "						</div>\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Nhà tổ chức</label> <input\r\n"
						+ "								id=\"fund-foundation\" type=\"text\" class=\"form-control\"\r\n"
						+ "								name=\"fundFoundation\" readonly\r\n"
						+ "								value=\"" + fund.getFoundation().getName() + "\">\r\n"
						+ "						</div>\r\n"
						+ "						<div class=\"form-group\">\r\n"
						+ "							<label class=\"form-label\">Trạng thái</label> <input\r\n"
						+ "								id=\"fund-status\" type=\"text\" class=\"form-control\"\r\n"
						+ "								name=\"fundStatus\" readonly\r\n"
						+ "								value=\"" + fund.getStatus() + "\">\r\n"
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
			Logger.getLogger(FundController.class.getName()).log(Level.SEVERE, null, e);
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
		session.setAttribute("pageActive", "admin-fund");

		String action = request.getParameter("action");

		if (action == null || action.equals("home")) {
			showFund(request, response);
		} else if (action.equals("search")) {
			searchFund(request, response);
		} else if (action.equals("edit")) {
			editFund(request, response);
		} else if (action.equals("add")) {
			addFund(request, response);
		} else if (action.equals("update")) {
			request.getRequestDispatcher(response.encodeURL("/admin/fund/fund.jsp")).forward(request, response);
		} else if (action.equals("errorF")) {
			request.getRequestDispatcher(response.encodeURL("/admin/fund/fundForm.jsp")).forward(request, response);
		} else if (action.equals("cancel")) {
			session.setAttribute("fundAction", "home");
			showFund(request, response);
		}else if (action.equals("view")) {
			viewFund(request, response);
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
		session.setAttribute("pageActive", "admin-fund");

		String action = request.getParameter("action");

		if (action.equals("save") && session.getAttribute("fundAction").equals("edit")) {
			updateFund(request, response);
		} else if (action.equals("save") && session.getAttribute("fundAction").equals("add")) {
			insertFund(request, response);
		} else if (action.equals("delete")) {
			deleteFund(request, response);
		} else {
			doGet(request, response);
		}

	}

}
