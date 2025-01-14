function toggleFilter() {
	const filterPanel = document.getElementById('filterPanel');
	const isVisible = filterPanel.style.display === 'block';
	filterPanel.style.display = isVisible ? 'none' : 'block';

	// Nếu filterPanel đang hiển thị, thêm sự kiện click ngoài để đóng
	if (!isVisible) {
		document.addEventListener('click', outsideClickListener);
	} else {
		document.removeEventListener('click', outsideClickListener);
	}
}

function outsideClickListener(event) {
	const filterPanel = document.getElementById('filterPanel');
	const filterIcon = document.querySelector('.filter-icon');

	// Kiểm tra nếu nhấp chuột không nằm trong filterPanel và filterIcon
	if (!filterPanel.contains(event.target) && !filterIcon.contains(event.target)) {
		filterPanel.style.display = 'none';  // Đóng filterPanel
		document.removeEventListener('click', outsideClickListener);  // Xóa sự kiện khi đóng
	}
}

function showTab(tabId) {
	const tabs = document.querySelectorAll('.tab-content');
	tabs.forEach(tab => {
		tab.style.display = 'none';
	});

	const buttons = document.querySelectorAll('.tab-btn');
	buttons.forEach(btn => {
		btn.classList.remove('active');
	});

	document.getElementById(tabId).style.display = 'block';
	document.querySelector(`[onclick="showTab('${tabId}')"]`).classList.add('active');
}

function renderFilter(colors, sizes) {
	// Render màu sắc
	const colorContainer = document.querySelector('.color-options');
	colorContainer.innerHTML = ''; // Xóa nội dung cũ

	colors.forEach(color => {
		// Tạo phần tử div ngoài cùng với các lớp tương ứng
		const colorItem = document.createElement('div');
		colorItem.className = 'ant-col ant-col-6 item-color';
		colorItem.style = 'padding-left: 5px; padding-right: 5px; padding-bottom: 10px; width: 100px;';

		// Tạo phần tử div bao bọc với các lớp và kiểu đã cho
		const colorWrapper = document.createElement('div');
		colorWrapper.className = 'border-border p-2.5 py-3 border-[1px] cursor-pointer flex flex-col items-center justify-center';
		colorWrapper.onclick = () => updateColorFilter(color.name);

		// Tạo phần tử div cho hình tròn màu sắc
		const colorCircle = document.createElement('div');
		colorCircle.className = 'mb-2 w-7 h-7';
		colorCircle.style.backgroundColor = color.code;
		colorCircle.style.border = ' 1px solid #808080'

		// Tạo phần tử div cho tên màu sắc
		const colorName = document.createElement('div');
		colorName.className = 'ellipsis-t w-full text-xs font-medium text-center';
		colorName.textContent = color.name;

		// Ghép các phần tử con vào các phần tử cha
		colorWrapper.appendChild(colorCircle);
		colorWrapper.appendChild(colorName);
		colorItem.appendChild(colorWrapper);

		// Thêm phần tử item vào container
		colorContainer.appendChild(colorItem);
	});

	// Render kích cỡ
	const sizeContainer = document.querySelector('.size-options');
	sizeContainer.innerHTML = ''; // Xóa nội dung cũ
	sizes.forEach(size => {
		const sizeLabel = document.createElement('label');
		sizeLabel.className = ' size-label';

		const sizeInput = document.createElement('input');
		sizeInput.type = 'checkbox';
		sizeInput.className = 'btn-check';
		sizeInput.dataset.sizeName = size.name;
		sizeInput.onclick = () => updateSizeFilter(size.name.toUpperCase()); // Gọi hàm khi checkbox được nhấn

		sizeLabel.appendChild(sizeInput);
		sizeLabel.appendChild(document.createTextNode(size.name)); // Hiển thị kích cỡ trên nhãn

		sizeContainer.appendChild(sizeLabel);
	});
}

