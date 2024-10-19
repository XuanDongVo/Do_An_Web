<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/Navbar.css">
<link rel="stylesheet" href="css/Hero.css">
<link rel="stylesheet" href="css/SearchBar.css">
<link rel="stylesheet" href="css/Popular.css">
<link rel="stylesheet" href="css/Item.css">
<link rel="stylesheet" href="css/NewCollections.css">
<link rel="stylesheet" href="css/NewLetter.css">
<link rel="stylesheet" href="css/Footer.css">


<!-- Bootstrap CSS -->
<link rel="stylesheet" href="adding/bootstrap/boostrap.min.css">
<!-- <script src="./adding/jquery/jquery-3.4.1.min.js"></script>
    <script src="./adding/poper/poper.min.js"></script>
    <script src="./adding/bootstrap/boostrap.min.js"></script>  -->

<script src="adding/bootstrap/bootstrap.bundle.min.js"></script>

</head>

<body>
	<!-- BEGIN nav -->
	<jsp:include page="header.jsp"></jsp:include>
	<!-- END nav -->


	<!-- Popular -->
	<!-- <div class="container-fluid popular mt-5" style="margin-top: 8%;">
        <h1>POPULAR IN WOMEN</h1>
        <hr />
        <div class="popular-item">
            CÃ¡c item sáº£n pháº©m sáº½ ÄÆ°á»£c láº·p á» ÄÃ¢y
            <div class="shop-item">
                <a href="/product/1">
                    Thay Äá»i `1` thÃ nh ID sáº£n pháº©m thá»±c táº¿
                    <img src="./img/p1_product_i1.png" alt="Product Image" style="width: 100%;"
                        onclick="window.scrollTo(0, 0)" />
                </a>
                <p>Product Name</p>
                <div class="item-prices">
                    <div class="item-price-new">
                        GiÃ¡ sáº£n pháº©m má»i
                        $100
                    </div>
                </div>
            </div>

            <div class="shop-item">
                <a href="/product/1">
                    Thay Äá»i `1` thÃ nh ID sáº£n pháº©m thá»±c táº¿
                    <img src="./img/p1_product_i1.png" alt="Product Image" style="width: 100%;"
                        onclick="window.scrollTo(0, 0)" />
                </a>
                <p>Product Name</p>
                <div class="item-prices">
                    <div class="item-price-new">
                        GiÃ¡ sáº£n pháº©m má»i
                        $100
                    </div>
                </div>
            </div>

            <div class="shop-item">
                <a href="/product/1">
                    Thay Äá»i `1` thÃ nh ID sáº£n pháº©m thá»±c táº¿
                    <img src="./img/p1_product_i1.png" alt="Product Image" style="width: 100%;"
                        onclick="window.scrollTo(0, 0)" />
                </a>
                <p>Product Name</p>
                <div class="item-prices">
                    <div class="item-price-new">
                        GiÃ¡ sáº£n pháº©m má»i
                        $100
                    </div>
                </div>
            </div>
            ThÃªm sáº£n pháº©m khÃ¡c náº¿u cÃ³
        </div>
    </div> -->


	<!-- Collections -->
	<div class="container new-collections mt-5">
		<h1>NEW COLLECTIONS</h1>

		<hr />

		<div class="collections">
			<div class="collection-item">
				<a href="/product/1">
					<div class="image-container">
						<img class="image-main" src="img/product_1.png"
							alt="Product 1 Image" /> <img class="image-hover"
							src="img/product_1.png" alt="Product 1 Hover Image" /> <img
							src="img/add.png" alt="" class="plus">
					</div>
					<div class="size-container">
						<div class="size-options">
							<button class="size-btn">S</button>
							<button class="size-btn">M</button>
							<button class="size-btn">L</button>
							<button class="size-btn">XL</button>
						</div>
					</div>
				</a>
				<div class="image-cate">
					<img src="./img/product_25.png" alt="" onclick="selectImage(this)">
					<img src="./img/product_26.png" alt="" onclick="selectImage(this)">
					<img src="./img/product_27.png" alt="" onclick="selectImage(this)">
				</div>
				<p>Product 1 Name</p>
				<div class="item-price-new">$100</div>
			</div>

		</div>
	</div>
	  <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Chọn tất cả các biểu tượng plus
            const plusIcons = document.querySelectorAll('.collection-item .plus');

            plusIcons.forEach(function (plus) {
                plus.addEventListener('click', function (event) {
                    event.preventDefault(); // Ngăn hành động mặc định nếu có

                    // Tìm phần tử cha .collection-item
                    const collectionItem = plus.closest('.collection-item');

                    // Tìm .size-container trong .collection-item này
                    const sizeContainer = collectionItem.querySelector('.size-container');

                    // Đóng tất cả các size-container khác
                    document.querySelectorAll('.size-container.active').forEach(function (container) {
                        if (container !== sizeContainer) {
                            container.classList.remove('active');
                        }
                    });

                    // Toggle lớp 'active' để hiển thị/ẩn
                    sizeContainer.classList.toggle('active');
                });
            });

            // Đóng size-container khi nhấp ra ngoài
            document.addEventListener('click', function (event) {
                plusIcons.forEach(function (plus) {
                    const collectionItem = plus.closest('.collection-item');
                    const sizeContainer = collectionItem.querySelector('.size-container');

                    // Nếu click không phải là trong .collection-item, đóng size-container
                    if (!collectionItem.contains(event.target)) {
                        sizeContainer.classList.remove('active');
                    }
                });
            });

            // Thêm sự kiện cho nút đóng
            const closeButtons = document.querySelectorAll('.size-container .close-btn');

            closeButtons.forEach(function (btn) {
                btn.addEventListener('click', function (event) {
                    event.stopPropagation(); // Ngăn sự kiện lan truyền
                    btn.closest('.size-container').classList.remove('active');
                });
            });

            // Xử lý chọn size
            const sizeButtons = document.querySelectorAll('.size-btn');

            sizeButtons.forEach(function (btn) {
                btn.addEventListener('click', function () {
                    // Xóa lớp 'selected' khỏi tất cả các nút trong cùng size-container
                    const sizeContainer = btn.closest('.size-container');
                    const buttons = sizeContainer.querySelectorAll('.size-btn');
                    buttons.forEach(function (button) {
                        button.classList.remove('selected');
                    });

                    // Thêm lớp 'selected' vào nút được nhấp
                    btn.classList.add('selected');
                });
            });
        });
    </script>
    <script>
        function selectImage(img) {
            // Xóa class 'selected' khỏi tất cả các hình ảnh
            const images = document.querySelectorAll('.image-cate img');
            images.forEach(image => {
                image.classList.remove('selected');
            });
    
            // Thêm class 'selected' cho hình ảnh đã được chọn
            img.classList.add('selected');
        }
    </script>
	<style>
