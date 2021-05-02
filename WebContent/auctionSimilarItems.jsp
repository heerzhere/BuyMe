<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="util.Account" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.time.Month" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
<% if ((session.getAttribute("user") == null)) { %>
<div class="marginLeft-Right">
    <p>You are not logged in</p>
    <br/>
    <a href="login.jsp">Please Login</a>
</div>
<%} else { %>
<%AuctionItem auctionItem = new AuctionItem(Integer.parseInt(request.getParameter("listingId")));%>
<div class="marginLeft-Right">
    <h1>Similar Products to <%out.print(auctionItem.getAuctionItemName());%></h1>
    <hr>
    <ul id="myUL">
        <%
                Database db = new Database();
                Connection conn = null;
                Statement st = null;
                ResultSet rs = null;
                try {
                    conn = db.getConnection();
                    st = conn.createStatement();

                    int listingId = auctionItem.getListingId();
                    String type = auctionItem.getType();

                    //get dates
                    LocalDateTime myDateObj = LocalDateTime.now();
                    DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    String today = myDateObj.format(myFormatObj);

                    LocalDateTime lastDate = myDateObj.minusMonths(1);
                    String lastMonth = lastDate.format(myFormatObj);


                    //query
                    rs = st.executeQuery("SELECT * FROM auctionItem WHERE listingID<>'" + listingId + "' AND type='" + type + "' AND listDate BETWEEN'" + lastMonth + "' AND '" + today + "' ORDER BY listDate DESC;");
                    if (!rs.next()) {
                        out.print("<h2>There Are No Similar Auctions</h2>");
                    } else {
                        do {
                            Account auctionItemSeller = new Account(auctionItem.getSeller());
                            //new listingId
                            int newListingID = rs.getInt("listingId");
                            auctionItem = new AuctionItem(newListingID);

                            String closingDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss").format(rs.getTimestamp("closingDate"));
                            Date date = new Date();
                            String currentDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss").format(date);
                            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss");

                            String completed = "<li><a href=\"auctionDetails.jsp?status=completed&listingId=" + auctionItem.getListingId() + "\">"
                                    + "Status: <span class=\"font-red\">Auction Completed<br></span>"
                                    + "Product: " + auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel()
                                    + "<br>Product Type: " + type
                                    + "<br>Seller: " + auctionItemSeller.getUsername()
                                    + "</a></li>";

                            String open = "<li><a href=\"auctionDetails.jsp?status=open&listingId=" + auctionItem.getListingId() + "\">"
                                    + "Status: <span class=\"font-green\">Auction Open<br></span>"
                                    + "Product: " + auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel()
                                    + "<br>Product Type: " + type
                                    + "<br>Seller: " + auctionItemSeller.getUsername()
                                    + "</a></li>";


                            if (sdf.parse(closingDate).before(sdf.parse(currentDate))) {
                                out.println(completed);
                            } else {
                                out.println(open);
                            }
                        } while (rs.next());
                    }
                    out.print("<br><div style=\"text-align: center;\" class=\"auctionbtn\">" + "<p><a href=\"auctionList.jsp\">Go back to list of auctions</a>.</p>" + "</div>");
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


            } %>
    </ul>
</div>

</body>

</html>