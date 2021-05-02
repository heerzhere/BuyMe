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
    Statement st;
    ResultSet rs = null;
    PreparedStatement ps = null;
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String username = request.getParameter("username");
    String password = request.getParameter("psw");
    String email = request.getParameter("email");

    if (request.getParameter("process").equals("edit")) {
        // UPDATING ACCOUNT INFORMATION
        Account userAccount = (Account) session.getAttribute("userAccount");
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            int accountNumber = userAccount.getAccountNumber();
            st = conn.createStatement();
            // Create query for login validation
            if (!userAccount.getUsername().equals(username)) {
                rs = st.executeQuery("SELECT * FROM account WHERE username='" + username + "';");
                if (rs.next()) {
                    out.println("<div class=\"container signin\"><p>Username Taken <br><a href=\"editAccountInformation.jsp\">Try Again</a>.</p> </div>");
                    return;
                }
            }
            // Build the SQL query with placeholders for parameters
            String query = "UPDATE account SET first_name = ?, last_name = ?, username = ?, password = ?, email = ? WHERE username = ?;";
            ps = conn.prepareStatement(query);

            // Add parameters to query
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, username);
            ps.setString(4, password);
            ps.setString(5, email);
            ps.setString(6, userAccount.getUsername());

            int result = ps.executeUpdate();
            if (result < 1) {
                out.println("<div class=\"container signin\"><p>There was a problem updating the account <br><a href=\"editAccountInformation.jsp\">Try Again</a>.</p> </div>");
            } else {
                userAccount.setAccountNumber(accountNumber);
                userAccount.setFirstName(firstName);
                userAccount.setLastName(lastName);
                userAccount.setUsername(username);
                userAccount.setPassword(password);
                userAccount.setEmail(email);

                session.setAttribute("userAccount", userAccount);
                session.setAttribute("user", username);
                out.println("<div class=\"container signin\"><p>Account Information Updated<br><a href=\"profile.jsp\">Go to profile page</a>.</p> </div>");
            }
        } catch (SQLException se) {
            out.print("<p>Error connecting to MYSQL server.</p>");
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else if (request.getParameter("process").equals("editUserProfile")) {
        // UPDATING USER'S ACCOUNT INFORMATION AS ADMIN/CUSTOMER REP
        Account recentlyViewedAccount = (Account) session.getAttribute("recentlyViewedAccount");
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            int accountNumber = recentlyViewedAccount.getAccountNumber();
            st = conn.createStatement();
            // Create query for login validation
            if (!recentlyViewedAccount.getUsername().equals(username)) {
                rs = st.executeQuery("SELECT * FROM account WHERE username='" + username + "';");
                if (rs.next()) {
                    out.println("<div class=\"container signin\"><p>Username Taken <br><a href=\"editAccountInformation.jsp\">Try Again</a>.</p> </div>");
                    return;
                }
            }
            // Build the SQL query with placeholders for parameters
            String query = "UPDATE account SET first_name = ?, last_name = ?, username = ?, password = ?, email = ? WHERE username = ?;";
            ps = conn.prepareStatement(query);

            // Add parameters to query
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, username);
            ps.setString(4, password);
            ps.setString(5, email);
            ps.setString(6, recentlyViewedAccount.getUsername());

            int result = ps.executeUpdate();
            if (result < 1) {
                out.println("<div class=\"container signin\"><p>There was a problem updating the account <br><a href=\"editAccountInformation.jsp\">Try Again</a>.</p> </div>");
            } else {
                recentlyViewedAccount.setAccountNumber(accountNumber);
                recentlyViewedAccount.setFirstName(firstName);
                recentlyViewedAccount.setLastName(lastName);
                recentlyViewedAccount.setUsername(username);
                recentlyViewedAccount.setPassword(password);
                recentlyViewedAccount.setEmail(email);

                session.setAttribute("recentlyViewedAccount", recentlyViewedAccount);
                out.println("<div class=\"container signin\"><p>Account Information Updated<br><a href=\"profile.jsp\">Go to profile page</a>.</p> </div>");
            }
        } catch (SQLException se) {
            out.print("<p>Error connecting to MYSQL server.</p>");
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else if (request.getParameter("process").equals("createCustomerRep")) {
        // ADMIN CREATING A CUSTOMER REP ACCOUNT
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            int accessLevel = 2;

            st = conn.createStatement();
            // Create query for login validation
            rs = st.executeQuery("SELECT * FROM account WHERE username='" + username + "';");
            if (rs.next()) {
                out.println("<div class=\"container signin\"><p>Username Taken <br><a href=\"register.jsp\">Try Again</a>.</p> </div>");
            } else {
                // Build the SQL query with placeholders for parameters
                String query = "INSERT INTO account (first_name, last_name, username, password, email, access_level, is_active) VALUES (?, ?, ?, ?, ?, ?, ?);";
                ps = conn.prepareStatement(query);

                // Add parameters to query
                ps.setString(1, firstName);
                ps.setString(2, lastName);
                ps.setString(3, username);
                ps.setString(4, password);
                ps.setString(5, email);
                ps.setInt(6, accessLevel);
                ps.setBoolean(7, true); // isActive = true

                int result;
                result = ps.executeUpdate();
                if (result < 1) {
                    out.println("<div class=\"container signin\"><p>There was a problem creating customer representative account <br><a href=\"profile.jsp\">Go back to your profile</a>.</p> </div>");
                } else {
                    out.println("<div class=\"container signin\"><p>Customer representative account created <br><a href=\"profile.jsp\">Go back to your profile</a>.</p> </div>");
                }
            }
        } catch (SQLException se) {
            out.print("<p>Error connecting to MYSQL server.</p>");
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        // ACCOUNT REGISTRATION
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            int accessLevel = 3;

            st = conn.createStatement();
            // Create query for login validation
            rs = st.executeQuery("SELECT * FROM account WHERE username='" + username + "';");
            if (rs.next()) {
                out.println("<div class=\"container signin\"><p>Username Taken <br><a href=\"register.jsp\">Try Again</a>.</p> </div>");
            } else {
                // Build the SQL query with placeholders for parameters
                String query = "INSERT INTO account (first_name, last_name, username, password, email, access_level, is_active) VALUES (?, ?, ?, ?, ?, ?, ?);";
                ps = conn.prepareStatement(query);

                // Add parameters to query
                ps.setString(1, firstName);
                ps.setString(2, lastName);
                ps.setString(3, username);
                ps.setString(4, password);
                ps.setString(5, email);
                ps.setInt(6, accessLevel);
                ps.setBoolean(7, true); // isActive = true

                int result;
                result = ps.executeUpdate();
                if (result < 1) {
                    out.println("<div class=\"container signin\"><p>There was a problem registering your account <br><a href=\"register.jsp\">Try Again</a>.</p> </div>");
                } else {
                    out.println("<div class=\"container signin\"><p>Thank you for registering <br><a href=\"login.jsp\">Please Login</a>.</p> </div>");
                }
            }
        } catch (SQLException se) {
            out.print("<p>Error connecting to MYSQL server.</p>");
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    // CLOSE
    try {
        if (rs != null) rs.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
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
%>
</body>

</html>