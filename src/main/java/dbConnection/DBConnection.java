package dbConnection;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class DBConnection {
	private static HikariDataSource dataSource;

	// Khởi tạo Connection Pool
	static {
		HikariConfig config = new HikariConfig();
		config.setJdbcUrl("jdbc:mysql://localhost:3306/ecommerce");
		config.setUsername("root");
		config.setPassword("dong14052004");

		config.setMaximumPoolSize(50); // Giảm để phù hợp với `max_connections`
		config.setMinimumIdle(5); // Tăng số kết nối nhàn rỗi tối thiểu
		config.setIdleTimeout(60000); // Giữ kết nối nhàn rỗi lâu hơn
		config.setMaxLifetime(1800000); // Không thay đổi, nhưng đảm bảo `wait_timeout` đủ lớn
		config.setConnectionTimeout(10000); // Giảm thời gian chờ lấy kết nối
		config.setDriverClassName("com.mysql.cj.jdbc.Driver");
		dataSource = new HikariDataSource(config);

	}

	// Phương thức lấy kết nối
	public static Connection getConection() {
		try {
			return dataSource.getConnection();
		} catch (SQLException e) {
			System.out.println("Error getting connection: " + e.getMessage());
			return null;
		}
	}

	// Đóng kết nối (tự động trả về pool)
	public static void closeConnection(Connection connection) {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {
			System.out.println("Error closing connection: " + e.getMessage());
		}
	}

}
