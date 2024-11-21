<%--
  Created by IntelliJ IDEA.
  User: ngoke
  Date: 5/15/2024
  Time: 10:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Quản lí số luợng tồn kho</title>
<link rel="stylesheet"
	href="//cdn.datatables.net/2.0.2/css/dataTables.dataTables.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<style>
.spinner {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

#table_id_wrapper {
	overflow-x: auto;
}

#table_id_wrapper {
	width: 100%;
	overflow-x: auto; /* Allow horizontal scrolling if necessary */
}

#table_id {
	width: 100%; /* Ensures table fills the container */
	table-layout: fixed; /* Ensures that columns take up fixed width */
}

.table-responsive {
	overflow-x: auto;
	-webkit-overflow-scrolling: touch;
	margin-bottom: 15px; /* Optional, for some spacing */
}
</style>
<body>
	<jsp:include page="admin_header.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row flex-nowrap">
			<div class="col-auto col-md-3 col-xl-2 px-sm-2 px-0 bg-dark">
				<div
					class="d-flex flex-column align-items-center align-items-sm-start px-3 pt-2 text-white min-vh-100">
					<a href="#"
						class="d-flex align-items-center pb-3 mb-md-0 me-md-auto text-white text-decoration-none">
						<span class="fs-5 d-none d-sm-inline">Danh mục </span>
					</a>
					<ul
						class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-center align-items-sm-start">
						<li class="nav-item"><a
							href="<%=request.getContextPath()%>/view/admin/admin_summary.jsp"
							class="nav-link align-middle px-0"> <i
								class="fa-solid fa-chart-simple"></i> <span
								class="ms-1 d-none d-sm-inline">Doanh thu</span>
						</a></li>
						<li><a
							href="<%=request.getContextPath()%>/view/admin/admin_product.jsp"
							class="nav-link px-0 align-middle" id="menu_0"> <i
								class="fa-brands fa-product-hunt"></i> <span
								class="ms-1 d-none d-sm-inline">Quản lí sản phẩm</span>
						</a></li>
						<li><a
							href="<%=request.getContextPath()%>/view/admin/admin_form_upload_product.jsp"
							class="nav-link px-0 align-middle" id="menu_1"> <i
								class="fa-solid fa-upload"></i> <span
								class="ms-1 d-none d-sm-inline">Thêm sản phẩm</span>
						</a></li>
						<li><a
							href="<%=request.getContextPath()%>/view/admin/admin_order.jsp"
							class="nav-link px-0 align-middle"> <i
								class="fa-solid fa-gift"></i> <span
								class="ms-1 d-none d-sm-inline">Quản lí đơn hàng</span>
						</a></li>
						<li><a
							href="<%=request.getContextPath()%>/view/admin/admin_user.jsp"
							class="nav-link px-0 align-middle"> <i
								class="fa-solid fa-user"></i> <span
								class="ms-1 d-none d-sm-inline">Quản lí người dùng</span>
						</a></li>
						<li><a
							href="<%=request.getContextPath()%>/view/admin/admin_inventory.jsp"
							class="nav-link px-0 align-middle"> <i
								class="fa-solid fa-warehouse"></i><span
								class="ms-1 d-none d-sm-inline">Quản lí số lượng tồn kho</span>
						</a></li>
						<li><a
							href="<%=request.getContextPath()%>/view/admin/admin_log.jsp"
							class="nav-link px-0 align-middle"> <i
								class="fa-solid fa-note-sticky"></i> <span
								class="ms-1 d-none d-sm-inline">Quản lí log</span>
						</a></li>
						<li><a
							href="<%=request.getContextPath()%>/view/admin/admin_image.jsp"
							class="nav-link px-0 align-middle"> <i
								class="fa-solid fa-image"></i> <span
								class="ms-1 d-none d-sm-inline">Quản lí ảnh</span>
						</a></li>
						<%
						if (session.getAttribute("user") != null) {
						%>
						<li><a href="<%=request.getContextPath()%>/admin_logout"
							class="nav-link px-0 align-middle"> <i
								class="fa-solid fa-door-open"></i><span
								class="ms-1 d-none d-sm-inline">Đăng xuất</span>
						</a></li>
						<%
						}
						%>
					</ul>


					<hr>
				</div>
			</div>


			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">First</th>
						<th scope="col">Last</th>
						<th scope="col">Handle</th>
					</tr>
				</thead>
				<tbody id="body">
					
				</tbody>
			</table>


			<!-- <div class="container-fluid">
				<div class="row flex-nowrap">
					<div class="col py-3" style="width: 70%">
						Thêm nút chọn giới tính
						<div class="d-flex align-items-center mb-3">
							<label for="gender" class="me-3">Giới tính:</label>
							<button class="btn btn-primary me-2" id="maleButton">Nam</button>
							<button class="btn btn-primary" id="femaleButton">Nữ</button>
						</div>

						Bảng dữ liệu
						<div class="table-responsive">
							<table id="table_id" class="table table-striped">
								<thead>
									<tr>
										<th>Mã sản phẩm</th>
										<th>Tên sản phẩm</th>
										<th>Danh mục</th>
										<th>Giá</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="body">
									Nội dung bảng
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div> -->

		</div>
	</div>
</body>
/Do_An_Web/src/main/webapp/js/admin/admin_product.js
<script type="text/javascript" src="../../js/admin/admin_product.js"></script>

<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="//cdn.datatables.net/2.0.2/js/dataTables.min.js"></script>
<script>
    $(document).ready(function () {
        $("#table_id").DataTable()
    })


    $(document).ready(function () {
        $('.dt-empty').hide();
    })
    var $tbody=$('#body')
    //hiển thị dữ liệu lên table
    $(document).ready(function(){
        var $spinner = $('<div class="spinner"><div class="d-flex justify-content-center"><div class="spinner-border" role="status"><span class="visually-hidden">Loading...</span></div></div></div>');
        $('body').append($spinner);

        function showSpinner() {
            $spinner.show();
        }

        function hideSpinner() {
            $spinner.hide();
        }

        showSpinner();
        $.ajax({
            url:
            	'<%=request.getContextPath()%>/gender?gender=nam',
									method : 'GET',
									dataType : 'JSON',
									success : function(response) {
										hideSpinner()
										renderProduct(response)

									},
									error : function(error) {
										alert('Lấy dữ liệu không thành công')
									}
								})
					})
</script>

</html>