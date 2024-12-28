

// Hàm cập nhật tổng tiền
function updateTotal() {
	let total = 0;
	const items = document.querySelectorAll('.select-item');

	// Duyệt qua tất cả các checkbox và tính tổng cho các sản phẩm được chọn
	items.forEach(item => {
		if (item.checked) {
			total += parseInt(item.getAttribute('data-price'), 10);
		}
	});

	// Cập nhật tổng tiền vào phần tử HTML
	document.getElementById('totalPrice').innerText = total.toLocaleString() +' đ';
}

function checkOut() {
	// Tạo mảng để lưu trữ các cartId đã chọn
	const selectedCartIds = [];

	// Lấy tất cả các checkbox của các sản phẩm
	const checkboxes = document.querySelectorAll(".select-item");

	// Lặp qua các checkbox
	checkboxes.forEach((checkbox) => {
		// Kiểm tra xem checkbox có được chọn hay không
		if (checkbox.checked) {
			// Nếu checkbox được chọn, thêm cartId vào mảng selectedCartIds
			const cartId = checkbox.closest('.cart-item').getAttribute('data-cart-id');
			selectedCartIds.push(cartId);
		}
	});

	// Kiểm tra xem có sản phẩm nào được chọn không
	if (selectedCartIds.length === 0) {
		alert("Vui lòng chọn ít nhất một sản phẩm để đặt hàng.");
		return;
	}

	// Mã hóa selectedCartIds dưới dạng JSON và encodeURIComponent
	const encodedSelectedCartIds = encodeURIComponent(JSON.stringify(selectedCartIds));

	// Chuyển hướng với dữ liệu đã mã hóa
	window.location.href = 'checkout?selectedCartIds=' + encodedSelectedCartIds;
}


// Hàm để chọn/bỏ chọn tất cả sản phẩm
function toggleSelectAll(selectAllCheckbox) {
	const items = document.querySelectorAll('.select-item');

	// Đặt trạng thái của tất cả các checkbox theo trạng thái của checkbox "Chọn tất cả"
	items.forEach(item => item.checked = selectAllCheckbox.checked);

	// Cập nhật tổng tiền sau khi chọn/bỏ chọn tất cả
	updateTotal();
}

// Hàm để kiểm tra và cập nhật trạng thái checkbox "Chọn tất cả"
function updateSelectAllStatus() {
	const items = document.querySelectorAll('.select-item');
	const selectAllCheckbox = document.getElementById('selectAll');

	// Kiểm tra xem tất cả các sản phẩm có được chọn hay không
	const allSelected = Array.from(items).every(item => item.checked);

	// Nếu tất cả các sản phẩm đều được chọn thì "Chọn tất cả" sẽ được chọn, ngược lại bỏ chọn
	selectAllCheckbox.checked = allSelected;
}

// Gọi hàm toggleSelectAll khi trang tải để kích hoạt chọn tất cả
document.addEventListener('DOMContentLoaded', function() {
	// Khởi động với trạng thái "Chọn tất cả" đã được chọn
	toggleSelectAll(document.getElementById('selectAll'));

	// Lắng nghe sự kiện thay đổi của các checkbox sản phẩm để cập nhật "Chọn tất cả"
	const items = document.querySelectorAll('.select-item');
	items.forEach(item => {
		item.addEventListener('change', updateSelectAllStatus);
	});
});

function closeModal() {
	const modal = document.getElementById('deleteConfirmationModal');
	const backdrop = document.querySelector('.modal-backdrop'); // Tìm phần nền đen

	// Loại bỏ lớp 'show' của modal và ẩn modal
	modal.classList.remove('show');
	modal.style.display = 'none';
	modal.setAttribute('aria-hidden', 'true');
	modal.setAttribute('aria-modal', 'false');

	// Xóa phần nền đen (modal-backdrop)
	if (backdrop) {
		backdrop.remove(); // Loại bỏ phần nền tối
	}
}

function openModal() {
	const modal = document.getElementById('deleteConfirmationModal');

	// Kiểm tra nếu modal-backdrop chưa tồn tại thì tạo mới
	let backdrop = document.querySelector('.modal-backdrop');
	if (!backdrop) {
		backdrop = document.createElement('div');
		backdrop.classList.add('modal-backdrop', 'fade', 'show'); // Tạo phần nền tối
		document.body.appendChild(backdrop); // Thêm nền tối vào body
	}

	modal.classList.add('show');  // Thêm lớp show vào modal để hiển thị
	modal.style.display = 'block';  // Đảm bảo modal hiển thị
	modal.setAttribute('aria-hidden', 'false');  // Modal có thể tương tác
	modal.setAttribute('aria-modal', 'true');  // Modal đang được mở
}

function changeQuantity(change, inputId) {
	var quantityInput = document.getElementById(inputId);
	var currentQuantity = parseInt(quantityInput.value);
	var cartId = inputId.split('_')[1];
	console.log('quantityInput: ' + currentQuantity);

	if (!isNaN(currentQuantity)) {
		var newQuantity = currentQuantity + change;

		if (newQuantity === 0) {
			// Lưu trữ cartId để sử dụng khi người dùng xác nhận xóa
			document.getElementById('confirmDeleteButton').setAttribute('data-cart-id', cartId);
			// Hiển thị modal xác nhận xóa
			openModal();
		} else if (newQuantity > 0) {
			quantityInput.value = newQuantity;
			window.location.href = 'cartdetail?action=update&&quantity=' + newQuantity + '&&cartId=' + cartId;
		}
	}
}
function deleteInCart(inputId){
	var cartId = inputId.split('_')[1];
	document.getElementById('confirmDeleteButton').setAttribute('data-cart-id', cartId);
	openModal();
}

function confirmDelete() {
	// Lấy cartId từ nút xác nhận xóa
	var cartId = document.getElementById('confirmDeleteButton').getAttribute('data-cart-id');

	// Lấy URL hiện tại và mã hóa nó để redirect
	var currentUrl = window.location.href;
	var encodedUrl = encodeURIComponent(currentUrl);

	// Thực hiện điều hướng đến hành động xóa
	window.location.href = 'cartdetail?action=remove&cartId=' + cartId + '&redirectUrl=' + encodedUrl;
}


