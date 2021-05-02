<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.AuctionItem" %>
<%@ page import="util.Bid" %>
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
        st = conn.createStatement();
        int listingId = Integer.parseInt(request.getParameter("listingId"));
        double bidValue = Double.parseDouble(request.getParameter("bidValue"));
        AuctionItem auctionItem = new AuctionItem(listingId);
        Bid bid = new Bid(listingId, bidValue);

        int i = st.executeUpdate("DELETE FROM bid WHERE listingID='" + listingId + "' AND bidValue='" + bidValue + "';");
        if (i < 1) {
            out.println("<div class=\"container signin\"><p>Error: Bid was not deleted. <br> <a href=\"bidHistory.jsp?listingId="+listingId+"\">Go back to bid history</a>.</p></div>");
        } else {
            db.closeConnection(conn);
            conn = db.getConnection();
            String topic = "Bid Deletion";
            String message = "Bid on "+auctionItem.getAuctionItemName()+" was deleted by Customer Representative";
            String query = "INSERT INTO alert (user, alertTopic, alertMessage, isRead) VALUES (?, ?, ?, ?);";
            psAlert = conn.prepareStatement(query);
            // Add parameters to query
            psAlert.setInt(1, bid.getBidder());
            psAlert.setString(2, topic);
            psAlert.setString(3, message);
            psAlert.setBoolean(4, false);
            int result = psAlert.executeUpdate();
            if (result < 1) {
                out.println("<div class=\"container signin\"><p>Error: Alert to inform bidder was not created but bid was deleted. <br> <a href=\"bidHistory.jsp?listingId="+listingId+"\">Go back to bid history</a>.</p></div>");
            } else {
                response.sendRedirect("bidHistory.jsp?listingId="+listingId);
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