<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="accounts.AccountDAO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Account Details</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nunito&display=swap" rel="stylesheet">
<style>
tr {
	background-color: #ffc4c4;
}

th {
	background-color: #0c1212;
	color: white;
}

th, td {
	padding: 10px;
	text-align: left;
}

table {
	border-collapse: collapse;
	width: 100%;
	font-family: 'Nunito', sans-serif;
}

body {
	font-family: 'Poppins', sans-serif;
	background: antiquewhite;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100vh;
	text-align: center;
}

h3 {
	text-align: center;
	font-family: 'Poppins', sans-serif;
	font-weight: 300;
	font-size: 25px;
	text-decoration-line: underline;
	color: coral;
}

.form_button {
	width: 150px;
	margin: 15px;
	height: 40px;
	border-radius: 8px;
	border: 1px solid;
	color: black !important;
}

.form_button:hover {
	color: black;
	cursor: pointer;
	background: #c4f2c4;
	transition: 0.4s;
	transform: scale(1.1);
}
</style>
</head>
<body>
	<h3>Account details</h3>
	<div id="container"></div>
	<div>
		<form action="patientHome.jsp" method="get">
			<button onclick="submit" class="form_button">Back Home</button>
		</form>
	</div>
	<div>
		<form action="modifyAccountDetails.jsp">
		<button onclick="submit" class="form_button">Modify account details</button>
	</form>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
function onLoad(){
	$.ajax({
		url : '/doctorPatientV3/ViewAccountDetails?',
		type : 'GET',
		success : function(data){
			var response = JSON.parse(data);
			var table = 
				`<table border='1'>
					<tr>
						<th>Email</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Age</th>
					</tr>`;
					for(i = 0 ; i<response.length;i++){
			table = table + "<tr><td>"+ response[i].email +"</td>";
			table = table + "<td>"+ response[i].first_name +"</td>";
			table = table + "<td>"+ response[i].last_name +"</td>";
			table = table + "<td>"+ response[i].age +"</td> </tr>";
					}
			document.getElementById("container").innerHTML = table;
		}
	});
}
onLoad();
</script>
</body>
</html>