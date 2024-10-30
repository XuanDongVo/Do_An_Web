package controller.product_cate;

import java.io.IOException;
import java.util.List;

import dto.response.ProductDetailResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.category.CategoryService;
import service.product.ProductService;

@WebServlet("/category")
public class ProductByCategoryController extends HttpServlet {
	private ProductService productService = new ProductService();
	private CategoryService categoryService = new CategoryService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String category = req.getParameter("category");
		List<ProductDetailResponse> listResponses = productService.getSkusByCategory(category, null);

		req.setAttribute("listResponses", listResponses);

		// điều hướng trang
		List<String> beadcrumb = categoryService.beadCrumb(category);
		req.setAttribute("beadcrumb", beadcrumb);

		req.getRequestDispatcher("product_cate.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
