<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="util.Account" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
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
    <a href="profile.jsp">Go Back</a>
</div>
<%} else { %>
<div class="marginLeft-Right">
    <h1>Generate Sales Reports For:</h1>
    <hr>
    <a href='salesReportProcess.jsp?for=total'>Total Earnings</a>
    <br>
    <a href='salesReportProcess.jsp?for=perItem'>Earnings Per Item</a>
    <br>
    <a href='salesReportProcess.jsp?for=perItemType'>Earnings Per Item Type</a>
    <br>
    <a href='salesReportProcess.jsp?for=perUser'>Earnings Per End-User</a>
    <br>
    <a href='salesReportProcess.jsp?for=bestSelling'>Best-Selling Items</a>
    <br>
    <a href='salesReportProcess.jsp?for=biggestSpenders'>Biggest Spenders</a>
</div>
<% } %>
</body>

</html>