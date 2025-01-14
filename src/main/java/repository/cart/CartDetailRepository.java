package repository.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import dbConnection.DBConnection;
import dto.response.DetailCartResponse;
import entity.Cart;
import entity.CartDetail;
import entity.ProductSku;

public class CartDetailRepository {
	private Connection connection = null;
	private PreparedStatement pst = null;

	public void removeByProductSkuId(Connection connection, Long productskuId) {
		try {
			String sql = "DELETE FROM cart_detail WHERE product_sku_id = ?";
			pst = connection.prepareStatement(sql);
			pst.setLong(1, productskuId);
			pst.executeUpdate();
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

		}
	}

	// lấy ra những sản phẩm mà khách hàng chọn để checkout
	public List<DetailCartResponse> getSelectProductsForCheckout(String[] selectedCartIds) {
		connection = DBConnection.getConection();
		List<DetailCartResponse> responses = new ArrayList<>();
		try {
			// Xây dựng chuỗi placeholder
			String placeholders = String.join(", ", Collections.nCopies(selectedCartIds.length, "?"));

			// Sử dụng câu truy vấn với IN
			String sql = "SELECT c.id, p.name, pci.image, color.name AS color, size.name AS size, cd.quantity, sku.price "
					+ "FROM cart_detail AS cd " + "INNER JOIN cart AS c ON c.id = cd.cart_id "
					+ "INNER JOIN product_sku AS sku ON sku.id = cd.product_sku_id "
					+ "INNER JOIN size ON size.id = sku.size_id "
					+ "INNER JOIN product_color_img AS pci ON pci.id = sku.product_color_img_id "
					+ "INNER JOIN product AS p ON p.id = pci.product_id "
					+ "INNER JOIN color ON color.id = pci.color_id " + "WHERE cd.id IN (" + placeholders + ")";

			pst = connection.prepareStatement(sql);

			// Thiết lập giá trị cho từng tham số trong câu lệnh SQL
			for (int i = 0; i < selectedCartIds.length; i++) {
				pst.setLong(i + 1, Long.parseLong(selectedCartIds[i]));
			}

			ResultSet rs = pst.executeQuery();
			while (rs.next()) {

				DetailCartResponse detailCartResponse = new DetailCartResponse(rs.getLong(1), rs.getString(2),
						rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getDouble(7));
				responses.add(detailCartResponse);
			}
		} catch (Exception e) {
			DBConnection.closeConnection(connection);
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection(connection);
		}
		return responses;
	}

	// lấy ra số lượng sản phẩm trong giỏ hàng của khách hàng
	public int getQuantityProductFromCart(Cart cart) {
		connection = DBConnection.getConection();
		String sql = "select sum(quantity) quantity\r\n" + "from cart_detail\r\n" + "where cart_id = ?";
		try {
			pst = connection.prepareStatement(sql);
			pst.setLong(1, cart.getId());
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			DBConnection.closeConnection(connection);
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection(connection);
		}
		return 0;
	}

