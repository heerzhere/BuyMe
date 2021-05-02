<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="util.Account" %>

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
    <%@include file="auctionClosedCheck.jsp" %>
    <h2>Auctions</h2>
    <div class="auction-btn-group">
        <a href="auction.jsp?type=car">
            <button>Start a New Car Auction</button>
        </a>
        <a href="auction.jsp?type=boat">
            <button>Start a New Boat Auction</button>
        </a>
        <a href="auction.jsp?type=aircraft">
            <button>Start a New Aircraft Auction</button>
        </a>
    </div>
    <input type="text" id="myInput" onkeyup="search()" placeholder="Search for an auction">
    <ul id="myUL">
        <%
            response.setIntHeader("Refresh", 10);
            Database db = new Database();
            ArrayList<AuctionItem> auctionList = new ArrayList<>();
            Connection conn = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                // Open DB Connection and get parameters
                conn = db.getConnection();
                st = conn.createStatement();

                // Create query for login validation
                rs = st.executeQuery("SELECT * FROM auctionItem ORDER BY auctionItem.listDate DESC;");
                if (!rs.next()) {
                    out.print("<h2>No auctions started</h2>");
                } else {
                    do {
                        int listingId = rs.getInt("listingID");

                        AuctionItem auctionItem = new AuctionItem(listingId);
                        String type = auctionItem.getType();
                        Account auctionItemSeller = new Account(auctionItem.getSeller());

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
                        auctionList.add(auctionItem);
                    } while (rs.next());
                }
                session.setAttribute("auctionList", auctionList);
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
    </ul>
    <% } %>
</div>

</body>

</html>