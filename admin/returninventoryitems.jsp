<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="login.SQLConnect" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Return Inventory Items</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
   
     <style>
        body {
            background-color: #f8f9fa;
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
        .mb-3 {
            margin-bottom: 15px;
        }
        .btn-primary {
            background-color: #007bff;
            color: #fff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
 <div class="m-5 shadow-lg bg-light rounded">
    <div class="container_fluid">
        <div class="text-center fw-bold fs-3 bg-success pt-4 text-light">Return Inventory Item</div>
        <div class="container">

            <form action="${pageContext.request.contextPath}/returnitem" method="post">
                <div class="mb-3">
                    <label for="equipmentid" class="form-label">Item ID:</label>
                    <input type="text" name="itemid" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="quantityReturned" class="form-label">Quantity Returned:</label>
                    <input type="text" name="quantityReturned" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary">Return</button>
            </form>

        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>