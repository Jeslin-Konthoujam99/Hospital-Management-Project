<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*"%>
<%@ page import="login.SQLConnect"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View OPD Receipt</title>
    <!-- Bootstrap CSS link -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            margin-top: 50px;
        }
        h1 {
            color: #007bff;
            margin-bottom: 20px;
        }
        strong {
            color: #007bff;
        }
    </style>
</head>
<body>
<%
int booked_id = Integer.parseInt(request.getParameter("booked_id"));

 
Connection con = null;
SQLConnect model = new SQLConnect();
con = model.connect();
Statement stmt = null;
ResultSet res = null;
PreparedStatement preparedStatement = null;
String sql = "SELECT * FROM opd_bill join opd_appointments on opd_bill.booked_id=opd_appointments.booked_id where opd_bill.booked_id = ? order by opd_bill_id desc limit 1";
try {
    stmt = con.createStatement();
    preparedStatement = con.prepareStatement(sql);
    // Set the patient ID parameter in the SQL query
    preparedStatement.setInt(1, booked_id);
    res = preparedStatement.executeQuery();
    System.out.println("QUERY EXECUTED SUCCESSFULLY");
} catch (Exception e) {
    System.out.println("QUERY failed");
}
String pay_status = "";
String date ="";
int amount = 0 ;
int doc_id=0;
String book_date="";
Timestamp time = null;
if (res.next()) {
	pay_status=res.getString("opd_bill.pay_status");
	date=res.getString("opd_bill.date");
	book_date=res.getString("opd_appointments.date");
	amount=res.getInt("opd_bill.amount");
	doc_id=res.getInt("opd_appointments.doctor_id");
}
String start = date.substring(0, 10);
start = start+" 00:00:00";
System.out.println("time :" + start);
int serial = 0 ;
try 
{
	PreparedStatement pstmt = con.prepareStatement("SELECT COUNT(*) AS appointment_count FROM opd_appointments WHERE date >= ? and appointment_status IN ('seen by nurse', 'confirmed') and booked_id<= ? and doctor_id = ?" );
	pstmt.setString(1,start);
	pstmt.setInt(2, booked_id );
	pstmt.setInt(3, doc_id );
	res = pstmt.executeQuery();
	if(res.next())
	{
		serial = res.getInt("appointment_count");
	}			
}
catch (Exception e) 
{
	e.printStackTrace(); // Handle SQL exception
}
%>
    <div class="container bg-white p-4 rounded shadow-sm">
        <h1 class="text-center">OPD Receipt</h1>
        <h1 class="text-center">Cubeten Hospital</h1>

        <p><strong>Booked ID:</strong> <%=booked_id %></p>
        <p><strong>Serial No:</strong> <%=serial %></p>
        <p><strong>Patient Name:</strong> <%= session.getAttribute("fullname") %></p>
        <p><strong>Department Name:</strong> <%= request.getParameter("department_name") %></p>
        <p><strong>Doctor Name: </strong> <%= request.getParameter("doc") %> <%= request.getParameter("doc1") %></p>
        <p><strong>Booked Date-Time:</strong> <%=book_date %></p>
        
       
        
        <p><strong>Payment Date:</strong> <%=date %></p>
        <p><strong>Payment Status:</strong><%=pay_status %></p>
        <p><strong>Paid Amount:</strong> <%=amount %></p>
                
        <button class="btn btn-primary d-print-none" name="print"
						onclick="window.print()">Print</button>
        
    </div>
    
    <!-- Bootstrap JS and Popper.js scripts (needed for Bootstrap) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
