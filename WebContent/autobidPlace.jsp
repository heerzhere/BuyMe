<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <script src="js/main.js"></script>
    <link rel="stylesheet" href="css/main.css">
    <style>
        h1 {text-align: center;}
        p {text-align: center;}
    </style>
    <link rel="stylesheet" href="css/main.css">
</head>

<body>
<%@ include file="navigationBar.jsp" %>
<form action="autobidPlaceProcess.jsp" method="POST">
    <div class="container">
        <h1>Place an Auto-bid</h1>
        <p>Please fill in this form to set up your auto-bid.</p>
        <hr>
        <%double bidValue = Double.parseDouble(request.getParameter("bidValue")); %>
        <label for="bidValue">Bid Amount</label>
        <input type="number" id="bidValue" name="bidValue" placeholder="Enter a Bid That is <%out.print(NumberFormat.getCurrencyInstance().format(bidValue+1.00));%> or Higher" min="<%out.print(bidValue+1.00);%>" step="0.01" required>

        <label for="ceiling">Price Ceiling</label>
        <input type="number" placeholder="Enter the maximum amount you would bid in USD" name="ceiling" id="ceiling" min="<%out.print(bidValue+1.00);%>" required>

        <label for="increment">Bid Increment Amount</label>
        <input type='number' placeholder='Enter the amount to increment above the current highest bid in USD' name='increment' id='increment' min="1" required>

        <input type='hidden' name='listingID' value="<% out.println(request.getParameter("listingId2")); %>">

        <button type="submit" class="registerbtn">Submit</button>
    </div>
</form>

</body>

</html>