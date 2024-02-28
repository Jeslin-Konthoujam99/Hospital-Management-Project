<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
 	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<title>SalaryEntry</title>
</head>
<style>
body{
	height: 100vh;
	padding: auto;
	justify-content: center;
	align-items: center;
	padding-top: 100px;
}
</style>
<body>
		<div class="container-fluid">
		<div class="row">
		<div class="col-md-12 col-lg-6 m-auto">
		<form action ="${pageContext.request.contextPath}/empsalary" method="post">
		  <h1 class="text-center fw-bold">SALARY ENTRY</h1>
		  
		  <div class="col-md-6 fw-bold">
		    <label for="validationCustom02" class="form-label" >Emp Id</label>
		    <input type="text" class="form-control" name="empId" required>
		  </div>
		  
		  <div class="col-md-6 fw-bold">
		    <label for="validationCustom01" class="form-label">Salary Amount</label>
		    <input type="text" class="form-control" name="salaryAmount" required>
		  </div>
		  <div class="col-md-6 fw-bold">
		    <label for="validationCustom02" class="form-label">Date</label>
		    <input type="date" class="form-control" name="dateTime" required>
		  </div>
		  
		  <div class="col-12">
		    <button class="btn btn-primary fw-bold" type="submit">Submit</button>
		  </div>
		  

		</form>
		</div>
		</div>
		</div>
		</body>
		</html>