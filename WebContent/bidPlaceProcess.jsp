<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="util.*" %>

<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="util.Account" %>
<%@ page import="util.Bid" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Calendar" %>

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
    Database db = new Database();
    Connection conn = null;
    Connection conn2 = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    Statement st = null;
    boolean sendA = false;
    Account userAccount = (Account) session.getAttribute("userAccount");
    String auctionStatus = request.getParameter("status");
    double bidValue = Double.parseDouble(request.getParameter("bid"));
    int bidder = userAccount.getAccountNumber();
    double maxBid = 0;
    int listingID = Integer.parseInt(request.getParameter("listingId"));
    AuctionItem item = new AuctionItem(listingID);
    String closingDate = item.getClosingDate();
    Locale locale = new Locale("en", "US");
    NumberFormat currency = NumberFormat.getCurrencyInstance(locale);

    try {
        conn = db.getConnection();
        st = conn.createStatement();

        rs = st.executeQuery("SELECT MAX(bidValue) FROM bid WHERE listingID =" + listingID + ";");
        rs.next();
        maxBid = rs.getDouble("MAX(bidValue)");
    } catch (SQLException se) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        se.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close
        try {
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
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
    try {
        conn2 = db.getConnection();
        Date date = Calendar.getInstance().getTime();
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss a");
        String strDate = dateFormat.format(date);
        if (maxBid >= bidValue) {
%>
<form>
    <input type="hidden" id="status" name="status" value="<%out.print("open");%>">
    <input type="hidden" id="listingId" name="listingId" value="<%out.print(listingID);%>">
    <button type="submit" class="loginbtn" formaction="auctionDetails.jsp">Bid was too low. Go back to Item</button>
</form>
<%

} else if (closingDate.compareTo(strDate) > 0) {
    String query2 = "INSERT INTO bid (listingID, bidder, bidValue, bidDate) VALUES (?, ?, ?, now());";

    ps = conn2.prepareStatement(query2);
    ps.setInt(1, listingID);
    ps.setInt(2, bidder);
    ps.setDouble(3, bidValue);
    int resultBid = ps.executeUpdate();
    if (resultBid < 1) {
        out.println("<div class=\"container signin\"><p>There was a problem submitting your bid<br><a href=\"auctionList.jsp\">Back to Auction List</a>.</p> </div>");
    } else {
        out.println("<div class=\"container signin\"><p>Your Bid of " + currency.format(bidValue) + " has been submitted <br><a href=\" auctionList.jsp\">Go back to the list of auctions</a>.</p> </div>");
%>
<%@ include file="bidAlertSend.jsp" %>
<%
            }
        } else {
            out.println("<div class=\"container signin\"><p>Time Ran Out<br><a href=\"auctionList.jsp\">Go Back to Auction List</a>.</p> </div>");
        }

    } catch (SQLException se) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        se.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close
        try {
            if (ps != null) ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (conn2 != null) db.closeConnection(conn2);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

%>
</body>

</html>