<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="util.*" %>

<%@page import="database.Database" %>
<%@page import="util.AuctionItem" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="util.Account" %>
<%@ page import="util.Bid" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="css/main.css">
    <script src="js/main.js"></script>

</head>

<body>
<%
    AuctionItem auctionItemChecked;
    Database dbCAC1 = new Database();
    Database dbCAC2 = new Database();
    Database dbCAC3 = new Database();
    Database dbCAC4 = new Database();
    Connection connect = null;
    ResultSet resSet = null;
    Statement statement1 = null;
    Connection connect2 = null;
    ResultSet resSet2 = null;
    Statement statement2 = null;
    Connection connect3 = null;
    PreparedStatement prepStat = null;
    double finalBid;
    int listingID;
    double minPrice;
    String aTopic = "Auction Won";
    boolean read = false;
    try {
        connect = dbCAC1.getConnection();
        statement1 = connect.createStatement();
        Date date = new Date();
        out.print(date);
        out.println("in Try1");

        resSet = statement1.executeQuery("SELECT * FROM auctionItem WHERE purchaser IS NULL and closingDate <= NOW();");
        out.println("sent query");
        if (!resSet.next()) {
            //this means that no items are closed and don't have a purchaser
            //out.print("<h2>No bids placed for this auction</h2>");
        } else {
            int x = 0;
            do {
                x++;
                out.println("model:  " + resSet.getString("model"));
                listingID = resSet.getInt("listingID");
                minPrice = resSet.getDouble("minSellPrice");
                //out.println(" MINBID:"+ minPrice+"                      ");
                try {
                    out.println("in Try2--");
                    connect2 = dbCAC2.getConnection();
                    statement2 = connect2.createStatement();
                    out.println("connected	");

                    resSet2 = statement2.executeQuery("SELECT MAX(bidValue), bidder FROM bid WHERE listingID =" + listingID + ";");
                    out.println("submited rs2	");
                    if (resSet2.next()) {
                        finalBid = resSet2.getDouble("MAX(bidValue)");
                        int bidderID = resSet2.getInt("bidder");
                        out.println("final bid: " + finalBid + "bidderID: " + bidderID);
                        out.println("    minbid" + minPrice);

                        if (finalBid >= minPrice) {
                            out.println("bid>minprice	");
                            try {
                                out.println("in Try3----");
                                connect3 = dbCAC3.getConnection();
                                out.println("connected	");
                                String query = "UPDATE auctionItem SET soldPrice = ?, purchaser = ? WHERE listingID = ?;";
                                prepStat = connect3.prepareStatement(query);
                                prepStat.setDouble(1, finalBid);
                                prepStat.setInt(2, bidderID);
                                prepStat.setInt(3, listingID);

                                int result = prepStat.executeUpdate();
                                if (result < 1) {
                                    out.println("<center>There was an issue updating auction winner.</center>");
                                }

                            } catch (SQLException se) {
                                out.print("<p>Error connecting to MYSQL server. TRY 3</p>");
                                se.printStackTrace();
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                // Close
                                try {
                                    if (prepStat != null) prepStat.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                try {
                                    if (connect3 != null) dbCAC3.closeConnection(connect3);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
// ------------------------------------------------------------------------------------------------------------------------------------------------------
                            try {
                                auctionItemChecked = new AuctionItem(listingID);
                                out.println("in Try4-----");
                                String message1 = "Congrats! You won the auction for the " + auctionItemChecked.getAuctionItemName() + " with your bid of $" + finalBid + "!";
                                connect3 = dbCAC4.getConnection();
                                out.println("connected	");
                                String query = "INSERT INTO alert (user, alertTopic, alertMessage, isRead) VALUES (?, ?, ?, ?);";
                                prepStat = connect3.prepareStatement(query);

                                prepStat.setInt(1, bidderID);
                                prepStat.setString(2, aTopic);
                                prepStat.setString(3, message1);
                                prepStat.setBoolean(4, false);


                                int result = prepStat.executeUpdate();
                                if (result < 1) {
                                    out.println("<center>There was an issue alerting auction winner.</center>");
                                }

                            } catch (SQLException se) {
                                out.print("<p>Error connecting to MYSQL server. TRY 4</p>");
                                se.printStackTrace();
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                // Close
                                try {
                                    if (prepStat != null) prepStat.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                try {
                                    if (connect3 != null) dbCAC4.closeConnection(connect3);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }

// --------------------------------------------------------------------------------------------------------------------------

                        } else {
                            out.println("highest bid smaller than minumum sell price");
                        }
                    }
                } catch (SQLException se) {
                    out.print("<p>Error connecting to MYSQL server. TRY 2	</p>");
                    se.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // Close
                    try {
                        if (resSet2 != null) resSet2.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    try {
                        if (statement2 != null) statement2.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    try {
                        if (connect2 != null) dbCAC2.closeConnection(connect2);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

// -------------------------------------------------------------------------------------------------
                out.println("       END OF WHILE       ");
            } while (resSet.next());
            out.println("       OUT OF WHILE       ");
        }

    } catch (SQLException se) {
        out.print("<p>Error connecting to MYSQL server. TRY 1</p>");
        se.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close
        try {
            if (resSet != null) resSet.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (statement1 != null) statement1.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (connect != null) dbCAC1.closeConnection(connect);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    out.println("Auctions Closings Checked");


%>
</body>

</html>