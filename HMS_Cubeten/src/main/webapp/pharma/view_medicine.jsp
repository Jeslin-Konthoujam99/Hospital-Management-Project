<%@ page import="java.sql.*" %>
	<%@ page import="login.SQLConnect" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Medicines List</title>
    <style>
    	body
    	{
    		padding-top:40px;
    		padding-left:40px;
    	}
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        button {
            padding: 5px 10px;
        }
    </style>
</head>
<body>

<%
    // JDBC parameters
    SQLConnect co = new SQLConnect();
	Connection connection = co.connect();

    // Fetch medicines from the database
    
    String selectQuery = "SELECT * FROM medicines";
    try (PreparedStatement preparedStatement = connection.prepareStatement(selectQuery)) {
        try (ResultSet resultSet = preparedStatement.executeQuery()) {
%>
            <table>
                <tr>
                    <th>Medicine ID</th>
                    <th>Medicine Name</th>
                    <th>Manufacturer</th>
                    <th>Dosage Form</th>
                    <th>Active Ingredient</th>
                    <th>Unit Price</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
<%
                while (resultSet.next()) {
%>
                    <tr>
                        <td><%= resultSet.getInt("medicine_id") %></td>
                        <td><%= resultSet.getString("medicine_name") %></td>
                        <td><%= resultSet.getString("manufacturer") %></td>
                        <td><%= resultSet.getString("dosage_form") %></td>
                        <td><%= resultSet.getString("active_ingredient") %></td>
                        <td><%= resultSet.getBigDecimal("unit_price") %></td>
                        <td>
                            <form action="/HMS_Cubeten/pharma/update_medicine.jsp" method="post">
                                <input type="hidden" name="medicine_id" value="<%= resultSet.getInt("medicine_id") %>">
                                <button type="submit">Update</button>
                            </form>
						</td>
						<td>
                            <form action="${pageContext.request.contextPath}/DeleteMedicine" method="post">
                                <input type="hidden" name="medicine_id" value="<%= resultSet.getInt("medicine_id") %>">
                                <button type="submit">Delete</button>
                            </form>
                        </td>
                    </tr>
<%
                }
            }
        
            
        } catch (Exception e) {
        	System.out.println("some exception in view_medicine.jsp");
            e.printStackTrace();
        }
%>
</table>

</body>
</html>
