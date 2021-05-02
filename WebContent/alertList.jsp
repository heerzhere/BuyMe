<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="util.Account" %>
<%@ page import="util.Alert" %>

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
    <h1>Alerts</h1>
    <hr>
    <ul id="myULNoLink">
        <%
            Database db = new Database();
            ArrayList<Alert> alertList = new ArrayList<>();
            Connection conn = null;
            Statement st = null;
            ResultSet rs = null;
            try {
                // Open DB Connection and get parameters
                conn = db.getConnection();
                st = conn.createStatement();

                // Create query for login validation
                rs = st.executeQuery("SELECT * FROM alert ORDER BY alert.alertID DESC;");
                if (!rs.next()) {
                } else {
                    do {
                        int alertID = rs.getInt("alertID");
                        boolean isRead = rs.getBoolean("isRead");

                        String isReadHeaderColor;
                        String isReadButton;
                        String isReadStatus;
                        String isReadLink;
                        String markAs;
                        if (isRead) {
                            isReadHeaderColor = "font-green";
                            isReadButton = "mark-as-unread";
                            isReadStatus = "READ";
                            isReadLink = "&isRead=true";
                            markAs = "Unread";
                        } else {
                            isReadHeaderColor = "font-red";
                            isReadButton = "mark-as-read";
                            isReadStatus = "UNREAD";
                            isReadLink = "&isRead=false";
                            markAs = "Read";
                        }

                        Alert alert = new Alert(alertID);
                        Account userAccount = (Account) session.getAttribute("userAccount");
                        if (alert.getUser() == userAccount.getAccountNumber()) {
                            out.println("<li>"
                                    + "Status: <span class=\"" + isReadHeaderColor + "\">" + isReadStatus + "</span>"
                                    + "<a href=\"alertMarkAs.jsp?process=delete&alertID="+alertID+"\">"
                                    + "<span class=\"close-button\">&times;</span>"
                                    + "</a>"
                                    + "<br>Topic: " + alert.getAlertTopic()
                                    + "<br>Message: " + alert.getAlertMessage()
                                    + "<a href=\"alertMarkAs.jsp?alertID="+alertID+isReadLink+"\">"
                                    + "<button class='"+isReadButton+"'>Mark as "+markAs+"</button>"
                                    + "</a>"
                                    + "</li>");
                            alertList.add(alert);
                        }
                    } while (rs.next());
                }
                if (alertList.isEmpty()) {
                    out.print("<h2>All caught up!</h2>");
                }
                session.setAttribute("alertList", alertList);
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