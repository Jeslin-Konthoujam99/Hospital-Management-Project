<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="login.SQLConnect"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OPD Doctor </title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
body {
	 padding-top: 50px;
  padding-right: 10px;
  padding-bottom: 5px;
  padding-left: 1px;
	font-size: 14px;
}

.card {
	padding: 30px;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}

.input-group-text {
	background: #007bff;
	border: none;
	color: white;
}

.container-fluid {
	padding-left: 50px;
	padding-right: 1px;
}

input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}

input[type=number] {
	-moz-appearance: textfield;
}

input, textarea {
	border: 1px solid #007bff;
	box-shadow: inset 0 1px 2px rgba(0, 0, 0, .075), inset 0 5px 8px
		rgba(0, 123, 255, 0.6);
}

@media print {
	body {
		padding: 0;
		padding-top: 20px;
		margin: 0;
	}
	.card {
		box-shadow: none;
	}
	.container-fluid {
		padding-left: 0;
		padding-right: 0;
		margin: 0;
		width: 100%;
		height: 100%;
		overflow: auto;
	}
	input, textarea {
		border: none;
		box-shadow: none;
	}
}
</style>
</head>
<body>
	<%
	SQLConnect model = new SQLConnect();
	Connection con = model.connect();
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String age = "";
	String gender = "";
	String name = "";
	String status = "";
	
	String date = "";
	String dpt_name = "";	
	String doctor = "";
		

	String bp = "";
	float temp = 0;
	float weight = 0;
	float height = 0;
	float bmi = 0;
	float pulse = 0;

	String medication = "";
	String dose = "";
	String dosage = "";
	String duration = "";
	String test = "";
	String recommendation = "";

	// Check if the "id" parameter is not null before parsing
	String idParameter = request.getParameter("id");
	int appointmentid = (idParameter != null && !idParameter.isEmpty()) ? Integer.parseInt(idParameter) : 0;

	String patientid = request.getParameter("pid");
	age = request.getParameter("age");
	gender = request.getParameter("gender");
	name = request.getParameter("name");
	System.out.println("patient name in jsp : " + name);
	status = request.getParameter("status");
	System.out.println("status in jsp : " + status);
	date = request.getParameter("date");
	doctor = request.getParameter("doctor");
	dpt_name = request.getParameter("dpt_name");
	

	request.setAttribute("patientid", appointmentid);
	if (status != null && status.equalsIgnoreCase("seen by nurse")) {
		try {

			pstmt = con.prepareStatement("select * from opd_prescriptions where appointment_id=?");
			pstmt.setInt(1, appointmentid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
		if (rs.getString("bp") != null) {
			bp = rs.getString("bp");
		}
		if (rs.getString("pulse") != null) {
			pulse = Float.parseFloat(rs.getString("pulse"));
		}
		if (rs.getString("weight") != null) {
			weight = Float.parseFloat(rs.getString("weight"));
		}
		if (rs.getString("height") != null) {
			height = Float.parseFloat(rs.getString("height"));
		}
		if (rs.getString("bmi") != null) {
			bmi = Float.parseFloat(rs.getString("bmi"));
		}
		if (rs.getString("temperature") != null) {
			temp = Float.parseFloat(rs.getString("temperature"));
		}

			}
		} catch (Exception e) {
			System.out.println("exception in doctor/ acknowledge    ");

			e.printStackTrace();

			response.sendRedirect("patienthistory.jsp");

		}
	}
	%>
	<div class="container-fluid">
		<div class="row">
				<div class="card">
				<div class="card-header">
					
					<div class="row d-md-block d-lg-flex">
						<div class="col-2">
						<button class="btn btn-primary d-print-none"
						onclick="window.location.reload()">
						<i class="bi bi-arrow-clockwise"></i>
					</button>
					<button class="btn btn-primary d-print-none" name="print"
								onclick="window.print()">Print
					</button>
							
						</div>
						<div class="col-5">
						
							<p class="fw-semibold">
								PATIENT NAME:
								<%=name%><br> AGE/GENDER:
								<%=age%>
								/
								<%=gender%>
								<br>
								 DOCTOR NAME :
								<%=doctor%> <br>
								
								
							</p>
						</div>
						<div class="col-5">
							<p class="fw-semibold">
							DEPARTMENT NAME :
								<%=dpt_name %><br>
							BOOK DATE :
								<%=date%><br>
							
								 STATUS :
								<%=status%>
							</p>
						</div>
					</div>
				</div>
			<div class="card-body">
					<div class="row">
						<div class="col-5">
				<%
				try {
					String sqlQuery = "SELECT " + "ip.prescription_id, " + "ip.medicine_id, " + "ip.appointment_id, " + "ip.test, "
					+ "ip.recommendation, " + "ip.dose, " + "ip.duration, " + "m.medicine_name, " + "m.dosage_form " + "FROM "
					+ "opd_prescriptions ip " + "LEFT JOIN " + "medicines m ON ip.medicine_id = m.medicine_id "
					+ "where ip.appointment_id=? " + "order by ip.prescription_id desc";

					pstmt = con.prepareStatement(sqlQuery);
					pstmt.setInt(1, appointmentid);
					rs = pstmt.executeQuery();
					while (rs.next()) {

						medication = rs.getString("m.medicine_name");
						dose = rs.getString("ip.dose");
						duration = rs.getString("ip.duration");
						dosage = rs.getString("m.dosage_form");
						test = rs.getString("ip.test");
						recommendation = rs.getString("ip.recommendation");

						if (dosage != null && dosage.equals("other")) {
					System.out.println("dose is other " + dosage);
						} else {
					dosage = "";
						}

						if (medication != null) {
					if (!medication.trim().isEmpty()) {
				%>
				<span class="fw-semibold">MEDICINE : </span>
				<%=medication%>
				<%
				}
				}

				if (dose != null) {
				if (!dose.trim().isEmpty()) {
				%>
				<%=dose%>
				<span class="fw-semibold"> per day , for </span>

				<%
				}
				}

				if (dosage != null) {
				if (!dosage.trim().isEmpty()) {
				%>
				<span class="fw-semibold">dosage : </span>
				<%=dosage%>
				<%
				}
				}

				if (duration != null) {
				if (!duration.trim().isEmpty()) {
				%>
				<span class="fw-semibold"> <%=duration%> days.
				</span><br>
				<%
				}
				}

				if (test != null) {
				if (!test.trim().isEmpty()) {
				%>
				<span class="fw-semibold">TEST : </span>
				<%=test%><br>
				<%
				}
				}

				if (recommendation != null) {
				if (!recommendation.trim().isEmpty()) {
				%>
				<span class="fw-semibold">DOCTOR NOTES : </span>
				<%=recommendation%><br>
				<%
				}
				}
				%>
				<hr>
				<%
				} //while end

				} catch (Exception e) {
				System.out.println("exception in doctor/ acknowledge    ");

				e.printStackTrace();

				response.sendRedirect("patienthistory.jsp");

				}
				%>




			</div>

			<div class="col-7">		
					<form action="../Prescriptions" method="post">


									<input type="hidden" name="pid" value="<%=appointmentid%>">
									<input type="hidden" name="pid1" value="<%=patientid%>">
									<input type="hidden" name="name" value="<%=name%>">
									<input type="hidden" name="doctor" value="<%=doctor%>">
									<input type="hidden" name="age" value="<%=age%>"> <input
										type="hidden" name="gender" value="<%=gender%>"> 
									<input
										type="hidden" name="status" value="<%=status%>">
									<input type="hidden" name="date" value="<%=date%>">
									<input type="hidden" name="dpt_name" value="<%=dpt_name%>">
									<div class="input-group mb-2">
										<span class="input-group-text" id="basic-addon2">BP</span> <input
											type="text" class="form-control shadow" id="BP" name="BP"
											value="<%=bp%>" readonly> <span
											class="input-group-text me-3" id="basic-addon2">mmHg</span> <span
											class="input-group-text" id="basic-addon2">Pulse</span> <input
											type="text" class="form-control shadow" id="Pulse"
											name="pulse" value="<%=pulse%>" readonly> <span
											class="input-group-text me-3" id="basic-addon2">bpm</span> 
											
									</div>
									
									<div class="input-group mb-2">
									<span
											class="input-group-text" id="basic-addon2">Temperature</span>
										<input type="number" class="form-control shadow"
											id="Temperature" name="temperature" value="<%=temp%>"
											readonly> <span class="input-group-text"
											id="basic-addon2">°C</span>
											<span class="input-group-text" id="basic-addon2">Weight</span>
										<input type="number" class="form-control shadow" id="weight"
											name="weight" value="<%=weight%>" readonly
											aria-describedby="basic-addon2"> <span
											class="input-group-text me-3" id="basic-addon2">kg</span> 
											
									</div>
									
									<div class="input-group mb-2">
										
											<span
											class="input-group-text" id="basic-addon2">Height</span> <input
											type="number" class="form-control shadow" id="height"
											name="height" value="<%=height%>" readonly
											aria-describedby="basic-addon2"> <span
											class="input-group-text me-3" id="basic-addon2">cm</span> <span
											class="input-group-text" id="basic-addon2">BMI</span> <input
											type="text" class="form-control shadow" id="bmi" name="bmi"
											value="<%=bmi%>" readonly aria-describedby="basic-addon2">
										<span class="input-group-text" id="basic-addon2">kg/m<sup>2</sup></span>
										
										
									</div>
									<div>
									<input type="text" class="form-control shadow" id="status"
											name="Status" value="" readonly>
									</div>
							
							<div class="row border-top border-3 mb-3">
								<div class="form-group">
									<div id="medication" class="d-flex">
										<span class="input-group-text" id="basic-addon2">Medicine
										</span> <input type="text" id="medication" name="medication"
											list="medicines" placeholder="medicine name" >
										<!-- Hidden field to store the selected medicine_id -->
										<input type="hidden" id="medicine_id" name="medicine_id"
											value="">
										<datalist id="medicines">
											<%
											ArrayList<String> medicineList = new ArrayList<>();
											int medicineId = 0;
											String medicineName = "";
											try {
												String sqlQuery = "SELECT medicine_id, medicine_name FROM medicines";
												pstmt = con.prepareStatement(sqlQuery);
												rs = pstmt.executeQuery();
												// Populate a Java ArrayList with medicine names and corresponding IDs
												while (rs.next()) {
													medicineId = rs.getInt("medicine_id");
													medicineName = rs.getString("medicine_name");
													medicineList.add(medicineName);

													// Use JavaScript to set the value of the hidden field when a medicine is selected
											%>

											<%
											} //while
											} catch (Exception e) {
											e.printStackTrace();
											} finally {
											con.close();
											}
											%>

											<%-- Generate options for each medicine --%>
											<%
											Iterator<String> iterator = medicineList.iterator();
											while (iterator.hasNext()) {
												String medicine = iterator.next();
											%>
											<option value="<%=medicine%>"
												onmousedown="setMedicineId<%=medicineId%>()">
												<%
												}
												%>
											
										</datalist>







										<input type="text" class="form-control" id="dose" name="dose" value="" placeholder="Dose" aria-describedby="basic-addon2">
										<input type="text" class="form-control" id="duration" name="duration" value="" placeholder="Duration" aria-describedby="basic-addon2">
									</div>

								</div>
							</div>
							<div class="row mb-3">
								<div class="form-group">
									<input type="text"
										class="form-control" id="test" name="test" value="" placeholder="Test">
								</div>
							</div>
							<div class="row mb-3">
								<div class="form-group">
									 
									<textarea class="form-control" id="recommendation" placeholder="Recommendation"
										name="recommendation" rows="2"></textarea>
								</div>
							</div>
							
							<div class="row">
								<div class="form-group mb-2">
									<button type="submit" class="btn btn-primary d-print-none">Submit</button>	
									--------------
