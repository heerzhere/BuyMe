<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <script src="js/main.js"></script>
    <link rel="stylesheet" href="css/main.css">
</head>

<body>
<%@ include file="navigationBar.jsp" %>
<form action="loginProcess.jsp" method="POST">
    <div class="container">
        <h1>Login</h1>
        <hr>

        <label for="username"><b>Username</b></label>
        <input type="text" placeholder="Enter Username" name="username" id="username" required>

        <label for="psw"><b>Password</b></label>
        <input type="password" placeholder="Enter Password" name="psw" id="psw" required>
        <input type="checkbox" onclick="showPassword()">Show Password
        <hr>

        <button type="submit" class="loginbtn">Login</button>

        <div class="signin">
            <p>Don't have a BuyMe account? <a href="register.jsp">Register</a>.</p>
        </div>
    </div>
</form>

</body>

</html>