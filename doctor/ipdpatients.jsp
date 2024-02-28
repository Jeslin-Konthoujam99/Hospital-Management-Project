<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@page import="login.SQLConnect"%>
    
    <%@page import="java.util.*"%>
	<%@page import="java.sql.*"%>
	<%@page import="java.time.LocalDateTime" %>
	<%@page import="java.time.LocalTime" %>
	<%@page import="java.time.format.DateTimeFormatter" %>
	<% 
		SQLConnect model = new SQLConnect();
		Connection con = model.connect();
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IPD Patients</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/datetime/1.5.1/css/dataTables.dateTime.min.css">
<style>
a {
	
}
body {
	padding: 60px;
	padding-left: 70px;
}
.card {
	padding: 30px;
}
</style>
</head>
<body>

<div class="container-fluid px-5">
	<div class="row">
		<div class="card shadow">
			<div class="card-header">
				Appointment History
			</div>
			<div class="card-body">
				<table class="table table-striped" id="example">
					<thead>
						<tr>
							<th scope="col">Appointment ID</th>
							<th scope="col">Patient Name</th>
							<th scope="col">Ward Name</th>
							<th scope="col">Nurse Name</th>
							<th scope="col">Prescription</th>
						</tr>
					</thead>
					<tbody>
						<%
							try {
								LocalDateTime myDateObj = LocalDateTime.now();
							    DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd");
							    String appointment_date = myDateObj.format(myFormatObj);
							    String sqlQuery = "SELECT " +
									    "ia.ipd_appointment_id, " +
									    "ia.checkin_date, " +
									    "ia.status, " +
									    "p.fullname, " +
									    "p.age, " +
									    "p.gender, " +
									    "w.ward_name, " +
									  "e_doctor.firstname AS doctor_firstname, "+ 
									    
									  "e_doctor.lastname AS doctor_lastname, " +
									  "e_nurse.firstname AS nurse_firstname, " +
									  "e_nurse.lastname AS nurse_lastname " +
									"FROM " +
									    "ipd_appointment ia " +
									"JOIN " +
									    "patients p ON ia.patient_id = p.patientid " +
									"JOIN " +
									    "ward w ON ia.ward_id = w.ward_id " +
									"JOIN " +
				"employeelist e_doctor ON ia.doctor_id = e_doctor.employee_id "
			+"JOIN employeelist e_nurse ON ia.nurse_id = e_nurse.employee_id "
			+"where ia.residency='residing'";

								pstmt = con.prepareStatement(sqlQuery);
								System.out.println("appointment date : "+ appointment_date );
								rs = pstmt.executeQuery();
								while(rs.next()) {
									%>
									<tr>
								<td><%=rs.getInt("ia.ipd_appointment_id")%></td>
								<td><%=rs.getString("p.fullname")%></td>
								<td><%=rs.getString("w.ward_name")%></td>
								<td><%=rs.getString("nurse_firstname")%> <%=rs.getString("nurse_lastname")%></td>
										<td>
											<form action="acknowledge_ipd.jsp" method="post">
										<input type="hidden" name="ipd_appointment_id" value="<%=rs.getInt("ia.ipd_appointment_id")%>"> 
										<input type="hidden" name="name" value="<%=rs.getString("p.fullname")%>"> 
										<input type="hidden" name="age" value="<%=rs.getInt("p.age")%>"> 
										<input type="hidden" name="status" value="<%=rs.getString("ia.status")%>"> 
										<input type="hidden" name="gender" value="<%=rs.getString("p.gender")%>"> 
										<input type="hidden" name="ward_name" value="<%=rs.getString("w.ward_name")%>"> 
										<input type="hidden" name="checkin_date" value="<%=rs.getTimestamp("ia.checkin_date")%>"> 
										<input type="hidden" name="doctor" value="<%=rs.getString("doctor_firstname")%> <%=rs.getString("doctor_lastname")%>"> 
										<input type="hidden" name="nurse" value="<%=rs.getString("nurse_firstname")%> <%=rs.getString("nurse_lastname")%>"> 
										
											
										<button type="submit" class="btn btn-success">Check up</button>
									</form>
										</td>
									</tr>
									<%
								}
							}catch(Exception e) {
								System.out.println("ipd patient.jsp  exception");
								e.printStackTrace();
								
							}
						%>
					</tbody>
				</table>
				<!-- Button trigger modal -->
				
				
				
				
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.2/moment.min.js"></script>
<script src="https://cdn.datatables.net/datetime/1.5.1/js/dataTables.dateTime.min.js"></script>
<script>
let minDate, maxDate;

//Custom filtering function which will search data in column four between two values
DataTable.ext.search.push(function (settings, data, dataIndex) {
 let min = minDate.val();
 let max = maxDate.val();
 let date = new Date(data[3]);

 if (
     (min === null && max === null) ||
     (min === null && date <= max) ||
     (min <= date && max === null) ||
     (min <= date && date <= max)
 ) {
     return true;
 }
 return false;
});

//Create date inputs
minDate = new DateTime('#min', {
 format: 'MMMM Do YYYY'
});
maxDate = new DateTime('#max', {
 format: 'MMMM Do YYYY'
});

//DataTables initialisation
let table = new DataTable('#example');

//Refilter the table
document.querySelectorAll('#min, #max').forEach((el) => {
 el.addEventListener('change', () => table.draw());
});

</script>
</body>
</html>