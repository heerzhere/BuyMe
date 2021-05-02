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
<% if ((session.getAttribute("user") == null)) { %>
<div class="marginLeft-Right">
    <p>You are not logged in</p>
    <br/>
    <a href="login.jsp">Please Login</a>
</div>
<%} else { %>
<%Account userAccount;%>
<%if (request.getParameter("profile") != null) { userAccount = (Account) session.getAttribute("recentlyViewedAccount");%>
<form action="accountProcess.jsp?process=editUserProfile" method="POST">
        <%} else { userAccount = (Account) session.getAttribute("userAccount");%>
    <form action="accountProcess.jsp?process=edit" method="POST">
        <% } %>
        <div class="container">
            <h1>Edit Account Information</h1>
            <hr>

            <label for="firstName"><b>First Name</b></label>
            <input type="text" value="<%out.println(userAccount.getFirstName());%>" name="firstName" id="firstName"
                   required>

            <label for="lastName"><b>Last Name</b></label>
            <input type="text" value="<%out.println(userAccount.getLastName());%>" name="lastName" id="lastName"
                   required>

            <label for="username"><b>Username</b></label>
            <input type="text" value="<%out.println(userAccount.getUsername());%>" name="username" id="username"
                   required>

            <label for="psw"><b>Password</b></label>
            <input type="checkbox" onclick="showPassword()">Show Password
            <input type="password" value="<%out.println(userAccount.getPassword());%>" name="psw" id="psw" required>

            <label for="email"><b>Email</b></label>
            <input type="text" value="<%out.println(userAccount.getEmail());%>" name="email" id="email" required>
            <br>

            <button type="submit" class="registerbtn">Update Account Information</button>
        </div>
    </form>
        <% } %>
</body>

</html>