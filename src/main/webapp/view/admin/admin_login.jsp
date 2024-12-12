<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.login-card {
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	padding: 30px;
	width: 400px;
}

.login-header {
	background-color: #9c27b0;
	color: white;
	padding: 15px;
	text-align: center;
	border-radius: 10px 10px 0 0;
}

.btn-purple {
	background-color: #9c27b0;
	color: white;
}

.btn-purple:hover {
	background-color: #7b1fa2;
}
</style>
</head>
<body>
	<div class="login-card">
		<div class="login-header">
			<h3>Admin Login</h3>
		</div>
		<form action="<%=request.getContextPath()%>/adminLogin" method="post">
			<div class="mb-3 mt-3">
				<label for="phone" class="form-label">Nhập số diện thoại</label> <input
					type="text" class="form-control" id="phone" name="phone"
					placeholder="Your Phone Number +84" maxlength="9" required>
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">Nhập mật khẩu</label> <input
					type="password" class="form-control" id="password" name="password"
					required> <c:if test="${not empty message }">
				<div class="text-danger">Vui lòng nhập mật khẩu hợp lệ.</div>
				</c:if>
			</div>
			<div class="d-flex justify-content-between align-items-center mb-3">
				<a href="#" class="text-decoration-none text-purple">Forget
					Password?</a>
			</div>
			<button type="submit" class="btn btn-purple w-100">Submit</button>
		</form>
	</div>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
