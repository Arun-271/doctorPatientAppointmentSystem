<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
}

button ,#login{
	width: 68px;
	margin: 2px;
	height: 33px;
	border-radius: 8px;
	border: 1px solid;
}
#login{
	color:black;
	background-color:white;
	padding-top:5px;
	font-size:14px;
	height:26px;
}
div {
	margin: 10px;
}

button:hover,#login:hover {
	color: black;
	cursor: pointer;
	background: #c4f2c4;
	transition: 0.4s;
	transform: scale(1.1);
}

a {
	text-decoration: none;
}
.lab{
	margin:8px;
}
</style>
</head>
<body>
	<h3>Enter Account details</h3>
	<form action="signup" method="post">
		<div class="lab"><label >Enter your Email :</label> <input type="email" name="email" required></div>
		<div class="lab"><label>Enter your Password :</label> <input type="password" name="password" required></div>
		<div class="lab"><label class="lab">Enter your First name : </label><input type="text" name="firstName" required></div>
		<div class="lab"><label>Enter your Last name :</label> <input type="text" name="lastName" required></div>
		<div class="lab"><label >Enter your age :</label> <input type="text" name="age" required></div>	
		<button onclick="submit">Sign up</button>
	</form>
	<a href="login.jsp" id="login">Login</a>
</body>
</html>