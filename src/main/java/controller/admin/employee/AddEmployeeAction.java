package controller.admin.employee;

import java.io.IOException;

import entity.User;
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
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Lấy dữ liệu từ request
		String email_employee = req.getParameter("email_employee");
		String phone_employee = req.getParameter("phone_employee");
		String address_employee = req.getParameter("address_employee");
		String name_employee = req.getParameter("name_employee");
		String passwword_employee = req.getParameter("password_employee");
		String role = req.getParameter("role_id");
		try {
			// Chuyển đổi dữ liệu từ String sang kiểu dữ liệu phù hợp
			Long roleConverted = Long.parseLong(role);
			if(userRepository.checkUserByPhone(phone_employee) && userRepository.checkUserByEmail(email_employee)) {
				req.setAttribute("error", "Mail hoặc phone đã bị trùng");
				req.getRequestDispatcher(req.getContextPath() + "/addEmployeeView").forward(req, resp);
				return;
			}
			// Gọi repository để thêm nhân viên và set quyền
			boolean isSuccess = userRepository.addUser(email_employee, phone_employee, address_employee, passwword_employee, 
					name_employee);

			// Kiểm tra kết quả và phản hồi
			if (isSuccess) {
				User user = userRepository.getUserByEmail(email_employee);
				boolean isSetRole = userRepository.setRoleUser(user.getId(), roleConverted);
				if(isSetRole) {
					// Chuyển hướng hoặc trả về thông báo thành công
					
					 resp.sendRedirect(req.getContextPath() + "/admin_employee");
				}
				else {
					// Trả về thông báo lỗi nếu không thành công
					System.out.println("Failed for set role user.");
					req.setAttribute("error", "Failed for set role user.");
					req.getRequestDispatcher(req.getContextPath() + "/addEmployeeView").forward(req, resp);
				}
			} else {
				// Trả về thông báo lỗi nếu không thành công
				System.out.println("Failed to add employee.");
				req.setAttribute("error", "Failed to add employee.");
				req.getRequestDispatcher(req.getContextPath() + "/addEmployeeView").forward(req, resp);
			}
		} catch (NumberFormatException e) {
			// Xử lý lỗi nếu dữ liệu đầu vào không hợp lệ
			System.out.println("Invalid ID or role. Please try again.");
			req.setAttribute("error", "Invalid ID or role. Please try again.");
			req.getRequestDispatcher(req.getContextPath() + "/addEmployeeView").forward(req, resp);
		} catch (Exception e) {
			// Xử lý lỗi khác
			System.out.println("An unexpected error occurred.");
			e.printStackTrace();
			req.setAttribute("error", "An unexpected error occurred.");
			req.getRequestDispatcher(req.getContextPath() + "/addEmployeeView").forward(req, resp);
		}
	}
}