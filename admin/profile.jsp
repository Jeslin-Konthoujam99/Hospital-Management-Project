<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ page import = "java.util.*"%>
	<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
body {
	padding: 70px;
	background-color: #f8f9fa;
}
</style>
<body>
	
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card shadow">
					<div class="card-header">
						<h2>My Profile</h2>
						<p class="text-muted">ID: <%=session.getAttribute("id") %></p>
					</div>
					<div class="card-body">
					<div class="row">
						<div class="col-md-6">
							<label for="name" class="form-label">Username</label>
							<input type="text" class="form-control" id="name" value="<%=session.getAttribute("username") %>" readonly>
						</div>
						<div class="col-md-6">
							<label for="email" class="form-label">Password</label>
							<input type="email" class="form-control" id="email" value="<%=session.getAttribute("password") %>" readonly>
						</div>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>