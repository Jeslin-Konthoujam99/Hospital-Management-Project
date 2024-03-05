<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OPD CHECKOUT</title>
<style>
body {
	padding: 100px;
	padding-left: 70px;
}
</style>
</head>
<body>
<% int patientid = (Integer)request.getAttribute("patientid"); %>



<h3>OPD CHECKOUT</h3>
<form action="dischargeopd" method="post">
<input type="hidden" name=OPDID value="<%=patientid%>">

<input type="number" name=bookingid >

<input type="submit" value="submit">
</form>
</body>
</html>