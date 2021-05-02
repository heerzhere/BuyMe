<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@page import="util.Account" %>
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
    Statement st = null;
    ResultSet rs = null;
    try {
        // Open DB Connection and get parameters
        conn = db.getConnection();
        String username = request.getParameter("username");
        String password = request.getParameter("psw");
        st = conn.createStatement();

        // Create query for login validation
        rs = st.executeQuery("SELECT * FROM account WHERE username='" + username + "' AND password='" + password + "';");
        if (rs.next()) {
            Account userAccount = new Account();
            int accountNumber = rs.getInt("account_number");
            String firstName = rs.getString("first_name");
            String lastName = rs.getString("last_name");
            String email = rs.getString("email");
            int accessLevel = rs.getInt("access_level");

            userAccount.setAccountNumber(accountNumber);
            userAccount.setFirstName(firstName);
            userAccount.setLastName(lastName);
            userAccount.setUsername(username);
            userAccount.setPassword(password);
            userAccount.setEmail(email);
            userAccount.setAccessLevel(accessLevel);

            session.setAttribute("userAccount", userAccount);
            session.setAttribute("user", username);
            if (!rs.getBoolean("is_active")) {
                int i = st.executeUpdate("UPDATE account SET is_active = true WHERE username='" + username + "' AND password='" + password + "';");
                out.println("<div class=\"container signin\"><p>Account Reactivated <br><a href=\"profile.jsp\">Go to Profile</a>.</p> </div>");
            } else {
                response.sendRedirect("profile.jsp");
            }
        } else {
            out.println("<div class=\"container signin\"><p>Invalid Credentials <br><a href=\"login.jsp\">Try Again</a>.</p> </div>");
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