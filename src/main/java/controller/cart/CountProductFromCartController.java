package controller.cart;

import java.io.IOException;
import java.util.List;

import dto.response.DetailCartResponse;
import entity.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.cartdetail.CartDetailService;

@WebFilter("/*")
public class CountProductFromCartController implements Filter {
	 private CartDetailService cartDetailService;

	    @Override
	    public void init(FilterConfig filterConfig) throws ServletException {
	        cartDetailService = new CartDetailService(); 
	    }


	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		HttpSession session = httpRequest.getSession();
		User user = (User) session.getAttribute("user");

		Integer quantityProduct = cartDetailService.getQuantityProductFromCart(user, httpRequest);
		
		List<DetailCartResponse> cartResponse = cartDetailService.getDetailsInCart(user, httpRequest);
		
		 httpRequest.setAttribute("quantityProduct", quantityProduct);
		 httpRequest.setAttribute("listCartDetail", cartResponse);
			chain.doFilter(httpRequest, httpResponse);
	
		
	}

}
