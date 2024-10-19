package repository.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import dbConnection.DBConnection;
import entity.Color;
import entity.Product;
import entity.ProductColorImage;
import entity.ProductSku;
import entity.Size;
import entity.SubCategory;

public class ProductSkuRepository {
	private Connection connection = null;
	private PreparedStatement pst = null;

	// Find product SKUs by product ID
	public List<ProductSku> findByProductId(Long id) {
		connection = DBConnection.getConection();
		String sql = "";

		List<ProductSku> list = new ArrayList<>();
		try {
			sql = "SELECT pu.id, pu.price, pci.image , pci.id, c.name as color_name,p.id as product_id ,p.name as product_name, "
					+ "sc.name as subcategory_name, s.name as size_name " + "FROM product_sku pu "
					+ "INNER JOIN product_color_img pci ON pu.product_color_img_id = pci.id "
					+ "INNER JOIN product p ON pci.product_id = p.id " + "INNER JOIN color c ON c.id = pci.color_id "
					+ "INNER JOIN sub_category sc ON sc.id = p.sub_category_id "
					+ "INNER JOIN size s ON s.id = pu.size_id " + "WHERE p.id = ?";

			pst = connection.prepareStatement(sql);
			pst.setLong(1, id);
			ResultSet resultSet = pst.executeQuery();

			while (resultSet.next()) { // Correct traversal of result set
				ProductSku productSku = new ProductSku();

				// Set ProductSku fields
				productSku.setId(resultSet.getLong("pu.id"));
				productSku.setPrice(resultSet.getDouble("pu.price"));

				// Set ProductColorImage with product and color information
				ProductColorImage productColorImage = new ProductColorImage();
				productColorImage.setId(resultSet.getLong("pci.id"));
				productColorImage.setImage(resultSet.getString("pci.image"));

				// Create Product and SubCategory objects
				Product product = new Product();
				product.setId(resultSet.getLong("product_id"));
				product.setName(resultSet.getString("product_name"));
				SubCategory subCategory = new SubCategory();
				subCategory.setName(resultSet.getString("subcategory_name"));
				product.setSubCategory(subCategory);
				productColorImage.setProduct(product);

				// Create Color object
				Color color = new Color();
				color.setName(resultSet.getString("color_name"));
				productColorImage.setColor(color);

				// Set productColorImage to productSku
				productSku.setProductColorImage(productColorImage);

				// Set Size object
				Size size = new Size();
				size.setName(resultSet.getString("size_name"));
				productSku.setSize(size);

				// Add productSku to the list
				list.add(productSku);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pst != null) {
				try {
					pst.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (connection != null) {
				try {
					connection.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return list;
	}

	public Optional<ProductSku> findByProductColorImgAndSize(Long productColorImgId, String size) {
		connection = DBConnection.getConection();
		try {
			String sql = "SELECT sku.id , p.name , pci.image, color.name as color, size.name as size, sku.price FROM product_sku AS sku\r\n"
					+ "	INNER JOIN product_color_img AS pci ON pci.id = sku.product_color_img_id\r\n"
					+ " INNER JOIN color ON color.id  = pci.color_id\r\n"
					+ " INNER JOIN product AS p ON p.id = pci.product_id\r\n"
					+ "	INNER JOIN size ON size.id = sku.size_id where size.name = ?  AND pci.id = ? ";
			pst = connection.prepareStatement(sql);
			pst.setString(1, size);
			pst.setLong(2, productColorImgId);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				ProductSku productSku = new ProductSku(rs.getLong(1), null, null, (rs.getDouble(6)));
				ProductColorImage productColorImage = new ProductColorImage();
				productColorImage.setImage(rs.getString("image"));
				
				Color color = new Color();
				color.setName(rs.getString("color"));
				productColorImage.setColor(color);
				
				Size currentSize = new Size();
				currentSize.setName(rs.getString("size"));
				productSku.setProductColorImage(productColorImage);
				productSku.setSize(currentSize);
				
				Product product = new Product();
				product.setName(rs.getString("name"));
				productColorImage.setProduct(product);
				
				return Optional.of(productSku);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pst != null) {
				try {
					pst.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (connection != null) {
				try {
					connection.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	
	public static void main(String[] args) {
		new ProductSkuRepository().findByProductColorImgAndSize(1L, "S");
	}

}
