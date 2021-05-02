<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Locale" %>
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
    <h2>Sales Report</h2>


    <%
        Database db = new Database();
        String salesReport = request.getParameter("for");
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
    %>

    <% try {
        // Open DB Connection and get parameters
        conn = db.getConnection();
        st = conn.createStatement();

        Locale locale = new Locale("en", "US");
        NumberFormat currency = NumberFormat.getCurrencyInstance(locale);

        // Create query for login validation
        if (salesReport.equals("total")) {
            out.print("<table class=\"center\" style=\"width: 15%;\">");
            out.print("<caption style=\"text-align: center;\">Total Earnings</caption>");
            out.print("<tr> <th style=\"text-align: center;\">Total Earnings</th> </tr>");
            rs = st.executeQuery("SELECT SUM(minSellPrice) AS `Total Earnings` FROM auctionItem;");
            if (!rs.next()) {
                out.print("<tr> <td style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    double earnings = rs.getDouble("Total Earnings");
                    out.print("<tr> <td style=\"text-align: center;\">" + currency.format(earnings) + "</td> </tr>");
                } while (rs.next());
            }
            out.print("</table>");
        } else if (salesReport.equals("perItem")) {
            out.print("<table class=\"center\">");
            out.print("<caption style=\"text-align: center;\">Earnings Per Item</caption>");
            out.print("<tr>");
            out.print("<th style=\"text-align: center;\">Manufacturer</th>");
            out.print("<th style=\"text-align: center;\">Model</th>");
            out.print("<th style=\"text-align: center;\">Quantity</th>");
            out.print("<th style=\"text-align: center;\">Earnings</th>");
            out.print("</tr>");
            rs = st.executeQuery("SELECT manufacturer AS Manufacturer, model AS Model, COUNT(model) AS Quantity, SUM(minSellPrice) AS Earnings " +
                    "FROM auctionItem " +
                    "GROUP BY manufacturer, model;");
            if (!rs.next()) {
                out.print("<tr> <td  colspan=\"4\" style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    String manufacturer = rs.getString("Manufacturer");
                    String model = rs.getString("Model");
                    int quantity = rs.getInt("Quantity");
                    double earnings = rs.getDouble("Earnings");

                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + manufacturer + "</td>");
                    out.print("<td style=\"text-align: left;\">" + model + "</td>");
                    out.print("<td style=\"text-align: left;\">" + quantity + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(earnings) + "</td>");
                    out.print("</tr>");
                } while (rs.next());
            }
            out.print("</table>");
        } else if (salesReport.equals("perItemType")) {
            out.print("<table class=\"center\">");
            out.print("<caption style=\"text-align: center;\">Earnings Per Item Type</caption>");
            out.print("<tr>");
            out.print("<th style=\"text-align: center;\">Item Type</th>");
            out.print("<th style=\"text-align: center;\">Earnings</th>");
            out.print("</tr>");
            rs = st.executeQuery("SELECT type AS `Item Type`, SUM(minSellPrice) AS `Earnings` " +
                    "FROM auctionItem " +
                    "GROUP BY type;");
            if (!rs.next()) {
                out.print("<tr> <td  colspan=\"2\" style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    String itemType = rs.getString("Item Type");
                    double earnings = rs.getDouble("Earnings");

                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + itemType + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(earnings) + "</td>");
                    out.print("</tr>");
                } while (rs.next());
            }
            out.print("</table>");
        } else if (salesReport.equals("perUser")) {
            out.print("<table class=\"center\">");
            out.print("<caption style=\"text-align: center;\">Earnings Per End-User</caption>");
            out.print("<tr>");
            out.print("<th style=\"text-align: center;\">First Name</th>");
            out.print("<th style=\"text-align: center;\">Last Name</th>");
            out.print("<th style=\"text-align: center;\">username</th>");
            out.print("<th style=\"text-align: center;\">Earnings</th>");
            out.print("</tr>");
            rs = st.executeQuery("SELECT a.first_name AS `First Name`, a.last_name AS `Last Name`, a.username, SUM(aI.minSellPrice) AS Earnings " +
                    "FROM account a INNER JOIN auctionItem aI " +
                    "ON a.account_number = aI.seller " +
                    "GROUP BY aI.seller;");
            if (!rs.next()) {
                out.print("<tr> <td  colspan=\"4\" style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    String fName = rs.getString("First Name");
                    String lName = rs.getString("Last Name");
                    String username = rs.getString("username");
                    double earnings = rs.getDouble("Earnings");

                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + fName + "</td>");
                    out.print("<td style=\"text-align: left;\">" + lName + "</td>");
                    out.print("<td style=\"text-align: left;\">" + "<a href=\"userProfile.jsp?userProfile=" + username + "\">" + username + "</a>" + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(earnings) + "</td>");
                    out.print("</tr>");
                } while (rs.next());
            }
            out.print("</table>");
        } else if (salesReport.equals("bestSelling")) {
            out.print("<table class=\"center\">");
            out.print("<caption style=\"text-align: center;\">Top 5 Selling Items</caption>");
            out.print("<tr>");
            out.print("<th style=\"text-align: center;\">Manufacturer</th>");
            out.print("<th style=\"text-align: center;\">Model</th>");
            out.print("<th style=\"text-align: center;\">Quantity</th>");
            out.print("<th style=\"text-align: center;\">Earnings</th>");
            out.print("</tr>");
            rs = st.executeQuery("SELECT manufacturer AS Manufacturer, model AS Model, COUNT(model) AS Quantity, SUM(minSellPrice) AS Earnings " +
                    "FROM auctionItem " +
                    "WHERE minSellPrice IS NOT NULL " +
                    "GROUP BY manufacturer, model " +
                    "ORDER BY Quantity DESC " +
                    "LIMIT 5;");
            if (!rs.next()) {
                out.print("<tr> <td  colspan=\"4\" style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    String manufacturer = rs.getString("Manufacturer");
                    String model = rs.getString("Model");
                    int quantity = rs.getInt("Quantity");
                    double earnings = rs.getDouble("Earnings");

                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + manufacturer + "</td>");
                    out.print("<td style=\"text-align: left;\">" + model + "</td>");
                    out.print("<td style=\"text-align: left;\">" + quantity + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(earnings) + "</td>");
                    out.print("</tr>");
                } while (rs.next());
            }
            out.print("</table>");
        } else if (salesReport.equals("biggestSpenders")) {
            out.print("<table class=\"center\">");
            out.print("<caption style=\"text-align: center;\">Top 5 Biggest Spenders</caption>");
            out.print("<tr>");
            out.print("<th style=\"text-align: center;\">First Name</th>");
            out.print("<th style=\"text-align: center;\">Last Name</th>");
            out.print("<th style=\"text-align: center;\">username</th>");
            out.print("<th style=\"text-align: center;\">Total Money Spent</th>");
            out.print("</tr>");
            rs = st.executeQuery("SELECT a.first_name AS `First Name`, a.last_name AS `Last Name`, a.username, SUM(aI.minSellPrice) AS `Total Money Spent` " +
                    "FROM account a INNER JOIN auctionItem aI " +
                    "ON a.account_number = aI.purchaser " +
                    "GROUP BY aI.purchaser " +
                    "ORDER BY `Total Money Spent` " +
                    "DESC LIMIT 5;");
            if (!rs.next()) {
                out.print("<tr> <td  colspan=\"4\" style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    String fName = rs.getString("First Name");
                    String lName = rs.getString("Last Name");
                    String username = rs.getString("username");
                    double spendings = rs.getDouble("Total Money Spent");

                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + fName + "</td>");
                    out.print("<td style=\"text-align: left;\">" + lName + "</td>");
                    out.print("<td style=\"text-align: left;\">" + "<a href=\"userProfile.jsp?userProfile=" + username + "\">" + username + "</a>" + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(spendings) + "</td>");
                    out.print("</tr>");
                } while (rs.next());
            }
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
    <br>
    <p style="text-align: center;"><a href="salesReport.jsp">Generate a Different Sales Report</a>.</p>
    <% } %>
</div>
</body>

</html>