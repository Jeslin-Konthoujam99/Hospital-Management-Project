<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <title>Add Medicine</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }
        form {
            max-width: 500px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 8px;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<br><br><br>
    <form action="../AddMedicine" method="post">
        <h2>Add Medicine</h2>

        <label for="medicine_name">Medicine Name:</label>
        <input type="text" id="medicine_name" name="medicine_name" required>

        <label for="manufacturer">Manufacturer:</label>
        <input type="text" id="manufacturer" name="manufacturer" >

        <label for="dosage_form">Dosage Form:</label>
        <input type="text" id="dosage_form" name="dosage_form" >

        <label for="active_ingredient">Active Ingredient:</label>
        <input type="text" id="active_ingredient" name="active_ingredient" >

        <label for="unit_price">Unit Price:</label>
        <input type="text" id="unit_price" name="unit_price" required>

        <input type="submit" value="Add Medicine">
    </form>

</body>
</html>