<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create appointment System</title>
</head>
<style>
.form_button{
	color: #d36c6c;
	font-family:sans-serif;
	padding: 20px;
	width :200px;
	margin: 10px;
	height: 50px;
}

</style>
<body>
<%
response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
response.setHeader("Pragma","no-cache");
response.setHeader("Expires","0");
if(session.getAttribute("email") == null){
	response.sendRedirect("login.jsp");
}
%>
<h3>Create a new appointment</h3>
<form action="PatientCreateAppointment" method="post">
	Enter your name : <input type="text" name="name"><br>
	Enter how you feel : <input type="text" name="details"><br>
	Enter the date for appointment : <input type="date" name="date" id="start_date"><br>
	Enter the time for appointment : <input type="time" name="time" id="start_time"><br>
	Enter the end date for appointment : <input type="date" name="endDate" id="end_date"><br>
	Enter the end time for appointment : <input type="time" name="endTime" id="end_time"><br>
<br>
	<button onsubmit="test" class="form_button">Create appointment</button>
</form>
<form action="BackHome" method="post">
<button onclick="submit" class="form_button">Back home</button>
</form>
</body>
</html>