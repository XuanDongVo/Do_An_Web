package controller.admin.order;

import java.io.IOException;

import dto.response.AdminOrderResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.order.OrderRepository;
@WebServlet("/update_order_action")
public class UpdateOrderAction extends HttpServlet{
	OrderRepository orderRepository = new OrderRepository();
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String orderId = req.getParameter("orderId");
		String status = req.getParameter("orderStatus");
	    if (orderId != null && !orderId.isEmpty()) {
	        try {
	            Long idConvert = Long.parseLong(orderId);
	            System.out.println(idConvert);
	            orderRepository.updateOrderById(idConvert, status);
	            resp.sendRedirect(req.getContextPath() + "/order");
	        } catch (NumberFormatException e) {
	            req.setAttribute("error", "ID đơn hàng không hợp lệ.");
	            resp.sendRedirect(req.getContextPath() + "/order");
	        }
	    } else {
	        req.setAttribute("error", "Không có ID đơn hàng để xóa.");
	        resp.sendRedirect(req.getContextPath() + "/order");
	    }
	}
}