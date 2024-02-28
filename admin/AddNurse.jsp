<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AddNurse</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
<style>
.nav-link {
	color: white;
}

.navbar-brand {
	color: white;
}

body {
	background: url(Photos/body.jpg);
	background-size: cover;
	background-position: center;
	background-attahchment: fixed
}

a {
	text-decoration: none;
}
</style>
</head>
<body>

	<div class="m-5 shadow-lg bg-light rounded">


		<div class="container_fluid">
			<div class="text-center fw-bold fs-3 bg-success pt-4 text-light">ADD
				NURSE DETAILS</div>
			<form action="${pageContext.request.contextPath}/AddNurse"
				method="post" class="p-5">
				<table class="table">

					<tr>
						<td colspan="3" class="fw-bold">Personal Details:-</td>
					</tr>
					<tr>
						<td colspan="5"><input type="text" maxlength="5"
							class="form-control" placeholder="Emp Id" name="EmpId" required></td>
					</tr>
					<tr>
						<td colspan="3" class="fw-bold"></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control"
							placeholder="First Name" name="FirstName" required></td>
						<td><input type="text" class="form-control"
							placeholder="Last Name" name="LastName" required></td>
						<td><select class="form-control" name="Gender" required>
								<option selected disabled>Select Gender</option>
								<option value="Male">Male</option>
								<option value="Female">Female</option>
						</select></td>
					</tr>
					<tr>
						<td><input type="text" maxlength="2" class="form-control"
							placeholder="Age" name="Age" required></td>
						<td><input type="number" class="form-control"
							placeholder="Department_ID" name="Department" required></td>
						<td><input type="text" class="form-control"
							placeholder="Designation" name="Designation" required></td>
					</tr>

					<tr>
						<td><input type="text" maxlength="12" class="form-control"
							placeholder="Aadhaar Number" name="AadhaarNumber" required></td>
						<td><input type="Email" class="form-control"
							placeholder="Email" name="Email" required></td>
						<td><input type="text" type="text" maxlength="10"
							class="form-control" placeholder="Phone Number"
							name="PhoneNumber" required></td>
					</tr>

					<tr>
						<td colspan="3" class="fw-bold">Permanent Address:-</td>
					</tr>
					<tr>
						<td><input type="text" class="form-control"
							placeholder="Address" name="Address" required></td>
						<td><input type="text" class="form-control"
							placeholder="District" name="District" required></td>
						<td><input type="text" class="form-control"
							placeholder="State" name="State" required></td>
					</tr>

					<tr>
						<td colspan="3" class="fw-bold"></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control"
							placeholder="Country" name="Country" required></td>
						<td><input type="text" class="form-control" placeholder="Pin"
							name="Pin" required></td>
						<td><input type="text" class="form-control"
							placeholder="Username" name="Username" required></td>
					</tr>

					<tr>
						<td colspan="3" class="fw-bold"></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control"
							placeholder="Password" name="Password" required></td>
						<td colspan="2"><input type="password" class="form-control"
							placeholder="Confirm Password" name="ConfirmPassword" required></td>
					</tr>

				</table>

				<table class="table table-striped">

					<tr>
						<td colspan="2"><input type="checkbox" id="check" checked
							required> &nbsp;&nbsp;&nbsp; I/We have read <a
							class="text-danger" data-bs-toggle="collapse"
							href="#termscondition" role="button"
							area-controls="collapseExample">term &amp; conditions</a>
							Understood and agree abide by the Hospital.<br>
							<div id="termscondition" class="collapse">
								<div>
									<strong class="ps-4 " style="text-align: center;">Terms
										&amp; Conditions &amp; Declaration.</strong>
									<ul class="me-3">
										<li>
											------------------------------------------------------------------------------------------------------------</li>
										<li>
											------------------------------------------------------------------------------------------------------------</li>
										<li>
											------------------------------------------------------------------------------------------------------------</li>
										<li>
											------------------------------------------------------------------------------------------------------------</li>
										<li>
											------------------------------------------------------------------------------------------------------------</li>
										<li>
											------------------------------------------------------------------------------------------------------------</li>
										<li>
											------------------------------------------------------------------------------------------------------------</li>
										<li>
											------------------------------------------------------------------------------------------------------------</li>
										<li>
											------------------------------------------------------------------------------------------------------------</li>
										<li>
											------------------------------------------------------------------------------------------------------------</li>
									</ul>
								</div>

							</div></td>
					</tr>

					<tr>
						<td><input type="reset" value="reset"
							class="form-control bg-danger fw-bold"></td>
						<td>
							<!-- <input type="submit" value="submit" class="form-control bg-primary fw-bold"> -->
							<button type="button"
								class="btn btn-primary form-control fw-bold"
								data-bs-toggle="modal" data-bs-target="#exampleModal">
								Submit</button>
						</td>
					</tr>

					<tr>
						<td colspan="2"><a href="#"> <input type="button"
								value="cancel"
								class="form-control bg-secondary fw-bold w-50 mx-auto text-light">
						</a></td>
					</tr>

				</table>
				<div class="modal fade" id="exampleModal" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="exampleModalLabel">Add
									Nurse</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">Panghapta Hapchillak Khinu, Amta
								Munna Check Toukho Hallaga Semdokpa Pamdradi.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
								<button type="submit" class="btn btn-primary">Submit</button>
							</div>
						</div>
					</div>
				</div>
			</Form>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>