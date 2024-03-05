<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
	<%@ page import="login.SQLConnect" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Select Department</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/
	bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/
	bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
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
<h3 class="text-center">Book Opd Appointment</h3> <br>

<%
Connection con = null;
SQLConnect model = new SQLConnect();
con = model.connect();
Statement stmt = null;
ResultSet res = null;
PreparedStatement preparedStatement = null;
String sql="select * from department";
String img = "";
String link = "";
try {
    stmt = con.createStatement();
    preparedStatement = con.prepareStatement(sql);
    res = preparedStatement.executeQuery();
    System.out.println("QUERY EXECUTED SUCCESSFULLY");
} catch (Exception e) {
	e.printStackTrace();
    System.out.println("QUERY failed");
}

try {
    while (res.next()) {
    	img="../Photo/gallery/gallery-"+ res.getInt("department_id") +".jpg";
    	link="../patient/book_appointments.jsp?department_id="+res.getInt("department_id")+"&department_name="+res.getString("dpt_name");

%>


<div class="card mb-3" style="max-width: 540px;">
  <div class="row g-0">
    <div class="col-md-4">
      <img src=<%=img%> class="img-fluid rounded-start" alt="...">
    </div>
    <div class="col-md-8">
      <div class="card-body">
        <h5 class="card-title"> <%=res.getString("dpt_name") %></h5>
        <p class="card-text">This is a department for treatment of various <%=res.getString("dpt_name") %> related illness</p>
        <a href=<%=link%>>Select This Department</a>
        
      </div>
    </div>
  </div>
</div>

<% 		}
    } catch (Exception e) {
	e.printStackTrace();
    System.out.println("QUERY failed");
	}
%>



<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/
	dist/umd/popper.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>