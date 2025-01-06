<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
					<a href="productDetail?id=${product.productId}">
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
								onclick="selectImage(this,'${sku.productColorImgId}', '${sku.img}', '${fn:escapeXml(sku.sizeAndStock)}', '${product.typeProduct}')" />
						</c:forEach>
					</div>
					<div class="item-price-new">
						<fmt:formatNumber value="${product.price}" pattern="#,###" />
						đ
					</div>
					<p class="product-name">
						<strong><a href="productDetail?id=${product.id}">
								${product.name}</a></strong>
					</p>

				</div>
			</c:forEach>
		</div>
	</div>



	<div class="container newsletter mt-5">
		<h1>Get Exclusive Ofers On You Email</h1>
		<p>Subscribe to our newletter and say updated</p>
		<div>
			<input type="email" placeholder='Your Email' />
			<button>Subscibe</button>
		</div>
	</div>


	<jsp:include page="footer.jsp"></jsp:include>

</body>
<!-- ThÃªm jQuery tá»« CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- ThÃªm Bootstrap JS tá»« CDN -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>



</html>