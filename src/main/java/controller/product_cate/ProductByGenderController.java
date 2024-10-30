package controller.product_cate;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dto.request.MultipleOptionsProductRequest;
import dto.response.ProductDetailResponse;
import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.category.CategoryService;
import service.product.ProductService;

@WebServlet("/gender")
public class ProductByGenderController extends HttpServlet {
	private ProductService productService = new ProductService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String gender = req.getParameter("gender");
		MultipleOptionsProductRequest mutileOption = new MultipleOptionsProductRequest();
		mutileOption.setGender(gender);
		List<ProductDetailResponse> listResponses = productService.getSkusByGender(gender, mutileOption);
		req.setAttribute("listResponses", listResponses);
		
		// điều hướng trang
		List<String> beadcrumb = new ArrayList<>();
		beadcrumb.add(gender);
		req.setAttribute("beadcrumb", beadcrumb);
		
		req.getRequestDispatcher("product_cate.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
