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

<label for="fuelType"><b>Fuel Type</b></label>
<select name="fuelType" id="fuelType">
    <option value="" selected disabled hidden>Select the vehicle's fuel type</option>
    <option value="Gasoline">Gasoline</option>
    <option value="Diesel">Diesel</option>
    <option value="Bio-diesel">Bio-diesel</option>
    <option value="Ethanol">Ethanol</option>
    <option value="Electric">Electric</option>
    <option value="Hybrid">Hybrid</option>
    <option value="Other">Other</option>
</select>
<br>

<label for="mileage"><b>Mileage</b></label>
<input type="number" placeholder="Enter the current mileage of the vehicle" name="mileage" id="mileage" min="0" step="1" required>

<label for="driveType"><b>Drive Type</b></label>
<select name="driveType" id="driveType">
    <option value="" selected disabled hidden>Select the vehicle's drive type</option>
    <option value="AWD">AWD</option>
    <option value="4WD">4WD</option>
    <option value="FWD">FWD</option>
    <option value="RWD">RWD</option>
</select>
<br>

<label for="bodyType"><b>Body Type</b></label>
<select name="bodyType" id="bodyType">
    <option value="" selected disabled hidden>Select the vehicle's body type</option>
    <option value="Convertible">Convertible</option>
    <option value="Coupe">Coupe</option>
    <option value="Hatchback">Hatchback</option>
    <option value="Minivan">Minivan</option>
    <option value="Sedan">Sedan</option>
    <option value="SUV">SUV</option>
    <option value="Truck">Truck</option>
    <option value="Van">Van</option>
    <option value="Wagon">Wagon</option>
    <option value="Other">Other</option>
</select>
<br>

<label for="transmission"><b>Transmission</b></label>
<select name="transmission" id="transmission">
    <option value="" selected disabled hidden>Select the vehicle's transmission</option>
    <option value="Automatic">Automatic</option>
    <option value="Manual">Manual</option>
    <option value="CVT">CVT</option>
</select>
<br>
</body>

</html>