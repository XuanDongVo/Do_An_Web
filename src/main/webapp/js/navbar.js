// Hàm để toggle (hiện/ẩn) mục con của subcategory 1
function toggleSubcategory(subcategoryId) {
	const subcategory = document.getElementById(`subcategory${subcategoryId}-extra`);
	if (subcategory) {
		subcategory.style.display = (subcategory.style.display === "none" ? "block" : "none");
	}
}

document.addEventListener("DOMContentLoaded", function() {
    // Gọi hàm đăng ký sự kiện khi DOM đã sẵn sàng
    registerEvents()
    // Xử lý sự kiện hiển thị menu người dùng
    const userIcon = document.querySelector('.user-icon');
    const userOptions = document.querySelector('.user-options');
    if (userIcon && userOptions) {
        userIcon.addEventListener('click', function() {
            // Toggle hiển thị menu
            if (userOptions.style.display === 'flex') {
                userOptions.style.display = 'none';
                userOptions.style.opacity = '0';
            } else {
                userOptions.style.display = 'flex';
                userOptions.style.opacity = '1';
            }
        });
    }
});

// Hàm đăng ký sự kiện (tìm kiếm và menu người dùng)
function registerEvents() {
    // Xử lý sự kiện tìm kiếm
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        // Đảm bảo rằng không có sự kiện cũ trước khi thêm mới
        searchInput.removeEventListener('keydown', handleSearch); // Loại bỏ sự kiện cũ
        searchInput.addEventListener('keydown', handleSearch); // Thêm sự kiện mới
    }
    
    // Xử lý sự kiện hiển thị menu người dùng (đảm bảo không có sự kiện cũ)
    const userIcon = document.querySelector('.user-icon');
    const userOptions = document.querySelector('.user-options');
    if (userIcon && userOptions) {
        userIcon.removeEventListener('click', toggleUserMenu); // Loại bỏ sự kiện cũ
        userIcon.addEventListener('click', toggleUserMenu);  // Thêm sự kiện mới
    }
}

// Định nghĩa hàm toggleUserMenu
function toggleUserMenu() {
    const userOptions = document.querySelector('.user-options');
    if (userOptions.style.display === 'flex') {
        userOptions.style.display = 'none';
        userOptions.style.opacity = '0';
    } else {
        userOptions.style.display = 'flex';
        userOptions.style.opacity = '1';
    }
}

// Hàm này sẽ được gọi khi người dùng nhấn Enter
function handleSearch(event) {
    if (event && event.key !== 'Enter') return;  // Chỉ thực thi khi nhấn Enter

    const searchInput = document.getElementById('searchInput');
    const searchTerm = searchInput.value.trim(); // Lấy giá trị từ input và loại bỏ khoảng trắng

    if (searchTerm) {
        performSearch(searchTerm); // Thực hiện tìm kiếm
    }
}

// Gọi controller tìm kiếm
function performSearch(term) {
    window.location.href = 'search?search=' + encodeURIComponent(term);  // Đảm bảo mã hóa từ khóa tìm kiếm
}



window.addEventListener('scroll', () => {
	const navbar = document.querySelector('.shop-navbar');
	if (window.scrollY > 50) {
		navbar.classList.add('scrolled');
	} else {
		navbar.classList.remove('scrolled');
	}
});



