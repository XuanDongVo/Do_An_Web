<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Profile</title>

<link rel="stylesheet" href="css/Navbar_procate.css">
<link rel="stylesheet" href="css/Hero_procate.css">
<link rel="stylesheet" href="css/SearchBar.css">


<!-- Bootstrap CSS -->
<link rel="stylesheet" href="adding/bootstrap/boostrap.min.css">

<script src="adding/bootstrap/bootstrap.bundle.min.js"></script>


</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container rounded bg-white mt-5 mb-5">
		<div class="row">
			<div class="col-md-6 border-right">
				<div
					class="d-flex flex-column align-items-center text-center p-3 py-5">
					<img class="rounded-circle mt-5" width="150px"
						src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"><span
						class="font-weight-bold">${user.name}</span><span
						class="text-black-50">${user.email}</span><span> </span>
				</div>
			</div>
			<div class="col-md-6 border-right">
				<div class="p-3 py-5">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h4 class="text-right">Thông tin profile</h4>
					</div>
					<div class="row mt-2">
						<div class="col-md-6">
							<label class="labels">Họ và Tên</label><input type="text"
								class="form-control" placeholder="${user.name}" value=""
								readonly>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-md-12">
							<label class="labels">Số điện thoại</label><input type="text"
								class="form-control" placeholder="${user.phone}" value=""
								readonly>
						</div>
						<div class="col-md-12 mt-3">
							<label class="labels">Email</label><input type="text"
								class="form-control" placeholder="${user.email}" value=""
								readonly>
						</div>
						<div class="col-md-12 mt-3">
							<label class="labels">Địa chỉ</label><input type="text"
								class="form-control" placeholder="${user.address}" value=""
								readonly>
						</div>

					</div>
					<div class="mt-3 text-center">
						<a href="<%=request.getContextPath()%>/edit_profile_view"><button
								class="btn btn-primary profile-button" type="button">Edit
								Profile</button></a>
					</div>
				</div>
			</div>

		</div>
	</div>
	<script src="js/cate_filter.js"></script>
	<script src="js/product_collection.js"></script>
</body>
</html>