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
<%
    String auctionType = request.getParameter("type");
    auctionType = auctionType.substring(0, 1).toUpperCase() + auctionType.substring(1);
%>
<form action="auctionProcess.jsp?type=<%out.print(auctionType);%>" method="POST">
    <div class="container">
        <h1>Create a New <%out.print(auctionType);%> Auction</h1>
        <hr>

        <label for="productID"><b>Identification Number (VIN#/HIN#/Tail#)</b></label>
        <input type="text" placeholder="Enter the vehicle's identification number" name="productID" id="productID" required>

        <%if (auctionType.equalsIgnoreCase("car")) {%>
        <label for="manufacturer"><b>Manufacturer</b></label>
        <select name="manufacturer" id="manufacturer">
            <option value="" selected disabled hidden>Select a Manufacturer</option>
            <option value="AMC">AMC</option>
            <option value="Acura">Acura</option>
            <option value="Alfa Romeo">Alfa Romeo</option>
            <option value="Ariel">Ariel</option>
            <option value="Aston Martin">Aston Martin</option>
            <option value="Audi">Audi</option>
            <option value="Austin">Austin</option>
            <option value="Austin Healey">Austin Healey</option>
            <option value="BMW">BMW</option>
            <option value="Bentley">Bentley</option>
            <option value="Bugatti">Bugatti</option>
            <option value="Buick">Buick</option>
            <option value="Cadillac">Cadillac</option>
            <option value="Chevrolet">Chevrolet</option>
            <option value="Chrysler">Chrysler</option>
            <option value="Citroën">Citroën</option>
            <option value="Cord">Cord</option>
            <option value="Daewoo">Daewoo</option>
            <option value="Daihatsu">Daihatsu</option>
            <option value="Datsun">Datsun</option>
            <option value="De Tomaso">De Tomaso</option>
            <option value="DeLorean">DeLorean</option>
            <option value="DeSoto">DeSoto</option>
            <option value="Dodge">Dodge</option>
            <option value="Eagle">Eagle</option>
            <option value="Edsel">Edsel</option>
            <option value="Ferrari">Ferrari</option>
            <option value="Fiat">Fiat</option>
            <option value="Fisker">Fisker</option>
            <option value="Ford">Ford</option>
            <option value="GMC">GMC</option>
            <option value="Genesis">Genesis</option>
            <option value="Geo">Geo</option>
            <option value="Honda">Honda</option>
            <option value="Hudson">Hudson</option>
            <option value="Hummer">Hummer</option>
            <option value="Hyundai">Hyundai</option>
            <option value="Infiniti">Infiniti</option>
            <option value="International Harvester">International Harvester</option>
            <option value="Isuzu">Isuzu</option>
            <option value="Jaguar">Jaguar</option>
            <option value="Jeep">Jeep</option>
            <option value="Kia">Kia</option>
            <option value="Koenigsegg">Koenigsegg</option>
            <option value="Lamborghini">Lamborghini</option>
            <option value="Lancia">Lancia</option>
            <option value="Land Rover">Land Rover</option>
            <option value="Lexus">Lexus</option>
            <option value="Lincoln">Lincoln</option>
            <option value="Lotus">Lotus</option>
            <option value="MG">MG</option>
            <option value="Maserati">Maserati</option>
            <option value="Maybach">Maybach</option>
            <option value="Mazda">Mazda</option>
            <option value="McLaren">McLaren</option>
            <option value="Mercedes-Benz">Mercedes-Benz</option>
            <option value="Mercury">Mercury</option>
            <option value="Mini">Mini</option>
            <option value="Mitsubishi">Mitsubishi</option>
            <option value="Morgan">Morgan</option>
            <option value="Morris">Morris</option>
            <option value="Nash">Nash</option>
            <option value="Nissan">Nissan</option>
            <option value="Oldsmobile">Oldsmobile</option>
            <option value="Opel">Opel</option>
            <option value="Other Makes">Other Makes</option>
            <option value="Packard">Packard</option>
            <option value="Peugeot">Peugeot</option>
            <option value="Plymouth">Plymouth</option>
            <option value="Pontiac">Pontiac</option>
            <option value="Porsche">Porsche</option>
            <option value="Ram">Ram</option>
            <option value="Renault">Renault</option>
            <option value="Replica/Kit Makes">Replica/Kit Makes</option>
            <option value="Rolls-Royce">Rolls-Royce</option>
            <option value="Saab">Saab</option>
            <option value="Saturn">Saturn</option>
            <option value="Scion">Scion</option>
            <option value="Shelby">Shelby</option>
            <option value="Skoda">Skoda</option>
            <option value="Smart">Smart</option>
            <option value="Studebaker">Studebaker</option>
            <option value="Subaru">Subaru</option>
            <option value="Sunbeam">Sunbeam</option>
            <option value="Suzuki">Suzuki</option>
            <option value="Tesla">Tesla</option>
            <option value="Toyota">Toyota</option>
            <option value="Triumph">Triumph</option>
            <option value="Volkswagen">Volkswagen</option>
            <option value="Volvo">Volvo</option>
            <option value="Willys">Willys</option>
        </select>
        <br>
        <%} else if (auctionType.equalsIgnoreCase("boat")) {%>
        <label for="manufacturer"><b>Manufacturer</b></label>
        <input type="text" placeholder="Enter the manufacturer name" name="manufacturer" id="manufacturer" required>

        <%} else if (auctionType.equalsIgnoreCase("aircraft")) {%>
        <label for="manufacturer"><b>Manufacturer</b></label>
        <input type="text" placeholder="Enter the manufacturer name" name="manufacturer" id="manufacturer" required>

        <%}%>

        <label for="model"><b>Model</b></label>
        <input type="text" placeholder="Enter the model name" name="model" id="model" required>

        <label for="condition"><b>New/Used</b></label>
        <select name="condition" id="condition">
            <option value="" selected disabled hidden>Select the condition of the vehicle</option>
            <option value="New">New</option>
            <option value="Used">Used</option>
        </select>
        <br>

        <%int currentYear = Calendar.getInstance().get(Calendar.YEAR);%>
        <label for="year"><b>Year</b></label>
        <input type="number" placeholder="Enter the year the vehicle was made in" name="year" id="year" min="1900" max="<%out.print(currentYear);%>" step="1" required>

        <label for="exteriorColor"><b>Exterior Color</b></label>
        <input type="text" placeholder="Enter the exterior color of the vehicle" name="exteriorColor" id="exteriorColor" required>

        <label for="interiorColor"><b>Interior Color</b></label>
        <input type="text" placeholder="Enter the interior color of the vehicle" name="interiorColor" id="interiorColor" required>

        <label for="capacity"><b>Capacity</b></label>
        <input type="number" placeholder="Enter the vehicle's passenger capacity" name="capacity" id="capacity" min="1" step="1" required>
        <%if (auctionType.equalsIgnoreCase("car")) {%>
            <%@ include file="auctionCar.jsp" %>
        <%} else if (auctionType.equalsIgnoreCase("boat")) {%>
            <%@ include file="auctionBoat.jsp" %>
        <%} else if (auctionType.equalsIgnoreCase("aircraft")) {%>
            <%@ include file="auctionAircraft.jsp" %>
        <%}%>

        <label for="listPrice"><b>Initial Listing Price($)</b></label>
        <input type="number" placeholder="Enter the price you want the vehicle to be listed for" name="listPrice" id="listPrice" min="1" step="0.01" required>

        <label for="minSellPrice"><b>Minimum Sell Price($)</b></label>
        <input type="number" placeholder="Enter the minimum price you are willing to sell the vehicle for" name="minSellPrice" id="minSellPrice" min="1" step="0.01">

        <label for="closingDate"><b>Closing Date and Time For the Auction</b></label>
        <br>
        <%
            Calendar cal = new GregorianCalendar();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
            dateFormat.setTimeZone(cal.getTimeZone());
            timeFormat.setTimeZone(cal.getTimeZone());
            String date = dateFormat.format(cal.getTime());
            cal.add(Calendar.MINUTE, 2); // Min auction length is 2 minutes
            String time = timeFormat.format(cal.getTime());
        %>
        <input type="datetime-local" name="closingDate" id="closingDate" min="<%out.print(date);%>T<%out.print(time);%>" required>
        <br>
        <br>

        <button type="submit" class="loginbtn">Create Auction</button>

        <div class="signin">
            <p><a href="auctionList.jsp">Go back to list of auctions</a>.</p>
        </div>
    </div>
</form>
<% } %>

</body>

</html>