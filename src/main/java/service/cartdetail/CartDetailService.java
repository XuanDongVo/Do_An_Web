package service.cartdetail;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import dto.request.AddProductInCartRequest;
import dto.request.ModifyProductRequest;
import dto.response.DetailCartResponse;
import entity.Cart;
import entity.CartDetail;
import entity.Product;
import entity.ProductColorImage;
import entity.ProductSku;
import entity.User;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.cart.CartDetailRepository;
import repository.cart.CartRepository;
import repository.product.ProductSkuRepository;

public class CartDetailService {
	private CartRepository cartRepository = new CartRepository();
	private CartDetailRepository cartDetailRepository = new CartDetailRepository();
	private ProductSkuRepository productSkuRepository = new ProductSkuRepository();

	// xóa sản phẩm trong cookies nếu sản phẩm không còn trong cơ sở dữ liệu
	public List<DetailCartResponse> removeNonExistentProducts(User user, HttpServletRequest request,
			HttpServletResponse servletResponse) {
		List<DetailCartResponse> list = getDetailsInCart(user, request);

		if (user != null) {
			return list;
		}

		for (DetailCartResponse detailCartResponse : list) {
			ProductSku productSku = productSkuRepository.findById(detailCartResponse.getCartId());
			// san pham da bi xoa trong database
			if (productSku == null) {
				removeProductForAnonymous(detailCartResponse.getCartId(), request, servletResponse);
			}
		}
		return getDetailsInCart(user, request);

	}

	// lấy ra những sản phẩm mà khách hàng chọn để checkout
	public List<DetailCartResponse> getSelectProductsForCheckout(User user, String[] selectedCartIds,
			HttpServletRequest request) {
		if (user == null) {
			// lấy ra những sản phẩm đã chọn trong cookie
			return getSelectProductsFromCookiesForCheckout(selectedCartIds, request);
		}
		return cartDetailRepository.getSelectProductsForCheckout(selectedCartIds);

	}

	// lấy ra số lượng sản phẩm trong giỏ hàng
	public int getQuantityProductFromCart(User user, HttpServletRequest request) {
		// người dùng chưa đăng nhập
		if (user == null) {
			return getQuantityProductFromCartForAnonymous(request);
		}
		// người dùng đã dăng nhập
		Cart cart = getUserCart(user);
		return cartDetailRepository.getQuantityProductFromCart(cart);

	}

	// lấy ra số lượng sản phẩm trong giỏ hàng của người dùng chưa đăng nhập
	private int getQuantityProductFromCartForAnonymous(HttpServletRequest request) {
		int quantity = 0;
		List<DetailCartResponse> detailCartResponses = getCartDetailsFromCookie(request);
		if (detailCartResponses == null) {
			return quantity;
		}
		for (DetailCartResponse detailCartResponse : detailCartResponses) {
			quantity += detailCartResponse.getQuantity();
		}
		return quantity;
	}

	// lấy danh sách sản phẩm trong giỏ hàng của người dùng
	public List<DetailCartResponse> getDetailsInCart(User user, HttpServletRequest request) {
		// Tìm giỏ hàng của người dùng hiện tại
		Cart cart = getUserCart(user);

		// Nếu giỏ hàng không tồn tại, tìm trong cookie
		if (cart == null) {
			return getCartDetailsFromCookie(request);
		}

		// Lấy chi tiết giỏ hàng từ database
		return getCartDetailsFromDatabase(cart);
	}

