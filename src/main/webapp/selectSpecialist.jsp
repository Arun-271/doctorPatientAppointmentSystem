<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<meta charset="UTF-8">
<title>Doctor Selection</title>
<style>
body {
	font-family: 'Poppins', sans-serif;
	background: antiquewhite;
}

.outer {
	text-align: center;
	display: flex;
	height: 100vh;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	flex-wrap: wrap;
	align-content: center;
}

button {
	width: 77px;
    height: 34px;
    margin: 16px;
    border-radius: 15px;
    color: black;
    border: 1px solid;
    background: white;
}

button:hover{
	cursor: pointer;
	background-color: #c4f2c4;
	transition: 0.3s;
    transform: scale(1.1);
}
h2{
	color:coral;
	text-decoration:underline;
}
</style>
</head>
<body>
	<div class="outer">
		<h2>Select the Specialist you want to visit</h2>
		<form action="DocServlet" method="post">
			<label for="doctors" style="font-size:medium">Choose the doctor:</label> <select
				name="doctors" id="doc">
				<option value="dentist">Dentist</option>
				<option value="dermatologist">Dermatologists</option>
				<option value="general" selected>General</option>
			</select><br/>
			<button onclick="submit">Submit</button>
		</form>

	</div>
</body>
</html>