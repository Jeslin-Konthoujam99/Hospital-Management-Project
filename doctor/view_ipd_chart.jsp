<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*, javax.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>IPD Prescription Table</title>
    <!-- Bootstrap CSS -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
 <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<%
    // Database connection parameters
    String jdbcURL = "jdbc:mysql://localhost:3306/hms_cubeten?useSSL=false";
    String jdbcUsername = "root";
    String jdbcPassword = "root";

    // Load the JDBC driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    // Establish a connection
    Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    //int ipd_appointment_id =Integer.parseInt( request.getParameter("ipd_appointment_id"));
    // Query to retrieve data from the ipd_prescription table
    String sqlQuery = "SELECT " +
                    "ip.ipd_appointment_id, " +
                    "p.fullname AS patient_name, " +
                    "m.medicine_name, " +
                    "ipd.frequency, " +
                    "ipd.duration, " +
                    "ipd.doctor_notes, " + 
                    "ipd.nurse_notes, " +
                    "ipd.test_required " +
                  "FROM " +
                    "ipd_prescription ipd " +
                  "JOIN " +
                    "ipd_appointment ip ON ipd.ipd_appointment_id = ip.ipd_appointment_id " +
                  "JOIN " +
                    "patients p ON ip.patient_id = p.patientid " +
                  "JOIN " +
                    "medicines m ON ipd.medicine_id = m.medicine_id";


    Statement statement = connection.createStatement();
    ResultSet resultSet = statement.executeQuery(sqlQuery);
%>

<div class="container">
    <h2>IPD Prescription Table</h2>

    <table class="table">
        <thead class="thead-light">
            <tr>
                
                <th>IPD Appointment ID</th>
                <th>Patient Name</th>
                <th>Doctor Notes</th>
                <th>Nurse Notes</th>
                <th>Test Required</th>
                <th>Medicine</th>
                <th>frequency</th>
                <th>duration</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Iterate through the result set and display the data
                while (resultSet.next()) {
            %>
                    <tr>
                        <td><%= resultSet.getInt("ip.ipd_appointment_id") %></td>
                        <td><%= resultSet.getString("patient_name") %></td>
                        <td><%= resultSet.getString("ipd.doctor_notes") %></td>
                        <td><%= resultSet.getString("ipd.nurse_notes") %></td>
                        <td><%= resultSet.getString("ipd.test_required") %></td>
                        <td><%= resultSet.getString("m.medicine_name") %></td>
                        <td><%= resultSet.getString("ipd.frequency") %></td>
                        <td><%= resultSet.getString("ipd.duration") %></td>
                    </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

<%
    // Close the resources
    resultSet.close();
    statement.close();
    connection.close();
%>

<!-- Bootstrap JS and Popper.js (required for Bootstrap) -->
<script type="text/javascript"src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.4.2/mdb.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
