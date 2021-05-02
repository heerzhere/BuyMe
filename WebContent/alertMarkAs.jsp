<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
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
    //Open DB Connection
    Database db = new Database();
    Connection conn = null;
    Statement st = null;
    try {
        //Get parameters
        conn = db.getConnection();
        st = conn.createStatement();
        int alertID = Integer.parseInt(request.getParameter("alertID"));

        if (request.getParameter("process") != null) {
            int i = st.executeUpdate("DELETE FROM alert WHERE alertID='" + alertID + "';");
            if (i < 1) {
                out.println("<div class=\"container signin\"><p>Error: Alert was not deleted. <br> <a href=\"alertList.jsp\">Go back to the list of alerts</a>.</p></div>");
            } else {
                response.sendRedirect("alertList.jsp");
            }
            return;
        }


        boolean isRead = Boolean.parseBoolean(request.getParameter("isRead"));
        // Generate and Execute Query
        if (!isRead) {
            int i = st.executeUpdate("UPDATE alert SET isRead = 1 WHERE alertID='" + alertID + "';");
            if (i < 1) {
                out.println("<div class=\"container signin\"><p>Error: Alert was not marked as read. <br> <a href=\"alertList.jsp\">Go back to the list of alerts</a>.</p></div>");
            } else {
                //out.println("<div class=\"container signin\"><p>Alert was marked as read <br> <a href=\"alertList.jsp\">Go back to the list of alerts</a>.</p></div>");
                response.sendRedirect("alertList.jsp");
            }
        } else {
            int i = st.executeUpdate("UPDATE alert SET isRead = 0 WHERE alertID='" + alertID + "';");
            if (i < 1) {
                out.println("<div class=\"container signin\"><p>Error: Alert was not marked as unread. <br> <a href=\"alertList.jsp\">Go back to the list of alerts</a>.</p></div>");
            } else {
                //out.println("<div class=\"container signin\"><p>Alert was marked as unread <br> <a href=\"alertList.jsp\">Go back to the list of alerts</a>.</p></div>");
                response.sendRedirect("alertList.jsp");
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