/*render dropListCategory*/
function renderDataDropListCategoryHeader(dropListCategory) {
	// Lấy phần tử HTML chứa menu để chèn dữ liệu mới vào
	const navMenu = document.querySelector('.nav-menu');

	// Xóa nội dung cũ nếu có
	navMenu.innerHTML = '';

	// Duyệt qua các phần tử trong dropListCategory và tạo cấu trúc HTML
	for (const categoryKey in dropListCategory) {
		if (dropListCategory.hasOwnProperty(categoryKey)) {
			// Tạo thẻ <li> cho mỗi category
			const navItem = document.createElement('li');
			navItem.className = 'nav-item';

			// Tạo liên kết category
			const categoryLink = document.createElement('a');
			categoryLink.href = `gender?gender=${categoryKey}`;
			categoryLink.style.textDecoration = 'none';
			categoryLink.style.color = 'inherit';
			categoryLink.innerText = categoryKey.toUpperCase();

			// Chèn liên kết category vào <li>
			navItem.appendChild(categoryLink);

			// Tạo thẻ <hr>
			const hr = document.createElement('hr');
			navItem.appendChild(hr);

			// Tạo div chứa subcategories
			const subcategoriesDiv = document.createElement('div');
			subcategoriesDiv.className = 'subcategories';
			subcategoriesDiv.style.margin = '0';
			subcategoriesDiv.style.width = '20rem';


			// Duyệt qua subcategories của category hiện tại
			const subcategories = dropListCategory[categoryKey];
			for (const subCategoryKey in subcategories) {
				if (subcategories.hasOwnProperty(subCategoryKey)) {
					// Tạo liên kết cho subcategory
					const subCategoryLink = document.createElement('a');

					// Tạo thẻ div bao bọc cả subCategoryParagraph và toggleSpan
					const subCategoryWrapper = document.createElement('div');
					subCategoryWrapper.style.display = 'flex';
					subCategoryWrapper.style.alignItems = 'center';

					// Tạo thẻ p cho subCategory
					const subCategoryParagraph = document.createElement('p');
					subCategoryParagraph.style.margin = '0'; // Loại bỏ margin mặc định
					subCategoryParagraph.innerText = subCategoryKey.toUpperCase();
					subCategoryParagraph.style.cursor = 'pointer';
					subCategoryParagraph.onclick = () => {
						window.location.href = 'category?category=' + subCategoryKey;
					};

					// Tạo nút toggle cho subcategory
					const toggleSpan = document.createElement('span');
					toggleSpan.style.color = 'red';
					toggleSpan.style.marginLeft = '8px'; // Khoảng cách giữa p và span
					toggleSpan.innerText = ' + ';
					toggleSpan.style.cursor = 'pointer';
					toggleSpan.onclick = () => toggleSubcategory(subCategoryKey);

					// Thêm p và span vào div wrapper
					subCategoryWrapper.appendChild(subCategoryParagraph);
					subCategoryWrapper.appendChild(toggleSpan);

					// Thêm wrapper vào subcategoriesDiv
					subcategoriesDiv.appendChild(subCategoryWrapper);


					// Tạo div chứa các extra subcategories
					const extraSubcategoriesDiv = document.createElement('div');
					extraSubcategoriesDiv.id = `subcategory${subCategoryKey}-extra`;
					extraSubcategoriesDiv.className = 'subcategory-extra';
					extraSubcategoriesDiv.style.display = 'none';
					extraSubcategoriesDiv.style.marginLeft = '8%';

					// Duyệt qua các extra subcategories
					const extraSubCategories = subcategories[subCategoryKey];
					extraSubCategories.forEach(extraSubCategory => {
						const extraSubCategoryLink = document.createElement('a');
						extraSubCategoryLink.href = '#';
						extraSubCategoryLink.style.textDecoration = 'none';

						const extraSubCategoryParagraph = document.createElement('p');
						extraSubCategoryParagraph.innerText = extraSubCategory.toUpperCase();
						extraSubCategoryParagraph.onclick = () => {
							window.location.href = 'subcategory?subCategory=' + extraSubCategory;
						}
						extraSubCategoryLink.appendChild(extraSubCategoryParagraph);

						// Thêm extra subcategory vào extraSubcategoriesDiv
						extraSubcategoriesDiv.appendChild(extraSubCategoryLink);
					});

					// Thêm extraSubcategoriesDiv vào subcategoriesDiv
					subcategoriesDiv.appendChild(extraSubcategoriesDiv);
				}
			}

			// Thêm subcategoriesDiv vào navItem
			navItem.appendChild(subcategoriesDiv);

			// Thêm dấu "|" sau mỗi category
			const separator = document.createElement('span');
			separator.style.fontSize = '2rem';
			separator.style.marginBottom = '2%';
			separator.innerText = '|';

			// Thêm navItem và separator vào navMenu
			navMenu.appendChild(navItem);
			navMenu.appendChild(separator);
		}
	}
}

