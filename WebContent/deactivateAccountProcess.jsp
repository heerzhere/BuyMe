<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.Account" %>

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
    ResultSet rs = null;
    try {
        //Get parameters
        conn = db.getConnection();
        String username = request.getParameter("userNameDeactivate");
        String password = request.getParameter("psw");

        // Generate and Execute Query
        st = conn.createStatement();

        Account userAccount = (Account) session.getAttribute("userAccount");
        if (userAccount.getAccessLevel() < 3 && username.equals(userAccount.getUsername())) {
            int i = st.executeUpdate("UPDATE account SET is_active = false WHERE username='" + username + "' AND password='" + password + "';");
            if (i < 1) {
                out.println("<div class=\"container signin\"><p>Account was not deactivated: User's Credentials are Incorrect <br> <a href=\"profile.jsp\">Go to your profile</a>.</p></div>");
            } else {
                session.invalidate();
                out.println("<div class=\"container signin\"><p>Account deactivated successfully <br> <a href=\"index.jsp\">Go to Homepage</a>.</p></div>");
            }
        } else if (userAccount.getAccessLevel() < 3) {
            int i = st.executeUpdate("UPDATE account SET is_active = false WHERE username='" + username + "' AND password='" + password + "';");
            if (i < 1) {
                out.println("<div class=\"container signin\"><p>Account was not deactivated: User's Credentials are Incorrect <br> <a href=\"profile.jsp\">Go to your profile</a>.</p></div>");
            } else {
                out.println("<div class=\"container signin\"><p>Account deactivated successfully <br> <a href=\"index.jsp\">Go to Homepage</a>.</p></div>");
            }
        } else {
            if (username.equals(session.getAttribute("user").toString())) {
                int i = st.executeUpdate("UPDATE account SET is_active = false WHERE username='" + username + "' AND password='" + password + "';");
                if (i < 1) {
                    out.println("<div class=\"container signin\"><p>Account was not deactivated: Invalid credentials <br> <a href=\"profile.jsp\">Go to your profile</a>.</p></div>");
                } else {
                    session.invalidate();
                    out.println("<div class=\"container signin\"><p>Account deactivated successfully <br> <a href=\"index.jsp\">Go to Homepage</a>.</p></div>");
                }
            } else {
                out.println("<div class=\"container signin\"><p>Account was not deactivated: Invalid credentials <br> <a href=\"profile.jsp\">Go to your profile</a>.</p></div>");
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
</body>

</html>