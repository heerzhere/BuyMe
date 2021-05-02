<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="util.Account" %>
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
<%
    Account userAccount = (Account) session.getAttribute("userAccount");
%>
<% if (userAccount.getAccessLevel() != 1) { %>
<div class="marginLeft-Right">
    <p>You do not have the appropriate access level</p>
    <br/>
    <a href="profile.jsp">Please Go Back</a>
</div>
<%} else { %>
<form action="accountProcess.jsp?process=createCustomerRep" method="POST">
    <div class="container">
        <h1>Create Customer a Representative Account</h1>
        <hr>

        <label for="firstName"><b>First Name</b></label>
        <input type="text" placeholder="Enter First Name" name="firstName" id="firstName" required>

        <label for="lastName"><b>Last Name</b></label>
        <input type="text" placeholder="Enter Last Name" name="lastName" id="lastName" required>

        <label for="username"><b>Username</b></label>
        <input type="text" placeholder="Enter Username" name="username" id="username" required>

        <label for="psw"><b>Password</b></label>
        <input type="checkbox" onclick="showPasswordWithConfirmation()">Show Passwords
        <input type="password" placeholder="Enter Password" name="psw" id="psw" onkeyup='passwordCheck();' required>

        <label for="pswConfirmation"><b>Confirm Password</b></label>
        <input type="password" placeholder="Confirm Password" name="pswConfirmation" id="pswConfirmation"
               onkeyup='passwordCheck();' required>
        <br>
        <span id='message'></span>
        <br>

        <label for="email"><b>Email</b></label>
        <input type="text" placeholder="Enter Email" name="email" id="email" required>
        <br>

        <button type="submit" class="registerbtn">Create</button>
    </div>
</form>
<% } %>
</body>

</html>