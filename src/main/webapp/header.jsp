<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="css/Navbar.css">
<link rel="stylesheet" href="css/SearchBar.css">
</head>
<body>
	<div class="hero" style="display: flex;">
		<div class="nav-header">
			<a href="/"
				style="text-decoration: none; color: inherit; z-index: 3; margin-top: 3.5rem; position: fixed; z-index: 9999;">
				<p style="color: white;">XUN_DON</p>
			</a>
		</div>
		<div class="shop-navbar">
			<ul class="nav-menu">
				<li class="nav-item"><a href="/product/gender/nam"
					style="text-decoration: none; color: inherit;">NAM</a>
					<hr />

					<div class="subcategories" style="margin: 0; width: 30rem;">
						<!-- SUBCATEGORY 1 -->
						<a href="javascript:void(0)" onclick="toggleSubcategory(1)"
							style="text-decoration: none;">
							<p style="display: inline;">SUBCATEGORY 1 +</p>
						</a>
						<!-- Container cho cÃ¡c má»¥c con cá»§a subcategory 1 -->
						<div id="subcategory1-extra" class="subcategory-extra"
							style="display: none; margin-left: 8%;">
							<a href="#" style="text-decoration: none;">
								<p>Extra Subcategory 1.1</p>
							</a> <a href="#" style="text-decoration: none;">
								<p>Extra Subcategory 1.2</p>
							</a>
						</div>

						<!-- SUBCATEGORY 2 -->
						<a href="javascript:void(0)" onclick="toggleSubcategory(2)"
							style="text-decoration: none;">
							<p>SUBCATEGORY 2 +</p>
						</a>
						<!-- Container cho cÃ¡c má»¥c con cá»§a subcategory 2 -->
						<div id="subcategory2-extra" class="subcategory-extra"
							style="display: none; margin-left: 8%;">
							<a href="#" style="text-decoration: none;">
								<p>Extra Subcategory 2.1</p>
							</a> <a href="#" style="text-decoration: none;">
								<p>Extra Subcategory 2.2</p>
							</a>
						</div>

						<!-- SUBCATEGORY 3 -->
						<a href="javascript:void(0)" onclick="toggleSubcategory(3)"
							style="text-decoration: none;">
							<p>SUBCATEGORY 3 +</p>
						</a>
						<!-- Container cho cÃ¡c má»¥c con cá»§a subcategory 3 -->
						<div id="subcategory3-extra" class="subcategory-extra"
							style="display: none; margin-left: 8%;">
							<a href="#" style="text-decoration: none;">
								<p>Extra Subcategory 3.1</p>
							</a> <a href="#" style="text-decoration: none;">
								<p>Extra Subcategory 3.2</p>
							</a>
						</div>
					</div></li>
				<span style="font-size: 2rem; margin-bottom: 2%;">|</span>
				<li class="nav-item"><a href="/product/gender/ná»¯"
					style="text-decoration: none; color: inherit;">Nữ</a>
					<hr />
					<div class="subcategories" style="margin: 0; width: 30rem;">
						<!-- SUBCATEGORY 4 -->
						<a href="javascript:void(0)" onclick="toggleSubcategory(4)"
							style="text-decoration: none;">
							<p style="display: inline;">SUBCATEGORY 4 +</p>
						</a>
						<!-- Container cho cÃ¡c má»¥c con cá»§a subcategory 4 -->
						<div id="subcategory4-extra" class="subcategory-extra"
							style="display: none; margin-left: 8%;">
							<a href="#" style="text-decoration: none;">
								<p>Extra Subcategory 4.1</p>
							</a> <a href="#" style="text-decoration: none;">
								<p>Extra Subcategory 4.2</p>
							</a>
						</div>

						<!-- SUBCATEGORY 5 -->
						<a href="javascript:void(0)" onclick="toggleSubcategory(5)"
							style="text-decoration: none;">
							<p>SUBCATEGORY 5 +</p>
						</a>
						<!-- Container cho cÃ¡c má»¥c con cá»§a subcategory 5 -->
						<div id="subcategory5-extra" class="subcategory-extra"
							style="display: none; margin-left: 8%;">
							<a href="#" style="text-decoration: none;">
								<p>Extra Subcategory 5.1</p>
							</a> <a href="#" style="text-decoration: none;">
								<p>Extra Subcategory 5.2</p>
							</a>
						</div>
					</div></li>
			</ul>
			<div class="nav-login-cart">
				<!-- Search bar -->
				<div class="search-bar"
					style="margin: 0.5px; border: none; border-bottom: 2px solid white; outline: none; background-color: transparent; display: flex; align-items: center;">
					<span style="font-size: 1rem; color: white;"><img
						src="./img/search.png" alt="" style="height: 20px;"></span>
					<!-- Search icon placeholder -->
					<input type="text" placeholder="Tìm kiếm"
						style="background: transparent; outline: none; border: none; color: white;">
				</div>

				<!-- User icon and hidden login/register options -->
				<div class="user-menu">
					<span class="user-icon"
						style="color: white; font-size: 2rem; cursor: pointer;"> <img
						src="./img/avatar.png" alt=""
						style="height: 30px; margin-top: 5%;">
					</span>
					<div class="user-options" style="display: none;">
						<button
							style="color: white; width: 100%; height: 40px; margin-bottom: 0.5rem; font-size: 15px; background-color: black;">
							Đăng nhập</button>
						<button
							style="color: black; width: 100%; height: 40px; font-size: 15px; background-color: white; border: 1px solid black">
							Đăng kí</button>
					</div>
				</div>


				<!-- Heart icon -->
				<div class="heart">
					<span style="color: white; font-size: 2rem; cursor: pointer;"><img
						src="./img/heart.png" alt="" style="height: 25px; opacity: 1;"></span>
				</div>

				<!-- Cart icon -->
				<div class="cart">
					<a href="#" data-bs-toggle="offcanvas"
						data-bs-target="#cartOffcanvas"> <span
						style="color: white; font-size: 2rem; cursor: pointer;"> <img
							src="./img/shopping-cart.png" alt=""
							style="height: 30px; padding-left: 15px;">
					</span>
					</a>
				</div>

				<!-- Offcanvas (cart frame) náº±m bÃªn pháº£i -->
				<div class="offcanvas offcanvas-end" tabindex="-1"
					id="cartOffcanvas" aria-labelledby="cartOffcanvasLabel">
					<div class="offcanvas-header">
						<h5 class="offcanvas-title" id="cartOffcanvasLabel">Giỏ hàng
							của tôi</h5>
						<button type="button" class="btn-close"
							data-bs-dismiss="offcanvas" aria-label="Close"></button>
					</div>
					<div class="offcanvas-body">
					
						<!-- Cart Item -->
						<c:forEach items="${listCartDetail}" var="item">
						<div class="cart-item">
							<div class="cart-item-image">
								<img src= "${item.image}"
									alt="Product Image" />
							</div>
							<div class="cart-item-details">
								<p class="cart-item-name">${item.name}</p>
								<p class="cart-item-description">${item.color} , ${item.size }</p>
								<div class="cart-item-actions">
									<span class="cart-item-quantity">SL: ${item.quantity }</span>
									<button class="remove-item-btn">
										<img src="https://via.placeholder.com/20x20" alt="Remove Icon">
									</button>
								</div>
							</div>
							<div class="cart-item-price">${item.price}</div>
						</div>
					</div>
					</c:forEach>
					<div class="offcanvas-footer">
						<button class="view-cart-btn">Xem giỏ hàng</button>
					</div>
				</div>



				<!-- Cart count -->
				<div class="nav-cart-count">${quantityProduct}</div>



			</div>
		</div>
		<!-- Navbar placeholder -->
	</div>

	<script>
    // Hàm để toggle (hiện/ẩn) mục con của subcategory 1
    function toggleSubcategory(subcategoryId) {
        const subcategory = document.getElementById(`subcategory${subcategoryId}-extra`);
        
        // Kiểm tra nếu mục con đang ẩn
        if (subcategory.style.display === "none") {
            subcategory.style.display = "block"; // Hiển thị mục con
        } else {
            subcategory.style.display = "none"; // Ẩn mục con
        }
    }
</script>


<!-- 	<script>
    document.addEventListener("DOMContentLoaded", function () {
        const userIcon = document.querySelector('.user-icon');
        const userOptions = document.querySelector('.user-options');

        userIcon.addEventListener('click', function () {
            // Toggle hiển thị menu
            if (userOptions.style.display === 'flex') {
                userOptions.style.display = 'none';
                userOptions.style.opacity = '0';
            } else {
                userOptions.style.display = 'flex';
                userOptions.style.opacity = '1';
            }
        });

        // Đóng menu nếu click ra bên ngoài
        document.addEventListener('click', function (event) {
            if (!userMenu.contains(event.target)) {
                userOptions.style.display = 'none';
                userOptions.style.opacity = '0';
            }
        });
    });
</script> -->


	<script>
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.shop-navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

    </script>
</body>
</html>