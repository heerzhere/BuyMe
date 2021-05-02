<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="css/main.css">
    <script src="js/main.js"></script>
</head>

<body>
<%@ include file="navigationBar.jsp" %>
<% if ((session.getAttribute("user") == null)) { %>
<div class="marginLeft-Right">
    <h1> BuyMe</h1>
    <hr>
    <a href="login.jsp">Login into your account</a>
    <br>
    <a href="register.jsp">Create your BuyMe account</a>
</div>
<%} else { %>
<div class="marginLeft-Right">
    <h1> BuyMe</h1>
    <hr>
    <a href="auctionList.jsp">Check out the list of auctions</a>
    <br>
</div>
<% } %>
</body>

</html>