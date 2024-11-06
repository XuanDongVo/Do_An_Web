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
	document.getElementById('totalPrice').innerText = total.toLocaleString() + 'đ';
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


function changeQuantity(change, inputId) {
	var quantityInput = document.getElementById(inputId);
	var currentQuantity = parseInt(quantityInput.value);
	// Extract cartId from inputId (e.g., 'quantity_123' => '123')
	var cartId = inputId.split('_')[1];

	if (!isNaN(currentQuantity)) {
		var newQuantity = currentQuantity + change;

		if (newQuantity == 0) {
			// Lấy URL hiện tại
			var currentUrl = window.location.href;
			// Mã hóa URL hiện tại để có thể truyền an toàn qua request
			var encodedUrl = encodeURIComponent(currentUrl);
			window.location.href = 'cartdetail?action=remove&cartId=' + cartId + '&redirectUrl=' + encodedUrl;
		}
		// Ensure that the quantity is not less than 1
		if (newQuantity > 0) {
			quantityInput.value = newQuantity;
			window.location.href = 'cartdetail?action=update&&quantity=' + newQuantity + '&&cartId=' + cartId;
		}
	}
}

// Hàm này được gọi mỗi khi người dùng thay đổi giá trị trong input (input thay cho onchange)
function validateAndUpdateQuantity(event, cartId) {
	const inputElement = event.target; // Tham chiếu đến input hiện tại
	let newQuantity = parseInt(inputElement.value, 10);

	// Nếu giá trị không phải là một số hợp lệ hoặc nhỏ hơn hoặc bằng 0
	if (isNaN(newQuantity) || newQuantity <= 0) {
		console.log("error")
	} else {
	window.location.href = 'cartdetail?action=update&&quantity=' + newQuantity + '&&cartId=' + cartId;
	}
}