function updateColorFilter(color) {
	// Lấy URL hiện tại
	let url = new URL(window.location.href);
	let colors = url.searchParams.get("color");

	// Chuyển chuỗi màu sắc thành mảng
	let colorArray = colors ? colors.split(",") : [];

	// Lấy tất cả các phần tử colorWrapper
	const colorItems = document.querySelectorAll('.color-options .item-color');

	colorItems.forEach(item => {
		const colorWrapper = item.querySelector('.border-border');
		const colorName = item.querySelector('.ellipsis-t').textContent.trim().toLowerCase();

		// Nếu màu sắc này được chọn, thêm 'active' vào
		if (colorName === color.toLowerCase()) {
			// Nếu màu sắc đã có trong mảng, xóa nó và bỏ lớp 'active'
			if (colorArray.includes(color)) {
				colorArray = colorArray.filter(c => c !== color);
				colorWrapper.classList.remove('active'); // Xóa lớp 'active'
			} else {
				// Nếu chưa có màu sắc, thêm vào mảng và thêm lớp 'active'
				colorArray.push(color);
				colorWrapper.classList.add('active'); // Thêm lớp 'active'
			}
		}
	});

	// Cập nhật tham số màu sắc trong URL
	if (colorArray.length > 0) {
		url.searchParams.set("color", colorArray.join(","));
	} else {
		url.searchParams.delete("color"); // Xóa tham số nếu không còn màu sắc nào
	}

	// Xóa tham số `page` nếu nó tồn tại
	if (url.searchParams.has("page")) {
		url.searchParams.delete("page");
	}

	// Điều hướng đến URL mới
	history.replaceState(null, "", url.toString()); // Cập nhật URL mà không tải lại trang
	fetchFilteredProducts();
}


function updateSizeFilter(size) {
	// Lấy URL hiện tại
	let url = new URL(window.location.href);
	let sizes = url.searchParams.get("size");

	// Chuyển chuỗi kích cỡ thành mảng
	let sizeArray = sizes ? sizes.split(",") : [];

	// Lấy tất cả các phần tử sizeLabel
	const sizeItems = document.querySelectorAll('.size-options .size-label');

	sizeItems.forEach(item => {
		const sizeLabel = item;
		const sizeName = sizeLabel.textContent.trim().toLowerCase();

		// Nếu kích cỡ này được chọn, thêm 'active' vào
		if (sizeName === size.toLowerCase()) {
			// Nếu kích cỡ đã có trong mảng, xóa nó và bỏ lớp 'active'
			if (sizeArray.includes(size)) {
				sizeArray = sizeArray.filter(s => s !== size);
				sizeLabel.classList.remove('active'); // Xóa lớp 'active'
			} else {
				// Nếu chưa có kích cỡ, thêm vào mảng và thêm lớp 'active'
				sizeArray.push(size);
				sizeLabel.classList.add('active'); // Thêm lớp 'active'
			}
		}
	});

	// Cập nhật tham số kích cỡ trong URL
	if (sizeArray.length > 0) {
		url.searchParams.set("size", sizeArray.join(","));
	} else {
		url.searchParams.delete("size"); // Xóa tham số nếu không còn kích cỡ nào
	}

	// Xóa tham số `page` nếu nó tồn tại
	if (url.searchParams.has("page")) {
		url.searchParams.delete("page");
	}

	// Điều hướng đến URL mới
	history.replaceState(null, "", url.toString()); // Cập nhật URL mà không tải lại trang
	fetchFilteredProducts();
}


function resetChoose() {
	// Xóa các lựa chọn màu sắc
	const colorItems = document.querySelectorAll('.color-options .item-color');
	colorItems.forEach(item => {
		const colorWrapper = item.querySelector('.border-border');
		colorWrapper.classList.remove('active'); // Xóa lớp 'active' của màu sắc
	});

	// Xóa các lựa chọn kích cỡ
	const sizeItems = document.querySelectorAll('.size-options .size-label');
	sizeItems.forEach(item => {
		item.classList.remove('active'); // Xóa lớp 'active' của kích cỡ
	});

	// Lấy URL hiện tại
	let url = new URL(window.location.href);

	// Xóa tham số color và size trong URL nếu có
	url.searchParams.delete("color");
	url.searchParams.delete("size");

	// Xóa tham số `page` nếu nó tồn tại
	if (url.searchParams.has("page")) {
		url.searchParams.delete("page");
	}

	// Cập nhật lại URL mà không tải lại trang
	history.replaceState(null, "", url.toString());

	// Gọi lại hàm để tải lại sản phẩm theo bộ lọc mới (không có bộ lọc)
	fetchFilteredProducts();
}


