package repository.category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import dbConnection.DBConnection;
import entity.Category;
import entity.Gender;
import entity.SubCategory;

public class SubCategoryRepository {
	private Connection connection = null;
	private PreparedStatement pst = null;

	public List<SubCategory> getSubCategoryByCategory(String nameCategory) {
		List<SubCategory> subCategories = new ArrayList<>();
		connection = DBConnection.getConection();
		String sql = "SELECT sc.* FROM sub_category sc "
				+ "INNER JOIN category c ON c.id = sc.category_id WHERE c.name = ?";
		try {
			pst = connection.prepareStatement(sql);
			pst.setString(1, nameCategory);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				SubCategory subCategory = new SubCategory();
				subCategory.setId(rs.getLong(1));
				subCategory.setName(rs.getString(2));
				subCategories.add(subCategory);
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
		return subCategories;
	}

	// Find Sub Category by id
	public Optional<SubCategory> findById(Long id) {
		connection = DBConnection.getConection();
		String sql = "SELECT sc.* , gender.name FROM sub_category AS sc \r\n"
				+ "INNER JOIN  category AS c ON c.id = sc.category_id  \r\n"
				+ "INNER JOIN gender ON gender.id = C.gender_id \r\n" + "WHERE sc.id = ?";
		try {
			pst = connection.prepareStatement(sql);
			pst.setLong(1, id);
			ResultSet rs = pst.executeQuery();
			if (rs.next()) {
				SubCategory subCategory = new SubCategory();
				subCategory.setId(rs.getLong(1));
				subCategory.setName(rs.getString(2));

				Category category = new Category();
				category.setId(rs.getLong(3));

				Gender gender = new Gender();
				gender.setName(rs.getString(4));
				category.setGender(gender);

				subCategory.setCategory(category);
				return Optional.of(subCategory);
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
}
