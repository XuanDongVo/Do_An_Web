package controller.cart;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

import dto.request.AddProductInCartRequest;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.cartdetail.CartDetailService;

@WebServlet("/cartdetail")
public class CartDetailController extends HttpServlet {
	private CartDetailService cartDetailService = new CartDetailService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	private void addProductInCartDetail(HttpServletRequest req, HttpServletResponse resp, User user) {
	    // Lấy id của sản phẩm từ tham số yêu cầu, chuyển đổi nó thành kiểu long
	    long productColorImageId = Long.parseLong(req.getParameter("id"));
	    
	    // Lấy kích thước của sản phẩm từ tham số yêu cầu
	    String size = req.getParameter("size");
	    
	    // Lấy số lượng sản phẩm từ tham số yêu cầu và chuyển đổi nó thành kiểu int
	    int quantity = Integer.parseInt(req.getParameter("quantity"));
	    
	    // Lấy URL hiện tại (đã được mã hóa) từ tham số yêu cầu
	    String encodedUrl = req.getParameter("redirectUrl");
	    
	    try {
	        // Giải mã URL đã được mã hóa để có thể sử dụng
	        String decodeUrl = URLDecoder.decode(encodedUrl, StandardCharsets.UTF_8.name());
	    } catch (UnsupportedEncodingException e) {
	        // Xử lý ngoại lệ nếu không thể giải mã URL
	        e.printStackTrace();
	    }
	    
	    // Tạo đối tượng yêu cầu thêm sản phẩm vào giỏ hàng với các tham số đã lấy
	    AddProductInCartRequest addProductInCartRequest = new AddProductInCartRequest(productColorImageId, size, quantity);
	    
	    // Gọi dịch vụ để thêm sản phẩm vào chi tiết giỏ hàng
	    cartDetailService.addProductToCartDetail(addProductInCartRequest, resp, req, user);
	    
	    try {
	        // Chuyển hướng đến URL đã được giải mã sau khi thêm sản phẩm vào giỏ hàng
	        resp.sendRedirect(encodedUrl);
	    } catch (IOException e) {
	        // Xử lý ngoại lệ nếu không thể chuyển hướng
	        e.printStackTrace();
	    }
	}


	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		String action = req.getParameter("action");
		switch (action) {
		case "add": {
			addProductInCartDetail(req, resp, user);
			break;
		}
		default:
			throw new IllegalArgumentException("Unexpected value: " + action);
		}
	}
}
