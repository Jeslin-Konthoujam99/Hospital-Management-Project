<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	align-items: center;
	justify-content: center;
	background: linear-gradient(to bottom, #f8f9fa, palegreen);
	height: 100vh;
	padding: 50px;
}

a {
	text-decoration: none;
	color: #ff0000;
}

a:hover {
	text-decoration: underline;
	color: orange;
	transition: all 0.3s ease-in-out;
}
.error-message {
      color: red;
    }

</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row g-4">
			<div class="col-md-12 text-center text-primary">
				<span class="display-lg-2 fw-bold"> Patient Registration Form</span>
			</div>
			<div class="col-md-12 col-lg-10 mx-lg-auto">
				<form	action="${pageContext.request.contextPath}/PatientRegistration"	method="post" id="passwordForm" onsubmit="return validateForm()">
					<table class="table table-striped">
						<tr>
							<td><label for="inputName" class="form-label">Name *</label></td>
							<td><input type="text" class="form-control" id="inputName" pattern="[A-Za-z ]+"	title="Please enter a valid name (letters and spaces only)" name="name" required></td>
						</tr>

						<tr>
							<td><label for="inputAge" class="form-label">Age *</label></td>
							<td><input type="number" class="form-control" id="inputAge" min="0" max="150" title="Please enter a valid age (between 0 and 150)" name="age" required></td>
						</tr>
						<tr>
							<td><label for="inputGender" class="form-label">Gender
									*</label></td>
							<td><select class="form-select" id="inputGender"
								name="gender" required>
									<option value="">Select Gender...</option>
									<option value="male">Male</option>
									<option value="female">Female</option>
							</select></td>
						</tr>
						<tr>
							<td><label for="inputEmail" class="form-label">Email
									*</label></td>
							<td><input type="email" class="form-control" id="inputEmail" pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$" title="plz provide a valid email" 
								name="email" required></td>
						</tr>
						<tr>
							<td><label for="inputPassword" class="form-label">Password
									*</label></td>
							<td><input type="password" class="form-control" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
  title="Must contain at least one  number and one uppercase and lowercase letter, and at least 8 or more characters"
								id="inputPassword" name="password" required></td>
						</tr>
						<tr>
							<td><label for="inputConfirmPassword" class="form-label">Confirm
									Password *</label></td>
							<td><input type="password" class="form-control"
								id="inputConfirmPassword" name="conPassword"  oninput="validatePasswordMatch()" required> 
								<div id="passwordMatchError" class="error-message"></div> </td>
						</tr>


						<tr>
							<td><label for="inputFname" class="form-label">Care
									of </label></td>
							<td><input type="text" class="form-control" id="inputFname"
								name="care"></td>
						</tr>
						<tr>
							<td><label for="inputAddress" class="form-label">Address</label></td>
							<td><input type="text" class="form-control"
								id="inputAddress" name="address"></td>
						</tr>

						<tr>
							<td><label for="inputContact" class="form-label">Contact</label></td>
							<td><input type="text" class="form-control"
								id="inputContact" name="contact"></td>
						</tr>

						<tr>
							<td colspan="2">
								<button type="submit" class="btn btn-primary">Register</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function validatePasswordMatch() {
      const password = document.getElementById('inputPassword').value;
      const confirmPassword = document.getElementById('inputConfirmPassword').value;
      const errorDiv = document.getElementById('passwordMatchError');

      if (password !== confirmPassword) {
        errorDiv.textContent = 'Passwords do not match';
      } else {
        errorDiv.textContent = '';
      }
    }

    function validateForm() {
      const password = document.getElementById('inputPassword').value;
      const confirmPassword = document.getElementById('inputConfirmPassword').value;

      if (password !== confirmPassword) {
        alert('Passwords do not match. Please check.');
        return false; // Prevent form submission
      }

      // Continue with form submission or other actions
      return true;
    }
  </script>
	
</body>
</html>