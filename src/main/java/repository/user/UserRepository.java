package repository.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;

import dbConnection.DBConnection;
import entity.User;

public class UserRepository {
	Connection connection = null;
	PreparedStatement pst = null;

	// lấy ra người dùng bằng số điện thoại
	public User getUserByPhone(String phone) {
		connection = DBConnection.getConection();
		try {
			String sql = "SELECT * FROM user WHERE phone = ? ";
			pst = connection.prepareStatement(sql);
			pst.setString(1, phone);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setId(rs.getLong(1));
				user.setEmail(rs.getString(2));
				user.setPhone(rs.getString(3));
				user.setAddress(rs.getString(4));
				user.setName(rs.getString(6));
				return user;
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

	// thay đổi mật khẩu người dùng
	public void changePassword(User user, String password) {
		connection = DBConnection.getConection();
		try {
			// Tắt auto-commit để thực hiện giao dịch thủ công
			connection.setAutoCommit(false);
			String sql = "UPDATE user SET password = ? WHERE id = ?";
			pst = connection.prepareStatement(sql);
			pst.setString(1, password);
			pst.setLong(2, user.getId());
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
			if (pst != null) {
				try {
					pst.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (connection != null) {
				try {
					connection.setAutoCommit(true); // Bật lại auto-commit sau giao dịch
					connection.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	// thay đổi thông tin người dùng
	public void changeInformationUser(Long userId, String name, String address) {
		connection = DBConnection.getConection();
		try {
			// Tắt auto-commit để thực hiện giao dịch thủ công
			connection.setAutoCommit(false);

			String sql = "UPDATE user SET name = ?, address = ? WHERE id = ?";
			pst = connection.prepareStatement(sql);
			pst.setString(1, name);
			pst.setString(2, address);
			pst.setLong(3, userId);

			pst.executeUpdate();

			connection.commit();
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
					connection.setAutoCommit(true); // Bật lại auto-commit sau giao dịch
					connection.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	// thay đổi email người dùng
	public void changeEmailUser(User user, String email) {
		connection = DBConnection.getConection();
		try {
			// Tắt auto-commit để thực hiện giao dịch thủ công
			connection.setAutoCommit(false);

			String sql = "UPDATE user SET email = ? WHERE id = ?";
			pst = connection.prepareStatement(sql);
			pst.setString(1, email);
			pst.setLong(2, user.getId());

			pst.executeUpdate();

			connection.commit();
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
					connection.setAutoCommit(true); // Bật lại auto-commit sau giao dịch
					connection.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

}
