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

<label for="engineType"><b>Engine Type</b></label>
<select name="engineType" id="engineType">
    <option value="" selected disabled hidden>Select the boat's engine type</option>
    <option value="Jet Drive">Jet Drive</option>
    <option value="Single Inboard">Single Inboard</option>
    <option value="Outboard 2 Stroke">Outboard 2 Stroke</option>
    <option value="Outboard 4 Stroke">Outboard 4 Stroke</option>
    <option value="Stern Drive">Stern Drive</option>
</select>
<br>

<label for="boatType"><b>Boat Type</b></label>
<select name="boatType" id="boatType">
    <option value="" selected disabled hidden>Select the boat type</option>
    <option value="All Purpose">All Purpose</option>
    <option value="Fishing">Fishing</option>
    <option value="Dinghy">Dinghy</option>
    <option value="Deck">Deck</option>
    <option value="Bowrider">Bowrider</option>
    <option value="Catamaran">Catamaran</option>
    <option value="Cuddy Cabins">Cuddy Cabins</option>
    <option value="Centre Console">Centre Console</option>
    <option value="Houseboats">Houseboats</option>
    <option value="Trawler">Trawler</option>
    <option value="Cabin Cruiser">Cabin Cruiser</option>
    <option value="Game">Game</option>
    <option value="Motor Yacht">Motor Yacht</option>
    <option value="Personal Watercraft">Personal Watercraft</option>
    <option value="Runabout">Runabout</option>
    <option value="Jet">Jet</option>
    <option value="Wakeboard">Wakeboard</option>
    <option value="Banana">Banana</option>
    <option value="Lifeboats">Lifeboats</option>
    <option value="Pontoon">Pontoon</option>
    <option value="Sedan Bridge">Sedan Bridge</option>
    <option value="Other">Other</option>
</select>
<br>

<label for="hullMaterial"><b>Hull Material</b></label>
<select name="hullMaterial" id="hullMaterial">
    <option value="" selected disabled hidden>Select the boat's hull material</option>
    <option value="Ferro-cement">Ferro-cement</option>
    <option value="Wood">Wood</option>
    <option value="Fiberglass">Fiberglass</option>
    <option value="Steel">Steel</option>
    <option value="Aluminum">Aluminum</option>
</select>
<br>

<label for="primaryFuelType"><b>Primary Fuel Type</b></label>
<select name="primaryFuelType" id="primaryFuelType">
    <option value="" selected disabled hidden>Select the boat's primary fuel type</option>
    <option value="Diesel">Diesel </option>
    <option value="Ethanol-free Gasoline">Ethanol-free Gasoline</option>
    <option value="E10">E10</option>
    <option value="Other">Other</option>
</select>
<br>

</body>

</html>