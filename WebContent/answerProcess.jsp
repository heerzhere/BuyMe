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
    Database db = new Database();
    Connection conn = null;
    ResultSet rs = null;
    PreparedStatement ps = null;
    try {
        // Open DB Connection and get parameters
        conn = db.getConnection();
        Account userAccount = (Account) session.getAttribute("userAccount");
        int answeredBy = userAccount.getAccountNumber();
        String answer = request.getParameter("answer");
        int questionId = Integer.parseInt(request.getParameter("qid"));

        // Build the SQL query with placeholders for parameters
        String query = "UPDATE question SET answer = ?, answered_by = ?, answer_date = now() WHERE question_id = ?;";
        ps = conn.prepareStatement(query);

        // Add parameters to query
        ps.setString(1, answer);
        ps.setInt(2, answeredBy);
        ps.setInt(3, questionId);

        int result;
        result = ps.executeUpdate();
        if (result < 1) {
            out.println("<div class=\"container signin\"><p>There was a problem processing your answer <br><a href=\"question.jsp\">Try Again</a>.</p> </div>");
        } else {
            out.println("<div class=\"container signin\"><p>You have answered the question <br><a href=\" questionsAndAnswers.jsp\">Go back to questions list</a>.</p> </div>");

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