<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
				<p style="color: white;">ECOMMERCE</p>
			</a>
		</div>
		<div class="shop-navbar">
			<ul class="nav-menu">

				<c:forEach items="${dropListCategory.keySet()}" var="categoryKey">
					<li class="nav-item">
						<!-- Category name --> <a href="/product/gender/nam"
						style="text-decoration: none; color: inherit;">
							${categoryKey.toUpperCase()} </a>
						<hr />

						<div class="subcategories" style="margin: 0; width: 30rem;">
							<!-- Loop through subcategories for this category -->
							<c:forEach items="${dropListCategory[categoryKey].keySet()}"
								var="subCategoryKey">
								<a>
									<p style="display: inline;">
										${subCategoryKey.toUpperCase()}</p>
								</a>
								<span onclick="toggleSubcategory('${subCategoryKey}')"
									style="color: red"> + </span>

								<!-- Extra subcategories (list items) -->
								<div id="subcategory${subCategoryKey}-extra"
									class="subcategory-extra"
									style="display: none; margin-left: 8%;">
									<c:forEach
										items="${dropListCategory[categoryKey][subCategoryKey]}"
										var="extraSubCategory">
										<a href="#" style="text-decoration: none;">
											<p>${extraSubCategory.toUpperCase()}</p>
										</a>
									</c:forEach>
								</div>
							</c:forEach>
						</div>
					</li>

					<span style="font-size: 2rem; margin-bottom: 2%;">|</span>
				</c:forEach>

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
					<c:forEach items="${listCartDetail}" var="item">
						<div class="offcanvas-body">
							<!-- Cart Item -->
							<div class="cart-item">
								<div class="cart-item-image">
									<img src="${item.image}" alt="Product Image" />
								</div>
								<div class="cart-item-details">
									<p class="cart-item-name">${item.name}</p>
									<p class="cart-item-description">${item.color},${item.size }</p>
									<div class="cart-item-actions">
										<span class="cart-item-quantity">SL: ${item.quantity }</span>
										<button class="remove-item-btn">
											<img src="https://via.placeholder.com/20x20"
												alt="Remove Icon">
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
				<div class="nav-cart-count">${quantityProduct}</div>
			</div>
		</div>
		<!-- Navbar placeholder -->
	</div>


	<script type="text/javascript">
    // Hàm để toggle (hiện/ẩn) mục con của subcategory 1
    function toggleSubcategory(subcategoryName) {
    const subcategory = document.getElementById('subcategory'+subcategoryName+'-extra');
   
    // Toggle hiển thị mục con của subcategory
    if (subcategory.style.display === "none" || subcategory.style.display === "") {
        subcategory.style.display = "block"; // Hiển thị
    } else {
        subcategory.style.display = "none"; // Ẩn
    }
    }
</script>


	<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const userIcon = document.querySelector('.user-icon');
	    const userOptions = document.querySelector('.user-options');

	    userIcon.addEventListener('click', function (event) {
	        event.stopPropagation(); // Ngăn chặn sự kiện click lan ra ngoài

	        // Toggle hiển thị menu
	        if (userOptions.style.display === 'flex') {
	            userOptions.style.display = 'none';
	            userOptions.style.opacity = '0';
	        } else {
	            userOptions.style.display = 'flex';
	            userOptions.style.opacity = '1';
	        }
	    });

	    // Đóng menu nếu click ra ngoài
	    document.addEventListener('click', function (event) {
	        // Kiểm tra nếu click ra ngoài userIcon và userOptions
	        if (!userIcon.contains(event.target) && !userOptions.contains(event.target)) {
	            userOptions.style.display = 'none';
	            userOptions.style.opacity = '0';
	        }
	    });
	});
</script>


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