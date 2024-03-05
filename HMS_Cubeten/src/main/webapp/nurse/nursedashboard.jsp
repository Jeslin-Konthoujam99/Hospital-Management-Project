
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Nurse Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.css"
	rel="stylesheet" />
<style type="text/css">
img {
	background-color: white;
}

img:hover {
	background-color: yellow;
}

body {
	margin-left: 45px;
}
</style>
</head>
<body>

	<nav class="fixed-top navbar navbar-expand-lg bg-dark py-3">
		<div class="container-fluid">

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mx-auto mb-2 mb-lg-0 text-white">
					<li class="text-center h4 fw-bold">NURSE DASHBOARD</li>
				</ul>
				<div class="dropdown">
					<a
						class=" bg-white rounded-circle dropdown-toggle d-flex align-items-center hidden-arrow"
						href="#" id="navbarDropdownMenuAvatar" role="button"
						data-mdb-toggle="dropdown" aria-expanded="false"><img
						src="Photo/Person.png" class="rounded-circle" height="30"
						alt="User" loading="lazy" /> </a>
					<ul class="dropdown-menu dropdown-menu-end my-4"
						aria-labelledby="navbarDropdownMenuAvatar">
						<li><a class="dropdown-item" href="nurse/opdpatients.jsp"
							target="frame">Home</a></li>
						<li><form action="Logout" method="post">
								<button type="submit" class="bt btn-danger">Logout</button>
							</form></li>
					</ul>
				</div>
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">
			<div class="bg-dark text-white fs-1 text-center fixed-top mt-5"
				style="width: 100px; height: 100vh">


				<div class="dropend">
					<a class="dropdown-toggle align-items-center hidden-arrow" href="#"
						id="navbarDropdownMenuAvatar" role="button"
						data-mdb-toggle="dropdown" aria-expanded="false"><img
						src="Photo/Nurse.png" class="rounded-circle my-3 img-fulid"
						height="50px" width="50px" alt="User" loading="lazy" /> </a>
					<ul class="ms-4 dropdown-menu dropdown-menu-end"
						aria-labelledby="navbarDropdownMenuAvatar">
						<li><a class="dropdown-item" href="nurse/opdpatients.jsp"
							target="frame">OPD Patient</a></li>
						<li><a class="dropdown-item" href="nurse/ipdpatients.jsp"
							target="frame">IPD Patient</a></li>
					</ul>
				</div>

			</div>
			<iframe src="nurse/opdpatients.jsp" width="100%" id="frame"
				name="frame" height="630px"></iframe>
		</div>
	</div>


	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>