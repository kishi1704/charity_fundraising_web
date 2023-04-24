package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;

/**
 * Servlet Filter implementation class AdminAuthorization
 */

public class AdminAuthorization extends HttpFilter implements Filter {

	/**
	 * 
	 */
	private static final long serialVersionUID = -738593004266342726L;

	/**
	 * @see HttpFilter#HttpFilter()
	 */
	public AdminAuthorization() {
		super();
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		
		if(user != null && user.getRole() == 2) {
			chain.doFilter(request, response);
		}else {
			resp.sendRedirect(resp.encodeRedirectURL(req.getContextPath() + "/home"));
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