/* Page */
.pagination {
	display: flex;
	justify-content: center;
	/* CÄn giá»¯a thanh phÃ¢n trang */
	margin-top: 20px;
	/* Khoáº£ng cÃ¡ch phÃ­a trÃªn */
}

.pagination a {
	color: black;
	/* MÃ u cho cÃ¡c nÃºt */
	padding: 8px 16px;
	/* Khoáº£ng cÃ¡ch trong cÃ¡c nÃºt */
	text-decoration: none;
	/* Bá» gáº¡ch chÃ¢n */
	margin: 0 5px;
	/* Khoáº£ng cÃ¡ch giá»¯a cÃ¡c nÃºt */
	border: 1px solid black;
	/* ÄÆ°á»ng viá»n */
	border-radius: 5px;
	/* Bo trÃ²n cÃ¡c gÃ³c */
	transition: background-color 0.3s;
	/* Hiá»u á»©ng chuyá»n mÃ u */
}

.pagination a:hover {
	background-color: #999999;
	/* MÃ u ná»n khi hover */
	color: white;
	/* MÃ u chá»¯ khi hover */
}

.pagination a.active {
	background-color: #999999;
	/* MÃ u ná»n cho trang hiá»n táº¡i */
	color: white;
	/* MÃ u chá»¯ cho trang hiá»n táº¡i */
}
</style>


	<!-- Pagination -->
	<div class="pagination"> 
		<a href="#">&laquo;</a>
		<!-- NÃºt trÆ°á»c -->
		<a href="#" class="active">1</a>
		<!-- Trang hiá»n táº¡i -->
		<a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a>
		<a href="#">&raquo;</a>
		<!-- NÃºt tiáº¿p theo -->
	</div>

	<!-- New Letter -->

	<div class="container newsletter mt-5">
		<h1>Get Exclusive Ofers On You Email</h1>
		<p>Subscribe to our newletter and say updated</p>
		<div>
			<input type="email" placeholder='Your Email' />
			<button>Subscibe</button>
		</div>
	</div>


	<!-- Footer -->
	<div class="footer">
		<div class="footer-logo">
			<img src="footer_logo.png" alt="" />
			<p>SHOPPEE</p>
		</div>
		<ul class="footer-links">
			<li>Company</li>
			<li>Products</li>
			<li>Offices</li>
			<li>About</li>
			<li>Contact</li>
		</ul>
		<div class="footer-social-icon">
			<div class="footer-icons-container">
				<img src="instagram.png" alt="" />
			</div>
			<div class="footer-icons-container">
				<img src="pinterest.png" alt="" />
			</div>
			<div class="footer-icons-container">
				<img src="whatsapp.png" alt="" />
			</div>
		</div>
		<div class="footer-copyright">
			<hr />
			<p>Â© 2023 by Shoppee. Proudly created with Wix.com</p>
		</div>
	</div>

</body>
<!-- ThÃªm jQuery tá»« CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- ThÃªm Bootstrap JS tá»« CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>



</html>