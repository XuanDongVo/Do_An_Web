package repository.order;

import java.sql.Connection;
import java.sql.PreparedStatement;

import dbConnection.DBConnection;
import entity.OrderDetail;

public class OrderDetailRepository {
	private PreparedStatement pst = null;

	// lưu giá trị orderdetail vào database
	public void save(Connection connection, OrderDetail orderDetail) {
		try {
			String sql = "INSERT INTO order_detail (order_id,product_sku_id, price, quantity) VALUES (?,?, ?, ?)";
			pst = connection.prepareStatement(sql);
			pst.setLong(1, orderDetail.getOrderId());
			pst.setLong(2, orderDetail.getProductSkuId());
			pst.setDouble(3, orderDetail.getPrice());
			pst.setInt(4, orderDetail.getQuantity());

			pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void removeByProductSkuId(Connection connection, Long ProductSkuId) {
		try {
			String sql = "DELETE FROM order_detail WHERE product_sku_id = ?";
			pst = connection.prepareStatement(sql);
			pst.setLong(1, ProductSkuId);
			pst.executeUpdate();
		} catch (Exception e) {
		}
	}
}
