<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/Navbar_procate.css">
<link rel="stylesheet" href="css/Hero_procate.css">
<link rel="stylesheet" href="css/SearchBar.css">
<link rel="stylesheet" href="css/Popular.css">
<link rel="stylesheet" href="css/Item.css">
<link rel="stylesheet" href="css/NewCollections.css">
<link rel="stylesheet" href="css/NewLetter.css">
<link rel="stylesheet" href="css/Footer.css">
<link rel="stylesheet" href="css/Cate.css">
<link rel="stylesheet" href="css/Cart.css">


<!-- Bootstrap CSS -->
<link rel="stylesheet" href="adding/bootstrap/boostrap.min.css">
<!-- <script src="adding/jquery/jquery-3.4.1.min.js"></script>
    <script src="adding/poper/poper.min.js"></script>
    <script src="adding/bootstrap/boostrap.min.js"></script>  -->

<script src="adding/bootstrap/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="js/cart.js"></script>
</head>

<body>

	<jsp:include page="header.jsp"></jsp:include>


	<div class="cate-container container">
		<div class="cate-left">
			<div class="cate-left-breadcrumb"
				style="margin-left: 20px; margin-top: 12px; text-decoration: none;">
				<a href="#" style="text-decoration: none;"> <span
					class="breadcrumb"> Trang chủ > <span
						class="current-category"
						style="cursor: default; margin-left: 10px;">Giỏ hàng của
							tôi</span>
				</span>
				</a>
			</div>
		</div>
	</div>


	<div class="container mt-5">
		<div class="row">
			<!-- Cart Items Section -->
			<div class="left-cart col-md-8">
				<div class="cart-items">
					<div class="p-3 text-center">
						<span class="font-weight-bold">Giao Hàng</span>
					</div>
					<hr class="divider"
						style="margin: 0; height: 4px; background: black; opacity: 0.8" />

					<div class="cart-items pb-5 px-23 undefined"
						style="padding: 0px 24px">
						<!-- Checkbox để chọn tất cả -->
						<c:choose>
							<c:when test="${not empty cartDetailList}">
								<div
									style="display: flex; justify-content: flex-start; gap: 0.5rem; margin-top: 0.5rem;">
									<label class="select-all-wrapper"> <input
										type="checkbox" class="select-item-all" id="selectAll" checked
										onclick="toggleSelectAll(this)"> <span
										class="custom-checkbox"></span>
									</label> <br> <span class="select-all-label">Chọn tất cả</span>
								</div>
							</c:when>
						</c:choose>

						<c:choose>
							<c:when test="${not empty cartDetailList}">
								<c:forEach items="${cartDetailList}" var="detail">
									<div
										class="cart-item d-flex justify-content-between align-items-center  border-bottom">
										<!-- Checkbox cho mỗi sản phẩm -->
										<label class="select-item-wrapper"> <input
											type="checkbox" class="select-item"
											data-price="${detail.price * detail.quantity}" checked
											onclick="updateTotal()"> <span
											class="custom-checkbox"></span>
										</label>

										<div class="cart-item-image ml-5">
											<img src="${detail.image}" alt="Product Image"
												class="img-fluid" />
										</div>
										<div class="cart-item-details ml-3">
											<p class="cart-item-name mb-0">${detail.name}</p>
											<p class="cart-item-description text-muted mb-2">${detail.color},
												${detail.size}</p>
											<div class="cart-item-actions">
												<div class="quantity-container">
													<button class="btn-quantity"
														onclick="changeQuantity(-1, 'quantity_${detail.cartId}')">-</button>
													<input type="text" class="item-quantity text-center"
														id="quantity_${detail.cartId}" value="${detail.quantity}"
														readonly="readonly">
													<button class="btn-quantity"
														onclick="changeQuantity(1, 'quantity_${detail.cartId}')">+</button>
												</div>
											</div>
										</div>


										<div class="cart-item-price font-weight-bold">${detail.price * detail.quantity}đ</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div
									style="height: 120px; display: flex; align-items: center; justify-content: center; flex-direction: column; padding: 0px 23px; text-align: center;">
									Bạn chưa có sản phẩm nào trong giỏ hàng</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>


			<!-- Total Summary Section -->
			<div class="col-md-4">
				<div class="total-summary">
					<p class="mb-2 font-weight-bold">Tổng đơn hàng:</p>
					<h4 class="total-price mb-2" id="totalPrice">0đ</h4>
					<button class="btn btn-dark btn-block mt-1"
						style="margin-right: 0.25rem">ĐẶT HÀNG</button>
					<a href="home" class="btn btn-outline-dark btn-block mt-1">TIẾP
						TỤC MUA SẮM</a>
				</div>
			</div>
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
			<p>© 2023 by Shoppee. Proudly created with Wix.com</p>
		</div>
	</div>
</body>

</html>