<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Home page</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
<style>
body {
	font-family: 'Poppins', sans-serif;
	background: antiquewhite;
}
button {
	color: black;
    font-family:'Poppins', sans-serif;
    width: 250px;
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
	response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Expires","0");
	String logedEmail = (String)session.getAttribute("email");
	if(session.getAttribute("email") == null || !logedEmail.equals("admin@xyz.com")){
		response.sendRedirect("login.jsp");
	}
%>
<div id="outter">
<h2>Welcome  ${email}</h2>

 <form action="viewAllAppointments.jsp">
<button onclick="submit">View all appointments</button>
</form>
<br>
<form action ="logout" method="post">
<button onclick="submit">Logout</button>
</form>
</div>
</body>
</html>