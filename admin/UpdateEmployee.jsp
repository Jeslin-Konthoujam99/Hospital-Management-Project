
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.SQLConnect"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>UpdateEmployee</title>
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

	<%
	Connection con = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String SlNumber = "";
	String EmpId = "";
	String FirstName = "";
	String LastName = "";
	String Gender = "";
	String Age = "";
	String Department = "";
	String Designation = "";
	String Aadhaar = "";
	String Email = "";
	String Phone = "";
	String Address = "";
	String District = "";
	String State = "";
	String Country = "";
	String Pin = "";
	String Username = "";
	String Password = "";
	try {
		SQLConnect connection = new SQLConnect();
		con = connection.connect();
		stmt = con.createStatement();
		rs = stmt.executeQuery("select * from employeelist where aadhaar='" + request.getParameter("UIDAadhaar") + "'");
		while (rs.next()) {
			SlNumber = rs.getString(1);
			EmpId = rs.getString(2);
			FirstName = rs.getString(3);
			LastName = rs.getString(4);
			Gender = rs.getString(5);
			Age = rs.getString(6);
			Department = rs.getString(7);
			Designation = rs.getString(8);
			Aadhaar = rs.getString(9);
			Email = rs.getString(10);
			Phone = rs.getString(11);
			Address = rs.getString(12);
			District = rs.getString(13);
			State = rs.getString(14);
			Country = rs.getString(15);
			Pin = rs.getString(16);
			Username = rs.getString(17);
			Password = rs.getString(18);
		}

	} catch (Exception e) {
		e.printStackTrace();

	}
	%>

	<div class="m-5 shadow-lg bg-light rounded">
		<div class="container_fluid">
			<div class="text-center fw-bold fs-3 bg-success pt-4 text-light">UPDATE
				EMPLOYEE DETAILS</div>
			<form action="${pageContext.request.contextPath}/UpdateEmployee"
				method="post" class="p-5">
				<table class="table align-middle">
					<%=EmpId%>
					<tr>
						<td colspan="3" class="fw-bold">Personal Details:-</td>
					</tr>
					<tr>
						<td colspan="2"><input type="text" maxlength="5"
							class="form-control" value="<%=SlNumber%>" name="SlNumber"
							required></td>
						<td colspan="2"><input type="text" maxlength="5"
							class="form-control" value="<%=EmpId%>" name="EmpId" required></td>
					</tr>
					<tr>
						<td colspan="3" class="fw-bold"></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control"
							value="<%=FirstName%>" name="FirstName" required></td>
						<td><input type="text" class="form-control"
							value="<%=LastName%>" name="LastName" required></td>
						<td><input type="text" class="form-control"
							value="<%=Gender%>" name="Gender" required></td>
					</tr>

					<tr>
						<td><input type="text" maxlength="2" class="form-control"
							value="<%=Age%>" name="Age" required></td>
						<td><input type="text" class="form-control"
							value="<%=Department%>" name="Department" required></td>
						<td><input type="text" class="form-control"
							value="<%=Designation%>" name="Designation" required></td>
					</tr>

					<tr>
						<td><input type="text" maxlength="12" class="form-control"
							value="<%=Aadhaar%>" name="AadhaarNumber" readonly></td>
						<td><input type="Email" class="form-control"
							value="<%=Email%>" name="Email" required></td>
						<td><input type="text" maxlength="10" class="form-control"
							value="<%=Phone%>" name="PhoneNumber" required></td>
					</tr>

					<tr>
						<td colspan="3" class="fw-bold">Permanent Address:-</td>
					</tr>
					<tr>
						<td><input type="text" class="form-control"
							value="<%=Address%>" name="Address" required></td>
						<td><input type="text" class="form-control"
							value="<%=District%>" name="District" required></td>
						<td><input type="text" class="form-control"
							value="<%=State%>" name="State" required></td>
					</tr>

					<tr>
						<td colspan="3" class="fw-bold"></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control"
							value="<%=Country%>" name="Country" required></td>
						<td><input type="text" class="form-control" value="<%=Pin%>"
							name="Pin" required></td>
						<td><input type="text" class="form-control"
							value="<%=Username%>" name="Username" required></td>
					</tr>

					<tr>
						<td colspan="3" class="fw-bold"></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control"
							value="<%=Password%>" name="Password" required></td>
					</tr>

				</table>
				<table class="table table-striped">

					<tr>
						<td><input type="reset" value="reset"
							class="form-control bg-danger fw-bold"></td>
						<td><input type="submit" value="submit"
							class="form-control bg-primary fw-bold"></td>
					</tr>

					<tr>
						<td colspan="2"><a href="admin/adminpanel.jsp"> <input
								type="button" value="cancel"
								class="form-control bg-secondary fw-bold w-50 mx-auto text-light">
						</a></td>
					</tr>

				</table>
			</Form>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
</body>
</html>


