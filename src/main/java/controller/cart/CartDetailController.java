package controller.cart;

import java.io.IOException;

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
		long productColorImageId = Long.parseLong(req.getParameter("id"));
		String size = req.getParameter("size");
		int quantity = Integer.parseInt(req.getParameter("quantity"));

		AddProductInCartRequest addProductInCartRequest = new AddProductInCartRequest(productColorImageId, size,
				quantity);
		cartDetailService.addProductToCartDetail(addProductInCartRequest, resp, req, user);

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
