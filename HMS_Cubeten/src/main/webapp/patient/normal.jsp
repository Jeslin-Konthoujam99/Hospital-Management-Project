<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="login.SQLConnect" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Normal</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            padding: 60px;
            padding-left: 70px;
        }
        h2 {
            text-align: center;
        }
        table {
            width: 50%;
            margin: auto;
        }
    </style>
</head>
<body>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    SQLConnect model = new SQLConnect();
    try {
        con = model.connect();
    } catch (Exception e) {
        e.printStackTrace();
    }
    int patientid = (Integer) session.getAttribute("patientid");
    String patientname = (String) session.getAttribute("fullname");
   
%>

<h2>
    BED LIST
    <button onclick="window.location.reload();">
        <i class="bi bi-arrow-clockwise"></i>
    </button>
</h2>

<table class="table mx-auto">
    <thead>
    <tr>
        <th>BED NO</th>
        <th>Ward Name</th>
        <th>AVAILABILITY</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <%
        try {
            String avail1 = "yes";
            Statement st = con.createStatement();
            ResultSet rs1 = null;
            String sql1 = "select * from ward";
            rs1 = st.executeQuery(sql1);
            while (rs1.next()) {
    %>
    <tr>
        <td><%= rs1.getInt("b_id") %></td>
        <td><%= rs1.getString("ward_name") %></td>
        <td><%= rs1.getString("availability") %></td>
        <td>
            <%
                if (avail1.equals(rs1.getString("availability"))) {
            %>
            <form action="../sendbedid" method="post">
                <input type="hidden" value="<%= patientid %>" name="patient_id">
                <input type="hidden" value="<%= rs1.getInt("ward_id") %>" name="ward_id">
                <button type="submit" class="btn btn-primary">Choose</button>
            </form>
            <%
                }
            %>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    </tbody>
</table>

<!-- Bootstrap JS and Popper.js links (required for dropdowns) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</body>
</html>
