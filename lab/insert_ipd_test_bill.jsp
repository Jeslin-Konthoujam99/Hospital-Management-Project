<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="login.SQLConnect"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<html>
<head>
<title>Insert IPD Test Bill</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<style>
body {
	background-color: #f8f9fa;
	padding-top: 40px;
}

.container {
	margin-top: 5px;
}

form {
	max-width: 400px;
	margin: 0 auto;
	background-color: #fff;
	padding: 15px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

label {
	margin-bottom: 0.5rem;
}

input {
	width: 100%;
	padding: 0.375rem 0.75rem;
	margin-bottom: 1rem;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	box-sizing: border-box;
}

input[type="submit"] {
	background-color: #007bff;
	color: #fff;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="m-5 shadow-lg bg-light rounded">
		<div class="container_fluid">
			<div class="text-center fw-bold fs-3 bg-success pt-4 text-light">Insert
				IPD Test Bill</div>
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
		    "op.test_required, " +
		    "oa.ipd_appointment_id, " +
		    "w.ward_name AS ward_name, " +
		    "w.b_id AS bed_no, " +
		    "CONCAT(e.firstname, ' ', e.lastname) AS doctor_fullname, " +
		    "CONCAT(f.firstname, ' ', f.lastname) AS nurse_fullname, " +
		    "oa.checkin_date AS appointment_date, " +
		    "p.fullname, " +
		    "p.age, " +
		    "p.gender " +
		    "FROM " +
		    "ipd_prescription op " +
		    "JOIN ipd_appointment oa ON op.ipd_appointment_id = oa.ipd_appointment_id " +
		    "JOIN patients p ON oa.patient_id = p.patientid " +
		    "JOIN ward w ON oa.ward_id = w.ward_id " +
		    "JOIN employeelist e ON oa.doctor_id = e.employee_id " +
		    "JOIN employeelist f ON oa.nurse_id = f.employee_id " +
		    "WHERE op.test_required = 'blood' " +
		    "ORDER BY op.prescription_id DESC";


	pstmt = con.prepareStatement(sqlQuery);
	rs = pstmt.executeQuery();
	while (rs.next()) 
	{
		%>
<div class="row">

	<div class="col-6">
		Prescription Id :
		<%=rs.getInt("op.prescription_id") %><br>
		Patient Name : 
		<%=rs.getString("p.fullname") %><br>
		Ward Name :
		<%=rs.getString("ward_name") %><br>
		Bed No :
		<%=rs.getString("bed_no") %><br>
		Doctor Name :
		<%=rs.getString("doctor_fullname") %><br>
		Main Nurse Name :
		<%=rs.getString("nurse_fullname") %><br>
		Check in Date :
		<%=rs.getString("appointment_date") %>
	</div>
	
	
	
	<div class="col-6">
		<div class="container">
				<form
					action="${pageContext.request.contextPath}/InsertIpdTestBillServlet"
					method="post">
					 <input value=<%=rs.getInt("op.prescription_id") %>
						type="hidden" name="ipdPrescriptionId" class="form-control" required>
					<input type="submit" value="Submit" class="btn btn-primary">
				</form>
			</div>
			
	</div>
</div>
		
	<hr>	
		
		
		
		<%
	}
}
catch (Exception e) 
{
	System.out.println("exception in lab/ insertTestBill    ");
	e.printStackTrace();
}
%>


















			
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>
