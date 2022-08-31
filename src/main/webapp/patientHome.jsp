<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
<title>Patient Home page</title>
<style>
body {
	font-family: 'Poppins', sans-serif;
	background: antiquewhite;
}
button {
	color: black;
    font-family: sans-serif;
    /* padding: 20px; */
    width: 200px;
    margin: 10px;
    height: 50px;
    border-radius: 50px;
    font-weight: bolder;
    border: 1px solid;
}
button:hover{
	color: coral;
	cursor: pointer;
}
#outter{
	display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
h2{
	color: coral;
    font-size: 30px;
    font-weight: 300;
}
</style>
</head>
<body>
	<%
	response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");
	String logedEmail = (String) session.getAttribute("email");
	if (session.getAttribute("email") == null || logedEmail.equals("admin@xyz.com")) {
		response.sendRedirect("login.jsp");
	}
	%>
	<div id="outter">
	<h2>Welcome ${email}</h2>
	<div id = "inner">
	<form action="selectSpecialist.jsp">
		<button onclick="submit">Create appointment</button>
	</form>
	<br>
	<form action="viewPatientAppointment.jsp">
		<button onclick="submit">View your appointments</button>
	</form>
	<br>
	<form action="deleteAppointment.jsp">
		<button onclick="submit">Delete a appointment</button>
	</form>
	<br>
	<form action="viewAccountDetails.jsp">
		<button onclick="submit">View Account details</button>
	</form>
	<br>	
	<form action="logout" method="post">
		<button onclick="submit">Logout</button>
	</form>
	</div>
	</div>
</body>
</html>