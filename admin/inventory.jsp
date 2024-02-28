<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inventory</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            background: url('Photos/body.jpg') center fixed;
            background-size: cover;
        }
        .container {
            margin-top: 5rem;
        }
        .bg-success {
            background-color: #28a745;
            color: white;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        label {
            margin-top: 0.5rem;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="text-center fw-bold fs-3 bg-success pt-4 text-light">Add Inventory</div>
    <form action="${pageContext.request.contextPath}/inventory" method="post" class="p-4">
        <div class="mb-3">
            <label for="itemname" class="form-label">Item Name:</label>
            <input type="text" name="itemname" class="form-control" placeholder="Item Name" required>
        </div>
        <div class="mb-3">
            <label for="departmentid" class="form-label">Department Id:</label>
            <input type="text" name="departmentid" class="form-control" placeholder="Department Id" required>
        </div>
        <div class="mb-3">
            <label for="quantity" class="form-label">Quantity:</label>
            <input type="number" name="quantity" class="form-control" placeholder="Quantity" required>
        </div>
        <div class="mb-3">
            <label for="price" class="form-label">Price:</label>
            <input type="number" name="price" class="form-control" placeholder="Price" required>
        </div>
        <div class="mb-3">
            <label for="lowStockqty" class="form-label">Low Stock Quantity:</label>
            <input type="number" name="lowStockqty" class="form-control" placeholder="Low Stock Quantity" required>
        </div>
        <div class="mb-3">
            <label for="datetime" class="form-label">Date:</label>
            <input type="datetime-local" name="datetime" class="form-control" placeholder="Date" required>
        </div>
        <button type="submit" class="btn btn-success">Add</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
