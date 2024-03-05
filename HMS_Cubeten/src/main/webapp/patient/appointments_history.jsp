<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.SQLConnect"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OPD Appointment History</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding: 100px;
        }

        .container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        hr {
            margin-top: 20px;
            margin-bottom: 20px;
            border: 0;
            border-top: 1px solid #e0e0e0;
        }

        .appointment-card {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }

        .btn-pay, .btn-cancel {
            width: 150px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center mb-4"> OPD Appointment History</h2>

        <%
        int patientID = (Integer) session.getAttribute("patientid");
        Connection con = null;
        SQLConnect model = new SQLConnect();
        con = model.connect();
        Statement stmt = null;
        ResultSet res = null;
        PreparedStatement preparedStatement = null;

        String payStatus = "Not Found";
        
        String SELECT_APPOINTMENTS = "SELECT " +
        	    "oa.booked_id, " +
        	    "oa.patient_id, " +
        	    "oa.date, " +
        	    "oa.appointment_status, " +
        	    "el.firstname AS doctor_firstname, " +
        	    "el.lastname AS doctor_lastname, " +
        	    "d.dpt_name AS department_name " +
        	"FROM " +
        	    "opd_appointments oa " +
        	"JOIN " +
        	    "employeelist el ON oa.doctor_id = el.employee_id " +
        	"JOIN " +
        	    "department d ON oa.department_id = d.department_id " +
        	"WHERE " +
        	    "oa.patient_id = ? " +
        	"ORDER BY " +
        	    "oa.date DESC;";


        try {
            stmt = con.createStatement();
            preparedStatement = con.prepareStatement(SELECT_APPOINTMENTS);

            // Set the patient ID parameter in the SQL query
            preparedStatement.setInt(1, patientID);
            res = preparedStatement.executeQuery();
            System.out.println("QUERY EXECUTED SUCCESSFULLY");
        } catch (Exception e) {
            System.out.println("QUERY failed");
        }

        try {
            while (res.next()) {
            	String doc = res.getString("doctor_firstname") + " " + res.getString("doctor_lastname") ;
            	String doc1 = res.getString("doctor_lastname") ;
            	String date = res.getString("oa.date") ;
        %>
        <div class="appointment-card">
            <p class="mb-1"><strong>Appointment with Doctor:</strong> <%=doc %> </p>
            <p class="mb-1"><strong>Department:</strong> <%= res.getString("department_name") %></p>
            <p class="mb-1"><strong>Date:</strong> <%= res.getTimestamp("oa.date") %></p>
            <p class="mb-1"><strong>Status:</strong> <%= res.getString("oa.appointment_status") %></p>

            <!-- Retrieve pay_status based on booked_id from opd_bill table -->
            <%
            int bookedId = res.getInt("oa.booked_id");
            payStatus = res.getString("oa.appointment_status");

            boolean disableSubmit1 = "confirmed".equals(payStatus);
            boolean disableSubmit2 = "cancelled".equals(payStatus);
            %>

           <div class="mb-3">
    <form action="../PayAppointment" method="post">
        <!-- booked_id ID -->
        <input type="hidden" value=<%= res.getInt("booked_id") %> id="booked_id" name="booked_id" readonly class="form-control">

        <button type="submit" class="btn btn-primary btn-pay mt-2" <%= disableSubmit1 ? "disabled" : "" %>>Pay for Appointment</button>
    </form>
</div>

<div class="mb-3">
    <form action="../CancelOpdAppointment" method="post">
        <!-- booked_id ID -->
        <input type="hidden" value=<%= res.getInt("booked_id") %> id="booked_id" name="booked_id" readonly class="form-control">
        
        <button type="submit" class="btn btn-danger btn-cancel"
         <%= disableSubmit2 ? "disabled" : "" %>>Cancel Appointment</button>
    </form>
</div>

<div class="mb-3">
    <form action="view_opd_reciept.jsp" method="post">
        <input type="hidden" value=<%= res.getInt("booked_id") %> name="booked_id"  >
        <input type="hidden" value=<%= res.getString("department_name") %>  name="department_name" >
        <input type="hidden" value=<%=date %> name="book_date" >
        <input type="hidden" value=<%=doc%>  name="doc" >
        <input type="hidden" value=<%=doc1%>  name="doc1" >
        
        <button type="submit" class="btn btn-danger btn-cancel"
         <%= disableSubmit1 ? "" : "disabled" %>>View Reciept</button>
    </form>
</div>


        </div>
        <hr>

        <%
            }//while
        }//try
        catch (SQLException e) {
            System.out.println("Unable to fetch data from the database");
        }
        %>
    </div>

    <!-- Bootstrap JS and Popper.js (required for Bootstrap) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
