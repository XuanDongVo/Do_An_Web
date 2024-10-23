package service.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.management.RuntimeErrorException;

import dto.request.MultipleOptionsProductRequest;
import dto.response.ProductDetailResponse;
import entity.Category;
import entity.Inventory;
import entity.Product;
import entity.ProductSku;
import entity.SubCategory;
import repository.category.CategoryRepository;
import repository.category.SubCategoryRepository;
import repository.inventory.InventoryRepository;
import repository.product.ProductRepository;
import repository.product.ProductSkuRepository;
import utils.MultipleOptionsSQLQueryBuilder;

public class ProductService {

	private ProductSkuRepository productSkuRepository = new ProductSkuRepository();
	private InventoryRepository inventoryRepository = new InventoryRepository();
	private ProductRepository productRepository = new ProductRepository();
	private SubCategoryRepository subCategoryRepository = new SubCategoryRepository();
	private CategoryRepository categoryRepository = new CategoryRepository();

	// Find Product Sku by id
	public ProductDetailResponse getSkusById(Long id) {
		List<ProductSku> productSkus = productSkuRepository.findByProductId(id);
		if (productSkus.isEmpty()) {
			throw new RuntimeException("Product not found by id " + id);
		}

		Map<Long, ProductDetailResponse> productResponseMap = new HashMap<>();
		populateProductDetails(productResponseMap, productSkus);

		return productResponseMap.values().stream().findFirst().orElse(null);
	}

