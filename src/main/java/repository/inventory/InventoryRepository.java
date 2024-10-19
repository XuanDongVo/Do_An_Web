package repository.inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Optional;

import dbConnection.DBConnection;
import entity.Inventory;

public class InventoryRepository {
	public Connection connection = null;
	public PreparedStatement preparedStatement = null;

	
	public Optional<Inventory> findByProductSku(Long id) {
	    Connection connection = DBConnection.getConection();
	    String sql = "SELECT * FROM INVENTORY WHERE PRODUCT_SKU_ID = ?";
	    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
	        preparedStatement.setLong(1, id);
	        try (ResultSet resultSet = preparedStatement.executeQuery()) {
	            if (resultSet.next()) { // Kiểm tra nếu có kết quả
	                Inventory inventory = new Inventory(resultSet.getLong("PRODUCT_SKU_ID"), resultSet.getInt("STOCK"));
	                return Optional.of(inventory); 
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); 
	    } finally {
	        try {
	            if (connection != null) {
	                connection.close();
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return Optional.empty(); // Trả về Optional rỗng nếu không có kết quả
	}

}
