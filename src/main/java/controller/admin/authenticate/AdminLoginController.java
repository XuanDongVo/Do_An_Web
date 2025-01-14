package controller.admin.authenticate;

import java.io.IOException;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.user.UserRepository;

@WebServlet("/adminLogin")
public class AdminLoginController extends HttpServlet {
	private UserRepository userRepository = new UserRepository();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String phone = req.getParameter("phone");
		String password = req.getParameter("password");

		User user = userRepository.loginForAdmin(phone, password);

		// Tai khoan khong ton tai
		if (user == null) {
			String error = "Tài khoản không tồn tại";
			req.setAttribute("message", error);
			req.getRequestDispatcher( "/view/admin/admin_login.jsp").forward(req, resp);
		}

		req.getSession().setAttribute("user", user);

		// Forward đến trang admin
		resp.sendRedirect(req.getContextPath() + "/adminController");
	}

}
