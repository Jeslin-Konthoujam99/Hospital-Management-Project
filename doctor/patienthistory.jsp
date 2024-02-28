<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="login.SQLConnect"%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OPD Patients</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/datetime/1.5.1/css/dataTables.dateTime.min.css">
<style>
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
				<div class="card-header">Appointment History</div>
				<div class="card-body">
					<table class="table table-striped" id="example">
						<thead>
							<tr>
								<th scope="col">Appointment ID</th>
								<th scope="col">Patient Name</th>
								<th scope="col">Department Name</th>
								<th scope="col">Appointment Status</th>
								<th scope="col">Prescription</th>
							</tr>
						</thead>
						<tbody>
							<%
							int doctor_id = (Integer) session.getAttribute("id");
							String doctorname = (String) session.getAttribute("name");
							SQLConnect model = new SQLConnect();
							Connection con = model.connect();
							Statement stmt = null;
							PreparedStatement pstmt = null;
							ResultSet rs = null;
							try {

								LocalDate currentDate = LocalDate.now();
								LocalDateTime startOfDay = LocalDateTime.of(currentDate, LocalTime.MIN);
								LocalDateTime endOfDay = LocalDateTime.of(currentDate, LocalTime.MAX);

								DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

								String startOfDayFormatted = startOfDay.format(myFormatObj);
								String endOfDayFormatted = endOfDay.format(myFormatObj);
								String sqlQuery = "SELECT " 
										+ "oa.booked_id, " 
										+ "oa.patient_id, " 
										+ "p.fullname AS patient_fullname, " 
										+ "p.age, "
										+ "p.gender, " 
										+ "oa.date, " 
										+ "oa.appointment_status, " 
										+ "d.dpt_name AS department_name, "
										+ "e.firstname AS doctor_firstname, " 
										+ "e.lastname AS doctor_lastname " 
								+ "FROM " 
										+ "opd_appointments oa "
										+ "JOIN " 
										+ "patients p ON oa.patient_id = p.patientid " 
										+ "JOIN "
								+ "department d ON oa.department_id = d.department_id " 
										+ "JOIN "
										
										+ "employeelist e ON oa.doctor_id = e.employee_id WHERE date >= ? AND date <= ? AND oa.doctor_id=? AND oa.appointment_status = 'seen by nurse' order by date desc";
								pstmt = con.prepareStatement(sqlQuery);

								Timestamp startOfDayTimestamp = Timestamp.valueOf(startOfDayFormatted);
								Timestamp endOfDayTimestamp = Timestamp.valueOf(endOfDayFormatted);

								pstmt.setTimestamp(1, startOfDayTimestamp);
								pstmt.setTimestamp(2, endOfDayTimestamp);
								pstmt.setInt(3, doctor_id);
								rs = pstmt.executeQuery();
								while (rs.next()) {
							%>
							<tr>
								<td><%=rs.getInt("oa.booked_id")%></td>
								<td><%=rs.getString("patient_fullname")%></td>
								<td><%=rs.getString("department_name")%></td>
								<td><%=rs.getString("oa.appointment_status")%></td>
								<td><form action="acknowledge.jsp" method="post">
										<input type="hidden" name="id" value="<%=rs.getString("oa.booked_id")%>"> 
											<input type="hidden" name="pid" value="<%=rs.getInt("oa.patient_id")%>">
										
											<input type="hidden" name="age" value="<%=rs.getInt("p.age")%>">
										<input type="hidden" name="gender" value="<%=rs.getString("p.gender")%>"> 
										<input type="hidden" name="name" value="<%=rs.getString("patient_fullname")%>"> 
										<input type="hidden" name="status" value="<%=rs.getString("oa.appointment_status")%>">
										<input type="hidden" name="date" value="<%=rs.getTimestamp("oa.date")%>">
										<input type="hidden" name="dpt_name" value="<%=rs.getString("department_name")%>">
										<input type="hidden" name="doctor" value="<%=rs.getString("doctor_firstname")%> <%=rs.getString("doctor_lastname")%>"> 
										
											
											
										<button type="submit" class="btn btn-primary">Acknowledge</button>
									</form></td>
							</tr>
							<%
							}
							} catch (Exception e) {
							System.out.println("exception in doctor/ patienthistory   ");

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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script
		src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.2/moment.min.js"></script>
	<script
		src="https://cdn.datatables.net/datetime/1.5.1/js/dataTables.dateTime.min.js"></script>
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