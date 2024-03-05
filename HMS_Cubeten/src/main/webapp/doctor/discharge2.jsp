<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@page import="login.SQLConnect" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OPD Discharge</title>
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





	<%
	Connection con;
	SQLConnect m = new SQLConnect();
	con = m.connect();
	System.out.println(con);
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;


int appointmentid = (Integer)request.getAttribute("appointmentid");
int pid1 = (Integer)request.getAttribute("pid1");
String name = (String)request.getAttribute("name");
int age = (int)request.getAttribute("age");
String gender = (String)request.getAttribute("gender");
String status = (String)request.getAttribute("status");
String date = (String)request.getAttribute("date");
String doctor = (String)request.getAttribute("doctor");
String dpt_name = (String)request.getAttribute("dpt_name");
int docid =0 ;
%>

<div class="container">
        <div class="patient-info">
            <div class="row">
                <div class="col">
                    <p>
                        <span class="fw-semibold">Patient Name:</span> <%= name %><br> 
                        <span class="fw-semibold">Age/Gender:</span> <%= age %> / <%= gender %><br>
                        <span class="fw-semibold">Department:</span> <%= dpt_name %><br>	
                        <span class="fw-semibold">Doctor Name:</span> <%= doctor %><br>							
                    </p>
                </div>
                <div class="col">
                    <p>
                        <span class="fw-semibold">Date:</span> <%= date %><br>
                        <span class="fw-semibold">Payment Status:</span> <%= status %><br>
                        
                        
                    </p>
                </div>
            </div>
        </div>

<div class="card-body">
					<div class="row">
						<div class="col-4">
				<%
				String medication = "";
				String dose = "";
				String dosage = "";
				String duration = "";
				String test = "";
				String recommendation = "";
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

				

				}
				%>

			</div>

        <!-- Display Discharge Date -->
        <div>
            <h4>Discharge date:</h4>
            <h5><%= new Date().toString() %></h5>
        </div>

        <!-- Print Button -->
        <button class="btn btn-primary" onclick="window.print();">Print</button>
    </div>
    </div>
    </div>

</body>
</html>