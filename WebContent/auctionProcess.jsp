<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="util.Account" %>
<%@page import="database.Database" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.AuctionItem" %>

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
    PreparedStatement ps = null;
    PreparedStatement psAlert = null;
    PreparedStatement psWishlist = null;
    PreparedStatement psWishlistIsAvailable = null;
    ResultSet rsWishlist = null;

    Account userAccount = (Account) session.getAttribute("userAccount");
    String productId = request.getParameter("productID");
    String type = request.getParameter("type");
    double listPrice = Double.parseDouble(request.getParameter("listPrice"));
    double minSellPrice;
    if (request.getParameter("minSellPrice") == null || request.getParameter("minSellPrice") == "") {
        minSellPrice = listPrice;
    } else {
        minSellPrice = Double.parseDouble(request.getParameter("minSellPrice"));
    }
    String exteriorColor = request.getParameter("exteriorColor");
    String interiorColor = request.getParameter("interiorColor");
    String model = request.getParameter("model");
    String manufacturer = request.getParameter("manufacturer");
    String condition = request.getParameter("condition");
    int capacity = Integer.parseInt(request.getParameter("capacity"));
    String closingDate = request.getParameter("closingDate");
    closingDate = closingDate.substring(0,10)+" "+closingDate.substring(11);
    int year = Integer.parseInt(request.getParameter("year"));
    int seller = userAccount.getAccountNumber();

    try {
        // Open DB Connection and get parameters
        conn = db.getConnection();
        // Build the SQL query with placeholders for parameters

        String query = "INSERT INTO auctionItem (productID, type, listPrice, minSellPrice, exteriorColor, interiorColor, model, manufacturer, `condition`, capacity, closingDate, `year`, listDate, seller) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,now(),?);";
        ps = conn.prepareStatement(query);

        // Add parameters to query
        ps.setString(1, productId);
        ps.setString(2, type);
        ps.setDouble(3, listPrice);
        ps.setDouble(4, minSellPrice);
        ps.setString(5, exteriorColor);
        ps.setString(6, interiorColor);
        ps.setString(7, model);
        ps.setString(8, manufacturer);
        ps.setString(9, condition);
        ps.setInt(10, capacity);
        ps.setString(11, closingDate);
        ps.setInt(12, year);
        ps.setInt(13, seller);

        int resultAuction;
        int resultAuctionCar;
        int resultAuctionBoat;
        int resultAuctionAircraft;
        resultAuction = ps.executeUpdate();

        if (type.equalsIgnoreCase("car")) {
            String fuelType = request.getParameter("fuelType");
            int mileage = Integer.parseInt(request.getParameter("mileage"));
            String driveType = request.getParameter("driveType");
            String bodyType = request.getParameter("bodyType");
            String transmission = request.getParameter("transmission");

            String queryCar = "INSERT INTO car (listingID, fuelType, mileage, driveType, bodyType, transmission) VALUES (LAST_INSERT_ID(),?,?,?,?,?);";
            ps = conn.prepareStatement(queryCar);

            ps.setString(1, fuelType);
            ps.setInt(2, mileage);
            ps.setString(3, driveType);
            ps.setString(4, bodyType);
            ps.setString(5, transmission);

            resultAuctionCar = ps.executeUpdate();
            if (resultAuctionCar < 1) {
                out.println("<div class=\"container signin\"><p>There was a problem creating your Car auction <br><a href=\"auction.jsp\">Try Again</a>.</p> </div>");
            }
        } else if (type.equalsIgnoreCase("boat")) {
            String engineType = request.getParameter("engineType");
            String boatType = request.getParameter("boatType");
            String hullMaterial = request.getParameter("hullMaterial");
            String primaryFuelType = request.getParameter("primaryFuelType");

            String queryBoat = "INSERT INTO boat (listingID, engineType, boatType, hullMaterial, primaryFuelType) VALUES (LAST_INSERT_ID(),?,?,?,?);";
            ps = conn.prepareStatement(queryBoat);

            ps.setString(1, engineType);
            ps.setString(2, boatType);
            ps.setString(3, hullMaterial);
            ps.setString(4, primaryFuelType);

            resultAuctionBoat = ps.executeUpdate();
            if (resultAuctionBoat < 1) {
                out.println("<div class=\"container signin\"><p>There was a problem creating your Boat auction <br><a href=\"auctionList.jsp\">Try Again</a>.</p> </div>");
            }
        } else if (type.equalsIgnoreCase("aircraft")) {
            String airCategory = request.getParameter("airCategory");
            int engineHours = Integer.parseInt(request.getParameter("engineHours"));
            String avionics = request.getParameter("avionics");

            String queryAircraft = "INSERT INTO aircraft (listingID, airCategory, engineHours, avionics) VALUES (LAST_INSERT_ID(),?,?,?);";
            ps = conn.prepareStatement(queryAircraft);

            ps.setString(1, airCategory);
            ps.setInt(2, engineHours);
            ps.setString(3, avionics);

            resultAuctionAircraft = ps.executeUpdate();
            if (resultAuctionAircraft < 1) {
                out.println("<div class=\"container signin\"><p>There was a problem creating your Aircraft auction <br><a href=\"auctionList.jsp\">Try Again</a>.</p> </div>");
            }
        }

        if (resultAuction < 1) {
            out.println("<div class=\"container signin\"><p>There was a problem creating your auction <br><a href=\"auctionList.jsp\">Try Again</a>.</p> </div>");
        } else {
            db.closeConnection(conn);
            conn = db.getConnection();
            String wishlistQuery = "SELECT * FROM  wishlist WHERE model=? AND manufacturer=? AND `condition`=? AND maxPrice>=?;";
            psWishlist = conn.prepareStatement(wishlistQuery);
            psWishlist.setString(1, model);
            psWishlist.setString(2, manufacturer);
            psWishlist.setString(3, condition);
            psWishlist.setDouble(4, listPrice);
            rsWishlist = psWishlist.executeQuery();
            if (!rsWishlist.next()) {
                response.sendRedirect("auctionList.jsp");
            } else {
                do {
                    int user = rsWishlist.getInt("user");
                    double maxPrice = rsWishlist.getDouble("maxPrice");
                    String topic = "Wishlist Item";
                    String message = manufacturer+" "+model+" has become available";
                    String queryAlert = "INSERT INTO alert (user, alertTopic, alertMessage, isRead) VALUES (?, ?, ?, ?);";
                    psAlert = conn.prepareStatement(queryAlert);
                    // Add parameters to query
                    psAlert.setInt(1, user);
                    psAlert.setString(2, topic);
                    psAlert.setString(3, message);
                    psAlert.setBoolean(4, false);
                    int result = psAlert.executeUpdate();
                    if (result < 1) {
                        out.println("<div class=\"container signin\"><p>Error: Wishlist alert to inform users was not created but auctionItem was created. <br> <a href=\"auctionList.jsp\">Go back to list of auctions</a>.</p></div>");
                    }

                    String queryWishlistIsAvailable = "UPDATE wishlist SET isAvailable = 1 WHERE user=? AND model=? AND manufacturer=? AND `condition`=? AND maxPrice=?;";
                    psWishlistIsAvailable = conn.prepareStatement(queryWishlistIsAvailable);
                    psWishlistIsAvailable.setInt(1, user);
                    psWishlistIsAvailable.setString(2, model);
                    psWishlistIsAvailable.setString(3, manufacturer);
                    psWishlistIsAvailable.setString(4, condition);
                    psWishlistIsAvailable.setDouble(5, maxPrice);
                    int resultIsAvailable = psWishlistIsAvailable.executeUpdate();

                    response.sendRedirect("auctionList.jsp");
                } while (rsWishlist.next());
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
            if (ps != null) ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (psAlert != null) psAlert.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (psWishlist != null) psWishlist.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (rsWishlist != null) rsWishlist.close();
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