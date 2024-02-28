<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="login.SQLConnect" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<% Class.forName("com.mysql.cj.jdbc.Driver"); %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Update Equipment</title>
         <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #007bff;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="datetime-local"] {
            width: calc(100% - 16px); /* Adjust width for date-time input */
        }
        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%
    SQLConnect model = new SQLConnect();
        Connection con = null;
        con = model.connect();
        Statement statement = con.createStatement();
        ResultSet res = statement.executeQuery("select * from equipment");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
    %>
<div class="m-5 shadow-lg bg-light rounded">
	<div class="container_fluid">
	<div class="text-center fw-bold fs-3 bg-success pt-4 text-light">Update Equipment</div>
   
        <% while(res.next()){ %>
             <div class="container">
    

        <form method="post" action="${pageContext.request.contextPath}/updateEquipment">
            <div class="form-group">
                <label for="equipmentid">Equipment ID:</label>
                <input type="hidden" name="equipmentid" value="<%= res.getInt(1) %>">
                <%= res.getInt(1) %>
            </div>
            <div class="form-group">
                <label for="equipmentname">Equipment Name:</label>
                <input type="text" name="equipmentname" value="<%= res.getString(2) %>">
            </div>
            <div class="form-group">
                <label for="departmentid">Department Id:</label>
                <input type="text" name="departmentid" value="<%= res.getString(3) %>">
            </div>
            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" name="quantity" value="<%= res.getInt(4) %>">
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" name="price" value="<%= res.getInt(5) %>">
            </div>
            <div class="form-group">
                <label for="lowStockqty">Low Stock Quantity:</label>
                <input type="number" name="lowStockqty" value="<%= res.getInt(6) %>">
            </div>
            <div class="form-group">
                <label for="datetime">Date:</label>
                <input type="datetime-local" name="datetime" value="<%= dateFormat.format(res.getTimestamp(7))%>">
            </div>
            <div class="form-group">
                <input type="submit" value="Update">
            </div>
        </form>
    </div>
            <hr>
        <% } %>
    </div>
    </div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</body>
</html>
