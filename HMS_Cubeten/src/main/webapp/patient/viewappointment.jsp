<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="login.SQLConnect"%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%
Connection con = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

SQLConnect connection = new SQLConnect();
con = connection.connect();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View IPD Appointment history</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<style>
body {
	padding: 60px;
}
</style>
<body>

	<div class="container-fluid m-5">
		<div class="row">
			<div class="card shadow">
				<div class="card-header">IPD Appointment History</div>
				<div class="card-body">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">Appointment ID</th>
								<th scope="col">Doctor Name</th>
								<th scope="col">Nurse Name</th>
								<th scope="col">Ward Name</th>
								<th scope="col"> Checkin_date</th>
								<th scope="col"> bill payment</th>
								<th scope="col"> residency status</th>
								
								<th scope="col">pay bill</th>

							</tr>
						</thead>
						<tbody>
<%
int patientid = (Integer) session.getAttribute("patientid");
try {
	String sql = "SELECT \r\n"
			+ "    i.ipd_appointment_id,\r\n"
			+ "    i.checkin_date,\r\n"
			+ "    i.status,\r\n"
			+ "    i.residency,\r\n"
			+ "    e.firstname AS doctor_firstname,\r\n"
			+ "    e.lastname AS doctor_lastname,\r\n"
			+ "    n.firstname AS nurse_firstname,\r\n"
			+ "    n.lastname AS nurse_lastname,\r\n"
			+ "    w.ward_name\r\n"
			+ "FROM \r\n"
			+ "    ipd_appointment i\r\n"
			+ "JOIN \r\n"
			+ "    employeelist e ON i.doctor_id = e.employee_id\r\n"
			+ "JOIN \r\n"
			+ "    employeelist n ON i.nurse_id = n.employee_id\r\n"
			+ "JOIN \r\n"
			+ "    ward w ON i.ward_id = w.ward_id where i.patient_id=? ";

	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, patientid);
	rs = pstmt.executeQuery();
	while (rs.next()) {
%>
							<tr>
								<td><%=rs.getInt("i.ipd_appointment_id")%></td>
								<td><%=rs.getString("doctor_firstname")%> <%=rs.getString("doctor_lastname")%></td>
								<td><%=rs.getString("nurse_firstname")%> <%=rs.getString("nurse_lastname")%></td>
								<td><%=rs.getString("w.ward_name")%></td>
								<td><%=rs.getTimestamp("i.checkin_date")%></td>
								<td><%=rs.getString("i.status")%></td>
								<td><%=rs.getString("i.residency")%></td>
								
								<td>
									<form action="../IpdBill" method="post">
										<input type="hidden"
											value=<%=rs.getInt("i.ipd_appointment_id")%>
											id="ipd_appointment_id" name="ipd_appointment_id"> <input
											type="submit" value="Pay">
									</form>
								</td>

							</tr>
							<%
							}
							} catch (Exception e) {
							e.printStackTrace();

							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>