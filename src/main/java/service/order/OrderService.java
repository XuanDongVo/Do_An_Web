package service.order;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import dto.request.OrderRequest;
import dto.response.DetailCartResponse;
import entity.Inventory;
import entity.OrderDetail;
import entity.ProductSku;
import entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import repository.inventory.InventoryRepository;
import repository.order.OrderDetailRepository;
import repository.order.OrderRepository;
import repository.product.ProductSkuRepository;
import service.cartdetail.CartDetailService;

public class OrderService {
	private OrderRepository orderRepository = new OrderRepository();
	private CartDetailService cartDetailService = new CartDetailService();
	private ProductSkuRepository productSkuRepository = new ProductSkuRepository();
	private InventoryRepository inventoryRepository = new InventoryRepository();
	private OrderDetailRepository orderDetailRepository = new OrderDetailRepository();

	public void processOrderItems(User user, OrderRequest orderRequest, HttpServletRequest request,
			HttpServletResponse response) {
		try {
			// Tạo đơn hàng
			Long orderId = orderRepository.createOrder(orderRequest, user);
			if (orderId == 0) {
				throw new RuntimeException("Cannot create order");
			}

			if (user == null) {
				createOrderDetailForAnonymous(orderId, orderRequest, request, response);
			}

			// Hoàn tất giao dịch
			orderRepository.finalizeTransaction();
		} catch (Exception e) {
			e.printStackTrace();
			orderRepository.rollbackTransaction();
			throw new RuntimeException("Error processing order items", e);
		}
	}

	private void createOrderDetailForAnonymous(Long orderId, OrderRequest orderRequest, HttpServletRequest request,
			HttpServletResponse response) {
		// Lấy giỏ hàng từ cookie hiện tại (nếu có)
		List<DetailCartResponse> detailCarts = new ArrayList<>();

		String cartCookieValue = cartDetailService.getCookieValue(request, "cart");

		// Nếu đã có cookie giỏ hàng, chuyển đổi chuỗi JSON từ cookie thành danh sách
		// CartDetail
		if (cartCookieValue != null && !cartCookieValue.isEmpty()) {
			detailCarts = cartDetailService.decodeCartDetailsFromCookie(cartCookieValue);
		}

		String[] ids = orderRequest.getIds();
		List<String> idsList = Arrays.asList(ids);

		List<DetailCartResponse> filteredDetailCarts = detailCarts.stream()
				.filter(cart -> idsList.stream().anyMatch(id -> cart.getCartId().equals(Long.valueOf(id)))).toList();

		// tạo order Detail cho khach hang
		filteredDetailCarts.forEach(cartDetail -> {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrderId(orderId);

			ProductSku productSku = productSkuRepository.findById(cartDetail.getCartId());

			orderDetail.setProductSkuId(productSku.getId());
			orderDetail.setPrice(productSku.getPrice());
			orderDetail.setQuantity(cartDetail.getQuantity());

			// cập nhật hàng tồn kho trong kho hàng
			Inventory invetory = inventoryRepository.findByProductSkuId(productSku.getId()).get();
			invetory.setStock(invetory.getStock() - cartDetail.getQuantity());
			orderDetailRepository.save(orderDetail);
			inventoryRepository.updateQuantityByInvetoryid(invetory.getId(), invetory.getStock());
		});

		detailCarts.removeAll(filteredDetailCarts);
		cartDetailService.updateCartCookie(response, detailCarts);

	}

}
