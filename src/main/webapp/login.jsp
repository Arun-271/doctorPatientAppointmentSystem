<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&display=swap"
	rel="stylesheet">
<title>Doctor Appointment System</title>
<style>
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

button {
	width: 68px;
	margin: 2px;
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

div {
	margin: 10px;
}

a {
	text-decoration: none;
}
</style>
</head>
<body>
	<div>
		<h3>Welcome to Doctor Appointment System</h3>
		<form action="login" method="post">
			<div>
				<label> Enter your Email : </label> <input type="email" name="email">
			</div>
			<div>
				<label>Enter your Password :</label> <input type="password"
					name="password">
			</div>
			<button onclick="submit">Login</button>
		</form>
		<h4>
			Don't have a account? Click here to <a href="signup.jsp">Sign up</a>
		</h4>
	</div>
</body>
</html>