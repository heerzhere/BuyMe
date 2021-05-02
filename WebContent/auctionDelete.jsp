<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.AuctionItem" %>
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
<%
    //Open DB Connection
    Database db = new Database();
    Connection conn = null;
    Statement st = null;
    PreparedStatement psAlert;
    try {
        //Get parameters
        conn = db.getConnection();
        int listingId = Integer.parseInt(request.getParameter("listingId"));
        AuctionItem auctionItem = new AuctionItem(listingId);

        // Generate and Execute Query
        st = conn.createStatement();

        int i = st.executeUpdate("DELETE FROM auctionItem WHERE listingID='" + listingId + "';");
        if (i < 1) {
            out.println("<div class=\"container signin\"><p>Auction was not deleted. <br> <a href=\"auctionList.jsp\">Go back to the list of auctions</a>.</p></div>");
        } else {
            db.closeConnection(conn);
            conn = db.getConnection();
            String topic = "Auction Deletion";
            String message = "Auction for "+auctionItem.getAuctionItemName()+" was deleted by Customer Representative";
            String query = "INSERT INTO alert (user, alertTopic, alertMessage, isRead) VALUES (?, ?, ?, ?);";
            psAlert = conn.prepareStatement(query);
            // Add parameters to query
            psAlert.setInt(1, auctionItem.getSeller());
            psAlert.setString(2, topic);
            psAlert.setString(3, message);
            psAlert.setBoolean(4, false);
            int result = psAlert.executeUpdate();
            if (result < 1) {
                out.println("<div class=\"container signin\"><p>Error: Alert to inform bidder was not created but auction was deleted. <br> <a href=\"auctionList.jsp\">Go back to the list of auctions</a>.</p></div>");
            } else {
                out.println("<div class=\"container signin\"><p>Auction deleted successfully <br> <a href=\"auctionList.jsp\">Go back to the list of auctions</a>.</p></div>");
            }
        }
    } catch (SQLException se) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        se.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close
        try {
            if (st != null) st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) db.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</body>

</html>