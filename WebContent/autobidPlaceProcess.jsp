<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ page import="util.*" import="database.*" import="java.sql.*" import="java.time.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Insert title here</title>
    <link rel='stylesheet' href='css/main.css'>
    <style>
        h1 {
            text-align: center;
        }

        h4 {
            text-align: center;
        }

        p {
            text-align: center;
        }
    </style>
</head>
<body>

<%
    Account acc = (Account) session.getAttribute("userAccount");
    int listingID = Integer.parseInt(request.getParameter("listingID").trim());
    double bidVal = Double.parseDouble(request.getParameter("bidValue"));
    double bidIncr = Double.parseDouble(request.getParameter("increment"));
    double bidCeil = Double.parseDouble(request.getParameter("ceiling"));
    Connection conn = new Database().getConnection();
    try {
        if (conn.createStatement().executeQuery("SELECT listingID FROM auctionItem WHERE listingID = " + listingID + " AND closingDate > NOW();").next()) {
            PreparedStatement pst = conn.prepareStatement("INSERT INTO bid (listingID, bidder, bidValue, bidDate) VALUES (?,?,?,NOW());");
            pst.setInt(1, listingID);
            pst.setInt(2, acc.getAccountNumber());
            pst.setDouble(3, bidVal);
            pst.executeUpdate();
            // flush any old autobid entries for this user and listing
            conn.createStatement().executeUpdate("DELETE FROM autobid WHERE listingID = " + listingID + " AND userID = " + acc.getAccountNumber() + ";");
            pst = conn.prepareStatement("INSERT INTO autobid (listingID, userID, ceiling, increment) VALUES (?,?,?,?);");
            pst.setInt(1, listingID);
            pst.setInt(2, acc.getAccountNumber());
            pst.setDouble(3, bidCeil);
            pst.setDouble(4, bidIncr);
            pst.executeUpdate();
            CheckAutoBids.run();
            out.println("<div class=\"container signin\"><p>Successfully placed bid!<br><br><a href=\"auctionList.jsp\">Return to listings</a>.</p> </div>");
        } else {
            out.println("<div class=\"container signin\"><p>Sorry, the auction has closed<br><br><a href=\"auctionList.jsp\">Return to listings</a>.</p> </div>");
        }
    } catch (SQLException throwables) {
        throwables.printStackTrace();
    }


%>

</body>
</html>