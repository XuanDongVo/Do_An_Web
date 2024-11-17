package repository.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dbConnection.DBConnection;
import dto.request.OrderRequest;
import entity.User;
import utils.OrderStatus;

public class OrderRepository {
	private Connection connection = null;
	private PreparedStatement pst = null;
	private ResultSet rs = null;

	// Phương thức tạo đơn hàng mới
	public long createOrder(OrderRequest orderRequest, User user) {
		long orderId = 0;
		try {
			// Mở kết nối cơ sở dữ liệu
			connection = DBConnection.getConection();
			connection.setAutoCommit(false); // Tắt chế độ tự động commit để quản lý giao dịch

			// Câu lệnh SQL để chèn dữ liệu vào bảng `order`
			String sql = "INSERT INTO `order` (user_id, order_status, total_price, create_at, customer_email, customer_name, customer_phone, customer_address) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			pst = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

			// Kiểm tra nếu người dùng tồn tại, sử dụng ID người dùng; nếu không, đặt giá
			// trị NULL cho user_id
			if (user != null && user.getId() != null) {
				pst.setLong(1, user.getId()); // Đặt ID người dùng
			} else {
				pst.setNull(1, java.sql.Types.NULL); // Đặt NULL nếu không có người dùng
			}

			// Đặt các thông tin khác của đơn hàng
			pst.setString(2, OrderStatus.PENDING.toString());
			pst.setDouble(3, orderRequest.getTotalPrice());
			pst.setDate(4, java.sql.Date.valueOf(java.time.LocalDate.now()));
			pst.setString(5, orderRequest.getCustomerEmail());
			pst.setString(6, orderRequest.getCustomerName());
			pst.setString(7, orderRequest.getCustomerPhone());
			pst.setString(8, orderRequest.getAddress());

			int rowsAffected = pst.executeUpdate();
			if (rowsAffected > 0) {
				rs = pst.getGeneratedKeys();
				if (rs.next()) {
					orderId = rs.getLong(1); // Lấy ID của đơn hàng vừa tạo
				}
			}

			// Nếu không tạo được đơn hàng, ném ra ngoại lệ SQLException
			if (orderId == 0) {
				throw new SQLException("Không thể tạo đơn hàng: Không có ID đơn hàng được sinh ra.");
			}

		} catch (SQLException e) {
			// Nếu có lỗi, rollback giao dịch
			try {
				if (connection != null) {
					connection.rollback();
				}
			} catch (SQLException rollbackEx) {
				rollbackEx.printStackTrace(); // Log lỗi khi rollback giao dịch
			}

			e.printStackTrace(); // Log lỗi gốc
		} finally {
			// Đảm bảo đóng tất cả các tài nguyên để tránh rò rỉ tài nguyên
			closeResources();
		}

		return orderId; // Trả về ID của đơn hàng vừa tạo
	}

	// Phương thức commit giao dịch (nếu cần sử dụng trong các phương thức khác)
	public void commitTransaction() throws SQLException {
		if (connection != null && !connection.getAutoCommit()) {
			connection.commit(); // Commit giao dịch nếu không sử dụng tự động commit
		}
	}

	// Phương thức rollback giao dịch (nếu cần sử dụng trong các phương thức khác)
	public void rollbackTransaction() throws SQLException {
		if (connection != null && !connection.getAutoCommit()) {
			connection.rollback(); // Rollback giao dịch nếu có lỗi
		}
	}

	// Phương thức hỗ trợ đóng các tài nguyên (Connection, PreparedStatement,
	// ResultSet)
	private void closeResources() {
		try {
			if (rs != null) {
				rs.close(); // Đóng ResultSet
			}
			if (pst != null) {
				pst.close(); // Đóng PreparedStatement
			}
			if (connection != null) {
				connection.close(); // Đóng Connection
			}
		} catch (SQLException e) {
			e.printStackTrace(); // Log lỗi khi đóng tài nguyên
		}
	}
}
