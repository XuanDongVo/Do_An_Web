package service.category;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import entity.Category;
import entity.Gender;
import entity.SubCategory;
import repository.category.CategoryRepository;
import repository.category.SubCategoryRepository;
import repository.gender.GenderRepository;

public class SubCategoryService {
	private GenderRepository genderRepository = new GenderRepository();
	private SubCategoryRepository subCategoryRepository = new SubCategoryRepository();
	private CategoryRepository categoryRepository = new CategoryRepository();

	public Map<String, Map<String, List<String>>> dropListCategory() {
		List<Gender> genders = genderRepository.getAllGender();
		if (genders == null) {
			throw new RuntimeException("Error exception for get all category");
		}

		Map<String, Map<String, List<String>>> dropListCategory = new HashMap<>();

		genders.forEach(gender -> {
			Map<String, List<String>> innerMap = new HashMap<>();

			// Lấy tất cả các category dựa trên gender
			List<Category> categories = categoryRepository.getAllCategoriesByGender(gender.getName());

			categories.forEach(category -> {
				// Lấy tất cả các subcategory dựa trên category
				List<SubCategory> subCategories = subCategoryRepository.getSubCategoryByCategory(category.getName());

				// Chuyển đổi danh sách các SubCategory thành danh sách các tên (String)
				List<String> nameSubCategories = subCategories.stream().map(SubCategory::getName)
						.collect(Collectors.toList()); // Thu thập kết quả thành một danh sách

				// Thêm vào innerMap với tên category và danh sách tên subcategories
				innerMap.putIfAbsent(category.getName(), nameSubCategories);
			});       

			// Thêm vào dropListCategory với tên gender và innerMap
			dropListCategory.putIfAbsent(gender.getName(), innerMap);
		});
		return dropListCategory;
	}

	public List<String> beadCrumb(String subCategory) {
		List<String> beadCrumb = subCategoryRepository.beadCrumb(subCategory);
		if (beadCrumb == null) {
			throw new RuntimeException();
		}
		return beadCrumb;
	}

}
