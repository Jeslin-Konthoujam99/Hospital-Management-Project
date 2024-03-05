<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OPD Receipt</title>
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

    <div class="container bg-white p-4 rounded shadow-sm">
        <h1 class="text-center">OPD Receipt</h1>
        <h1 class="text-center">Cubeten Hospital</h1>

        <p><strong>Booked ID:</strong> <%= request.getAttribute("booked_id") %></p>
        <p><strong>Patient Name:</strong> <%= request.getAttribute("patient_name") %></p>
        <p><strong>Department Name:</strong> <%= request.getAttribute("department_name") %></p>
        <p><strong>Doctor Name:</strong> <%= request.getAttribute("doctor_name") %></p>
        <p><strong>Date:</strong> <%= new SimpleDateFormat("yyyy-MM-dd").format(request.getAttribute("date")) %></p>
        <p><strong>Payment Status:</strong> Paid</p>
        <p><strong>Pay Amount:</strong> <%= request.getAttribute("pay") %></p>
        
        <button class="btn btn-primary d-print-none" name="print"
						onclick="window.print()">Print</button>
        
    </div>
    
    <!-- Bootstrap JS and Popper.js scripts (needed for Bootstrap) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
