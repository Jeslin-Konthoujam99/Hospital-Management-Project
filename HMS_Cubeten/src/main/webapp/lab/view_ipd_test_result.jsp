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
                    <th>Ward Name </th>
                    <th>Bed No </th>
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
  		    "op.test_required, " +
  		    "oa.ipd_appointment_id, " +
    		"w.ward_name AS ward_name, " +
		    "w.b_id AS bed_no, " +
    		"CONCAT(e.firstname, ' ', e.lastname) AS doctor_fullname, " +
  		    "CONCAT(ee.firstname, ' ', ee.lastname) AS nurse_fullname, " +
  		    "p.fullname, " +
  		    "tb.test_bill_id, " +
  		    "tb.test_cost, " +
  		    "tb.test_date AS payment_date, " +
  		    "tb.payment_status, " +
  		    "tr.testResult_id, " +
  		    "tr.blood_type, " +
  		    "tr.Employee_id " +
  		    "FROM " +
  		    "ipd_prescription op " +
  		    "JOIN ipd_appointment oa ON op.ipd_appointment_id = oa.ipd_appointment_id " +
  		    "JOIN patients p ON oa.patient_id = p.patientid " +
  		    "JOIN ward w ON oa.ward_id = w.ward_id " +
  		    "JOIN employeelist e ON oa.doctor_id = e.employee_id " +
  		    "JOIN employeelist ee ON oa.nurse_id = ee.employee_id " +
  		    "JOIN ipd_test_bill tb ON op.prescription_id = tb.ipd_prescription_id " +
  		    "JOIN ipd_testresult tr ON tb.test_bill_id = tr.bill_id " +
  		    "WHERE op.test_required = 'blood done' " +
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
                  <td><%= resultSet.getString("ward_name") %></td>
                  <td><%= resultSet.getString("bed_no") %></td>
                  <td><%= resultSet.getString("payment_date") %></td>
                  <td><%= resultSet.getString("tr.blood_type") %></td>
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
