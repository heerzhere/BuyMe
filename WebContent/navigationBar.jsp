<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="util.Account" %>
<%@ page import="util.Alert" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<body>
<nav class="navbar navbar-default" style="padding-top: 5px">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="index.jsp">BuyMe</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="profile.jsp">My Profile</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="auctionList.jsp">Auctions</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="questionsAndAnswers.jsp">Q&A</a>
            </li>
        </ul>
        <% if ((session.getAttribute("user") != null)) { %>
        <%
            Account userAccount = (Account) session.getAttribute("userAccount");
            Database dbAlert = new Database();
            int alertCount = 0;
            Connection connAlert = null;
            Statement stAlert = null;
            ResultSet rsAlert = null;
            try {
                // Open DB Connection and get parameters
                connAlert = dbAlert.getConnection();
                stAlert = connAlert.createStatement();

                // Create query for login validation
                rsAlert = stAlert.executeQuery("SELECT * FROM alert;");
                if (!rsAlert.next()) {
                } else {
                    do {
                        int alertID = rsAlert.getInt("alertID");
                        Account userProfile = (Account) session.getAttribute("userAccount");
                        Alert alert = new Alert(alertID);
                        if (alert.getUser() == userProfile.getAccountNumber() && !alert.isRead()) {
                            alertCount++;
                        }
                    } while (rsAlert.next());
                }
            } catch (SQLException se) {
                out.print("<p>Error connecting to MYSQL server.</p>");
                se.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close
                try {
                    if (rsAlert != null) rsAlert.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                try {
                    if (stAlert != null) stAlert.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                try {
                    if (connAlert != null) dbAlert.closeConnection(connAlert);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>

        <ul class="nav navbar-nav navbar-right">
            <%if (userAccount.getAccessLevel() == 3) { %>
            <li>
                <a class="nav-link" href="wishlist.jsp">Wishlist</a>
            </li>
            <li class="nav-item">
                <%if (alertCount > 0) { %>
                <span class="badge badge-pill badge-primary"
                      style="float:right;margin-bottom:-10px; background: red; color: white;">
                    <%
                        out.print(alertCount);
                    %>
                </span>
                <%}%>
                <a class="nav-link" href="alertList.jsp">Alerts</a>
            </li>
            <%}%>
            <li>
                <a class="nav-link" href="logout.jsp">Logout</a>
            </li>
        </ul>

        <%}%>
    </div>
</nav>
</body>

</html>