<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="css/main.css">
</head>

<body>
<%@ include file="navigationBar.jsp" %>
<% if ((session.getAttribute("user") == null)) { %>
<div class="marginLeft-Right">
    <p>You are not logged in</p>
    <br/>
    <a href="login.jsp">Please Login</a>
</div>
<%} else { %>
<form action="questionProcess.jsp" method="POST">
    <div class="container">
        <h1>Ask a Question</h1>
        <hr>

        <label for="topic"><b>Topic</b></label>
        <input type="text" placeholder="Enter the topic for your question" name="topic" id="topic" required>

        <label for="question"><b>Question</b></label>
        <br>
        <textarea placeholder="Enter your question" name="question" id="question" required></textarea>
        <br>

        <button type="submit" class="loginbtn">Ask Question</button>

        <div class="signin">
            <p><a href="questionsAndAnswers.jsp">Go back to questions list</a>.</p>
        </div>
    </div>
</form>
<% } %>

</body>

</html>