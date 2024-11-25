<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thêm Sản Phẩm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet" href="adding/bootstrap/boostrap.min.css">

<script src="adding/bootstrap/bootstrap.bundle.min.js"></script>

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

.color-options, .size-options {
	display: flex;
	flex-flow: row wrap;
	min-width: 0;
}

.w-7 {
	width: 2.25rem !important;
}

.h-7 {
	height: 2.25rem !important;
}

.mb-2 {
	margin-bottom: .5rem !important;
}

.ellipsis-t {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	font-size: 1rem; /* Tăng nhẹ kích thước chữ cho dễ đọc */
}

.ellipsis-t {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.font-medium {
	font-weight: 500 !important;
}

.text-xs {
	font-size: 1rem !important;
	line-height: 1rem !important;
	font-style: normal;
}

.text-center {
	text-align: center !important;
}

.w-full {
	width: 100% !important;
}

.p-2\.5 {
	padding: .625rem !important;
}

.border-border {
	/* border-color: gray !important; */
	border: 0 solid #e5e7eb;
}

.border-\[1px\] {
	border-width: 1px !important;
}

.justify-center {
	justify-content: center !important;
}

.items-center {
	align-items: center !important;
}

.flex-col {
	flex-direction: column !important;
}

.cursor-pointer {
	cursor: pointer !important;
}

.flex {
	display: flex !important;
}

.min-w-\[400px\] {
	min-width: 400px !important;
	max-height: 500px !important;
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
							name="description" rows="3"></textarea>
					</div>

					<div class="mb-3">
						<label for="productType" class="form-label">Loại Sản Phẩm</label>
						<select class="form-select" id="productType" name="product_type"
							required onchange="updateSubCategory(this)">
							<option value="">Chọn loại sản phẩm</option>
							<c:forEach var="entry" items="${genderToSubCategoryMap}">
								<option value="${entry.key}"
									data-type-subCatgory="${fn:escapeXml(entry.value)}">${entry.key}</option>
							</c:forEach>
						</select>
					</div>

					<div class="mb-3">
						<label for="subCategory" class="form-label">Danh Mục</label> <select
							class="form-select" id="subCategory" name="subCatgory" required
							disabled>
							<option value="">Chọn danh mục</option>
						</select>
					</div>

					<div class="mb-3">
						<label for="price" class="form-label">Giá tiền</label> <input
							type="number" class="form-control" id="productPrice" name="price"
							required min="0" step="any">

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
						<label for="productColor" class="form-label">Màu sắc</label> <select
							class="form-select" id="productColor" name="productColor"
							required>
							<option value="">Chọn màu sắc</option>
							<c:forEach items="${colors}" var="color">
								<option value="${color.name}">${color.name}</option>
							</c:forEach>
						</select>
					</div>


					<div class="mb-3">
						<label for="productImage" class="form-label">URL hình ảnh
							sản phẩm</label> <input type="text" class="form-control"
							id="productImage" name="product_color_img"
							placeholder="Nhập URL hình ảnh sản phẩm" required>
					</div>

					<div class="mb-3">
						<label for="productSizeType" class="form-label">Loại sản
							phẩm</label> <select class="form-select" id="productSizeType" name="size"
							required onchange="updateSize(this)">
							<option value="">Chọn loại quần áo</option>
							<c:forEach var="entry" items="${sizeMap}">
								<option value="${entry.key}"
									data-type-size="${fn:escapeXml(entry.value)}">${entry.key}</option>
							</c:forEach>

						</select>
					</div>

					<div class="mb-3">
						<label for="productSize" class="form-label">Kích Thước</label> <select
							class="form-select" id="productSize" name="size" required
							disabled>
							<option value="">Chọn kích thước</option>

						</select>
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
				<button type="button" class="btn btn-success fade" id="saveSku"
					onclick="saveProductSku()">Lưu sản phẩm</button>
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

	<c:if test="${not empty message}">
		<div class="modal fade" id="message" tabindex="-1"
			aria-labelledby="outOfStockModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="outOfStockModalLabel">Thông báo</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<p>${fn:escapeXml(URLDecoder.decode(message, StandardCharsets.UTF_8.toString()))}</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Đóng</button>
					</div>
				</div>
			</div>
		</div>
	</c:if>

	<!-- Custom JS -->
	<script>
	
	 // Lấy các phần tử
    const productType = document.getElementById('productType');
    const subCategory = document.getElementById('subCategory');
    const  productSizeType =document.getElementById('productSizeType');
    const  productSize =document.getElementById('productSize');

    // Lắng nghe sự kiện thay đổi trên productType
    productType.addEventListener('change', function () {
        if (productType.value) {
            subCategory.disabled = false; // Bật subCategory nếu đã chọn loại sản phẩm
        } else {
            subCategory.disabled = true;  // Vô hiệu hóa subCategory nếu chưa chọn loại sản phẩm
            subCategory.value = "";       // Đặt lại giá trị danh mục
        }
    });
    
 // Lắng nghe sự kiện thay đổi trên subCategory
    productSizeType.addEventListener('change', function () {
        if (productSizeType.value) {
        	productSize.disabled = false;  // Bật productSize nếu đã chọn danh mục
        } else {
        	productSize.disabled = true;   // Vô hiệu hóa productSize nếu chưa chọn danh mục
        	productSize.value = "";        // Đặt lại giá trị kích thước
        }
    });
 
    window.onload = function() {
        const modalElement = document.getElementById('message');
        if (modalElement) {
            const modal = new bootstrap.Modal(modalElement);
            modal.show();  // Hiển thị modal nếu nó tồn tại
        }
    };
	
	
        let productSpu =null;

        document.getElementById('saveSpu').addEventListener('click', function () {
            const isValid = document.getElementById('spuForm').reportValidity();
            if (isValid) {
            	
            	// Lấy thông tin từ form
                const productName = document.getElementById('productName').value;
                const productDescription = document.getElementById('productDescription').value;
                const productTypeId = document.getElementById('productType').value;
                const subCategory = document.getElementById('subCategory').value;
                const productPrice = document.getElementById('productPrice').value;

                // Tạo đối tượng sản phẩm SPU
                productSpu = {
                    name: productName,
                    subCategory:subCategory,
                    price:productPrice,
                    description: productDescription,
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
                const imageUrl = document.getElementById('productImage').value; // Get the URL input
                const size = document.getElementById('productSize').value;
                const stock = parseInt(document.getElementById('productStock').value);

                if (imageUrl) {
                    // Hiển thị ảnh trong giao diện người dùng (nếu cần)
                    const imagePreview = document.getElementById('imagePreview');
                    if (imagePreview) {
                        imagePreview.src = imageUrl; // Use the URL directly
                        imagePreview.style.display = 'block';
                    }

                    // Kiểm tra sản phẩm đã tồn tại
                    const existingProductColorImg = productSpu.skus.find(
                        sku => sku.color === color && sku.image === imageUrl // Compare with the URL
                    );

                    if (existingProductColorImg) {
                        // Nếu tồn tại, thêm size và stock vào sizeAndStock (là đối tượng)
                        existingProductColorImg.sizeAndStock[size] = stock;
                    } else {
                        // Nếu chưa có, tạo mới
                        const productColorImg = {
                            color: color,
                            image: imageUrl, // Lưu URL thay vì đối tượng file
                            sizeAndStock: {
                                [size]: stock
                            }
                        };
                        productSpu.skus.push(productColorImg);
                    }

                    // Cập nhật nút và bảng
                    updateDetailButton();
                    renderSkuTable();
                } else {
                    alert("Vui lòng chọn hình ảnh!");
                }
            }
        });



        // Hàm hiển thị nút "Chi tiết SKU" nếu có sản phẩm
        function updateDetailButton() {
            const detailButton = document.getElementById('detailSku');
            const sacveButton = document.getElementById('saveSku');
            
            if (productSpu.skus && productSpu.skus.length > 0) {
                detailButton.classList.remove('fade'); // Hiển thị nút
                saveSku.classList.remove('fade'); // Hiển thị nút
            } else {
                detailButton.classList.add('fade'); // Ẩn nút
                saveSku.classList.add('fade'); // Ẩn nút
            }
        }

        // Hàm render bảng SKUs
      function renderSkuTable() {
    const tableBody = document.getElementById('skuTableBody');
    tableBody.innerHTML = ''; // Xóa nội dung cũ

    productSpu.skus.forEach(productColorImg => {
        // Lặp qua sizeAndStock bằng Object.entries
        Object.entries(productColorImg.sizeAndStock).forEach(([size, stock], index) => {
            const row = document.createElement('tr');

            // Thêm cột color và image chỉ ở hàng đầu tiên
            if (index === 0) {
                const colorCell = document.createElement('td');
                colorCell.rowSpan = Object.keys(productColorImg.sizeAndStock).length;
                colorCell.textContent = productColorImg.color;
                row.appendChild(colorCell);

                const imageCell = document.createElement('td');
                imageCell.rowSpan = Object.keys(productColorImg.sizeAndStock).length;
                const imgElement = document.createElement('img');

                // Kiểm tra nếu image là đối tượng File, dùng URL.createObjectURL
                if (productColorImg.image instanceof File) {
                    imgElement.src = URL.createObjectURL(productColorImg.image);
                } else {
                    // Nếu là chuỗi (Base64 hoặc URL), gán trực tiếp
                    imgElement.src = productColorImg.image;
                }

                imgElement.alt = "Product Image";
                imgElement.style.width = "50px";
                imgElement.style.height = "50px";
                imageCell.appendChild(imgElement);
                row.appendChild(imageCell);
            }

            // Thêm cột size, stock và nút xóa
            const sizeCell = document.createElement('td');
            sizeCell.textContent = size;
            row.appendChild(sizeCell);

            const stockCell = document.createElement('td');
            stockCell.textContent = stock;
            row.appendChild(stockCell);

            const actionCell = document.createElement('td');
            const deleteButton = document.createElement('button');
            deleteButton.textContent = 'Xóa';
            deleteButton.className = 'btn btn-danger btn-sm';
            deleteButton.addEventListener('click', function () {
                deleteSizeAndStock(productColorImg, size);
            });

            actionCell.appendChild(deleteButton);
            row.appendChild(actionCell);

            tableBody.appendChild(row);
        });
    });

}



        // Hàm xóa size và stock
     function deleteSizeAndStock(productColorImg, size) {
    delete productColorImg.sizeAndStock[size];  // Xóa size và stock khỏi đối tượng

    // Nếu không còn sizeAndStock, xóa toàn bộ productColorImg
    if (Object.keys(productColorImg.sizeAndStock).length === 0) {
        const skuIndex = productSpu.skus.indexOf(productColorImg);
        productSpu.skus.splice(skuIndex, 1);
    }

    // Cập nhật giao diện
    updateDetailButton();
    renderSkuTable();
}

        
     function saveProductSku() {
    	    // Chuyển đối tượng productSpu thành JSON
    	    let product = JSON.stringify(productSpu);

    	    // Tạo form ẩn để gửi dữ liệu qua POST
    	    let form = document.createElement('form');
    	    form.method = 'POST';
    	    form.action = '<%=request.getContextPath()%>/adminAddProduct';  

    	    // Tạo input ẩn để lưu dữ liệu JSON
    	    let inputJson = document.createElement('input');
    	    inputJson.type = 'hidden';
    	    inputJson.name = 'product';  // Tên tham số mà server sẽ nhận
    	    inputJson.value = product;
    	  
    	    // Thêm các input vào form
    	    form.appendChild(inputJson);

    	    // Thêm form vào body và gửi đi
    	    document.body.appendChild(form);
    	    form.submit();
    	}



    </script>
	<script>
   
</script>

	<script type="text/javascript">

	function updateSubCategory(selectElement) {
	    const subCategorySelect = document.getElementById('subCategory');
	    const selectedOption = selectElement.options[selectElement.selectedIndex];

	    // Reset danh sách danh mục
	    subCategorySelect.innerHTML = '<option value="">Chọn danh mục</option>';
	    subCategorySelect.disabled = true;

	    // Lấy danh sách danh mục từ thuộc tính data-type-subCatgory
	    let subCategories = selectedOption.getAttribute('data-type-subCatgory');
	    if (subCategories) {
	        // Loại bỏ dấu ngoặc vuông và khoảng trắng thừa
	        subCategories = subCategories.replace(/[\[\]"]+/g, '').trim();
	        
	        // Tách chuỗi thành mảng theo dấu phẩy
	        const subCategoryList = subCategories.split(',').map(item => item.trim());

	        subCategoryList.forEach(subCategory => {
	            const option = document.createElement('option');
	            option.value = subCategory;
	            option.textContent = subCategory;
	            subCategorySelect.appendChild(option);
	        });
	        
	        subCategorySelect.disabled = false;
	    }
	}
	
	function updateSize(selectElement) {
	    const sizeSelect = document.getElementById('productSize');
	    const selectedOption = selectElement.options[selectElement.selectedIndex];

	    // Reset danh sách kích thước
	    sizeSelect.innerHTML = '<option value="">Chọn kích thước</option>';
	    sizeSelect.disabled = true;

	    // Lấy danh sách kích thước từ thuộc tính data-type-size
	    let sizes = selectedOption.getAttribute('data-type-size');
	    if (sizes) {
	    	 // Loại bỏ dấu ngoặc vuông và khoảng trắng thừa
	        sizes = sizes.replace(/[\[\]"]+/g, '').trim();
	        // Xử lý chuỗi kích thước thành mảng
	        const sizeList = sizes.split(',').map(item => item.trim());

	        // Thêm các kích thước vào select
	        sizeList.forEach(size => {
	            const option = document.createElement('option');
	            option.value = size;
	            option.textContent = size;
	            sizeSelect.appendChild(option);
	        });
	        
	        sizeSelect.disabled = false;
	    }
	}
	


</script>
</body>
</html>


