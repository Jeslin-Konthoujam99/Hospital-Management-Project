<%@ page import="java.sql.*"%>
<%@ page import="login.SQLConnect"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<meta charset="UTF-8">
<title>Update Medicine</title>
<style>
form {
	max-width: 500px;
	margin: 20px auto;
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

	<%
	try {
		// JDBC parameters
		SQLConnect co = new SQLConnect();
		Connection connection = co.connect();

		// Retrieve medicine details for the given medicine_id
		int medicineId = Integer.parseInt(request.getParameter("medicine_id"));

		String selectQuery = "SELECT * FROM medicines WHERE medicine_id = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
		preparedStatement.setInt(1, medicineId);
		ResultSet resultSet = preparedStatement.executeQuery();
		if (resultSet.next()) {
	%>
	<form action="../UpdateMedicine" method="post">
		<h2>Update Medicine</h2>

		<input type="hidden" name="medicine_id"
			value="<%=resultSet.getInt("medicine_id")%>"> <label
			for="medicine_name">Medicine Name:</label> <input type="text"
			id="medicine_name" name="medicine_name"
			value="<%=resultSet.getString("medicine_name")%>" >

		<label for="manufacturer">Manufacturer:</label> <input type="text"
			id="manufacturer" name="manufacturer"
			value="<%=resultSet.getString("manufacturer")%>" >

		<label for="dosage_form">Dosage Form:</label> <input type="text"
			id="dosage_form" name="dosage_form"
			value="<%=resultSet.getString("dosage_form")%>" > <label
			for="active_ingredient">Active Ingredient:</label> <input type="text"
			id="active_ingredient" name="active_ingredient"
			value="<%=resultSet.getString("active_ingredient")%>" >

		<label for="unit_price">Unit Price:</label> <input type="text"
			id="unit_price" name="unit_price"
			value="<%=resultSet.getBigDecimal("unit_price")%>" required>

		<input type="submit" value="Update Medicine">
	</form>
	<%
	} else {
	%>
	<p>Medicine not found</p>
	<%
	}

	} catch (Exception e) {
	e.printStackTrace();
	}
	%>

</body>
</html>
