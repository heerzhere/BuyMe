<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="util.Account" %>
<%@ page import="util.Alert" %>
<%@ page import="util.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="css/main.css">
    <script src="js/main.js"></script>
</head>

<body>
<%
    Database dbA = new Database();
    Connection connA = null;
    Statement stA = null;
    ResultSet rsA = null;
    Connection connB = null;
    Statement stB = null;
    ResultSet rsB = null;
    Connection connC = null;

    PreparedStatement psC = null;
    AuctionItem auctionItem = new AuctionItem(Integer.parseInt(request.getParameter("listingId")));
    ArrayList<Integer> bidderList = new ArrayList<Integer>();
    int maxBidder = -1;
    int listingId = auctionItem.getListingId();
    int finalResult = 1;
    try {
        // Open DB Connection and get parameters
        connA = dbA.getConnection();
        stA = connA.createStatement();
        rsA = stA.executeQuery("SELECT * FROM bid WHERE listingID =" + listingId + " AND bidValue = (Select MAX(bidValue) from bid where listingID = " + listingId + ")");
        if (rsA.next()) {
            maxBidder = rsA.getInt("bidder");
        } else {
            out.println("There are no other bids.");

        }
    } catch (SQLException se) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        se.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close
        try {
            if (rsA != null) rsA.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (stA != null) stA.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (connA != null) dbA.closeConnection(connA);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    try {
        if (maxBidder == -1) {
            out.println("There is no Bid");
        }
        connB = dbA.getConnection();
        stB = connB.createStatement();
        rsB = stB.executeQuery("SELECT * FROM bid WHERE listingID='" + listingId + "' ORDER BY bidValue asc;");
        if (rsB.next()) {
            do {
                int acct = rsB.getInt("bidder");
                if (acct != maxBidder) {
                    if (bidderList.contains(acct)) {
                        continue;
                    } else {
                        bidderList.add(acct);
                    }
                }
            } while (rsB.next());
        }
    } catch (Exception se) {
        se.printStackTrace();
    } finally {
        // Close
        try {
            if (rsB != null) rsB.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (stB != null) stB.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (connB != null) dbA.closeConnection(connB);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    try {
        connC = dbA.getConnection();
        for (int account : bidderList) {
            if (account != maxBidder) {
                String topic = "Higher Bid on " + auctionItem.getAuctionItemName();
                String message = "Another user has placed a bid that is higher than your bid.";
                String query = "INSERT INTO alert (user, alertTopic, alertMessage, isRead) VALUES (?, ?, ?, ?);";
                psC = connC.prepareStatement(query);
                psC.setInt(1, account);
                psC.setString(2, topic);
                psC.setString(3, message);
                psC.setBoolean(4, false);
                int result;
                result = psC.executeUpdate();
                if (result < 1) {
                    finalResult = 0;
                }
            }
        }
        if (finalResult < 1) {
        } else {
            out.println("<center>Other Users have been notified of bid placement.</center>");
        }
    } catch (Exception se) {
        se.printStackTrace();
    } finally {
        try {
            if (psC != null) psC.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (connC != null) dbA.closeConnection(connC);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

</body>

</html>