<%@page import="login.SQLConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OPD Bill</title>
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
        <h2>OPD Bill</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>OPD Bill ID</th>
                    <th>Booked ID</th>
                    <th>Pay Status</th>
                    <th>Date</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                    	SQLConnect model = new SQLConnect();
                        Connection con = null;
                        con = model.connect();
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM opd_bill");
                        while(rs.next()) {
                %>
                            <tr>
                                <td><%= rs.getInt("opd_bill_id") %></td>
                                <td><%= rs.getInt("booked_id") %></td>
                                <td><%= rs.getString("pay_status") %></td>
                                <td><%= rs.getDate("date") %></td>
                                <td><%= rs.getFloat("amount") %></td>
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