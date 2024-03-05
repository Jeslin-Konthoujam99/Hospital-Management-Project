<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GPAY PORTAL</title>
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
        label {
            margin-top: 10px;
        }
        input {
            margin-bottom: 15px;
        }
        .btn-pay {
            background-color: #007bff;
            color: #fff;
        }
    </style>
</head>
<body>
<%
//retrieve booked_id
int booked_id = (Integer)request.getAttribute("booked_id");

// Retrieve the discountedAmount from the request
float discountedAmount = (Float)request.getAttribute("discountedAmount");

// Format the BigDecimal as a String for display
NumberFormat currencyFormatter = new DecimalFormat("#,##0.00");
String formattedDiscountedAmount = currencyFormatter.format(discountedAmount);
%>
    <div class="container bg-white p-4 rounded shadow-sm">
        <h1 class="text-center">GPAY PORTAL</h1>

        <p>Formatted Amount: <%= formattedDiscountedAmount %></p>

        <form action="OpdBillPaid" method="post">
            <div class="mb-3">
                <input type="hidden" value="<%= booked_id %>" id="booked_id" name="booked_id" class="form-control" readonly>
            </div>

            <div class="mb-3">
                <input type="hidden" value="<%= discountedAmount %>" id="pay" name="pay" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-pay">Pay Up</button>
        </form>
    </div>

    <!-- Bootstrap JS and Popper.js scripts (needed for Bootstrap) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
