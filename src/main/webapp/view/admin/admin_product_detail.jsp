<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ProductDetail</title>

<link rel="stylesheet" href="css/admin/admin_product_detail.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="adding/bootstrap/boostrap.min.css">

<script src="adding/bootstrap/bootstrap.bundle.min.js"></script>
</head>
<body>

	<!-- Button trigger modal -->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#staticBackdrop">Launch static backdrop modal
	</button>

	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel">Chi tiết
						sản phẩm</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<div class="container ">
						<c:set value="${productResponse}" var="product" />
						<div class="row">
							<!-- Left Section: Image Gallery -->
							<div class="col-md-4">
								<div class="main-image mb-3">
									<img id="mainImage" src="${product.productSkus[0].img}"
										alt="${product.name}" class="img-fluid" style="width: 100%;">
								</div>
							</div>

							<!-- Right Section: Product Info -->
							<div class="col-md-8">
								<h2 id="productTitle">${product.name}</h2>
								<p>
									<span class="productPrice"><fmt:formatNumber
											value="${product.price}" pattern="#,###" /> đ</span>
								</p>

								<!-- Color Options -->
								 <h6 id="color-name">Màu sắc: ${product.productSkus[0].color.toUpperCase()}</h6>


								<div class="color-options d-flex mt-3 mb-3">
									<c:forEach items="${product.productSkus}" var="sku">
										<button class="btn btn-outline-primary color-btn"
											style="background-color: ${sku.color};"
											onclick="selectImage('${sku.img}', '${fn:escapeXml(sku.sizeAndStock)}' , '${sku.color}')" /></button>
									</c:forEach>
								</div>
							</div>
							<!-- Label cho bảng -->
							<h5 >Bảng Size và Số lượng</h5>
							<!-- Bảng hiển thị size và quantity -->
							<div class="table-responsive mt-3">
								<table class="table table-striped table-hover table-bordered"
									style="max-width: 600px;">
									<thead class="table-primary text-center">
										<tr>
											<th scope="col">Size</th>
											<th scope="col">Số lượng</th>
										</tr>
									</thead>
									<tbody id="sizeTableBody">
										<c:forEach items="${product.productSkus[0].sizeAndStock}"
											var="entry">
											<tr class="text-center">
												<td>${fn:toUpperCase(entry.key)}</td>
												<td>${entry.value}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript" src="js/admin/admin_product.js"></script>

</body>
</html>