function fetchFilteredProducts() {
	const currentUrl = window.location.href;
	console.log(currentUrl)
	$.ajax({
		url: currentUrl,
		method: "GET",
		success: function(response) {
			console.log(response)
			renderProducts(response.data);
			renderPagination(response.currentPage, response.totalPages)
		},
		error: function(xhr, status, error) {
			console.error("Lỗi: ", error);
		}
	});
}

function renderProducts(response) {
	// Lấy phần tử cha nơi bạn sẽ thêm sản phẩm
	const collectionsDiv = document.querySelector('.collections');

	// Xóa nội dung hiện tại trong collectionsDiv nếu cần
	collectionsDiv.innerHTML = '';

	// Lặp qua từng sản phẩm trong phản hồi
	response.forEach(product => {
		// Tạo phần tử cho mỗi sản phẩm
		const collectionItemDiv = document.createElement('div');
		collectionItemDiv.classList.add('collection-item');

		// Tạo liên kết đến sản phẩm
		const productLink = document.createElement('a');
		productLink.href = `productDetail?id=${product.productId}`;

		// Tạo container hình ảnh
		const imageContainerDiv = document.createElement('div');
		imageContainerDiv.classList.add('image-container');

		// Tạo hình ảnh chính và hình ảnh hover
		const mainImage = document.createElement('img');
		mainImage.id = 'image-main';
		mainImage.classList.add('image-main');
		mainImage.src = product.productSkus[0].img;
		mainImage.alt = `${product.name} Image`;

		const hoverImage = document.createElement('img');
		hoverImage.id = 'image-hover';
		hoverImage.classList.add('image-hover');
		hoverImage.src = product.productSkus[0].img;
		hoverImage.alt = `${product.name} Hover Image`;

		const addImage = document.createElement('img');
		addImage.src = 'img/add.png';
		addImage.alt = '';
		addImage.classList.add('plus');

		// Thêm các hình ảnh vào container
		imageContainerDiv.appendChild(mainImage);
		imageContainerDiv.appendChild(hoverImage);
		imageContainerDiv.appendChild(addImage);

		// Thêm container hình ảnh vào liên kết
		productLink.appendChild(imageContainerDiv);
		collectionItemDiv.appendChild(productLink);

		// Tạo container cho kích thước
		const sizeContainerDiv = document.createElement('div');
		sizeContainerDiv.classList.add('size-container');

		const sizeOptionsDiv = document.createElement('div');
		sizeOptionsDiv.classList.add('size-options');
		sizeOptionsDiv.id = 'size-options';

		// Xác định kích thước dựa trên loại sản phẩm
		let sizeString;
		if (product.typeProduct === 'áo') {
			sizeString = 's,m,l,xl,xxl';
		} else if (product.typeProduct === 'quần') {
			sizeString = '28,29,30,31,32';
		}

		const sizeList = sizeString.split(',');

		// Lặp qua từng kích thước
		sizeList.forEach(size => {
			const stock = product.productSkus[0].sizeAndStock[size];
			const sizeButton = document.createElement('button');
			sizeButton.classList.add('size-btn');
			sizeButton.textContent = size.toUpperCase();

			// Kiểm tra số lượng
			if (stock != null && stock > 0) {
				sizeButton.onclick = () => addProductToCart(product.productSkus[0].productColorImgId, size, '1');
			} else {
				sizeButton.classList.add('size-unavailable');
				sizeButton.disabled = true; // Disable if out of stock
			}

			sizeOptionsDiv.appendChild(sizeButton);
		});

		sizeContainerDiv.appendChild(sizeOptionsDiv);
		collectionItemDiv.appendChild(sizeContainerDiv);

		// Thêm phần hiển thị hình ảnh của sản phẩm
		const imageCateDiv = document.createElement('div');
		imageCateDiv.classList.add('image-cate');

		product.productSkus.forEach(sku => {
			const skuImage = document.createElement('img');
			skuImage.src = sku.img;
			skuImage.alt = `${sku.color} Image`;
			skuImage.onclick = () => selectImage(skuImage, sku.productColorImgId, sku.img, JSON.stringify(sku.sizeAndStock), product.typeProduct);
			imageCateDiv.appendChild(skuImage);
		});

		collectionItemDiv.appendChild(imageCateDiv);

		// Tạo tên sản phẩm và giá
		const productName = document.createElement('p');
		productName.className = "product-name";

		// Tạo thẻ strong
		const strongElement = document.createElement('strong');

		// Tạo liên kết sản phẩm
		const productNameLink = document.createElement('a');
		productNameLink.href = `productDetail?id=${product.productId}`;
		productNameLink.textContent = product.name;

		// Thêm liên kết vào thẻ strong
		strongElement.appendChild(productNameLink);

		// Thêm thẻ strong vào thẻ p
		productName.appendChild(strongElement);


		const itemPriceDiv = document.createElement('div');
		itemPriceDiv.classList.add('item-price-new');
		itemPriceDiv.textContent = `${formatPrice(product.price)} đ`;

		// Thêm tên sản phẩm và giá vào collection item
		collectionItemDiv.appendChild(itemPriceDiv);
		collectionItemDiv.appendChild(productName);


		// Thêm collection item vào collectionsDiv
		collectionsDiv.appendChild(collectionItemDiv);
	});
		attachPlusEvents();
}


