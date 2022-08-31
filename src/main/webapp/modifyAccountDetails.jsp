<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modify Account details</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" >
<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap" rel="stylesheet">
<style>
body {
	font-family: 'Rubik', sans-serif;
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
	font-family: 'Rubik', sans-serif;
	font-weight: 300;
	font-size: 25px;
	text-decoration-line: underline;
}

button{
	width: 68px;
	margin: 15px;
	height: 33px;
	border-radius: 8px;
	border: 1px solid;
}

button:hover {
	color: black;
	cursor: pointer;
	background: #c4f2c4;
	transition: 0.4s;
	transform: scale(1.1);
}
#backHome{
	width:150px;
}
</style>
</head>
<body>
	<div>
		<h3>Enter the new account details.</h3>
		<form action="PatientAccount" method="post">
			Enter the updated first name : <input type="text" name="firstName"><br>
			Enter the updated Last name : <input type="text" name="lastName"><br>
			Enter the updated age : <input type="text" name="age"><br>
			<button onclick="submit">Submit</button>
		</form>
	</div>
		<form action="viewAccountDetails.jsp" method="get">
			<button onclick="submit" class="form_button" id="backHome">Previous page</button>
		</form>
</body>
</html>