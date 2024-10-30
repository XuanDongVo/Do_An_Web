package controller.product_cate;

import java.io.IOException;
import java.util.List;

import dto.response.ProductDetailResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.category.SubCategoryRepository;
import service.category.CategoryService;
import service.product.ProductService;

@WebServlet("/subcategory")
public class ProductBySubCategoryController extends HttpServlet {
	private ProductService productService = new ProductService();
	private SubCategoryRepository subCategoryRepository = new SubCategoryRepository();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String subCategory = req.getParameter("subCategory");
		System.out.println("subCategory" + subCategory);
		List<ProductDetailResponse> listResponses = productService.getSkusBySubCategory(subCategory, null);

		req.setAttribute("listResponses", listResponses);
		// điều hướng trang
		List<String> beadcrumb = subCategoryRepository.beadCrumb(subCategory);
		req.setAttribute("beadcrumb", beadcrumb);
		req.getRequestDispatcher("product_cate.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
