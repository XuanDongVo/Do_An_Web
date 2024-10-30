package repository.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dbConnection.DBConnection;
import entity.Product;

public class ProductRepository {
	private Connection connection = null;
	private PreparedStatement pst = null;

	public List<Product> getRandomProduct(int randomOfProduct) {
		connection = DBConnection.getConection();
		List<Product> products = new ArrayList<>();
		String sql = "SELECT * FROM product WHERE id > FLOOR(RAND() * (SELECT MAX(id) FROM product)) LIMIT  ?";
		try {
			pst = connection.prepareStatement(sql);
			pst.setInt(1, randomOfProduct);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Product product = new Product(rs.getLong(1), rs.getString(2), rs.getString(3), null);
				products.add(product);
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
		return products;
	}

	// Find product by sub_cateogry ID
	public List<Product> findBySubCategory(String subCategory) {
		connection = DBConnection.getConection();
		List<Product> products = new ArrayList<>();
		String sql = "";
		try {
			sql = "SELECT product.*" + "FROM ecommerce.product " + "INNER JOIN sub_category AS sc "
					+ "ON sc.id = product.sub_category_id " + "WHERE sc.name = ?";
			pst = connection.prepareStatement(sql);
			pst.setString(1, subCategory);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Product product = new Product(rs.getLong(1), rs.getString(2), rs.getString(3), null);
				products.add(product);
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
		return products;
	}

	// Find product by Cateogry ID
	public List<Product> findByCategory(Long id) {
		connection = DBConnection.getConection();
		List<Product> products = new ArrayList<>();
		String sql = "";
		try {
			sql = "SELECT product.*" + "FROM ecommerce.product " + "INNER JOIN sub_category AS sc "
					+ "ON sc.id = product.sub_category_id " + "INNER JOIN category AS c " + "ON c.id = sc.category_id "
					+ "WHERE c.id = ?";
			pst = connection.prepareStatement(sql);
			pst.setLong(1, id);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Product product = new Product(rs.getLong(1), rs.getString(2), rs.getString(3), null);
				products.add(product);
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
		return products;
	}

	// Find product by GENDER NAME
	public List<Product> findByGender(String gender) {
		connection = DBConnection.getConection();
		List<Product> products = new ArrayList<>();
		String sql = "";
		try {
			sql = "	SELECT p.* FROM ecommerce.product as p "
					+ "	INNER JOIN sub_category AS sc ON sc.id = p.sub_category_id "
					+ "	INNER JOIN category AS c ON c.id = sc.category_id "
					+ "	INNER JOIN gender ON gender.id = c.gender_id " + "	WHERE gender.name = ? ";
			pst = connection.prepareStatement(sql);
			pst.setString(1, gender);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Product product = new Product(rs.getLong(1), rs.getString(2), rs.getString(3), null);
				products.add(product);
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
		return products;
	}

	public List<Product> findBySearching(String search) {
		connection = DBConnection.getConection();
		List<Product> products = new ArrayList<>();
		StringBuilder builder = appendPercentage(search);
		String sql = "";
		try {
			sql = "SELECT * FROM ecommerce.product where  name like " + builder.toString();
			pst = connection.prepareStatement(sql);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Product product = new Product(rs.getLong(1), rs.getString(2), rs.getString(3), null);
				products.add(product);
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
				if (connection != null) {
					try {
						connection.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		return products;
	}

	private StringBuilder appendPercentage(String search) {
		String[] words = search.split("\\s+"); // Tách chuỗi theo khoảng trắng
		StringBuilder result = new StringBuilder();

		for (String word : words) {
			result.append("'%").append(word).append("%' "); // Thêm % ở trước và sau từng từ
		}

		return result;
	}


}
