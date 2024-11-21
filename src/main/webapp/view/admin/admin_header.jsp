<%--
  Created by IntelliJ IDEA.
  User: ngoke
  Date: 3/9/2024
  Time: 9:24 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Header</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>
	<!--admin header-->
	<section class="container-fluid bg-dark text-white">
		<div class="row flex-row justify-content-between align-items-start">
			<div class="col-4 p-2 text-start text-white">Quản trị Admin</div>
			<div class="col-auto text-end">
				<div class="dropdown">
					<a href="#"
						class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
						id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
						<img src="https://github.com/mdo.png" alt="hugenerd" width="30"
						height="30" class="rounded-circle me-2"> <span
						class="d-none d-sm-inline">Admin</span> <!-- Tên đăng nhập -->
					</a>
					<ul
						class="dropdown-menu dropdown-menu-dark text-small shadow dropdown-menu-end">
						<li><a class="dropdown-item" href="#">Chỉnh sửa hồ sơ</a></li>
						<li><a class="dropdown-item" href="#">Đăng xuất</a></li>
					</ul>
				</div>
			</div>
		</div>
	</section>



</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<script>
	
</script>
</html>