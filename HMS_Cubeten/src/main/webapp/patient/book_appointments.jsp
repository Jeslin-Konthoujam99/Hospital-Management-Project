<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
	<%@ page import="login.SQLConnect" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book OPD Appointment</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        body {
            padding: 100px;
        }

        form {
            max-width: 400px;
            margin: auto;
        }

        label {
            margin-bottom: 0.5rem;
            font-weight: bold;
        }

        select, input {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<% 
int patientID = (Integer) session.getAttribute("patientid");
int department_id = Integer.parseInt(request.getParameter("department_id"));
String department_name = request.getParameter("department_name");
System.out.println("dep id : "+ department_id +"dep name : "+ department_name );
%>

<div class="container">
    <h2 class="text-center">Book OPD Appointment</h2>
    <form action="../BookOpdAppointment" method="post">
        <!-- Patient ID -->
        <div class="mb-3">
            <input type="hidden" value=<%=patientID %> id="patient_id" name="patient_id">
        </div>

        <!-- Department ID -->
        <div class="mb-3">
            <label for="department_id" class="form-label">Selected Department : <%= department_name %></label>
            <input type="hidden" class="form-select" id="department_id" name="department_id" value=<%=department_id%>>
                
        </div>

        <!-- Doctor ID -->
        <div class="mb-3">
            <label for="doctor_id" class="form-label">Select Doctor:</label>
            <select class="form-select" id="doctor_id" name="doctor_id" required>
            <%
            Connection con = null;
            SQLConnect model = new SQLConnect();
            con = model.connect();
            Statement stmt = null;
            ResultSet res = null;
            PreparedStatement preparedStatement = null;
            String sql="select * from employeelist where role='doctor' and department_id=? ";
            try {
                stmt = con.createStatement();
                preparedStatement = con.prepareStatement(sql);
                preparedStatement.setInt(1,department_id);
                res = preparedStatement.executeQuery();
                System.out.println("QUERY EXECUTED SUCCESSFULLY");
            } catch (Exception e) {
            	e.printStackTrace();
                System.out.println("QUERY failed");
            }

            try {
                while (res.next()) {
            
            
            %>
                <option value=<%=res.getInt("employee_id")%>><%=res.getString("firstname")%> <%=res.getString("lastname")%>  </option>
                
              
			<% 		}
			    } catch (Exception e) {
				e.printStackTrace();
			    System.out.println("QUERY failed");
				}
			%>
			              
                <!-- Add more doctors as needed -->
            </select>
        </div>

        <!-- Appointment Date -->
        <div class="mb-3">
            <label for="date" class="form-label">Appointment Date:</label>
            <input type="datetime-local" class="form-control" id="date" name="date" required>
        </div>

        <button type="submit" class="btn btn-primary">Book Appointment</button>
    </form>
</div>

<!-- Bootstrap JS and Popper.js (required for Bootstrap) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
