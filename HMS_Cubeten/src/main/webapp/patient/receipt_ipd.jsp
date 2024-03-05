
<!DOCTYPE html>
<html lang="en">
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IPD Bill Receipt</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        body {
            padding: 50px;
        }

        .card {
            border: 1px solid #ddd;
            margin: 20px auto;
            max-width: 600px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #ddd;
            padding: 20px;
        }

        .card-body {
            padding: 20px;
        }

        .card-title {
            margin-bottom: 0;
        }

        .list-group-item {
            border: none;
            padding: 10px 0;
        }

        .list-group-item strong {
            font-weight: bold;
            margin-right: 10px;
        }
    </style>
</head>
<body>
<% // Get the current date and time
        LocalDateTime currentDateTime = LocalDateTime.now();
        
        // Define a custom date and time format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        // Format the LocalDateTime using the defined formatter
        String formattedDateTime = currentDateTime.format(formatter);
        

        %> <%= formattedDateTime %>
<div class="card">
    <div class="card-header">
        <h5 class="card-title">IPD Bill Receipt</h5>
    </div>
    <div class="card-body">
        <ul class="list-group list-group-flush">
            <li class="list-group-item"><strong>Payment for IPD Appointment Id:</strong> <%= request.getAttribute("ipd_appointment_id") %></li>
            <li class="list-group-item"><strong>Amount Paid:</strong> <%= request.getAttribute("amount") %></li>
            <li class="list-group-item"><strong>Patient Full Name:</strong> <%= request.getAttribute("patientFullName") %></li>
            <li class="list-group-item"><strong>Check-in Date:</strong> <%= request.getAttribute("checkin_date") %></li>
            <li class="list-group-item"><strong>Ward Name:</strong> <%= request.getAttribute("wardName") %></li>
            <li class="list-group-item"><strong>Doctor Name:</strong> <%= request.getAttribute("doctorFirstName") %></li>
            <li class="list-group-item"><strong>Nurse Name:</strong> <%= request.getAttribute("nurseFirstName") %></li>
           <li class="list-group-item"><strong>Date Time Now:</strong> <%= formattedDateTime %></li>
        </ul>
         <button class="btn btn-primary d-print-none" name="print"
						onclick="window.print()">Print</button>
    </div>
</div>

<!-- Bootstrap JS and Popper.js (required for Bootstrap) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
