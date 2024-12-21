package controller.admin.customer;

import java.io.IOException;
import java.util.List;

import dto.response.AdminUserResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.user.UserRepository;

@WebServlet("/admin_customer")
public class AdminCustomerController extends HttpServlet{
	UserRepository userRespository = new UserRepository();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<AdminUserResponse> lst = userRespository.getAllCustomer();
		req.setAttribute("list_customer", lst);
		req.getRequestDispatcher("view/admin/admin_customer.jsp").forward(req, resp);
	}
	
}