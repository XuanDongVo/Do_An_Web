<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<<<<<<< HEAD
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.nio.charset.StandardCharsets"%>
=======
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
>>>>>>> 66771eb (commit all)
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
<<<<<<< HEAD
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/admin/admin_add_product.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
<!-- or -->
<link rel="stylesheet"
	href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
=======

>>>>>>> 66771eb (commit all)

<!-- Font-icon css-->
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<<<<<<< HEAD
<!-- <link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"> -->

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/adding/bootstrap/boostrap.min.css">
=======
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
<%-- <link rel="stylesheet"
	href="${pageContext.request.contextPath}/adding/bootstrap/boostrap.min.css"> --%>
>>>>>>> 66771eb (commit all)

<script
	src="${pageContext.request.contextPath}/adding/bootstrap/bootstrap.bundle.min.js"></script>

<<<<<<< HEAD

</head>


=======
</head>

>>>>>>> 66771eb (commit all)
<body onload="time()" class="app sidebar-mini rtl">
	<!-- Navbar-->
	<header class="app-header">
		<!-- Sidebar toggle button-->
		<a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
			aria-label="Hide Sidebar"></a>
		<!-- Navbar Right Menu-->
		<ul class="app-nav">


			<!-- User Menu-->
			<li><a class="app-nav__item" href="/index.html"><i
					class='bx bx-log-out bx-rotate-180'></i> </a></li>
		</ul>
	</header>
	<!-- Sidebar menu-->
	<div class="app-sidebar__overlay" data-toggle="sidebar"></div>
	<aside class="app-sidebar">
		<div class="app-sidebar__user">
			<div>
				<p class="app-sidebar__user-name">
<<<<<<< HEAD
					<b>Võ Trường</b>
=======
					<b>${user.name}</b>
>>>>>>> 66771eb (commit all)
				</p>
				<p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
			</div>
		</div>
<<<<<<< HEAD
		<hr>
=======
>>>>>>> 66771eb (commit all)
		<ul class="app-menu">
			<li><a class="app-menu__item"
				href="${pageContext.request.contextPath}/adminController"><i
					class='app-menu__icon bx bx-tachometer'></i><span
					class="app-menu__label">Bảng điều khiển</span></a></li>
<<<<<<< HEAD
			<li><a class="app-menu__item "
=======
			<li><a class="app-menu__item active"
>>>>>>> 66771eb (commit all)
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
<<<<<<< HEAD

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
=======
	<main class="app-content">
		<div class="app-title">
			<ul class="app-breadcrumb breadcrumb side">
				<li class="breadcrumb-item active"><a href="#"><b>Danh
							sách khách hàng</b></a></li>
			</ul>
			<div id="clock"></div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="tile">
					<div class="tile-body">
						<div class="row element-button">
							<div class="col-sm-2">
								<c:if test="${sessionScope.role == 'ADMIN'}">
									<a class="btn btn-add btn-sm"
										href="${pageContext.request.contextPath}/addEmployeeView"
										title="Thêm"><i class="fas fa-plus"></i> Thêm nhân viên</a>
								</c:if>

							</div>
							<c:if test="${not empty error}">
								<div class="alert alert-danger" role="alert">${error}</div>
							</c:if>
						</div>
						<table class="table table-hover table-bordered" id="sampleTable">
							<thead>
								<tr>
									<th>Mã nhân viên</th>
									<th>Email</th>
									<th>Số điện thoại</th>
									<th>Tên khách hàng</th>
									<th>Địa chỉ</th>
									<th>Ngày tạo</th>
									<th>Phân quyền</th>
								</tr>
							</thead>
							<tbody>
								<form
									action="${pageContext.request.contextPath}/delete_employee"
									method="POST">
									<c:if test="${not empty error}">
										<div class="alert alert-danger" role="alert">${error}</div>
									</c:if>
									<c:forEach items="${list_employee}" var="employee">
										<tr>
											<td>${employee.user_id}</td>
											<!-- Input ẩn để lưu `user_id` -->
											<input type="hidden" name="user_id"
												value="${employee.user_id}">
											<td>${employee.email}</td>
											<td>${employee.phone}</td>
											<td>${employee.user_name}</td>
											<td>${employee.address}</td>
											<td>${employee.create_at}</td>
											<td>${employee.role_name}</td>
											<td>
												<c:if test="${sessionScope.role == 'ADMIN'}">
												<button class="btn btn-primary btn-sm trash" type="submit"
													title="Xóa">
													<i class="fas fa-trash-alt"></i>
												</button>
												</c:if>
											</td>
										</tr>
									</c:forEach>
								</form>
							</tbody>
						</table>
>>>>>>> 66771eb (commit all)
					</div>
				</div>
			</div>
		</div>
<<<<<<< HEAD
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
=======
	</main>

	<!-- Modal -->
	<div class="modal fade" id="deleteConfirmationModal" tabindex="-1"
		aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close">
						<i class="fas fa-times"></i>
					</button>
				</div>
				<div class="modal-body">Bạn có chắc chắn muốn xóa sản phẩm này
					không?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Hủy bỏ</button>
					<button type="button" class="btn btn-danger" id="confirmDelete">Xóa</button>
				</div>
			</div>
		</div>
	</div>



	<script src="${pageContext.request.contextPath}/js/admin/main.js"></script>
	<script
		src="${pageContext.request.contextPath}/js/admin/admin_product.js"></script>

	<script type="text/javascript">
		//Thời Gian
		function time() {
			var today = new Date();
			var weekday = new Array(7);
			weekday[0] = "Chủ Nhật";
			weekday[1] = "Thứ Hai";
			weekday[2] = "Thứ Ba";
			weekday[3] = "Thứ Tư";
			weekday[4] = "Thứ Năm";
			weekday[5] = "Thứ Sáu";
			weekday[6] = "Thứ Bảy";
			var day = weekday[today.getDay()];
			var dd = today.getDate();
			var mm = today.getMonth() + 1;
			var yyyy = today.getFullYear();
			var h = today.getHours();
			var m = today.getMinutes();
			var s = today.getSeconds();
			m = checkTime(m);
			s = checkTime(s);
			nowTime = h + " giờ " + m + " phút " + s + " giây";
			if (dd < 10) {
				dd = '0' + dd
			}
			if (mm < 10) {
				mm = '0' + mm
			}
			today = day + ', ' + dd + '/' + mm + '/' + yyyy;
			tmp = '<span class="date"> ' + today + ' - ' + nowTime + '</span>';
			document.getElementById("clock").innerHTML = tmp;
			clocktime = setTimeout("time()", "1000", "Javascript");

			function checkTime(i) {
				if (i < 10) {
					i = "0" + i;
				}
				return i;
			}
		}
	</script>

</body>

</html>
>>>>>>> 66771eb (commit all)
