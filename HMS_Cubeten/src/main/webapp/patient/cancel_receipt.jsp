<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OPD Cancel Receipt</title>
    <!-- Bootstrap CSS link -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
        }
        h1 {
            color: #007bff;
        }
        strong {
            color: #6c757d;
        }
        .mb-2 {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

    <div class="container mt-5 bg-white p-4 rounded shadow-sm">
        <h1 class="text-center mb-4">OPD Cancel Receipt</h1>

        <p class="mb-2"><strong>Date today:</strong> <%= request.getAttribute("currentDate") %></p>

        <p class="mb-2"><strong>Booked ID:</strong> <%= request.getAttribute("booked_id") %></p>
        <p class="mb-2"><strong>Patient Name:</strong> <%= request.getAttribute("patient_name") %></p>
        <p class="mb-2"><strong>Department Name:</strong> <%= request.getAttribute("department_name") %></p>
        <p class="mb-2"><strong>Doctor Name:</strong> <%= request.getAttribute("doctor_name") %></p>
        <p class="mb-2"><strong>Date of appointment:</strong> <%= request.getAttribute("date") %></p>
        <p class="mb-2"><strong>Refunded Amount:</strong> <%= request.getAttribute("amount") %></p>
    </div>

    <!-- Bootstrap JS and Popper.js scripts (needed for Bootstrap) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
