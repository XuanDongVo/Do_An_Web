<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<title>Danh sách đơn hàng | Quản trị Admin</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Main CSS-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/admin/main.css">

<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
</head>

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
					<b>Võ Trường</b>
				</p>
				<p class="app-sidebar__user-designation">Chào mừng bạn trở lại</p>
			</div>
		</div>
		<hr>
		<ul class="app-menu">
			<li><a class="app-menu__item "
				href="${pageContext.request.contextPath}/view/admin/admin.jsp"><i
					class='app-menu__icon bx bx-tachometer'></i><span
					class="app-menu__label">Bảng điều khiển</span></a></li>
			<li><a class="app-menu__item " href="table-data-table.html"><i
					class='app-menu__icon bx bx-id-card'></i> <span
					class="app-menu__label">Quản lý nhân viên</span></a></li>
			<li><a class="app-menu__item" href="#"><i
					class='app-menu__icon bx bx-user-voice'></i><span
					class="app-menu__label">Quản lý khách hàng</span></a></li>
				<li><a class="app-menu__item "
				href="${pageContext.request.contextPath}/adminProduct"><i
					class='app-menu__icon bx bx-purchase-tag-alt'></i><span
					class="app-menu__label">Quản lý sản phẩm</span></a></li>
			<li><a class="app-menu__item active"
				href="${pageContext.request.contextPath}/view/admin/admin_order.jsp"><i
					class='app-menu__icon bx bx-task'></i><span class="app-menu__label">Quản
						lý đơn hàng</span></a></li>
		</ul>
	</aside>
	<main class="app-content">
		<div class="app-title">
			<ul class="app-breadcrumb breadcrumb side">
				<li class="breadcrumb-item active"><a href="#"><b>Danh
							sách sản phẩm</b></a></li>
			</ul>
			<div id="clock"></div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="tile">
					<div class="tile-body">
						<div class="row element-button">
							<div class="col-sm-2">
								<a class="btn btn-add btn-sm"
									href="<%=request.getContextPath()%>/adminAddProduct?action=view"
									title="Thêm"><i class="fas fa-plus"></i> Tạo mới sản phẩm</a>
							</div>
						</div>
						<table class="table table-hover table-bordered" id="sampleTable">
							<thead>
								<tr>
									<th width="10"><input type="checkbox" id="all"></th>
									<th>ID đơn hàng</th>
									<th>Khách hàng</th>
									<th>Đơn hàng</th>
									<th>Số lượng</th>
									<th>Tổng tiền</th>
									<th>Tình trạng</th>
									<th>Tính năng</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td width="10"><input type="checkbox" name="check1"
										value="1"></td>
									<td>MD0837</td>
									<td>Triệu Thanh Phú</td>
									<td>Ghế làm việc Zuno, Bàn ăn gỗ Theresa</td>
									<td>2</td>
									<td>9.400.000 đ</td>
									<td><span class="badge bg-success">Hoàn thành</span></td>
									<td><button class="btn btn-primary btn-sm trash"
											type="button" title="Xóa">
											<i class="fas fa-trash-alt"></i>
										</button>
										<button class="btn btn-primary btn-sm edit" type="button"
											title="Sửa">
											<i class="fa fa-edit"></i>
										</button></td>
								</tr>
								<tr>
									<td width="10"><input type="checkbox" name="check1"
										value="1"></td>
									<td>MĐ8265</td>
									<td>Nguyễn Thị Ngọc Cẩm</td>
									<td>Ghế ăn gỗ Lucy màu trắng</td>
									<td>1</td>
									<td>3.800.000 đ</td>
									<td><span class="badge bg-success">Hoàn thành</span></td>
									<td><button class="btn btn-primary btn-sm trash"
											type="button" title="Xóa">
											<i class="fas fa-trash-alt"></i>
										</button>
										<button class="btn btn-primary btn-sm edit" type="button"
											title="Sửa">
											<i class="fa fa-edit"></i>
										</button></td>
								</tr>
								<tr>
									<td width="10"><input type="checkbox" name="check1"
										value="1"></td>
									<td>MT9835</td>
									<td>Đặng Hoàng Phúc</td>
									<td>Giường ngủ Jimmy, Bàn ăn mở rộng cao cấp Dolas, Ghế
										làm việc Zuno</td>
									<td>3</td>
									<td>40.650.000 đ</td>
									<td><span class="badge bg-success">Hoàn thành</span></td>
									<td><button class="btn btn-primary btn-sm trash"
											type="button" title="Xóa">
											<i class="fas fa-trash-alt"></i>
										</button>
										<button class="btn btn-primary btn-sm edit" type="button"
											title="Sửa">
											<i class="fa fa-edit"></i>
										</button></td>
								</tr>
								<tr>
									<td width="10"><input type="checkbox" name="check1"
										value="1"></td>
									<td>ER3835</td>
									<td>Nguyễn Thị Mỹ Yến</td>
									<td>Bàn ăn mở rộng Gepa</td>
									<td>1</td>
									<td>16.770.000 đ</td>
									<td><span class="badge bg-info">Chờ thanh toán</span></td>
									<td><button class="btn btn-primary btn-sm trash"
											type="button" title="Xóa">
											<i class="fas fa-trash-alt"></i>
										</button>
										<button class="btn btn-primary btn-sm edit" type="button"
											title="Sửa">
											<i class="fa fa-edit"></i>
										</button></td>
								</tr>
								<tr>
									<td width="10"><input type="checkbox" name="check1"
										value="1"></td>
									<td>AL3947</td>
									<td>Phạm Thị Ngọc</td>
									<td>Bàn ăn Vitali mặt đá, Ghế ăn gỗ Lucy màu trắng</td>
									<td>2</td>
									<td>19.770.000 đ</td>
									<td><span class="badge bg-warning">Đang giao hàng</span></td>
									<td><button class="btn btn-primary btn-sm trash"
											type="button" title="Xóa">
											<i class="fas fa-trash-alt"></i>
										</button>
										<button class="btn btn-primary btn-sm edit" type="button"
											title="Sửa">
											<i class="fa fa-edit"></i>
										</button></td>
								</tr>
								<tr>
									<td width="10"><input type="checkbox" name="check1"
										value="1"></td>
									<td>QY8723</td>
									<td>Ngô Thái An</td>
									<td>Giường ngủ Kara 1.6x2m</td>
									<td>1</td>
									<td>14.500.000 đ</td>
									<td><span class="badge bg-danger">Đã hủy</span></td>
									<td><button class="btn btn-primary btn-sm trash"
											type="button" title="Xóa">
											<i class="fas fa-trash-alt"></i>
										</button>
										<button class="btn btn-primary btn-sm edit" type="button"
											title="Sửa">
											<i class="fa fa-edit"></i>
										</button></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</main>

	<script src="${pageContext.request.contextPath}/js/admin/main.js"></script>

	<script>
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