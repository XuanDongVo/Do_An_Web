package repository.userRole;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dbConnection.DBConnection;
import entity.Role;
import entity.User;
import entity.User_Role;

public class UserRoleRepository {
	Connection connection = null;
	PreparedStatement pst = null;

	public User_Role getUserRole(User user) {
		connection = DBConnection.getConection();
		try {
			String sql = "SELECT user_role.id, user.id, role.name FROM user_role INNER JOIN role ON role.id = user_role.role_id\r\n"
					+ "	INNER JOIN user ON user.id = user_role.user_id\r\n" + " WHERE user.id = ? ";

			pst = connection.prepareStatement(sql);
			pst.setLong(1, user.getId());
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				User_Role user_Role = new User_Role();
				user_Role.setId(rs.getInt(1));
				User currentUser = new User();
				user.setId(rs.getLong(2));
				user_Role.setUser(currentUser);

				Role role = new Role();
				role.setNameRole(rs.getString(3));
				user_Role.setRole(role);

				return user_Role;
			}

		} catch (Exception e) {
			DBConnection.closeConnection(connection);
			e.printStackTrace();
		} finally {
			DBConnection.closeConnection(connection);
		}

		return null;
	}
}
