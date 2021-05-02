<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="util.Account" %>
<%@ page import="util.Bid" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>

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
<%@ include file="navigationBar.jsp" %>
<div class="marginLeft-Right">
    <% if ((session.getAttribute("user") == null)) { %>
    <p>You are not logged in</p>
    <br/>
    <a href="login.jsp">Please Login</a>
    <%} else { %>
    <%
        Account userAccount = (Account) session.getAttribute("userAccount");
    %>
    <h2>Bid History</h2>
    <%
        Database db = new Database();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        AuctionItem auctionItem = new AuctionItem(Integer.parseInt(request.getParameter("listingId")));
        Locale locale = new Locale("en", "US");
        NumberFormat currency = NumberFormat.getCurrencyInstance(locale);

        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            st = conn.createStatement();
            int listingId = auctionItem.getListingId();

            rs = st.executeQuery("SELECT * FROM bid WHERE listingID='" + listingId + "' ORDER BY bidValue DESC;");
            if (!rs.next()) {
                out.print("<h2>No bids placed for this auction</h2>");
            } else {
                out.print("<table class=\"center\">");
                out.print("<caption style=\"text-align: center;\">Bidding History For: " + auctionItem.getAuctionItemName() + "</caption>");
                out.print("<tr>");
                out.print("<th style=\"text-align: center;\">Bidder</th>");
                out.print("<th style=\"text-align: center;\">Bid Amount</th>");
                out.print("<th style=\"text-align: center;\">Bid Date/Time</th>");
                out.print("</tr>");
                do {

                    double bidValue = rs.getDouble("bidValue");
                    Bid bid = new Bid(listingId, bidValue);
                    Account bidder = new Account(bid.getBidder());
                    String username = bidder.getUsername();
                    String hrefBidDelete = "location.href='bidDelete.jsp?listingId="+auctionItem.getListingId()+"&bidValue="+bidValue+"'";

                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + "<a href=\"userProfile.jsp?userProfile=" + username + "\">" + username + "</a>" + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(bid.getBidValue()) + "</td>");
                    out.print("<td style=\"text-align: left;\">" + bid.getBidDate() + "</td>");
                    // Delete a bid - Customer rep functionality
                    if (userAccount.getAccessLevel() == 2) {
                        out.print("<td style=\"text-align: left;\">" + "<button class=\"deleteBidBtn\" onclick=\""+hrefBidDelete+"\" type=\"button\">Delete</button>" + "</td>");
                    }
                    out.print("</tr>");
                } while (rs.next());
                out.print("</table>");
            }
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
    %>


    <% } %>

</div>

</body>

</html>