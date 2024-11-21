package controller;

import java.io.IOException;

import entity.User;
import entity.User_Role;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import repository.userRole.UserRoleRepository;

//@WebFilter("/view/admin/*")
public class SecurityFilterRoleLoginController implements Filter {
	private UserRoleRepository userRoleRepository = new UserRoleRepository();

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		HttpSession session = request.getSession();
		
		if (request.getRequestURI().endsWith("/admin_login.jsp")) {
	        filterChain.doFilter(request, response);
	        return;
	    }

		// Check if user is logged in
		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/view/admin/admin_login.jsp"); // Redirect to home if not logged in
			return; // Stop further processing
		}

		// Get user's role
		User_Role user_role = userRoleRepository.getUserRole(user);

		if (user_role == null || "USER".equalsIgnoreCase(user_role.getRole().getNameRole())) {
			// Redirect to "not permission" page if user is not an admin
			response.sendRedirect(request.getContextPath() + "/view/not_permission.jsp");
			return; // Stop further processing
		}

		if ("ADMIN".equalsIgnoreCase(user_role.getRole().getNameRole())) {
			// Redirect to admin page
			response.sendRedirect(request.getContextPath() + "/view/admin/admin.jsp");
			return; // Stop further processing
		}

		// If all checks pass, continue with the filter chain
		filterChain.doFilter(request, response);
	}
}
