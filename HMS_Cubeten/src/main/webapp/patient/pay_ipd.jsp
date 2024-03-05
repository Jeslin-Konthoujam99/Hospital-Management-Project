
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>GPAY PORTAL - Pay Ipd Bill</title>
    <!-- Bootstrap CSS link -->
     <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
 <style>
        body {
            padding: 100px;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        form {
            max-width: 400px;
            margin: auto;
        }

        label {
            margin-bottom: 0.5rem;
            font-weight: bold;
        }

        input {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<%
int ipd_appointment_id = 0 ;
int amount=0;
//retrieve booked_id
if(     	request.getParameter("ipd_appointment_id") != null 
		&& !request.getParameter("ipd_appointment_id").isEmpty() 
		&& request.getParameter("amount") != null 
		&& !request.getParameter("amount").isEmpty()
){
ipd_appointment_id = Integer.parseInt(request.getParameter("ipd_appointment_id"));

// Retrieve the discountedAmount from the request
amount = Integer.parseInt(request.getParameter("amount"));
}
// Format the BigDecimal as a String for display
NumberFormat currencyFormatter = new DecimalFormat("#,##0.00");
String formattedDiscountedAmount = currencyFormatter.format(amount);
%>
    <div class="container">
        <h1 class=text-center>GPAY PORTAL -Pay Ipd Bill</h1>

        <form action="../PayIpdBill" method="post">
            <!-- IPD Appointment ID -->
            <div class="form-group">
                <label for="ipd_appointment_id">IPD Appointment ID:</label>
                <input type="number" value="<%=ipd_appointment_id %>" id="ipd_appointment_id" name="ipd_appointment_id" class="form-control" readonly>
            </div>

            <!-- Amount -->
            <div class="form-group">
                <label for="amount">Amount:</label>
                <input type="number" value="<%=amount %>" id="amount" name="amount" class="form-control" readonly>
            </div>

            <button type="submit" class="btn btn-primary">Pay Up</button>
        </form>
    </div>

    <!-- Bootstrap JS and Popper.js scripts (optional) -->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
