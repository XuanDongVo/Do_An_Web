package controller.admin.employee;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.user.UserRepository;

@WebServlet("/add_employee_action")
public class AddEmployeeAction extends HttpServlet {
	UserRepository userRepository = new UserRepository();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Lấy dữ liệu từ request
		String id_employee = req.getParameter("id_employee");
		String email_employee = req.getParameter("email_employee");
		String phone_employee = req.getParameter("phone_employee");
		String address_employee = req.getParameter("address_employee");
		String name_employee = req.getParameter("name_employee");
		String role = req.getParameter("role");

		try {
			// Chuyển đổi dữ liệu từ String sang kiểu dữ liệu phù hợp
			Long id = Long.parseLong(id_employee);
			Long roleConverted = Long.parseLong(role);

			// Gọi repository để thêm nhân viên và set quyền
			boolean isSuccess = userRepository.addUserWithRole(id, email_employee, phone_employee, address_employee,
					name_employee, roleConverted);

			// Kiểm tra kết quả và phản hồi
			if (isSuccess) {
				// Chuyển hướng hoặc trả về thông báo thành công
				 resp.sendRedirect(req.getContextPath() + "/admin_employee");
			} else {
				// Trả về thông báo lỗi nếu không thành công
				req.setAttribute("error", "Failed to add employee.");
				req.getRequestDispatcher(req.getContextPath() + "/admin_employee").forward(req, resp);
			}
		} catch (NumberFormatException e) {
			// Xử lý lỗi nếu dữ liệu đầu vào không hợp lệ
			req.setAttribute("error", "Invalid ID or role. Please try again.");
			req.getRequestDispatcher(req.getContextPath() + "/admin_employee").forward(req, resp);
		} catch (Exception e) {
			// Xử lý lỗi khác
			e.printStackTrace();
			req.setAttribute("error", "An unexpected error occurred.");
			req.getRequestDispatcher(req.getContextPath() + "/admin_employee").forward(req, resp);
		}
	}
}