/*render quantity*/
function renderDataQuantityProductHeader(quantityProduct) {
	// Lấy phần tử HTML có class 'nav-cart-count'
	const navCartCount = document.querySelector('.nav-cart-count');

	// Xóa nội dung cũ nếu có
	navCartCount.innerHTML = '';

	// Thêm số lượng sản phẩm mới vào
	navCartCount.innerText = quantityProduct;

}


/*render ListCartDetail*/
function renderDataListCartDetailHeader(listCartDetail) {
	// Lấy phần tử chứa các item trong giỏ hàng
	const offcanvasBody = document.querySelector('.offcanvas-body');

	// Xóa nội dung cũ nếu có
	offcanvasBody.innerHTML = '';

	if (listCartDetail == null || listCartDetail.length === 0) {
		// Render thông báo khi giỏ hàng trống
		const noProductsMessage = `
            <div style="height: 120px; display: flex; align-items: center; justify-content: center; flex-direction: column; padding: 0px 23px; text-align: center;">
                Bạn chưa có sản phẩm nào trong giỏ hàng
            </div>
        `;
		offcanvasBody.innerHTML = noProductsMessage;
	}

	// Lặp qua từng item trong listCartDetail và tạo phần tử HTML cho mỗi item
	listCartDetail.forEach(item => {

		// Tạo phần tử chứa item
		const cartItem = document.createElement('div');
		cartItem.className = 'cart-item';

		// Tạo phần tử hình ảnh của sản phẩm
		const cartItemImage = document.createElement('div');
		cartItemImage.className = 'cart-item-image';
		const img = document.createElement('img');
		img.src = item.image;
		img.alt = 'Product Image';
		cartItemImage.appendChild(img);

		// Tạo phần tử chi tiết sản phẩm
		const cartItemDetails = document.createElement('div');
		cartItemDetails.className = 'cart-item-details';

		const name = document.createElement('p');
		name.className = 'cart-item-name';
		name.innerText = item.name;

		const description = document.createElement('p');
		description.className = 'cart-item-description';
		description.innerText = item.color + ' , ' + item.size;

		const cartItemActions = document.createElement('div');
		cartItemActions.className = 'cart-item-actions';

		const quantity = document.createElement('span');
		quantity.className = 'cart-item-quantity';
		quantity.innerText = 'SL: ' + item.quantity;

		const removeBtn = document.createElement('button');
		removeBtn.className = 'remove-item-btn';

		const removeIcon = document.createElement('img');
		removeIcon.src = 'img/remove.png';
		removeIcon.alt = 'Remove Icon';
		removeBtn.appendChild(removeIcon);

		// Gán sự kiện onclick cho nút xóa
		removeBtn.onclick = function() {
			// Lấy URL hiện tại
			var currentUrl = window.location.href;
			// Mã hóa URL hiện tại để có thể truyền an toàn qua request
			var encodedUrl = encodeURIComponent(currentUrl);
			window.location.href = 'cartdetail?action=remove&cartId=' + item.cartId + '&redirectUrl=' + encodedUrl;
		};

		// Gắn các phần tử con vào cartItemActions
		cartItemActions.appendChild(quantity);
		cartItemActions.appendChild(removeBtn);

		// Gắn các phần tử con vào cartItemDetails
		cartItemDetails.appendChild(name);
		cartItemDetails.appendChild(description);
		cartItemDetails.appendChild(cartItemActions);

		// Tạo phần tử giá sản phẩm
		const cartItemPrice = document.createElement('div');
		cartItemPrice.className = 'cart-item-price';
		cartItemPrice.innerText = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(item.price);

		// Gắn các phần tử vào cartItem
		cartItem.appendChild(cartItemImage);
		cartItem.appendChild(cartItemDetails);
		cartItem.appendChild(cartItemPrice);

		// Thêm cartItem vào offcanvasBody
		offcanvasBody.appendChild(cartItem);
	});
}


function redirectCartDetail() {
	window.location.href = 'cartdetail?action=get';
}





