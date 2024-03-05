<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="login.SQLConnect"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<html>
<head>
<title>Insert OPD Test Result</title>
<!-- Bootstrap CSS link -->

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<style>
body {
	padding: 50px;
}
</style>
</head>
<body class="container mt-5">
	<h2 class="text-center">Insert Test Result</h2>
<%
SQLConnect model = new SQLConnect();
Connection con = model.connect();
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
try
{
	String sqlQuery = "SELECT " +
		    "op.prescription_id, " +
		    "op.test, " +
		    "oa.booked_id, " +
		    "d.dpt_name AS department_name, " +
		    "CONCAT(e.firstname, ' ', e.lastname) AS doctor_fullname, " +
		    "oa.date AS appointment_date, " +
		    "p.fullname, " +
		    "p.age, " +
		    "p.gender, " +
		    "tb.Blood_id, " +
		    "tb.Amount, " +
		    "tb.date AS payment_date, " +
		    "tb.payment_status " +
		    "FROM " +
		    "opd_prescriptions op " +
		    "JOIN opd_appointments oa ON op.appointment_id = oa.booked_id " +
		    "JOIN patients p ON oa.patient_id = p.patientid " +
		    "JOIN department d ON oa.department_id = d.department_id " +
		    "JOIN employeelist e ON oa.doctor_id = e.employee_id " +
		    "JOIN testbill tb ON op.prescription_id = tb.prescription_id " +
		    "WHERE op.test = 'blood paid' " +
		    "ORDER BY op.prescription_id DESC;";



	pstmt = con.prepareStatement(sqlQuery);
	rs = pstmt.executeQuery();
	while (rs.next()) 
	{
		%>	
	
	
	
	

	<div class="card">
		<div class="card-body">
			
<div class="row">

	<div class="col-6">
		Prescription Id :
		<%=rs.getInt("op.prescription_id") %><br>
		Patient Name : 
		<%=rs.getString("p.fullname") %><br>
		Department Name :
		<%=rs.getString("department_name") %><br>
		Doctor Name :
		<%=rs.getString("doctor_fullname") %><br>
		Appointment Date :
		<%=rs.getString("appointment_date") %>
	</div>

	<div class="col-6">

			<form action="${pageContext.request.contextPath}/TestResult"
				method="post">
					 <input type="hidden" value=<%=rs.getInt("tb.Blood_id")%>
						class="form-control" name="bloodId" required>
					<input type="hidden" value=<%=rs.getInt("op.prescription_id")%>
						class="form-control" name="prescription_id" required>
					<input value=<%=session.getAttribute("id") %>
						type="hidden" class="form-control" name="technicianId" required>
				<div class="form-group">
					<label for="bloodType">Blood Type:</label> <input type="text"
						class="form-control" name="bloodType" required>
				</div>
					
				<button type="submit" class="btn btn-primary">Insert Test
					Result</button>
			</form>
	</div>
</div>

		</div>
	</div>


	
		<%
	}
}
catch (Exception e) 
{
	System.out.println("exception in lab/ insertTestBill    ");
	e.printStackTrace();
}
%>


	<!-- Bootstrap JS and Popper.js scripts (optional) -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-Mrlg7GQUn1Fx9vHvMUblFqIfb8fQGqe3fEzRWi5Na6ZlgpVFFbXBYvccERyXxmqq"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>

	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
		integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+WyklCyaqBDa"
		crossorigin="anonymous"></script>
</body>
</html>
