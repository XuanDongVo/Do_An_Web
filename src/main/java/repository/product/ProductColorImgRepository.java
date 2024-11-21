package repository.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import dbConnection.DBConnection;
import entity.ProductColorImage;

public class ProductColorImgRepository {
	private Connection connection = null;
	private PreparedStatement pst = null;
	private ResultSet rs = null;

	public long addProductColorImg(ProductColorImage productColorImage) {
		long productColorImg = 0;
		connection = DBConnection.getConection();
		String sql = "INSERT INTO product_color_img (product_id, color_id, image) VALUES (?, ?, ?)";
		try {
			// Đặt AutoCommit thành false
			connection.setAutoCommit(false);

			pst = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pst.setLong(1, productColorImage.getProduct().getId());
			pst.setLong(2, productColorImage.getColor().getId());
			pst.setString(3, productColorImage.getImage());
			// Thực thi câu lệnh
			int rowsAffected = pst.executeUpdate();

			if (rowsAffected > 0) {
				rs = pst.getGeneratedKeys();
				if (rs.next()) {
					productColorImg = rs.getLong(1); // Lấy ID của đơn hàng vừa tạo
				}
			}
			if (productColorImg == 0) {
				throw new SQLException("Không thể tạo productColorImg: Không có ID productColorImg được sinh ra.");
			}

		} catch (Exception e) {
			rollbackTransaction();
			e.printStackTrace();
		}
		return productColorImg;

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
