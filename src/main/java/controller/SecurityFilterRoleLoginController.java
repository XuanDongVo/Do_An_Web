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

@WebFilter(urlPatterns = { "/view/admin/*", "/adminProduct", "/adminAddProduct", "/adminDeleteProduct",
		"/adminDetailProduct","/adminUpdateProductColorImg","/adminUpdateProduct", "/adminController", "/admin_customer", "/delete_customer", "/add_employee_action",
		"/addEmployeeView", "/admin_employee", "/delete_employee", "/add_inventory", "/add_inventory_view",
		"/delete_inventory","/inventory","/update_inventory","/delete_order","/order","/update_order_action","/update_order"})
public class SecurityFilterRoleLoginController implements Filter {
	private UserRoleRepository userRoleRepository = new UserRoleRepository();

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		HttpSession session = request.getSession();

		String requestURI = request.getRequestURI();

		// Bỏ qua kiểm tra nếu đang ở trang login
		if (requestURI.endsWith("/admin_login.jsp")) {
			filterChain.doFilter(request, response);
			return;
		}

		// Kiểm tra xem user đã login chưa
		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/view/admin/admin_login.jsp");
			return;
		}

		// Kiểm tra quyền hạn
		User_Role user_role = (User_Role) session.getAttribute("user_role");
		if (user_role == null) {
			user_role = userRoleRepository.getUserRole(user);
			if (user_role != null) {
				session.setAttribute("role", user_role.getRole().getNameRole());
			}
		}

		// Nếu user không phải admin
		if (user_role == null || "USER".equalsIgnoreCase(user_role.getRole().getNameRole())) {
			response.sendRedirect(request.getContextPath() + "/view/not_permission.jsp");
			return;
		}

		// Nếu user là admin và đang truy cập đúng trang, tiếp tục xử lý
		filterChain.doFilter(request, response);
	}
}
