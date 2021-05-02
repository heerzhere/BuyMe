<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="css/main.css">
    <script src="js/main.js"></script>
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
<form action="wishlistProcess.jsp" method="POST">
    <div class="container">
        <%if (request.getParameter("process") == null) {%>

        <h1>Add Product to Wishlist</h1>
        <hr>

        <label for="manufacturer"><b>Manufacturer</b></label>
        <input type="text" placeholder="Enter the manufacturer name" name="manufacturer" id="manufacturer" required>

        <label for="model"><b>Model</b></label>
        <input type="text" placeholder="Enter the model name" name="model" id="model" required>

        <label for="condition"><b>New/Used</b></label>
        <select name="condition" id="condition">
            <option value="" selected disabled hidden>Select the condition of the vehicle</option>
            <option value="New">New</option>
            <option value="Used">Used</option>
        </select>
        <br>

        <label for="maxPrice"><b>Maximum Price($)</b></label>
        <input type="number" placeholder="Enter the maximum price you are willing to pay for the product"
               name="maxPrice" id="maxPrice" min="1" step="0.01" required>

        <button type="submit" class="loginbtn">Add to Wishlist</button>

        <% } else if (request.getParameter("process").equals("auctionAdd")) {%>
        <% AuctionItem auctionItem = new AuctionItem(Integer.parseInt(request.getParameter("listingId")));%>
        <h1>Add Product to Wishlist</h1>
        <hr>

        <label for="manufacturer"><b>Manufacturer</b></label>
        <input type="text" value="<%out.print(auctionItem.getManufacturer());%>" name="manufacturer" id="manufacturer" required>

        <label for="model"><b>Model</b></label>
        <input type="text" value="<%out.print(auctionItem.getModel());%>" name="model" id="model" required>

        <label for="condition"><b>New/Used</b></label>
        <select name="condition" id="condition">
            <option value="" selected disabled hidden>Select the condition of the vehicle</option>
            <option value="New">New</option>
            <option value="Used">Used</option>
        </select>
        <br>

        <label for="maxPrice"><b>Maximum Price($)</b></label>
        <input type="number" placeholder="Enter the maximum price you are willing to pay for the product"
               name="maxPrice" id="maxPrice" min="1" step="0.01" required>

        <button type="submit" class="loginbtn">Add to Wishlist</button>
        <% } %>
    </div>
</form>
<% } %>

</body>

</html>