	// Find Product Sku by sub_category_id
	public List<ProductDetailResponse> getSkusBySubCategory(Long subCategoryId, MultipleOptionsProductRequest options) {
		List<Product> products = new ArrayList<>();

		// Lấy thực thể sub-category dựa trên ID
		SubCategory subCategory = subCategoryRepository.findById(subCategoryId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy danh mục con với ID " + subCategoryId));

		// lọc với options
		if (options != null) {
			// set options
			String gender = subCategory.getCategory().getGender().getName();
			options.setGender(gender);
			options.setSubCategory(subCategory.getName());
			products = MultipleOptionsSQLQueryBuilder.findByMultipleOptions(options);
		} else {
			// Lấy danh sách sản phẩm theo danh mục con
			products = productRepository.findBySubCategory(subCategoryId);
		}

		// Lấy danh sách ID của sản phẩm từ trang kết quả
		List<Long> productIds = products.stream().map(Product::getId).toList();

		// Lấy danh sách ProductSku theo danh sách ID sản phẩm
		List<ProductSku> productSkuList = new ArrayList<>();
		productIds.forEach(productId -> {
			List<ProductSku> productskus = productSkuRepository.findByProductId(productId);
			productSkuList.addAll(productskus);
		});
		List<ProductDetailResponse> responses = createProductDetailResponses(productSkuList);
		return responses;
	}

	// Find Product Sku by category_name
	public List<ProductDetailResponse> getSkusByCategory(String categoryName, MultipleOptionsProductRequest options) {
		List<Product> products = new ArrayList<>();

		Category category = categoryRepository.findByName(categoryName)
				.orElseThrow(() -> new RuntimeException("Category not found"));

		// lọc với options
		if (options != null) {
			// set options
			options.setCategory(category.getName());
			options.setGender(category.getGender().getName());

			products = MultipleOptionsSQLQueryBuilder.findByMultipleOptions(options);
		} else {
			products = productRepository.findByCategory(category.getId());
		}

		// Lấy danh sách ID của sản phẩm từ trang kết quả
		List<Long> productIds = products.stream().map(Product::getId).toList();

		// Lấy danh sách ProductSku theo danh sách ID sản phẩm
		List<ProductSku> productSkuList = new ArrayList<>();
		productIds.forEach(productId -> {
			List<ProductSku> productskus = productSkuRepository.findByProductId(productId);
			productSkuList.addAll(productskus);
		});

		List<ProductDetailResponse> responses = createProductDetailResponses(productSkuList);
		return responses;

	}

	// Find PRODUCT SKU by gender
	public List<ProductDetailResponse> getSkusByGender(String gender, MultipleOptionsProductRequest options) {
		List<Product> products = new ArrayList<>();
		// lọc với options
		if (options != null) {
			options.setGender(gender);
			// Áp dụng lọc bằng Specification nếu có yêu cầu lọc
			products = MultipleOptionsSQLQueryBuilder.findByMultipleOptions(options);
		} else {
			products = productRepository.findByGender(gender);
		}
		// Lấy danh sách ID của sản phẩm từ trang kết quả
		List<Long> productIds = products.stream().map(Product::getId).toList();

		// Lấy danh sách ProductSku theo danh sách ID sản phẩm
		List<ProductSku> productSkuList = new ArrayList<>();
		productIds.forEach(productId -> {
			List<ProductSku> productskus = productSkuRepository.findByProductId(productId);
			productSkuList.addAll(productskus);
		});

		List<ProductDetailResponse> responses = createProductDetailResponses(productSkuList);
		return responses;

	}

	// Find PRODUCT SKU by searching
	public List<ProductDetailResponse> getSkusBySearching(String search, MultipleOptionsProductRequest options) {
		List<Product> products = new ArrayList<>();
		// lọc với options
		if (options != null) {
			// Áp dụng lọc bằng Specification nếu có yêu cầu lọc
			products = MultipleOptionsSQLQueryBuilder.findByMultipleOptions(options);
		} else {
			products = productRepository.findBySearching(search);
		}
		// Lấy danh sách ID của sản phẩm từ trang kết quả
		List<Long> productIds = products.stream().map(Product::getId).toList();

		// Lấy danh sách ProductSku theo danh sách ID sản phẩm
		List<ProductSku> productSkuList = new ArrayList<>();
		productIds.forEach(productId -> {
			List<ProductSku> productskus = productSkuRepository.findByProductId(productId);
			productSkuList.addAll(productskus);
		});

		List<ProductDetailResponse> responses = createProductDetailResponses(productSkuList);
		return responses;

	}

	// Get random PRODUCT SKU
	public List<ProductDetailResponse> getRandomProductSku(int numberOfRandom) {
		List<Product> products = productRepository.getRandomProduct(numberOfRandom);
		if(products.isEmpty()) {
			throw new RuntimeException( "Can not get random product");
		}
		
		List<Long> productIds = products.stream().map(Product::getId).toList();

		// Lấy danh sách ProductSku theo danh sách ID sản phẩm
		List<ProductSku> productSkuList = new ArrayList<>();
		productIds.forEach(productId -> {
			List<ProductSku> productskus = productSkuRepository.findByProductId(productId);
			productSkuList.addAll(productskus);
		});

		List<ProductDetailResponse> responses = createProductDetailResponses(productSkuList);
		return responses;
		
	}

	// Lấy chi tiết sản phẩm từ ProductSku và ánh xạ vào ProductDetailResponse
	private List<ProductDetailResponse> createProductDetailResponses(List<ProductSku> productSkus) {
		// Tạo bản đồ để ánh xạ chi tiết sản phẩm
		Map<Long, ProductDetailResponse> productResponseMap = new HashMap<>();
		populateProductDetails(productResponseMap, productSkus);

		// Trả về danh sách chi tiết sản phẩm
		return new ArrayList<>(productResponseMap.values());
	}

	// Điền chi tiết sản phẩm
	private void populateProductDetails(Map<Long, ProductDetailResponse> productResponseMap,
			List<ProductSku> productSkus) {
		for (ProductSku productSku : productSkus) {
			Long productId = productSku.getProductColorImage().getProduct().getId();
			ProductDetailResponse productResponse = productResponseMap.getOrDefault(productId,
					new ProductDetailResponse());

			if (productResponse.getId() == null) {
				productResponse.setId(productId);
				productResponse.setName(productSku.getProductColorImage().getProduct().getName());
				productResponse
						.setSubCategory(productSku.getProductColorImage().getProduct().getSubCategory().getName());
				productResponse.setPrice(productSku.getPrice());
				productResponse.setTypeProduct(productSku.getSize().getSizeType().getName());
				productResponse.setProductSkus(new ArrayList<>());
				productResponseMap.put(productId, productResponse);
			}

			processSku(productSku, productResponse);
		}
	}

	private void processSku(ProductSku productSku, ProductDetailResponse productResponse) {
		// Tìm kiếm ProductSkuResponse hiện tại dựa trên màu sắc và hình ảnh
		Optional<ProductDetailResponse.ProductSkuResponse> existingSku = productResponse.getProductSkus().stream()
				.filter(sku -> sku.getColor().equals(productSku.getProductColorImage().getColor().getName())
						&& sku.getImg().equals(productSku.getProductColorImage().getImage()))
				.findFirst();

		// Lấy số lượng tồn kho từ InventoryRepository
		Inventory inventory = inventoryRepository.findByProductSku(productSku.getId())
				.orElseThrow(() -> new RuntimeException("Not found inventory by id " + productSku.getId()));
		Integer stock = inventory.getStock();

		if (existingSku.isPresent()) {
			// Thêm hoặc cập nhật size và stock trong entry SKU hiện tại
			String size = productSku.getSize().getName();
			Integer currentStock = existingSku.get().getSizeAndStock().getOrDefault(size, 0);
			existingSku.get().getSizeAndStock().put(size, currentStock + stock);
		} else {
			// Tạo mới một SKU response nếu không tìm thấy màu sắc tương ứng
			ProductDetailResponse.ProductSkuResponse skuResponse = new ProductDetailResponse.ProductSkuResponse();
			skuResponse.setProductColorImgId(productSku.getProductColorImage().getId());
			skuResponse.setColor(productSku.getProductColorImage().getColor().getName());
			skuResponse.setImg(productSku.getProductColorImage().getImage());

			// Khởi tạo map sizeAndStock với size hiện tại và số lượng tồn kho
			Map<String, Integer> sizeAndStock = new HashMap<>();
			sizeAndStock.put(productSku.getSize().getName(), stock);
			skuResponse.setSizeAndStock(sizeAndStock);

			// Thêm SKU mới vào danh sách SKUs của product
			productResponse.getProductSkus().add(skuResponse);
		}
	}
	
	public static void main(String[] args) {
		new ProductService().getRandomProductSku(1);
	}

}
