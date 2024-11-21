package controller.admin.product;

import java.io.IOException;

import dto.response.ProductDetailResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.product.ProductService;

@WebServlet("/adminProduct")
public class AdminProductDetailController extends HttpServlet {
	private ProductService productService = new ProductService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		Long id = Long.parseLong(req.getParameter("id"));

		if (action.equalsIgnoreCase("view")) {
			ProductDetailResponse detailResponse = productService.getSkusById(id);
			req.setAttribute("productResponse", detailResponse);
			req.getRequestDispatcher("/view/admin/admin_product_detail.jsp").forward(req, resp);
			return;
		} else if (action.equalsIgnoreCase("edit")) {

		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
