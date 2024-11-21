package repository.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dbConnection.DBConnection;
import entity.Product;

public class ProductRepository {
	private Connection connection = null;
	private PreparedStatement pst = null;
	private ResultSet rs = null;

	public long addProduct(Product product) {
		long productId = 0;
		connection = DBConnection.getConection();
		String sql = "INSERT INTO product (name, description, sub_category_id) VALUES (?, ?, ?)";
		try {
			// Đặt AutoCommit thành false
			connection.setAutoCommit(false);

			pst = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pst.setString(1, product.getName());
			pst.setString(2, product.getDescription());
			pst.setLong(3, product.getSubCategory().getId());
			// Thực thi câu lệnh
			int rowsAffected = pst.executeUpdate();

			if (rowsAffected > 0) {
				rs = pst.getGeneratedKeys();
				if (rs.next()) {
					productId = rs.getLong(1); // Lấy ID của đơn hàng vừa tạo
				}
			}
			if (productId == 0) {
				throw new SQLException("Không thể tạo product: Không có ID product được sinh ra.");
			}

		} catch (Exception e) {
			rollbackTransaction();
			e.printStackTrace();
		}
		return productId;
	}

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

	// Phương thức chuyển trạng thái Commit khi xử lý xong OrderDetail
	public void finalizeTransaction() {
		try {
			if (connection != null && !connection.getAutoCommit()) {
				connection.commit(); // Commit giao dịch
				connection.setAutoCommit(true); // Trả lại trạng thái AutoCommit
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
	}

	// Phương thức rollback giao dịch
	public void rollbackTransaction() {
		try {
			if (connection != null && !connection.getAutoCommit()) {
				connection.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
	}

	// Phương thức hỗ trợ đóng các tài nguyên (Connection, PreparedStatement,
	// ResultSet)
	private void closeResources() {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pst != null) {
				pst.close();
			}
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