<form action="../dischargeopd" method="post">
									<input type="hidden" name="pid" value="<%=appointmentid%>">
									<input type="hidden" name="pid1" value="<%=patientid%>">
									<input type="hidden" name="name" value="<%=name%>">
									<input type="hidden" name="doctor" value="<%=doctor%>">
									<input type="hidden" name="age" value="<%=age%>"> 
									<input type="hidden" name="gender" value="<%=gender%>"> 
									<input type="hidden" name="status" value="<%=status%>">
									<input type="hidden" name="date" value="<%=date%>">
									<input type="hidden" name="dpt_name" value="<%=dpt_name%>">
									<button type="submit" class="btn btn-primary d-print-none">Discharge</button>
						</form>		
									
									</div>	
													
							</div>
							
						</form>	
						
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
        function setMedicineId<%=medicineId%>(){
            var medicationInput = document.getElementById('medication');
            var medicineIdInput = document.getElementById('medicine_id');
            medicineIdInput.value = <%=medicineId%>;
        }
    </script>
	<script>
		var weight = document.getElementById("weight");
		var height = document.getElementById("height");
		var bmi = document.getElementById("bmi");
		height.style.fontWeight = "bold";
		weight.style.fontWeight = "bold";
		bmi.style.fontWeight = "bold";
		document.getElementById("status").style.fontWeight = "bold";

		if (parseFloat(bmi.value) < 16) {
			document.getElementById("status").value = "Severely Thinness";
			document.getElementById("status").style.color = "red";
			bmi.style.color = "red";
		} else if (parseFloat(bmi.value) >= 16 && parseFloat(bmi.value) < 18.5) {
			document.getElementById("status").value = "Moderate Thinness";
			document.getElementById("status").style.color = "red";
			bmi.style.color = "red";
		} else if (parseFloat(bmi.value) < 18.5) {
			document.getElementById("status").value = "Mild Thinness";
			document.getElementById("status").style.color = "red";
			bmi.style.color = "red";
		} else if (parseFloat(bmi.value) >= 18.5 && parseFloat(bmi.value) < 25) {
			document.getElementById("status").value = "Normal";
			document.getElementById("status").style.color = "green";
			bmi.style.color = "green";
		} else if (parseFloat(bmi.value) >= 25 && parseFloat(bmi.value) < 30) {
			document.getElementById("status").value = "Overweight";
			document.getElementById("status").style.color = "orange";
			bmi.style.color = "orange";
		} else if (parseFloat(bmi.value) >= 30) {
			document.getElementById("status").value = "Obese";
			document.getElementById("status").style.color = "red";
			bmi.style.color = "red";
		}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>