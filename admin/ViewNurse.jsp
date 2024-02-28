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
<title>ViewNurse</title>
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
	margin-top: 75px;
}

a {
	text-decoration: none;
}
</style>
</head>
<body>
	<table class="table ms-5 my-5 align-middle text-nowrap">
		<tr>
			<td class="fw-bold text-white bg-success">Update/Delete</td>
			<td class="fw-bold text-white bg-success">Sl</td>
			<td class="fw-bold text-white bg-success">Emp_Id</td>
			<td class="fw-bold text-white bg-success">First_Name</td>
			<td class="fw-bold text-white bg-success">Last_Name</td>
			<td class="fw-bold text-white bg-success">Username</td>
			<td class="fw-bold text-white bg-success">Password</td>
			<td class="fw-bold text-white bg-success">Department</td>
			<td class="fw-bold text-white bg-success">Designation</td>
			<td class="fw-bold text-white bg-success">Gender</td>
			<td class="fw-bold text-white bg-success">Age</td>
			<td class="fw-bold text-white bg-success">Aadhaar</td>
			<td class="fw-bold text-white bg-success">Email</td>
			<td class="fw-bold text-white bg-success">Phone</td>
			<td class="fw-bold text-white bg-success">Address</td>
			<td class="fw-bold text-white bg-success">District</td>
			<td class="fw-bold text-white bg-success">State</td>
			<td class="fw-bold text-white bg-success">Country</td>
			<td class="fw-bold text-white bg-success">Pin</td>
			
		</tr>


		<%
		Connection con = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String UIDAadhaar = "";
		try {
			SQLConnect connection = new SQLConnect();
			con = connection.connect();
			stmt = con.createStatement();
			rs = stmt.executeQuery("select * from employeelist where role='nurse' ");
			while (rs.next()) {
				UIDAadhaar = rs.getString(9);
		%>
		<tr>
		<td class="d-flex">
				<form action="UpdateNurse.jsp" method="post">
					<input type="hidden" name="UIDAadhaar" value="<%=UIDAadhaar%>">
					<button type="submit" class="btn btn-primary fw-bold">Update
					</button>
				</form>
				<button type="button" class="btn btn-danger fw-bold"
					data-bs-toggle="modal" data-bs-target="#exampleModal">Delete</button>

			</td>
			<td><%=rs.getString(1)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getString(3)%></td>
			<td><%=rs.getString(4)%></td>
			<td><%=rs.getString(17)%></td>
			<td><%=rs.getString(18)%></td>
			<td><%=rs.getString(7)%></td>
			<td><%=rs.getString(8)%></td>
			<td><%=rs.getString(5)%></td>
			<td><%=rs.getString(6)%></td>
			
			<td><%=rs.getString(9)%></td>
			<td><%=rs.getString(10)%></td>
			<td><%=rs.getString(11)%></td>
			<td><%=rs.getString(12)%></td>
			<td><%=rs.getString(13)%></td>
			<td><%=rs.getString(14)%></td>
			<td><%=rs.getString(15)%></td>
			<td><%=rs.getString(16)%></td>
			
		</tr>
		<%
		}
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
	</table>
	<!-- Button trigger modal -->


	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Delete
						Employee</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">Asengbamak - ki Nahak Sengna Kakning
					Ngabara? Wakhal Macha Amadi Khallu He.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<form action="${pageContext.request.contextPath}/DeleteNurse"
						method="post">
						<input type="hidden" name="UIDAadhaar" value="<%=UIDAadhaar%>">
						<button type="submit" class="btn btn-danger ">Delete</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>

</body>
</html>