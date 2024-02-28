<%@page import="login.SQLConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IPD Bill</title>
         <style>
        body {
            padding: 100px;
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
</style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>IPD Bill</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>IPD Bill ID</th>
                    <th>IPD Appointment ID</th>
                    <th>Amount</th>
                    <th>Reason</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                    	SQLConnect model = new SQLConnect();
                        Connection con = null;
                        con = model.connect();
                        
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM ipd_bill");
                        while(rs.next()) {
                %>
                            <tr>
                                <td><%= rs.getInt("ipd_bill_id") %></td>
                                <td><%= rs.getInt("ipd_appointment_id") %></td>
                                <td><%= rs.getInt("amount") %></td>
                                <td><%= rs.getString("reason") %></td>
                                <td><%= rs.getTimestamp("date") %></td>
                            </tr>
                <%
                        }
                        con.close();
                    } catch(Exception e) {
                        out.println(e);
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
