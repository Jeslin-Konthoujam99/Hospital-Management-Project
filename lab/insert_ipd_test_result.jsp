<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="login.SQLConnect"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<html>
<head>
<title>Insert IPD Test Result</title>
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
	<h2 class="text-center">Insert IPD Test Result</h2>
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
		    "p.gender, " +
		    "tb.test_bill_id, " +
		    "tb.test_cost, " +
		    "tb.test_date AS payment_date, " +
		    "tb.payment_status " +
		    "FROM " +
		    "ipd_prescription op " +
		    "JOIN ipd_appointment oa ON op.ipd_appointment_id = oa.ipd_appointment_id " +
		    "JOIN patients p ON oa.patient_id = p.patientid " +
		    "JOIN ward w ON oa.ward_id = w.ward_id " +
		    "JOIN employeelist e ON oa.doctor_id = e.employee_id " +
		    "JOIN employeelist f ON oa.nurse_id = f.employee_id " +
			"JOIN ipd_test_bill tb ON op.prescription_id = tb.ipd_prescription_id " +
		    "WHERE op.test_required = 'blood paid' " +
		    "ORDER BY op.prescription_id DESC";
	
		    



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

			<form action="${pageContext.request.contextPath}/InsertIpdTestResultServlet" method="post">
                <input value=<%=rs.getInt("tb.test_bill_id") %> type="hidden" class="form-control" name="testBillId" required>
                <input value=<%=rs.getInt("op.prescription_id") %> type="hidden" class="form-control" name="ipd_prescription_id" required>
                <input value=<%=session.getAttribute("id") %> type="hidden" class="form-control" name="employeeId" required>

            <div class="form-group">
                <label for="bloodType">Blood Type:</label>
                <input type="text" class="form-control" name="bloodType" required>
            </div>

                


            <button type="submit" class="btn btn-primary">Insert Result</button>
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
