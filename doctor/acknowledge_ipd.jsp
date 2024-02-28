<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="login.SQLConnect"%>
<%@page import="java.sql.*"%>
                <%@ page import="java.util.ArrayList" %>
                <%@ page import="java.util.Iterator" %>
                


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Acknowledgement</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
body {
	padding: 60px;
	padding-left: 70px;
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
	padding-right: 50px;
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
	String name = "";
	String gender = "";
	String ward_name = "";
	String checkin_date = "";
	String status = "";
	String doctor = "";
	String nurse = "";
	int app_id = Integer.parseInt(request.getParameter("ipd_appointment_id"));
	name = request.getParameter("name");
	System.out.println("name in jsp :"+name);
	age = request.getParameter("age");
	gender = request.getParameter("gender");
	ward_name = request.getParameter("ward_name");
	checkin_date = request.getParameter("checkin_date");
	status = request.getParameter("status");
	doctor = request.getParameter("doctor");
	nurse = request.getParameter("nurse");
	System.out.println("nurse  in jsp :"+nurse);

	%>
	<div class="container-fluid">
		<div class="row">
			<div class="card">
				<div class="card-header">
					<button class="btn btn-primary d-print-none"
						onclick="window.location.reload()">
						<i class="bi bi-arrow-clockwise"></i>
					</button>
					<button class="btn btn-primary d-print-none" name="print"
						onclick="window.print()">Print</button>
					<div class="row d-md-block d-lg-flex mt-2">
						<div class="col">
							<p class="fw-semibold">
								PATIENT NAME:
								<%=name%><br> AGE/GENDER:
								<%=age%>
								/
								<%=gender%><br> 
								
							</p>
						</div>
						<div class="col">
							<p class="fw-semibold">
								 DOCTOR NAME :
								<%=doctor%><br> NURSE NAME :
								<%=nurse%>
							</p>
						</div>
						<div class="col">
							<p class="fw-semibold">
								CHECK IN DATE :
								<%= checkin_date%><br>
								WARD NAME :
								<%=ward_name%><br>
								 PAYMENT STATUS :
								<%=status%>
							</p>
						</div>
					</div>
				</div>
				<div class="card-body">
					<div class="row">
						<div class="col-4">
						 	<%
						String nurse_notes="";
						Timestamp date=null;
						String medicine_name = "";
						int dose = 0;
						int frequency = 0;
						int duration = 0;
						String dosage = "";
						String test = "";
						String recommendation = "";
						try {
							String sqlQuery = "SELECT " + "ip.prescription_id, " 
							+ "ip.medicine_id, " + "ip.ipd_appointment_id, "
							+ "ip.test_required, " + "ip.doctor_notes, " 
							+ "ip.nurse_notes, " + "ip.date, " + "ip.dose, "
							+ "ip.frequency, " + "ip.duration, " 
							+ "m.medicine_name, " + "m.dosage_form " 
							+ "FROM "
							+ "ipd_prescription ip " 
							+ "LEFT JOIN "
							+ "medicines m ON ip.medicine_id = m.medicine_id " 
							+ "where ip.ipd_appointment_id=? "
							+ "order by ip.prescription_id desc";

							pstmt = con.prepareStatement(sqlQuery);
							pstmt.setInt(1, app_id);
							rs = pstmt.executeQuery();
							while (rs.next()) {
								nurse_notes = rs.getString("ip.nurse_notes");

								System.out.println("Debug nurse_notes: " + nurse_notes);
								System.out.println("dose is other "+dosage);
								
								date = rs.getTimestamp("ip.date");
								medicine_name = rs.getString("m.medicine_name");
								dose = rs.getInt("ip.dose");
								frequency = rs.getInt("ip.frequency");
								duration = rs.getInt("ip.duration");
								dosage = rs.getString("m.dosage_form");
								test = rs.getString("ip.test_required");
								recommendation = rs.getString("ip.doctor_notes");
					
								if (dosage != null && dosage.equals("other")) 
								{
								    System.out.println("dose is other "+dosage);
								}
								else{
									dosage = "";
								}


								if (date != null) {
						%>
						<span class="fw-semibold">DATE : </span>
						<%=date%><br>
						<%
						}

						if (nurse_notes != null) {
						if (!nurse_notes.trim().isEmpty()) {
						%>
						<span class="fw-semibold">NURSE NOTES : </span>
						<%=nurse_notes%><br>
						<%
						}
						}

						if (medicine_name != null) {
						if (!medicine_name.trim().isEmpty()) {
						%>
						<span class="fw-semibold">MEDICINE : </span>
						<%=medicine_name%>
						<%
						}
						}

						if (dose != 0) {
						%>
						<%=dose%>
						<%=dosage%>
						<span class="fw-semibold">per dose , </span>
						<%
						}

						if (frequency != 0) {
						%>
						<%=frequency%>
						<span class="fw-semibold">/day for </span>
						<%
						}

						if (duration != 0) {
						%>
						<%=duration%>
						<span class="fw-semibold">days . </span> <br>
						<%
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
						<div class="col-8">
							<form action="../IpdPrescriptions" method="post">
						<input type="hidden" name="ipd_appointment_id" value="<%=app_id%>">
						<input type="hidden" name="name" value="<%=name%>"> <input
							type="hidden" name="age" value="<%=age%>"> <input
							type="hidden" name="gender" value="<%=gender%>"> <input
							type="hidden" name="ward_name" value="<%=ward_name%>"> <input
							type="hidden" name="checkin_date" value="<%=checkin_date%>">
						<input type="hidden" name="status" value="<%=status%>"> <input
							type="hidden" name="doctor" value="<%=doctor%>"> 
						<input
							type="hidden" name="nurse" value="<%=nurse%>">


						<div class="row border-top border-3 mb-3">
							<div class="form-group">


								<div id="medication" class="d-flex">
									<span class="input-group-text" id="basic-addon2">Medicine </span> 
									 <input type="text" id="medication" name="medication" list="medicines" placeholder="medicine name" required>
            <!-- Hidden field to store the selected medicine_id -->
            <input type="hidden" id="medicine_id" name="medicine_id" value="">
            <datalist id="medicines">
            <%
            ArrayList<String> medicineList = new ArrayList<>();
            int medicineId = 0 ;
            String medicineName = "";
            try{
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
                   }//while
            }catch(Exception e)
            {
            	e.printStackTrace();
            }finally{
                con.close();
            }
                %>

                <%-- Generate options for each medicine --%>
                <%
    Iterator<String> iterator = medicineList.iterator();
    while (iterator.hasNext()) {
        String medicine = iterator.next();
%>
<option value="<%= medicine %>" onmousedown="setMedicineId<%= medicineId %>()">
<%
    }
%>
            </datalist>
            
            
            
									<input type="number"
										class="form-control" id="dose" name="dose" value=""
										placeholder="Dose" aria-describedby="basic-addon2"> <input
										type="number" class="form-control" id="frequency"
										name="frequency" value="" placeholder="Frequency"
										aria-describedby="basic-addon2"> <input type="number"
										class="form-control" id="duration" name="duration" value=""
										placeholder="Duration" aria-describedby="basic-addon2">
								</div>


							</div>
						</div>
						<div class="row mb-3">
							<div class="form-group">
								<label for="test">Test</label> <input type="text"
									class="form-control" id="test" name="test" value="">
							</div>
						</div>
						<div class="row mb-3">
							<div class="form-group">
								<label for="recommendation">Recommendation</label>
								<textarea class="form-control" id="recommendation"
									name="recommendation" rows="4"></textarea>
							</div>
						</div>
						<div class="row">
							<div class="form-group">
								<button type="submit" class="btn btn-primary d-print-none">Submit</button>
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
        function setMedicineId<%= medicineId %>(){
            var medicationInput = document.getElementById('medication');
            var medicineIdInput = document.getElementById('medicine_id');
            medicineIdInput.value = <%= medicineId %>;
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