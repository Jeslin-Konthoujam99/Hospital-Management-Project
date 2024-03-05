<%@page import="login.SQLConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Bill Table</title>
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
        <h2>Test Bill Table</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Blood ID</th>
                    <th>Prescription ID</th>
                    <th>Amount</th>
                    <th>Date</th>
                    <th>Payment Status</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                    	SQLConnect model = new SQLConnect();
                        Connection con = null;
                        con = model.connect();
                        
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM testbill");
                        while(rs.next()) {
                %>
                            <tr>
                                <td><%= rs.getInt("Blood_id") %></td>
                                <td><%= rs.getInt("prescription_id") %></td>
                                <td><%= rs.getBigDecimal("Amount") %></td>
                                <td><%= rs.getDate("date") %></td>
                                <td><%= rs.getString("payment_status") %></td>
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
