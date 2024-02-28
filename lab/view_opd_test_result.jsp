<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="login.SQLConnect" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blood Test Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            padding: 60px;
        }
        table {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2 class="mt-4 mb-4">Blood Test Report</h2>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Prescription ID</th>
                    <th>Patient Name</th>
                    <th>Doctor Name</th>
                    <th>Department </th>
                    <th>Test Date</th>
                    <th>Blood Type</th>
                </tr>
            </thead>
            <tbody>
<% 
  SQLConnect model = new SQLConnect();
  Connection con = model.connect();
  try {
  	String sqlQuery = "SELECT " +
  		    "op.prescription_id, " +
  		    "op.test, " +
  		    "oa.booked_id, " +
  		    "d.dpt_name AS department_name, " +
  		    "CONCAT(e.firstname, ' ', e.lastname) AS doctor_fullname, " +
  		    "oa.date AS appointment_date, " +
  		    "p.fullname, " +
  		    "tb.Blood_id, " +
  		    "tb.Amount, " +
  		    "tb.date AS payment_date, " +
  		    "tb.payment_status, " +
  		    "tr.result_id, " +
  		    "tr.Blood_type, " +
  		    "tr.Employee_id " +
  		    "FROM " +
  		    "opd_prescriptions op " +
  		    "JOIN opd_appointments oa ON op.appointment_id = oa.booked_id " +
  		    "JOIN patients p ON oa.patient_id = p.patientid " +
  		    "JOIN department d ON oa.department_id = d.department_id " +
  		    "JOIN employeelist e ON oa.doctor_id = e.employee_id " +
  		    "JOIN testbill tb ON op.prescription_id = tb.prescription_id " +
  		    "JOIN testresult tr ON tb.Blood_id = tr.Blood_id " +
  		    "WHERE op.test = 'blood done' " +
  		    "ORDER BY op.prescription_id DESC;";



      try (PreparedStatement preparedStatement = con.prepareStatement(sqlQuery);
           ResultSet resultSet = preparedStatement.executeQuery()) {

          // Display table headers
          while (resultSet.next()) {
%>
              <tr>
                  <td><%= resultSet.getInt("op.prescription_id") %></td>
                  <td><%= resultSet.getString("p.fullname") %></td>
                  <td><%= resultSet.getString("doctor_fullname") %></td>
                  <td><%= resultSet.getString("department_name") %></td>
                  <td><%= resultSet.getString("payment_date") %></td>
                  <td><%= resultSet.getString("Blood_type") %></td>
              </tr>
<%
          }
      }
  } catch (SQLException e) {
      e.printStackTrace();
  } finally {
      try {
          // Close the connection in the finally block
          if (con != null && !con.isClosed()) {
              con.close();
          }
      } catch (SQLException e) {
          e.printStackTrace();
      }
  }
%>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
