<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@page import="login.SQLConnect"%>

<%
    // Import necessary classes and establish database connection
    SQLConnect model = new SQLConnect();
    Connection con = model.connect();
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // Retrieve attributes from request
    int app_id = (Integer)request.getAttribute("ipd_app_id");
    String name = (String) request.getAttribute("name");
    String age = (String) request.getAttribute("age");
    String gender = (String) request.getAttribute("gender");
    String ward_name = (String) request.getAttribute("ward_name");
    String checkin_date = (String) request.getAttribute("checkin_date");
    String status = (String) request.getAttribute("status");
    String doctor = (String) request.getAttribute("doctor");
    String nurse = (String) request.getAttribute("nurse");

    // Display patient details
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IPD Discharge</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            padding: 100px;
            font-family: Arial, sans-serif;
        }
        .patient-info {
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .medication-info {
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .fw-semibold {
            font-weight: 600;
        }
        hr {
            margin-top: 20px;
            margin-bottom: 20px;
            border: 0;
            border-top: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="patient-info">
            <div class="row">
                <div class="col">
                    <p>
                        <span class="fw-semibold">Patient Name:</span> <%= name %><br> 
                        <span class="fw-semibold">Age/Gender:</span> <%= age %> / <%= gender %><br>
                        <span class="fw-semibold">Check-in Date:</span> <%= checkin_date %><br>								
                    </p>
                </div>
                <div class="col">
                    <p>
                        <span class="fw-semibold">Ward Name:</span> <%= ward_name %><br>
                        <span class="fw-semibold">Payment Status:</span> <%= status %><br>
                        <span class="fw-semibold">Doctor Name:</span> <%= doctor %><br>
                        <span class="fw-semibold">Nurse Name:</span> <%= nurse %><br>
                    </p>
                </div>
            </div>
        </div>


<div class="medication-info">
    <h4>Prescribed Medicines</h4>
    
					<div class="row">
						<div class="col-4">
						 	<%
						 	
						int app_id1 = (Integer)request.getAttribute("ipd_app_id");
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
							pstmt.setInt(1, app_id1);
							rs = pstmt.executeQuery();
							while (rs.next()) {
								nurse_notes = rs.getString("ip.nurse_notes");

								System.out.println("Debug nurse_notes: " + nurse_notes);System.out.println("dose is other "+dosage);
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
						

						e.printStackTrace();

					

						}
						%>
						
						
						
						</div>
</div>
</div>

        <!-- Display Discharge Date -->
        <div>
            <h4>Discharge date:</h4>
            <h5><%= new Date().toString() %></h5>
        </div>

        <!-- Print Button -->
        <button class="btn btn-primary" onclick="window.print();">Print</button>
    </div>
</body>
</html>
