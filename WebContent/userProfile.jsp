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
<%--CHECK IF USER IS LOGGED IN--%>
<% if ((session.getAttribute("user") == null)) { %>
<div class="marginLeft-Right">
    <p>You are not logged in</p>
    <br/>
    <a href="login.jsp">Please Login</a>
</div>
<%--IF A LOGGED IN USER IS VIEWING A PROFILE THAT IS NOT THEIRS--%>
<%} else if (!(session.getAttribute("user").equals(request.getParameter("userProfile")))) { %>
<div class="marginLeft-Right">
    <h1>Viewing <%out.print(request.getParameter("userProfile"));%>'s Profile</h1>
    <hr>
    <%
        Account userAccount = (Account) session.getAttribute("userAccount");
        Account recentlyViewedAccount = new Account(request.getParameter("userProfile"));
        int recentlyViewedAccountNumber = recentlyViewedAccount.getAccountNumber();
        session.setAttribute("recentlyViewedAccount", recentlyViewedAccount);
    %>
    <%if (recentlyViewedAccount.getIsActive() == 0) {%>
    <h1>This Account Has Been Deactivated</h1>
    <%} else { %>

    <a href='transactionHistory.jsp?accountNumber=<%out.print(recentlyViewedAccountNumber);%>'>Transaction History</a>
    <br>
    <%if (userAccount.getAccessLevel() == 2) {%>
    <a href='editAccountInformation.jsp?profile=userProfile'>Edit This Account's Information</a>
    <br>
    <a href='deactivateAccount.jsp?profile=userProfile'>Deactivate This User Account</a>
    <%}%>
    <%}%>
</div>
<%--IF A LOGGED IN USER IS VIEWING THEIR OWN PROFILE--%>
<%} else { %>
<%response.sendRedirect("profile.jsp");%>
<% } %>
</body>

</html>