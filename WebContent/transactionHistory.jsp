<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
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
<% if ((session.getAttribute("user") == null)) { %>
<p>You are not logged in</p>
<br/>
<a href="login.jsp">Please Login</a>
<%} else { %>
<%
    Database db = new Database();
    int accountNumber = Integer.parseInt(request.getParameter("accountNumber"));
    Account userAccount = new Account(accountNumber);
    ArrayList<AuctionItem> auctionList = new ArrayList<>();
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;
%>
<div class="marginLeft-Right">
    <h2><%out.print(userAccount.getFirstName());%>'s Transaction History</h2>
    <div class="auction-btn-group">
        <button onclick="showHideDiv()">Auctions created by <%out.print(userAccount.getFirstName());%></button>
        <button onclick="showHideDiv2()">Auctions won by <%out.print(userAccount.getFirstName());%></button>
        <button onclick="showHideDiv3()">Auctions <%out.print(userAccount.getFirstName());%> participated in</button>
    </div>
    <%--    Auctions created by user--%>
    <div id="showHideDiv" >
        <h3>Auctions created by <%out.print(userAccount.getFirstName());%></h3>
        <ul id="myUL">
            <%
                try {
                    // Open DB Connection and get parameters
                    conn = db.getConnection();
                    st = conn.createStatement();

                    // Create query for login validation
                    rs = st.executeQuery("SELECT * FROM auctionItem WHERE seller = " + accountNumber + " ORDER BY auctionItem.listDate DESC;");
                    if (!rs.next()) {
                        out.print("<h2>No auctions started by this user</h2>");
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


                            if (sdf.parse(closingDate).before(sdf.parse(currentDate))) {
                                out.println("<li><a href=\"auctionDetails.jsp?status=completed&listingId=" + auctionItem.getListingId() + "\">"
                                        + "Status: <span class=\"font-red\">Auction Completed<br></span>"
                                        + "Product: " + auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel()
                                        + "<br>Product Type: " + type
                                        + "<br>Seller: " + auctionItemSeller.getUsername()
                                        + "</a></li>");
                            } else {
                                out.println("<li><a href=\"auctionDetails.jsp?status=open&listingId=" + auctionItem.getListingId() + "\">"
                                        + "Status: <span class=\"font-green\">Auction Open<br></span>"
                                        + "Product: " + auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel()
                                        + "<br>Product Type: " + type
                                        + "<br>Seller: " + auctionItemSeller.getUsername()
                                        + "</a></li>");
                            }
                            auctionList.add(auctionItem);
                        } while (rs.next());
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
        </ul>
    </div>
    <%--    Auctions won by this user--%>
    <div id="showHideDiv2" style="display:none">
        <h3>Auctions won by <%out.print(userAccount.getFirstName());%></h3>
        <ul id="myUL2">
            <%
                try {
                    // Open DB Connection and get parameters
                    conn = db.getConnection();
                    st = conn.createStatement();

                    // Create query for login validation
                    rs = st.executeQuery("SELECT * FROM auctionItem WHERE purchaser = " + accountNumber + ";");
                    if (!rs.next()) {
                        out.print("<h2>No auctions won by this user</h2>");
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

                            if (sdf.parse(closingDate).before(sdf.parse(currentDate))) {
                                out.println("<li><a href=\"auctionDetails.jsp?status=completed&listingId=" + auctionItem.getListingId() + "\">"
                                        + "Status: <span class=\"font-red\">Auction Completed<br></span>"
                                        + "Product: " + auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel()
                                        + "<br>Product Type: " + type
                                        + "<br>Seller: " + auctionItemSeller.getUsername()
                                        + "</a></li>");
                            } else {
                                out.println("<li><a href=\"auctionDetails.jsp?status=open&listingId=" + auctionItem.getListingId() + "\">"
                                        + "Status: <span class=\"font-green\">Auction Open<br></span>"
                                        + "Product: " + auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel()
                                        + "<br>Product Type: " + type
                                        + "<br>Seller: " + auctionItemSeller.getUsername()
                                        + "</a></li>");
                            }
                            auctionList.add(auctionItem);
                        } while (rs.next());
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
        </ul>
    </div>
    <%--    Auctions this user participated in--%>
    <div id="showHideDiv3" style="display:none">
        <h3>Auctions <%out.print(userAccount.getFirstName());%> participated in</h3>
        <ul id="myUL3">
            <%
                try {
                    // Open DB Connection and get parameters
                    conn = db.getConnection();
                    st = conn.createStatement();

                    // Create query for login validation
                    rs = st.executeQuery("SELECT * FROM bid WHERE bidder = " + accountNumber + " GROUP BY listingID, bidder;");
                    if (!rs.next()) {
                        out.print("<h2>This user did not participate in any auctions</h2>");
                    } else {
                        do {
                            int listingId = rs.getInt("listingID");

                            AuctionItem auctionItem = new AuctionItem(listingId);
                            String type = auctionItem.getType();

                            Account auctionItemSeller = new Account(auctionItem.getSeller());

                            Date cDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a", Locale.US).parse(auctionItem.getClosingDate());
                            String closingDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss").format(cDate);
                            Date date = new Date();
                            String currentDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss").format(date);
                            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss");

                            if (sdf.parse(closingDate).before(sdf.parse(currentDate))) {
                                out.println("<li><a href=\"auctionDetails.jsp?status=completed&listingId=" + auctionItem.getListingId() + "\">"
                                        + "Status: <span class=\"font-red\">Auction Completed<br></span>"
                                        + "Product: " + auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel()
                                        + "<br>Product Type: " + type
                                        + "<br>Seller: " + auctionItemSeller.getUsername()
                                        + "</a></li>");
                            } else {
                                out.println("<li><a href=\"auctionDetails.jsp?status=open&listingId=" + auctionItem.getListingId() + "\">"
                                        + "Status: <span class=\"font-green\">Auction Open<br></span>"
                                        + "Product: " + auctionItem.getYear() + " " + auctionItem.getManufacturer() + " " + auctionItem.getModel()
                                        + "<br>Product Type: " + type
                                        + "<br>Seller: " + auctionItemSeller.getUsername()
                                        + "</a></li>");
                            }
                            auctionList.add(auctionItem);
                        } while (rs.next());
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
        </ul>
    </div>
</div>
<% } %>

</body>

</html>