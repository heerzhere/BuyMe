<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="util.Account" %>
<%@page import="database.Database" %>
<%@ page import="java.sql.*" %>

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
    Database db = new Database();
    Connection conn = null;
    PreparedStatement ps = null;
    Account userAccount = (Account) session.getAttribute("userAccount");
    int user = userAccount.getAccountNumber();
    String model = request.getParameter("model");
    String manufacturer = request.getParameter("manufacturer");
    String condition = request.getParameter("condition");
    double maxPrice = Double.parseDouble(request.getParameter("maxPrice"));

    try {
        // Open DB Connection and get parameters
        conn = db.getConnection();

        if (request.getParameter("process") != null) {
            String query = "DELETE FROM wishlist WHERE user=? AND model=? AND manufacturer=? AND `condition`=? AND maxPrice=?;";
            ps = conn.prepareStatement(query);
            // Add parameters to query
            ps.setInt(1, user);
            ps.setString(2, model);
            ps.setString(3, manufacturer);
            ps.setString(4, condition);
            ps.setDouble(5, maxPrice);

            int result = ps.executeUpdate();
            if (result < 1) {
                out.println("<div class=\"container signin\"><p>Error: Wishlist item was not deleted. <br> <a href=\"wishlist.jsp\">Go back wishlist</a>.</p></div>");
            } else {
                response.sendRedirect("wishlist.jsp");
            }
            return;
        }
        // Build the SQL query with placeholders for parameters
        String query = "INSERT INTO wishlist (user, model, manufacturer, `condition`, maxPrice, isAvailable) VALUES (?, ?, ?, ?, ?, ?);";
        ps = conn.prepareStatement(query);
        // Add parameters to query
        ps.setInt(1, user);
        ps.setString(2, model);
        ps.setString(3, manufacturer);
        ps.setString(4, condition);
        ps.setDouble(5, maxPrice);
        ps.setBoolean(6, false);

        int result = ps.executeUpdate();


        if (result < 1) {
            out.println("<div class=\"container signin\"><p>There was a adding to your wishlist <br><a href=\"wishlist.jsp\">Try Again</a>.</p> </div>");
        } else {
            out.println("<div class=\"container signin\"><p>Product added to your wishlist <br><a href=\" wishlist.jsp\">Go back to your wishlist</a>.</p> </div>");
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
            if (conn != null) db.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</body>

</html>