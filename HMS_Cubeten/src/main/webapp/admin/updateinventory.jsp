<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="login.SQLConnect" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<% Class.forName("com.mysql.cj.jdbc.Driver"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Update Inventory</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            background: url(Photos/body.jpg) center/cover fixed;
        }
        .container {
            margin-top: 20px;
        }
        .shadow-box {
            margin: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #007bff;
        }
        label {
            margin-top: 0.5rem;
            display: block;
        }
        input {
            margin-bottom: 1rem;
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
        ResultSet res = statement.executeQuery("select * from inventory");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    %>
    <div class="m-5 shadow-lg bg-light rounded">
	<div class="container_fluid">
	<div class="text-center fw-bold fs-3 bg-success pt-4 text-light">Update Inventory Items</div>

      <% while(res.next()){ %>
 <div class="container mt-5">
    <form method="post" action="${pageContext.request.contextPath}/updateinventory">
        <div class="mb-3">
            <label for="itemid" class="form-label">Item ID:</label>
            <input type="hidden" name="itemid" value="<%= res.getInt(1) %>">
            <%= res.getInt(1) %>
        </div>

        <div class="mb-3">
            <label for="itemname" class="form-label">Item Name:</label>
            <input type="text" name="itemname" class="form-control" value="<%= res.getString(2) %>">
        </div>

        <div class="mb-3">
            <label for="departmentid" class="form-label">Department Id:</label>
            <input type="text" name="departmentid" class="form-control" value="<%= res.getString(3) %>">
        </div>

        <div class="mb-3">
            <label for="quantity" class="form-label">Quantity:</label>
            <input type="number" name="quantity" class="form-control" value="<%= res.getInt(4) %>">
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Price:</label>
            <input type="number" name="price" class="form-control" value="<%= res.getInt(5) %>">
        </div>

        <div class="mb-3">
            <label for="lowStockqty" class="form-label">Low Stock Quantity:</label>
            <input type="number" name="lowStockqty" class="form-control" value="<%= res.getInt(6) %>">
        </div>

        <div class="mb-3">
            <label for="datetime" class="form-label">Date:</label>
            <input type="datetime-local" name="datetime" class="form-control" value="<%= dateFormat.format(res.getTimestamp(7))%>">
        </div>

        <div class="mb-3">
            <input type="submit" value="Update" class="btn btn-primary">
        </div>
    </form>
</div>

            <hr>
          <% } %>
    </div>
</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
  
