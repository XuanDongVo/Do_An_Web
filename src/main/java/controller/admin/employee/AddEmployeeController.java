package controller.admin.employee;


import java.io.IOException;
import java.util.List;

import entity.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.user.UserRepository;
@WebServlet("/addEmployeeView")
public class AddEmployeeController extends HttpServlet{
	UserRepository userRepository = new UserRepository();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Role> list_role = userRepository.getListRole();
		req.setAttribute("list_role", list_role);
		req.getRequestDispatcher("view/admin/admin_add_employee.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}