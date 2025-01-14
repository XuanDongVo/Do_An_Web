<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.nio.charset.StandardCharsets"%>
<!DOCTYPE html>
<html lang="en">

<head>
<title>Danh sách nhân viên | Quản trị Admin</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/admin/main.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/admin/admin_add_product.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
<!-- or -->
<link rel="stylesheet"
	href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/adding/bootstrap/boostrap.min.css">

<script
	src="${pageContext.request.contextPath}/adding/bootstrap/bootstrap.bundle.min.js"></script>


</head>


<body class="app sidebar-mini rtl">
	<!-- Navbar-->
	<header class="app-header">
		<!-- Sidebar toggle button-->
		<a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
			aria-label="Hide Sidebar"></a>
		<!-- Navbar Right Menu-->
		<ul class="app-nav">


			<li><a class="app-nav__item"
				href="${pageContext.request.contextPath}/logout"><i
					class='bx bx-log-out bx-rotate-180'></i> </a></li>
		</ul>
	</header>
	<!-- Sidebar menu-->
	<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
	<aside class="app-sidebar">
		<div class="app-sidebar__user">
			<div>
				<p class="app-sidebar__user-name">
					<b>${user.name}</b>
				</p>
				<p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
			</div>
		</div>
		<hr>
		<ul class="app-menu">
			<li><a class="app-menu__item"
				href="${pageContext.request.contextPath}/adminController"><i
					class='app-menu__icon bx bx-tachometer'></i><span
					class="app-menu__label">Bảng điều khiển</span></a></li>
			<li><a class="app-menu__item active"
				href="${pageContext.request.contextPath}/admin_employee"><i
					class='app-menu__icon bx bx-id-card'></i> <span
					class="app-menu__label">Quản lý nhân viên</span></a></li>
			<li><a class="app-menu__item"
				href="${pageContext.request.contextPath}/admin_customer"><i
					class='app-menu__icon bx bx-user-voice'></i><span
					class="app-menu__label">Quản lý khách hàng</span></a></li>
			<li><a class="app-menu__item "
				href="${pageContext.request.contextPath}/adminProduct"><i
					class='app-menu__icon bx bx-purchase-tag-alt'></i><span
					class="app-menu__label">Quản lý sản phẩm</span></a></li>
			<li><a class="app-menu__item "
				href="${pageContext.request.contextPath}/order"><i
					class='app-menu__icon bx bx-task'></i><span class="app-menu__label">Quản
						lý đơn hàng</span></a></li>
			<li><a class="app-menu__item "
				href="${pageContext.request.contextPath}/inventory"><i
					class='app-menu__icon bx bx-task'></i><span class="app-menu__label">Quản
						lý hàng tồn kho</span></a></li>
		</ul>
	</aside>

	<main class="app-content">
		<div class="container mt-5">
			<!-- Title -->
			<h2 class="text-center mb-4">Thêm nhân viên</h2>
			<c:if test="${not empty error}">
				<div class="alert alert-danger" role="alert">${error}</div>
			</c:if>
			<!-- Tab navigation -->
			<ul class="nav nav-tabs" id="productTab" role="tablist">
				<li class="nav-item">
					<button class="nav-link active" id="spu-tab" data-bs-toggle="tab"
						data-bs-target="#spu" type="button" role="tab">Thông Tin
						Nhân Viên</button>
				</li>
			</ul>

			<!-- Tab content -->
			<div class="tab-content mt-4" id="productTabContent">
				<div class="tab-pane fade show active" id="spu" role="tabpanel"
					aria-labelledby="spu-tab">
					<form
						action="${pageContext.request.contextPath}/add_employee_action"
						method="POST">
						<!-- <div class="mb-3">
							<label for="orderCode" class="form-label">Mã nhân viên</label> 
							<input
								type="text" class="form-control" id="id_employee" name="id_employee" 
								 >
						</div> -->
						<div class="mb-3">
							<label for="customerName" class="form-label">Email </label> <input
								type="text" class="form-control" id="email_employee"
								name="email_employee">
						</div>
						<div class="mb-3">
							<label for="orderDetails" class="form-label">Số điện
								thoại</label> <input type="number" class="form-control"
								id="phone_employee" name="phone_employee"
								oninput="this.value = this.value.slice(0, 11)">
						</div>
						<div class="mb-3">
							<label for="orderDetails" class="form-label">Địa chỉ</label> <input
								type="text" class="form-control" id="address_employee"
								name="address_employee">
						</div>
						<div class="mb-3">
							<label for="quantity" class="form-label">Mật khẩu</label> <input
								type="text" class="form-control" id="password_employee"
								name="password_employee">
						</div>
						<div class="mb-3">
							<label for="quantity" class="form-label">Tên nhân viên</label> <input
								type="text" class="form-control" id="name_employee"
								name="name_employee">
						</div>
						<div class="mb-3">
							<label for="role" class="form-label">Phân quyền</label> <select
								class="form-control" id="role" name="role_id" required>
								<option value="" disabled selected>-- Chọn vai trò --</option>
								<c:forEach items="${list_role}" var="role">
									<option value="${role.id}">${role.nameRole}</option>
								</c:forEach>
							</select>

						</div>

						<button type="submit" class="btn btn-primary" id="saveSpu">Thêm
							nhân viên</button>
					</form>
				</div>


			</div>
	</main>

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


	<script src="${pageContext.request.contextPath}/js/admin/main.js"></script>
	<%-- 	<script
		src="${pageContext.request.contextPath}/js/admin/admin_add_product.js"></script>

	<script type="text/javascript">
	
	
	
	// Lưu thông tin sản phẩm (SPU và SKU) dưới dạng JSON
	function saveProductSku() {
	    const product = JSON.stringify(productSpu);
	    // cập nhật lại 
	    productSpu = null;

	    // Tạo form ẩn và gửi dữ liệu
	    const form = document.createElement('form');
	    form.method = 'POST';
	    form.action = '<%=request.getContextPath()%>
		/adminAddProduct';

			const inputJson = document.createElement('input');
			inputJson.type = 'hidden';
			inputJson.name = 'product';
			inputJson.value = product;

			form.appendChild(inputJson);
			document.body.appendChild(form);
			form.submit();

		}
	</script> --%>


</body>
</html>

