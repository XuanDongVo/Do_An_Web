package controller.admin.employee;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.user.UserRepository;
@WebServlet("/delete_employee")
public class DeleteEmpoyeeAction extends HttpServlet{
	UserRepository userRespository = new UserRepository();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userIdParam = req.getParameter("user_id"); // Lấy giá trị từ request
		if (userIdParam != null && !userIdParam.isEmpty()) {
	        try {
	            Long idConvert = Long.parseLong(userIdParam);

	            // Xóa đơn hàng
	            boolean isDeleted = userRespository.deleteUser(idConvert);

	            if (isDeleted) {
	                // Chuyển hướng về trang danh sách khách hàng
	                resp.sendRedirect(req.getContextPath() + "/admin_employee");
	            } else {
	                req.setAttribute("error", "Không thể xóa user. Vui lòng thử lại.");
	                resp.sendRedirect(req.getContextPath() + "/admin_employee");
	            }
	        } catch (NumberFormatException e) {
	            req.setAttribute("error", "ID user không hợp lệ.");
	            resp.sendRedirect(req.getContextPath() + "/admin_employee");
	        }
	    } else {
	        req.setAttribute("error", "Không có ID user để xóa.");
	        resp.sendRedirect(req.getContextPath() + "/admin_employee");
	    }
	}
}