	// cập nhật giỏ hàng tạm giờ vào giỏ hàng chính khi người dùng đăng nhập
	public void mergeCartAfterLogin(HttpServletRequest servletRequest, User user, HttpServletResponse servletResponse) {
		List<DetailCartResponse> cartResponses = getCartDetailsFromCookie(servletRequest);
		// kiểm tra có sản phẩm trong cookies không
		if (cartResponses == null) {
			return;
		}
		// Lấy ra giỏ hàng người dùng
		Cart cart = getUserCart(user);

		cartResponses.forEach((detail) -> {
			CartDetail cartDetail = cartDetailRepository.findByProductSkuAndCart(detail.getCartId(), cart.getId());
			// kiểm tra sản phẩm đó tồn tại trong giỏ hàng chưa
			if (cartDetail == null) {
				cartDetailRepository.addProductSkuInCartDetail(detail.getCartId(), cart, detail.getQuantity());
			} else {
				// cập nhật lại số lượng trong giỏ hàng
				cartDetail.setQuantity(detail.getQuantity() + cartDetail.getQuantity());
				cartDetailRepository.updateQuantityInCartDetail(cartDetail);
			}
		});
		Cookie[] cookies = servletRequest.getCookies();

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("cart".equals(cookie.getName())) {
					cookie.setMaxAge(0); // Xóa cookie ngay lập tức
					cookie.setPath("/"); // Đảm bảo cookie bị xóa ở tất cả các đường dẫn
					servletResponse.addCookie(cookie); // Cập nhật cookie trong response
				}
			}
		}
	}

	// thêm sản phẩm vào trong giỏ hàng
	public void addProductToCartDetail(AddProductInCartRequest productRequest, HttpServletResponse response,
			HttpServletRequest request, User user) {

		ProductSku productSku = productSkuRepository
				.findByProductColorImgAndSize(productRequest.getId(), productRequest.getSize())
				.orElseThrow(() -> new RuntimeException("not found"));

		// Tìm giỏ hàng của người dùng hiện tại
		Cart cart = getUserCart(user);
		if (cart == null) {
			addCartDetailForAnonymous(productSku, productRequest, request, response);
			return;
		}

		CartDetail cartDetail = cartDetailRepository.findByProductSkuAndCart(productSku.getId(), cart.getId());
		// kiểm tra sản phẩm đã tồn tại trong giỏ hàng chưa
		if (cartDetail == null) {
			// thêm sản phẩm vào giỏ hàng
			cartDetailRepository.addProductSkuInCartDetail(productSku.getId(), cart, productRequest.getQuantity());
			return;
		}
		// Cập nhật số lượng sản phẩm trong CartDetail
		int updatedQuantity = cartDetail.getQuantity() + productRequest.getQuantity();
		cartDetail.setQuantity(updatedQuantity);

		cartDetailRepository.updateQuantityInCartDetail(cartDetail);
	}

	// chỉnh sửa số lượng sản phẩm trong giỏ hàng
	public void modifyProductInCartDetail(ModifyProductRequest modifyProductRequest, HttpServletRequest request,
			HttpServletResponse response, User user) {
		Cart cart = getUserCart(user);
		// xử lí người dùng ẩn danh
		if (cart == null) {
			modifyProductForAnonymous(modifyProductRequest, request, response);
			return;
		}
		CartDetail cartDetail = cartDetailRepository.findById(modifyProductRequest.getId())
				.orElseThrow(() -> new RuntimeException("Cart Detail not found by id " + modifyProductRequest.getId()));
		cartDetail.setQuantity(modifyProductRequest.getQuantity());
		cartDetailRepository.updateQuantityInCartDetail(cartDetail);
	}

	// xóa sản phẩm trong giỏ hàng
	public void removeProductInCartDetail(Long cartDetailId, User user, HttpServletRequest request,
			HttpServletResponse response) {
		Cart cart = getUserCart(user);
		// xử lí người dùng ẩn danh
		if (cart == null) {
			removeProductForAnonymous(cartDetailId, request, response);
			return;
		}
		cartDetailRepository.deleteProductSkuInCartDetail(cartDetailId);
	}

	// chỉnh sửa số lượng sản phẩm trong giỏ hàng cho người ẩn danh
	private void modifyProductForAnonymous(ModifyProductRequest modifyProductRequest, HttpServletRequest request,
			HttpServletResponse response) {
		List<DetailCartResponse> detailCarts;

		String cartCookieValue = getCookieValue(request, "cart");

		// Nếu đã có cookie giỏ hàng, chuyển đổi chuỗi JSON từ cookie thành danh sách
		// CartDetail
		detailCarts = decodeCartDetailsFromCookie(cartCookieValue);

		// lọc lấy sản phẩm cần modify
		Optional<DetailCartResponse> existingDetailCart = detailCarts.stream()
				.filter(cd -> cd.getCartId().equals(modifyProductRequest.getId())).findFirst();

		if (existingDetailCart.isPresent()) {
			// Nếu tìm thấy sản phẩm, cập nhật số lượng
			existingDetailCart.get().setQuantity(modifyProductRequest.getQuantity());
		} else {
			throw new RuntimeException("Product not found in cart for modification.");
		}

		// cập nhật dữ liệu trong cookie
		updateCartCookie(response, detailCarts);
	}

	// xóa sản phẩm trong giỏ hàng tạm thời
	public void removeProductForAnonymous(Long productSkuId, HttpServletRequest request, HttpServletResponse response) {
		List<DetailCartResponse> detailCarts;

		String cartCookieValue = getCookieValue(request, "cart");

		// Nếu đã có cookie giỏ hàng, chuyển đổi chuỗi JSON từ cookie thành danh sách
		// CartDetail
		detailCarts = decodeCartDetailsFromCookie(cartCookieValue);

		// lọc lấy sản phẩm cần modify
		Optional<DetailCartResponse> existingDetailCart = detailCarts.stream()
				.filter(cd -> cd.getCartId().equals(productSkuId)).findFirst();

		if (existingDetailCart.isPresent()) {
			// xóa sản phẩm
			detailCarts.remove(existingDetailCart.get());
		}

		// cập nhật dữ liệu trong cookie
		updateCartCookie(response, detailCarts);
	}

	// thêm sản phẩm vào trong giỏ hàng đối với người ẩn danh
	private void addCartDetailForAnonymous(ProductSku productSku, AddProductInCartRequest productRequest,
			HttpServletRequest request, HttpServletResponse response) {
		// Lấy giỏ hàng từ cookie hiện tại (nếu có)
		List<DetailCartResponse> detailCarts = new ArrayList<>();

		String cartCookieValue = getCookieValue(request, "cart");

		// Nếu đã có cookie giỏ hàng, chuyển đổi chuỗi JSON từ cookie thành danh sách
		// CartDetail
		if (cartCookieValue != null && !cartCookieValue.isEmpty()) {
			detailCarts = decodeCartDetailsFromCookie(cartCookieValue);
		}
		Optional<DetailCartResponse> existingCartDetail = detailCarts.stream()
				.filter(cd -> cd.getCartId().equals(productSku.getId())).findFirst();

		if (existingCartDetail.isPresent()) {
			// Nếu sản phẩm đã tồn tại trong giỏ hàng, cập nhật số lượng
			DetailCartResponse detailCartResponse = existingCartDetail.get();
			int updatedQuantity = detailCartResponse.getQuantity() + productRequest.getQuantity();
			detailCartResponse.setQuantity(updatedQuantity);
		} else {
			ProductColorImage productColorImg = productSku.getProductColorImage();
			Product product = productColorImg.getProduct();

			// Nếu sản phẩm chưa có trong giỏ hàng, tạo CartDetail mới
			DetailCartResponse detailCart = new DetailCartResponse(productSku.getId(), product.getName(),
					productColorImg.getImage(), productColorImg.getColor().getName(), productSku.getSize().getName(),
					productRequest.getQuantity(), productSku.getPrice());
			detailCarts.add(detailCart);
		}

		updateCartCookie(response, detailCarts);

	}

	// giải mã
	public List<DetailCartResponse> decodeCartDetailsFromCookie(String cartCookieValue) {
		Gson gson = new Gson();
		List<DetailCartResponse> detailCarts = new ArrayList<>();

		try {
			// Giải mã chuỗi JSON từ cookie (Base64)
			byte[] decodedBytes = Base64.getDecoder().decode(cartCookieValue);
			String decodedCartJson = new String(decodedBytes, StandardCharsets.UTF_8);

			// Chuyển đổi chuỗi JSON thành danh sách DetailCartResponse sử dụng Gson
			detailCarts = gson.fromJson(decodedCartJson, new TypeToken<List<DetailCartResponse>>() {
			}.getType());

		} catch (Exception e) {
			throw new RuntimeException("Error parsing cart details from cookie", e);
		}

		return detailCarts;
	}

	// Phương thức cập nhật giỏ hàng trong cookie
	public void updateCartCookie(HttpServletResponse response, List<DetailCartResponse> detailCarts) {
		Gson gson = new Gson();
		try {
			// Chuyển danh sách CartDetail thành chuỗi JSON
			String cartDetailsJson = gson.toJson(detailCarts);
			// Mã hóa chuỗi JSON thành Base64
			String encodedCartDetails = Base64.getEncoder()
					.encodeToString(cartDetailsJson.getBytes(StandardCharsets.UTF_8));

			// Tạo cookie với thời gian sống là 1 tuần (7 ngày)
			Cookie cartCookie = new Cookie("cart", encodedCartDetails);
			cartCookie.setHttpOnly(true); // Ngăn chặn truy cập từ Javascript
			cartCookie.setSecure(true); // Chỉ gửi cookie qua HTTPS
			cartCookie.setPath("/"); // Đặt đường dẫn mà cookie có hiệu lực
			cartCookie.setMaxAge(7 * 24 * 60 * 60); // Thời gian sống là 7 ngày

			// Thêm cookie vào response
			response.addCookie(cartCookie);

		} catch (Exception e) {
			throw new RuntimeException("Error converting CartDetail list to JSON", e);
		}
	}

	// Phương thức lấy ra giỏ hàng người dùng
	private Cart getUserCart(User user) {
		// Người dùng chưa đăng nhập
		if (user == null) {
			return null;
		}
		String phone = user.getPhone();
		String email = user.getEmail();
		// lấy ra cart
		Cart cart = cartRepository.getUserCartByPhoneOrEmail(phone,email)
				.orElseThrow(() -> new RuntimeException("Not found cart for user"));
		return cart;
	}

	// Phương thức lấy giỏ hàng từ trong Database
	private List<DetailCartResponse> getCartDetailsFromDatabase(Cart cart) {
		List<DetailCartResponse> detailCartResponses = cartDetailRepository.getDetailCartByCartId(cart.getId());
		return detailCartResponses;
	}

	// Phương thức để lấy chi tiết giỏ hàng từ cookie trong servlet
	private List<DetailCartResponse> getCartDetailsFromCookie(HttpServletRequest request) {
		// Tạo danh sách để chứa chi tiết giỏ hàng
		List<DetailCartResponse> detailCartResponses = new ArrayList<>();

		// Lấy giá trị cookie giỏ hàng theo tên "cart"
		String cartCookieValue = getCookieValue(request, "cart");

		if (cartCookieValue != null) {
			Gson gson = new Gson();
			try {
				// Giải mã chuỗi Base64 từ cookie
				byte[] decodedBytes = Base64.getDecoder().decode(cartCookieValue);
				String decodedCartJson = new String(decodedBytes, StandardCharsets.UTF_8);

				// Chuyển đổi JSON thành List<DetailCartResponse> sử dụng Gson
				List<DetailCartResponse> cartDetails = gson.fromJson(decodedCartJson,
						new TypeToken<List<DetailCartResponse>>() {
						}.getType());
				// Thêm các chi tiết giỏ hàng từ cookie vào danh sách
				detailCartResponses.addAll(cartDetails);
			} catch (Exception e) {
				// Xử lý lỗi nếu không thể giải mã hoặc parse JSON
				throw new RuntimeException("Error parsing cart details from cookies", e);
			}
		}

		return detailCartResponses;
	}

	private List<DetailCartResponse> getSelectProductsFromCookiesForCheckout(String[] selectedCartIds,
			HttpServletRequest request) {
		List<DetailCartResponse> detailCarts = new ArrayList<>();
		List<DetailCartResponse> selectProducts = new ArrayList<>();

		// Lấy giá trị của cookie "cart"
		String cartCookieValue = getCookieValue(request, "cart");

		// Nếu có cookie và không rỗng, giải mã cookie thành danh sách sản phẩm
		if (cartCookieValue != null && !cartCookieValue.isEmpty()) {
			detailCarts = decodeCartDetailsFromCookie(cartCookieValue);
		}

		// Lọc và thêm các sản phẩm cần checkout vào danh sách
		for (String id : selectedCartIds) {
			// Tìm sản phẩm từ danh sách đã có từ cookie
			Optional<DetailCartResponse> existingDetailCart = detailCarts.stream()
					.filter(cd -> cd.getCartId().equals(Long.parseLong(id))).findFirst();

			// Nếu tìm thấy sản phẩm, thêm vào danh sách
			existingDetailCart.ifPresent(selectProducts::add);
		}

		return selectProducts;
	}

	// Phương thức lấy giá trị từ cookie
	public String getCookieValue(HttpServletRequest request, String name) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(name)) {
					return cookie.getValue();
				}
			}
		}
		return null;
	}

}
