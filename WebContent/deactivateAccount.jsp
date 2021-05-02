<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="util.Account" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <script src="js/main.js"></script>
    <link rel="stylesheet" href="css/main.css">
</head>

<body>
<%@ include file="navigationBar.jsp" %>
<% if (session.getAttribute("user") == null) {
    response.sendRedirect("index.jsp");
} else { %>
<div class="container">
    <form action="deactivateAccountProcess.jsp" method="POST">
    <%
        if (request.getParameter("profile") != null) {
            Account userAccount = (Account) session.getAttribute("recentlyViewedAccount");

    %>
        <h1>Deactivate This Account</h1>
        <hr>

        <label for="userNameDeactivate"><b>Username</b></label>
        <input type="text" value="<%out.print(userAccount.getUsername());%>" name="userNameDeactivate" id="userNameDeactivate" required>

        <label for="psw"><b>Password</b></label>
        <input type="checkbox" onclick="showPassword()">Show Password
        <input type="password" value="<%out.print(userAccount.getPassword());%>" name="psw" id="psw" required>

        <br>

        <button type="submit" class="deactivatebtn">Deactivate User Account</button>
    <%} else {%>
        <h1>Deactivate Your Account</h1>
        <hr>

        <label for="userNameDeactivate"><b>Username</b></label>
        <input type="text" placeholder="Enter Username" name="userNameDeactivate" id="userNameDeactivate" required>

        <label for="psw"><b>Password</b></label>
        <input type="checkbox" onclick="showPasswordWithConfirmation()">Show Passwords
        <input type="password" placeholder="Enter Password" name="psw" id="psw" onkeyup='passwordCheck();'
               required>

        <label for="pswConfirmation"><b>Confirm Password</b></label>
        <input type="password" placeholder="Confirm Password" name="pswConfirmation"
               id="pswConfirmation"
               onkeyup='passwordCheck();' required>
        <br>
        <span id='message'></span>
        <br>

        <button type="submit" class="deactivatebtn">Deactivate Account</button>
    <%}%>
    </form>
</div>
<% } %>
</body>

</html>