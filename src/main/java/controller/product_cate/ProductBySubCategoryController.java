package controller.product_cate;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.google.gson.Gson;

import dto.request.MultipleOptionsProductRequest;
import dto.response.ProductDetailResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.category.SubCategoryRepository;
import service.color.ColorService;
import service.product.ProductService;

@WebServlet("/subcategory")
public class ProductBySubCategoryController extends HttpServlet {
    private ProductService productService = new ProductService();
    private SubCategoryRepository subCategoryRepository = new SubCategoryRepository();
    private ColorService colorService = new ColorService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String subCategory = req.getParameter("subCategory");
        String sizeParam = req.getParameter("size");
        String colorParam = req.getParameter("color");

        // Chuyển các tham số thành mảng nếu chúng không rỗng, bỏ qua nếu null hoặc rỗng
        List<String> sizes = (sizeParam != null && !sizeParam.isEmpty()) ? Arrays.asList(sizeParam.split(",")) : null;
        List<String> colors = (colorParam != null && !colorParam.isEmpty()) ? Arrays.asList(colorParam.split(",")) : null;

        // Kiểm tra xem đây có phải là yêu cầu AJAX hay không
        boolean isAjax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));

        if (sizes == null && colors == null) {
            // Không có bộ lọc, trả về JSP
            List<ProductDetailResponse> listResponses = productService.getSkusBySubCategory(subCategory, null);
            req.setAttribute("listResponses", listResponses);

            // Thiết lập breadcrumb
            List<String> beadcrumb = subCategoryRepository.beadCrumb(subCategory);
            req.setAttribute("beadcrumb", beadcrumb);

            // Chỉ chuyển tiếp đến JSP nếu không phải là yêu cầu AJAX
            if (!isAjax) {
                req.getRequestDispatcher("product_cate.jsp").forward(req, resp);
            } else {
                // Nếu là yêu cầu AJAX, trả về JSON cho các yêu cầu không có bộ lọc
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                Gson gson = new Gson();
                String jsonResponse = gson.toJson(listResponses);
                resp.getWriter().write(jsonResponse);
            }
        } else {
            // Có bộ lọc, trả về JSON
            MultipleOptionsProductRequest mutileOption = new MultipleOptionsProductRequest();
            mutileOption.setSubCategory(subCategory);
            mutileOption.setColors(colors);
            mutileOption.setSizes(sizes);

            List<ProductDetailResponse> listResponses = productService.getSkusBySubCategory(subCategory, mutileOption);

            // Thiết lập kiểu dữ liệu trả về là JSON
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");

            Gson gson = new Gson();
            // Chuyển đối tượng thành JSON và ghi vào phản hồi
            String jsonResponse = gson.toJson(listResponses);
            resp.getWriter().write(jsonResponse);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}