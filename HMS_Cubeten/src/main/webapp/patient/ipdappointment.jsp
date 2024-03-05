<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.SQLConnect"%>
<%
int bed_id = 0;
int ward_id = 0;
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
<title>Book IPD Appointment</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
body {
	padding: 100px;
}
</style>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="card shadow">
				<div class="card-header">
					<p class="text-center fs-3">Book IPD Appointment</p>
					<%
				String message = "";
				if (request.getAttribute("message") == null) {
					message = "";
				} else {
					message = (String) request.getAttribute("message");
				}
				%>

				</div>
				<div class="card-body">
					<form action="${pageContext.request.contextPath}/IpdAppointment1"
						method="post">
						<div class="mb-3">
							<label for="inputPatientID" class="form-label">Patient ID</label>
							<input type="text" class="form-control" id="inputPatientID"
								value="<%=session.getAttribute("patientid")%>" name="patientID">
						</div>
						
						<div class="mb-3">
							<label for="doctorid" class="form-label">Doctor Name</label> 
							<select id="doctorid" class="form-select" aria-describedby="doctorid" name="doctorid">
								<%
								
								try {
									pstmt = con.prepareStatement("select * from employeelist where role='doctor' ");
									rs = pstmt.executeQuery();
									while (rs.next()) {
								%>
								<option value="<%=rs.getInt("employee_id")%>"> <%=rs.getString("firstname")%> <%=rs.getString("lastname")%></option>
								<%
								}
								} catch (Exception e) {
									e.printStackTrace();
									}	
								%>
									
							</select>
						</div>
						
						<div class="mb-3">
							<label for="nurseid" class="form-label">Nurse Name</label> 
							<select id="nurseid" class="form-select" aria-describedby="nurseid" name="nurseid">
								<%
								
								try {
									pstmt = con.prepareStatement("select * from employeelist where role='nurse' ");
									rs = pstmt.executeQuery();
									while (rs.next()) {
								%>
								<option value="<%=rs.getInt("employee_id")%>"> <%=rs.getString("firstname")%> <%=rs.getString("lastname")%></option>
								<%
								}
								} catch (Exception e) {
									e.printStackTrace();
									}
								%>
									
							</select>
						</div>
						
						<div class="mb-3">
						checkin date : <input type="datetime-local" name="date" id="datetime">
						</div>
						 <script>
        // Get the current date and time in the format required by datetime-local input
        const now = new Date();
        const formattedDate = now.toISOString().slice(0, 16); // Format: YYYY-MM-DDTHH:mm

        // Set the value of the datetime-local input
        document.getElementById('datetime').value = formattedDate;
    </script>
						
						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#exampleModal">Choose
							Bed</button>
							<%
							try {
								Statement st = con.createStatement();
								ResultSet rs1 = null;

								String sql1 = "select * from ward where patient_id='" + session.getAttribute("patientid") + "' and availability='no'";
								rs1 = st.executeQuery(sql1);

								while (rs1.next()) {
								bed_id = rs1.getInt("b_id");
								ward_id = rs1.getInt("ward_id");
								}
								} catch (Exception e) {
								e.printStackTrace();
								}
								%>
						<div class="mb-3">
							<label for="inputBed" class="form-label">Bed No.:</label> 
							<input type="number" id="bed_id" class="form-control" value="<%=bed_id%>" name="bed_id"> 
							<label for="inputWard" class="form-label">Ward No.:</label> 
							<input type="number" id="ward_id" class="form-control" value="<%=ward_id%>" name="ward_id"> 
								
						</div>

						<button type="submit" class="btn btn-primary">Save &amp;
							Continue</button>
					</form>
					<div class="modal fade mt-5" id="exampleModal"
						data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog model-dialog-centered">
							<div class="modal-content custom-modal-content">
								<div class="modal-header">
									<h1 class="modal-title fs-5" id="exampleModalLabel">Bed
										Availability</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<div class="dropdown">
										<button class="btn btn-primary" type="button"
											data-bs-toggle="dropdown" aria-expanded="false">Choose
											a ward first</button>
										<ul class="dropdown-menu">
											<li><a class="dropdown-item" href="normal.jsp">Normal
													ward (Rs 500/day)</a></li>
											<li><a class="dropdown-item" href="normal.jsp">Special
													ward (Rs 1000/day)</a></li>
											<li><a class="dropdown-item" href="normal.jsp">Delux
													Ward (Rs 3000/day)</a></li>
										</ul>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>