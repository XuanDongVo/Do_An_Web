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
<script type="text/javascript" src="js/product_collection.js"></script>

</head>

<body>
	<!-- BEGIN nav -->
	<jsp:include page="header.jsp"></jsp:include>
	<!-- END nav -->

	<!-- Collections -->
	<div class="container new-collections mt-5">
		<h1>NEW COLLECTIONS</h1>
		<hr />
		<div class="collections">
			<c:forEach items="${listResponses}" var="product">
				<div class="collection-item">
					<a href="/product/${product.productId}">
						<div class="image-container">
							<img id="image-main" class="image-main"
								src="${product.productSkus[0].img}" alt="${product.name} Image" />
							<img id="image-hover" class="image-hover"
								src="${product.productSkus[0].img}"
								alt="${product.name} Hover Image" /> <img src="img/add.png"
								alt="" class="plus" />
						</div>
					</a>
					<div class="size-container">
						<div class="size-options" id="size-options">
							<c:choose>
								<c:when test="${product.typeProduct == 'áo'}">
									<c:set var="sizeString" value="s,m,l,xl,xxl" />
								</c:when>
								<c:when test="${product.typeProduct == 'quần'}">
									<c:set var="sizeString" value="28,29,30,31,32" />
								</c:when>
							</c:choose>
							<c:set var="sizeList" value="${fn:split(sizeString, ',')}" />

							<c:forEach items="${sizeList}" var="size">
								<c:set var="stock"
									value="${product.productSkus[0].sizeAndStock[size]}" />
								<c:choose>
									<c:when test="${stock != null && stock > 0}">
										<button class="size-btn"
											onclick="addProductToCart('${product.productSkus[0].productColorImgId}', '${size}', '1')">
											${size.toUpperCase()}</button>
									</c:when>
									<c:otherwise>
										<button class="size-btn size-unavailable">
											${size.toUpperCase()}</button>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>

					<div class="image-cate">
						<c:forEach items="${product.productSkus}" var="sku"
							varStatus="status">
							<img src="${sku.img}" alt="${sku.color} Image"
								onclick="selectImage('${sku.productColorImgId}', '${sku.img}', '${fn:escapeXml(sku.sizeAndStock)}', '${product.typeProduct}')" />
						</c:forEach>
					</div>

					<p>${product.name}</p>
					<div class="item-price-new">$${product.price}</div>
				</div>
			</c:forEach>
		</div>
	</div>


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