<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="login.SQLConnect"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<% Class.forName("com.mysql.cj.jdbc.Driver"); %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Inventory Items</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        table {
            margin-top: 20px;
            width: 100%;
        }
        th, td {
            text-align: center;
        }
        .btn-danger {
            background-color: #dc3545;
            color: #fff;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<% Class.forName("com.mysql.cj.jdbc.Driver"); %>
<%
    SQLConnect model = new SQLConnect();
    Connection con = null;
    con = model.connect();
    Statement statement = con.createStatement();
    String selectQuery = "SELECT i.itemid, i.itemname, d.dpt_name, i.quantity, i.price, i.lowStockqty, i.date " +
            			 "FROM inventory i JOIN department d ON i.departmentid = d.department_id order by i.itemid asc";

    ResultSet res = statement.executeQuery(selectQuery);
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<div class="m-5 shadow-lg bg-light rounded">
    <div class="container_fluid">
        <div class="text-center fw-bold fs-3 bg-success pt-4 text-light">Inventory Items</div>
        <div class="container">
            <form method="post" action="${pageContext.request.contextPath}/updateinventory">
                <div class="table-responsive"> <!-- Add this div for responsiveness -->
                    <table class="table table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th>Sl</th>
                                <th>Item Name</th>
                                <th>Department Name</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Low Stock Quantity</th>
                                <th>Bought at</th>
                                <th>Action</th>
                                <th>Action</th>
                                <th>Action</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% while (res.next()) { %>
                            <tr>
                                <td><%=res.getInt(1)%></td>
                                <td><input type="text" name="itemName_<%=res.getInt(1)%>"
                                    value="<%=res.getString(2)%>"></td>
                                <td><input type="text"
                                    name="departmentId_<%=res.getInt(1)%>"
                                    value="<%=res.getString(3)%>"></td>
                                <td><input type="text" name="quantity_<%=res.getInt(1)%>"
                                    value="<%=res.getInt(4)%>" readonly></td>
                                <td><input type="text" name="price_<%=res.getInt(1)%>"
                                    value="<%=res.getInt(5)%>"></td>
                                <td><input type="text"
                                    name="lowStockQuantity_<%=res.getInt(1)%>"
                                    value="<%=res.getInt(6)%>"></td>
                                <td><input type="text" name="date_<%=res.getInt(1)%>"
                                    value="<%=res.getTimestamp(7)%>" readonly></td>
                            
                                <td>
                                    <div class="d-flex align-items-center">
                                        <input type="number" name="buyquantity_<%= res.getInt(1) %>" placeholder="Enter quantity"  class="me-2">
                                        <button type="submit" name="action" value="buy_<%= res.getInt(1) %>" class="btn btn-success">Buy</button>
                                    </div>
                                </td>
                                
                                <td>
                                    <div class="d-flex align-items-center">
                                        <input type="number" name="returnquantity_<%= res.getInt(1) %>" placeholder="Enter quantity" class="me-2">
                                        <button type="submit" name="action" value="return_<%= res.getInt(1) %>" class="btn btn-danger">Return</button>
                                    </div>
                                </td>
                                
                                <td>
                                    <button type="submit" name="action" value="update_<%= res.getInt(1) %>" class="btn btn-primary">Update</button>
                                </td>
                                
                                <td>
                                    <button type="submit" name="action" value="delete_<%= res.getInt(1) %>" class="btn btn-danger">Delete</button>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </form>
            <hr>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
