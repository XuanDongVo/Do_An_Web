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
<!-- <script src="adding/jquery/jquery-3.4.1.min.js"></script>
    <script src="adding/poper/poper.min.js"></script>
    <script src="adding/bootstrap/boostrap.min.js"></script>  -->

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
				<form action="<%=request.getContextPath()%>/edit_profile">
					<div class="p-3 py-5">
						<div
							class="d-flex justify-content-between align-items-center mb-3">
							<h4 class="text-right">Sửa thông tin cá nhân</h4>
						</div>
						<div class="row mt-2">
							<div class="col-md-6">
								<label class="labels">Họ và Tên</label><input type="text"
									class="form-control" placeholder="${user.name}" value="${user.name}"
									name="username">
							</div>
						</div>
						<div class="row mt-3">
							<div class="col-md-12">
								<label class="labels">Số điện thoại</label><input type="number"
									class="form-control" placeholder="${user.phone}" value="${user.phone}"
									name="phone" oninput="this.value = this.value.slice(0, 9)">
							</div>
							<div class="col-md-12 mt-3">
								<label class="labels">Email</label><input type="text"
									class="form-control" placeholder="${user.email}" value="${user.email}"
									name="email" >
							</div>
							<div class="col-md-12 mt-3">
								<label class="labels">Địa chỉ</label><input type="text"
									class="form-control" placeholder="${user.address}" value="${user.address}"
									name="address">
							</div>

						</div>
						<div class="mt-3 text-center">
						<input type="hidden" name="userId" value="${user.id}">
							<button class="btn btn-primary profile-button" type="submit">Save
								Profile</button>
							<a href="<%=request.getContextPath()%>/profile"><button
									class="btn btn-primary profile-button" type="button">Cancle</button></a>
						</div>
					</div>
				</form>
			</div>


		</div>
	</div>
	</div>
	</div>

	<script>
		function validateForm(event) {
			// Lấy giá trị số điện thoại
			const phoneInput = document.querySelector('input[name="phone"]');
			const phone = phoneInput.value.trim();

			// Kiểm tra số điện thoại: chỉ chứa số và có độ dài từ 9-10 ký tự
			const phoneRegex = /^\d{9}$/;
			if (!phoneRegex.test(phone)) {
				alert("Số điện thoại phải chứa 9 chữ số kể từ số 0 đầu tiên!");
				event.preventDefault(); // Ngăn gửi form
				return false;
			}

			// Nếu hợp lệ, cho phép gửi form
			return true;
		}
	</script>
</body>
</html>