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
<title>Thêm Sản Phẩm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">


<style type="text/css">
table {
	width: 100%;
	border-collapse: collapse;
}

table td, table th {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center; /* Căn giữa ngang */
	vertical-align: middle; /* Căn giữa dọc */
}

table th {
	background-color: #f4f4f4;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="container mt-5">
		<!-- Title -->
		<h2 class="text-center mb-4">Thêm Sản Phẩm</h2>

		<!-- Tab navigation -->
		<ul class="nav nav-tabs" id="productTab" role="tablist">
			<li class="nav-item">
				<button class="nav-link active" id="spu-tab" data-bs-toggle="tab"
					data-bs-target="#spu" type="button" role="tab">Thông Tin
					Sản Phẩm (SPU)</button>
			</li>
			<li class="nav-item">
				<button class="nav-link disabled" id="sku-tab" data-bs-toggle="tab"
					data-bs-target="#sku" type="button" role="tab">Thông Tin
					Biến Thể (SKU)</button>
			</li>
			<li class="nav-item">
				<button class="nav-link disabled" id="detail-sku-tab"
					data-bs-toggle="tab" data-bs-target="#detailsku" type="button"
					role="tab">Chi tiết Biến Thể (SKU)</button>
			</li>
		</ul>

		<!-- Tab content -->
		<div class="tab-content mt-4" id="productTabContent">
			<!-- SPU Form -->
			<div class="tab-pane fade show active" id="spu" role="tabpanel"
				aria-labelledby="spu-tab">
				<form id="spuForm">
					<div class="mb-3">
						<label for="productName" class="form-label">Tên Sản Phẩm</label> <input
							type="text" class="form-control" id="productName" name="name"
							required>
					</div>
					<div class="mb-3">
						<label for="productDescription" class="form-label">Mô Tả
							Sản Phẩm</label>
						<textarea class="form-control" id="productDescription"
							name="description" rows="3" required></textarea>
					</div>
					<div class="mb-3">
						<label for="productType" class="form-label">Loại Sản Phẩm</label>
						<select class="form-select" id="productType"
							name="product_type_id" required>
							<option value="">Chọn loại sản phẩm</option>
							<option value="1">Thời Trang Nam</option>
							<option value="2">Thời Trang Nữ</option>
						</select>
					</div>

					<div class="mb-3">
						<label for="subCategory" class="form-label">Danh Mục </label> <select
							class="form-select" id="subCategory" name="subCatgory" required>
							<option value="">Chọn danh mục</option>
							<option value="1">Áo thun Nam</option>
							<option value="2">Quần Jean</option>
						</select>
					</div>

					<button type="button" class="btn btn-primary" id="saveSpu">Lưu
						Thông Tin SPU</button>
				</form>
			</div>

			<!-- SKU Form -->
			<div class="tab-pane fade" id="sku" role="tabpanel"
				aria-labelledby="sku-tab">
				<form id="skuForm">
					<div class="mb-3">
						<label for="productColor" class="form-label">Màu Sắc</label> <select
							class="form-select" id="productColor" name="color" required>
							<option value="">Chọn màu sắc</option>
							<option value="Đỏ">Đỏ</option>
							<option value="Xanh">Xanh</option>
							<option value="Đen">Đen</option>
						</select>
					</div>
					<div class="mb-3">
						<label for="productImage" class="form-label">Hình Ảnh Sản
							Phẩm</label> <input type="file" class="form-control" id="productImage"
							name="product_color_img" accept="image/*" required>
					</div>
					<div class="mb-3">
						<label for="productSize" class="form-label">Kích Thước</label> <select
							class="form-select" id="productSize" name="size" required>
							<option value="">Chọn kích thước</option>
							<option value="S">S</option>
							<option value="M">M</option>
							<option value="L">L</option>
						</select>
					</div>
					<div class="mb-3">
						<label for="productPrice" class="form-label">Giá</label> <input
							type="number" class="form-control" id="productPrice" name="price"
							required>
					</div>
					<div class="mb-3">
						<label for="productStock" class="form-label">Số Lượng Tồn
							Kho</label> <input type="number" class="form-control" id="productStock"
							name="stock" required>
					</div>
					<button type="button" class="btn btn-success" id="addSku">Thêm
						SKU</button>
					<button type="button" class="btn btn-success fade" id="detailSku">Chi
						tiết SKU</button>
				</form>

				<!-- Temporary SKU Table -->
				<h5 class="mt-4">Danh Sách SKU</h5>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Màu</th>
							<th>Hình Ảnh</th>
							<th>Kích Thước</th>
							<th>Số Lượng</th>
							<th>Hành Động</th>
						</tr>
					</thead>
					<tbody id="skuTableBody">
						<!-- Dữ liệu SKU sẽ được thêm vào đây -->
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<%-- <div class="tab-pane fade" id="detailsku" role="tabpanel"
		aria-labelledby="detail-sku-tab">
		<div class="container ">
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
					<h6 id="color-name">Màu sắc:
						${product.productSkus[0].color.toUpperCase()}</h6>


					<div class="color-options d-flex mt-3 mb-3">
						<c:forEach items="${product.productSkus}" var="sku">
							<button class="btn btn-outline-primary color-btn"
								style="background-color: ${sku.color};"
								onclick="selectImage('${sku.img}', '${fn:escapeXml(sku.sizeAndStock)}' , '${sku.color}')" /></button>
						</c:forEach>
					</div>
				</div>
				<!-- Label cho bảng -->
				<h5>Bảng Size và Số lượng</h5>
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
	</div> --%>


	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Custom JS -->
	<script>
        let productSpu =null;

        document.getElementById('saveSpu').addEventListener('click', function () {
            const isValid = document.getElementById('spuForm').reportValidity();
            if (isValid) {
            	
            	// Lấy thông tin từ form
                const productName = document.getElementById('productName').value;
                const productDescription = document.getElementById('productDescription').value;
                const productTypeId = document.getElementById('productType').value;
                const subCategoryId = document.getElementById('subCategory').value;

                // Tạo đối tượng sản phẩm SPU
                productSpu = {
                    name: productName,
                    description: productDescription,
                    productTypeId: productTypeId,
                    subCategoryId: subCategoryId,
                    skus: [] // Mảng lưu thông tin SKU
                };
            
                // Enable SKU tab and switch to it
                document.getElementById('sku-tab').classList.remove('disabled');
                new bootstrap.Tab(document.getElementById('sku-tab')).show();
            }
        });

        document.getElementById('addSku').addEventListener('click', function () {
            const form = document.getElementById('skuForm');
            if (form.reportValidity()) {
                const color = document.getElementById('productColor').value;
                const fileInput = document.getElementById('productImage');
                const imageFile = fileInput.files[0];
                const size = document.getElementById('productSize').value;
                const stock = parseInt(document.getElementById('productStock').value);

                if (imageFile) {
                    const reader = new FileReader();
                    reader.onload = function (event) {
                        const base64Image = event.target.result;

                        // Kiểm tra sản phẩm đã tồn tại
                        const existingProductColorImg = productSpu.skus.find(
                            sku => sku.image === base64Image && sku.color === color
                        );

                        if (existingProductColorImg) {
                            // Nếu tồn tại, thêm size và stock
                            existingProductColorImg.sizeAndStock.push({ size, stock });
                        } else {
                            // Nếu chưa có, tạo mới
                            const productColorImg = {
                                image: base64Image, // Ảnh dưới dạng Base64
                                color: color,
                                sizeAndStock: [{ size, stock }]
                            };
                            productSpu.skus.push(productColorImg);
                        }

                        // Cập nhật nút và bảng
                        updateDetailButton();
                        renderSkuTable();
                    };

                    reader.readAsDataURL(imageFile);
                } else {
                    alert("Vui lòng chọn hình ảnh!");
                }
            }
        });

        // Hàm hiển thị nút "Chi tiết SKU" nếu có sản phẩm
        function updateDetailButton() {
            const detailButton = document.getElementById('detailSku');
            if (productSpu.skus && productSpu.skus.length > 0) {
                detailButton.classList.remove('fade'); // Hiển thị nút
            } else {
                detailButton.classList.add('fade'); // Ẩn nút
            }
        }

        // Hàm render bảng SKUs
        function renderSkuTable() {
            const tableBody = document.getElementById('skuTableBody');
            tableBody.innerHTML = ''; // Xóa nội dung cũ

            productSpu.skus.forEach(productColorImg => {
                productColorImg.sizeAndStock.forEach((sizeStock, index) => {
                    const row = document.createElement('tr');

                    // Chỉ thêm cột color và image ở hàng đầu tiên
                    if (index === 0) {
                        const colorCell = document.createElement('td');
                        colorCell.rowSpan = productColorImg.sizeAndStock.length;
                        colorCell.textContent = productColorImg.color;
                        row.appendChild(colorCell);

                        const imageCell = document.createElement('td');
                        imageCell.rowSpan = productColorImg.sizeAndStock.length;
                        const imgElement = document.createElement('img');
                        imgElement.src = productColorImg.image;
                        imgElement.alt = "Product Image";
                        imgElement.style.width = "50px"; // Tùy chỉnh kích thước
                        imgElement.style.height = "50px";
                        imageCell.appendChild(imgElement);
                        row.appendChild(imageCell);
                    }

                    // Thêm cột size, stock và nút xóa
                    const sizeCell = document.createElement('td');
                    sizeCell.textContent = sizeStock.size;
                    row.appendChild(sizeCell);

                    const stockCell = document.createElement('td');
                    stockCell.textContent = sizeStock.stock;
                    row.appendChild(stockCell);

                    const actionCell = document.createElement('td');
                    const deleteButton = document.createElement('button');
                    deleteButton.textContent = 'Xóa';
                    deleteButton.className = 'btn btn-danger btn-sm';
                    deleteButton.addEventListener('click', function () {
                        deleteSizeAndStock(productColorImg, sizeStock);
                    });

                    actionCell.appendChild(deleteButton);
                    row.appendChild(actionCell);

                    tableBody.appendChild(row);
                });
            });
            console.log(productSpu);	
        }

        // Hàm xóa size và stock
        function deleteSizeAndStock(productColorImg, sizeStock) {
            const sizeIndex = productColorImg.sizeAndStock.indexOf(sizeStock);
            productColorImg.sizeAndStock.splice(sizeIndex, 1);

            // Nếu không còn sizeAndStock, xóa toàn bộ productColorImg
            if (productColorImg.sizeAndStock.length === 0) {
                const skuIndex = productSpu.skus.indexOf(productColorImg);
                productSpu.skus.splice(skuIndex, 1);
            }

            // Cập nhật giao diện
            updateDetailButton();
            renderSkuTable();
        }

      

        
   


    </script>
</body>
</html>


