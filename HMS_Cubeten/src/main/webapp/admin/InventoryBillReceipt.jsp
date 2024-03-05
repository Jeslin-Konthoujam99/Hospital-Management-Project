<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="login.SQLConnect"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inventory Bill</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">

<style>
body {
	background-color: #f8f9fa;
}

.container {
	margin-top: 50px;
}

table {
	margin-top: 20px;
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

table {
	border-collapse: collapse;
	width: 100%;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}
</style>
</head>
<body>

	<div class="m-5 shadow-lg bg-light rounded">
		<div class="container_fluid">
			<div class="text-center fw-bold fs-3 bg-success pt-4 text-light">Inventory
				Bill</div>
			<div class="container">

				<table class="table table-bordered">
					<thead class="table-dark">

						<tr>
							<th>Item ID</th>
							<th>Item Name</th>
							<th>Price</th>
							<th>Bill ID</th>
							<th>Amount</th>
							<th>Bill Date</th>
							<th>Quantity in Bill</th>
							<th>Transaction Type</th>
						</tr>
					</thead>
					<tbody>
						<%
						SQLConnect connection = new SQLConnect();
						Connection con = connection.connect();

						try {

							// SQL query to join the inventory and inventorybill tables
							String query = "SELECT inventory.itemid, itemname, price, billid, amount, inventorybill.date AS bill_date, qty, transaction_type "
							+ "FROM inventory JOIN inventorybill ON inventory.itemid = inventorybill.itemid";

							try (PreparedStatement preparedStatement = con.prepareStatement(query);
							ResultSet resultSet = preparedStatement.executeQuery()) {

								// Iterate through the result set and display data
								while (resultSet.next()) {
						%>
						<tr>
							<td><%=resultSet.getInt("itemid")%></td>
							<td><%=resultSet.getString("itemname")%></td>
							<td><%=resultSet.getInt("price")%></td>
							<td><%=resultSet.getInt("billid")%></td>
							<td><%=resultSet.getInt("amount")%></td>
							<td><%=resultSet.getTimestamp("bill_date")%></td>
							<td><%=resultSet.getInt("qty")%></td>
							<td><%=resultSet.getString("transaction_type")%></td>
						</tr>
						<%
						}
						}
						} catch (SQLException e) {
						e.printStackTrace();
						}
						%>
					</tbody>
				</table>
				<hr>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>

</body>
</html>
