<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="util.*" %>
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
    <h1>Wishlist</h1>
    <a href="wishlistAdd.jsp">
        <button class="loginbtn">Add an Item to Your Wishlist</button>
    </a>
    <hr>
    <ul id="myULNoLink">
        <%
            Database db = new Database();
            ArrayList<WishlistItem> wishArrayList = new ArrayList<>();
            Connection conn = null;
            Statement st = null;
            ResultSet rs = null;
            Locale locale = new Locale("en", "US");
            NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
            try {
                // Open DB Connection and get parameters
                conn = db.getConnection();
                st = conn.createStatement();

                // Create query for login validation
                rs = st.executeQuery("SELECT * FROM wishlist;");
                if (!rs.next()) {
                } else {
                    do {
                        int user = rs.getInt("user");
                        String model = rs.getString("model");
                        String manufacturer = rs.getString("manufacturer");
                        String condition = rs.getString("condition");
                        double maxPrice = rs.getDouble("maxPrice");
                        boolean isAvailable = rs.getBoolean("isAvailable");

                        String isAvailableColor;
                        String isAvailableStatus;
                        if (isAvailable) {
                            isAvailableColor = "font-green";
                            isAvailableStatus = "Available";
                        } else {
                            isAvailableColor = "font-red";
                            isAvailableStatus = "Unavailable";
                        }
                        String deleteHref = "wishlistProcess.jsp?process=delete"+"&model="+model+"&manufacturer="+manufacturer+"&condition="+condition+"&maxPrice="+maxPrice;

                        WishlistItem wishlistItem = new WishlistItem(user, model, manufacturer, condition, maxPrice);
                        Account userAccount = (Account) session.getAttribute("userAccount");
                        if (wishlistItem.getUser() == userAccount.getAccountNumber()) {
                            out.println("<li>"
                                    + "Status: <span class=\"" + isAvailableColor + "\">" + isAvailableStatus + "</span>"
                                    + "<a href=\""+deleteHref+"\">"
                                    + "<span class=\"close-button\">&times;</span>"
                                    + "</a>"
                                    + "<br>Product: " + wishlistItem.getWishlistItemName()
                                    + "<br>Maximum Price: " + currency.format(wishlistItem.getMaxPrice())
                                    + "</li>");
                            wishArrayList.add(wishlistItem);
                        }
                    } while (rs.next());
                }
                if (wishArrayList.isEmpty()) {
                    out.print("<h2>No items in Wishlist.</h2>");
                }
                session.setAttribute("wishlist", wishArrayList);
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