	// lấy ra CART_DETAIL bằng id
	public Optional<CartDetail> findById(Long cartDetailId) {
		connection = DBConnection.getConection();
		try {
			String sql = "SELECT * FROM cart_detail WHERE id = ?";
			pst = connection.prepareStatement(sql);
			pst.setLong(1, cartDetailId);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				CartDetail cartDetail = new CartDetail();
				cartDetail.setId(rs.getLong(1));

				Cart cart = new Cart(rs.getLong(2), null);
				cartDetail.setCart(cart);

				ProductSku productSku = new ProductSku();
				productSku.setId(rs.getLong(3));
				cartDetail.setProductSku(productSku);

				cartDetail.setQuantity(rs.getInt(4));
				return Optional.of(cartDetail);
			}
		} catch (Exception e) {
			DBConnection.closeConnection(connection);
			e.printStackTrace();
		} finally {
			if (connection != null) {
				try {
					DBConnection.closeConnection(connection);
					;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

	// lấy ra danh sách CART_DETAIL bằng cartId
	public List<DetailCartResponse> getDetailCartByCartId(Long cartId) {
		connection = DBConnection.getConection();
		List<DetailCartResponse> responses = new ArrayList<>();
		try {
			String sql = "SELECT  cd.id , p.name , pci.image , color.name as color , size.name  as size , cd.quantity , sku.price  FROM cart_detail as cd "
					+ "INNER JOIN cart AS c ON c.id = cd.cart_id "
					+ "INNER JOIN product_sku AS sku ON sku.id = cd.product_sku_id "
					+ "INNER JOIN size ON size.id = sku.size_id "
					+ "INNER JOIN product_color_img AS pci ON pci.id = sku.product_color_img_id "
					+ "INNER JOIN product AS p ON p.id = pci.product_id "
					+ "INNER JOIN color ON color.id = pci.color_id " + "WHERE c.id = ? ";
			pst = connection.prepareStatement(sql);
			pst.setLong(1, cartId);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {

				DetailCartResponse detailCartResponse = new DetailCartResponse(rs.getLong(1), rs.getString(2),
						rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getDouble(7));
				responses.add(detailCartResponse);
			}
		} catch (Exception e) {
			DBConnection.closeConnection(connection);
			e.printStackTrace();
		} finally {

			if (connection != null) {
				try {
					DBConnection.closeConnection(connection);
					;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return responses;
	}

	// lấy ra CART_DETAIL bằng productSkuId và cartId
	public CartDetail findByProductSkuAndCart(Long productSkuId, Long cartId) {
		connection = DBConnection.getConection();
		try {
			String sql = "SELECT * FROM cart_detail WHERE cart_id = ? AND product_sku_id = ?";
			pst = connection.prepareStatement(sql);
			pst.setLong(1, cartId);
			pst.setLong(2, productSkuId);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				CartDetail cartDetail = new CartDetail();
				cartDetail.setId(rs.getLong(1));

				Cart cart = new Cart(rs.getLong(2), null);
				cartDetail.setCart(cart);

				ProductSku productSku = new ProductSku();
				productSku.setId(rs.getLong(3));
				cartDetail.setProductSku(productSku);

				cartDetail.setQuantity(rs.getInt(4));
				return cartDetail;
			}
		} catch (Exception e) {DBConnection.closeConnection(connection);
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
					DBConnection.closeConnection(connection);
					;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return null;
	}

	// thêm sản phẩm vào trong giỏ hàng
	public void addProductSkuInCartDetail(Long productSkuId, Cart cart, int quantity) {
		connection = DBConnection.getConection();
		try {
			// Tắt auto-commit để thực hiện giao dịch thủ công
			connection.setAutoCommit(false);

			String sql = "INSERT INTO cart_detail (cart_id ,product_sku_id ,quantity)  VALUES(?,?,?)";
			pst = connection.prepareStatement(sql);
			pst.setLong(1, cart.getId());
			pst.setLong(2, productSkuId);
			pst.setInt(3, quantity);
			pst.executeUpdate();

			// Commit nếu mọi thứ đều thành công
			connection.commit();
		} catch (Exception e) {
			try {
				if (connection != null) {
					connection.rollback();
				}
			} catch (Exception rollbackEx) {
				rollbackEx.printStackTrace();
			}

			// In ra lỗi ban đầu
			e.printStackTrace();

		} finally {
			DBConnection.closeConnection(connection);
		}
	}

	// cập nhật số lượng sản phâm trong giỏ hàng
	public void updateQuantityInCartDetail(CartDetail cartDetail) {
		connection = DBConnection.getConection();
		try {
			// Tắt auto-commit để thực hiện giao dịch thủ công
			connection.setAutoCommit(false);

			String sql = "UPDATE cart_detail SET quantity = ? WHERE id = ?";
			pst = connection.prepareStatement(sql);
			pst.setInt(1, cartDetail.getQuantity());
			pst.setLong(2, cartDetail.getId());
			pst.executeUpdate();

			// Commit nếu mọi thứ đều thành công
			connection.commit();

		} catch (Exception e) {
			// Rollback giao dịch nếu có lỗi xảy ra
			try {
				if (connection != null) {
					connection.rollback();
				}
			} catch (Exception rollbackEx) {
				rollbackEx.printStackTrace();
			}

			// In ra lỗi ban đầu
			e.printStackTrace();

		} finally {
			DBConnection.closeConnection(connection);
		}
	}

	// xóa sản phẩm trong giỏ hàng tạm thời
	public void deleteProductSkuInCartDetail(Long cartDetailId) {
		connection = DBConnection.getConection();
		try {
			// Tắt auto-commit để thực hiện giao dịch thủ công
			connection.setAutoCommit(false);

			String sql = "DELETE FROM cart_detail WHERE id = ?";
			pst = connection.prepareStatement(sql);
			pst.setLong(1, cartDetailId);
			pst.executeUpdate();

			// Commit nếu mọi thứ đều thành công
			connection.commit();
		} catch (Exception e) {
			try {
				if (connection != null) {
					connection.rollback();
				}
			} catch (Exception rollbackEx) {
				rollbackEx.printStackTrace();
			}
			// In ra lỗi ban đầu
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
					DBConnection.closeConnection(connection);
					;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	}
}