function attachPlusEvents() {
	const plusIcons = document.querySelectorAll('.collection-item .plus');

	plusIcons.forEach(function (plus) {
		plus.addEventListener('click', function (event) {
			event.preventDefault(); // Ngăn chặn hành động mặc định

			const collectionItem = plus.closest('.collection-item');
			const sizeContainer = collectionItem.querySelector('.size-container');

			document.querySelectorAll('.size-container.active').forEach(function (container) {
				if (container !== sizeContainer) {
					container.classList.remove('active');
				}
			});

			sizeContainer.classList.toggle('active');
		});
	});

	// Đóng size-container khi nhấp ra ngoài
	document.addEventListener('click', function (event) {
		plusIcons.forEach(function (plus) {
			const collectionItem = plus.closest('.collection-item');
			const sizeContainer = collectionItem.querySelector('.size-container');

			if (!collectionItem.contains(event.target)) {
				sizeContainer.classList.remove('active');
			}
		});
	});
}


// Hàm format giá tiền
function formatPrice(price) {
	return new Intl.NumberFormat('vi-VN', { style: 'decimal' }).format(price);
}


function renderPagination(currentPage, totalPage) {
	const navElement = document.querySelector('nav[aria-label="Page navigation"].mt-4');

	if (totalPage <= 1) {
		navElement.innerHTML = '';
		return;
	}

	// Tạo HTML cho phân trang
	let paginationHTML = '<ul class="pagination justify-content-center custom-pagination">';

	// Nút "Previous"
	paginationHTML += `
        <li class="page-item ${currentPage === 1 ? 'disabled' : ''}">
            <button class="page-link" onclick="handPagination(${currentPage - 1})" ${currentPage === 1 ? 'disabled' : ''}>&laquo;</button>
        </li>
    `;

	// Các số trang
	for (let page = 1; page <= totalPage; page++) {
		paginationHTML += `
            <li class="page-item ${currentPage === page ? 'active' : ''}">
                <button class="page-link" onclick="handPagination(${page})">${page}</button>
            </li>
        `;
	}

	// Nút "Next"
	paginationHTML += `
        <li class="page-item ${currentPage === totalPage ? 'disabled' : ''}">
            <button class="page-link" onclick="handPagination(${currentPage + 1})" ${currentPage === totalPage ? 'disabled' : ''}>&raquo;</button>
        </li>
    `;

	paginationHTML += '</ul>';

	// Cập nhật DOM
	navElement.innerHTML = paginationHTML;
}

function handPagination(pageNumber) {
	// Lấy URL hiện tại
	var currentUrl = window.location.href;

	// Kiểm tra xem URL có chứa tham số page không
	var newUrl;
	if (currentUrl.includes('page=')) {
		// Nếu có tham số page, thay thế giá trị của nó
		newUrl = currentUrl.replace(/page=\d+/, 'page=' + pageNumber);
	} else {
		// Nếu không có tham số page, thêm vào cuối URL
		newUrl = currentUrl + (currentUrl.includes('?') ? '&' : '?') + 'page=' + pageNumber;
	}

	// Cập nhật URL mà không tải lại trang
	window.history.pushState({}, '', newUrl);
	$.ajax({
		url: newUrl,
		method: "GET",
		success: function(response) {
			renderProducts(response.data);
			renderPagination(response.currentPage, response.totalPages)
		},
		error: function(xhr, status, error) {
			console.error("Lỗi: ", error);
		}
	});

}




