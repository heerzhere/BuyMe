package util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import database.Database;

public class CheckAutoBids {

    public static void run() throws IOException {
//        CheckListings.run();
        Connection conn = new Database().getConnection();
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM autobid JOIN bid USING(listingID) WHERE bidvalue = (SELECT MAX(bidvalue) FROM bid WHERE listingID = autobid.listingID);");
            while (rs.next()) {
                int autoBidder = rs.getInt(2);
                int maxBidder = rs.getInt(5);
                double ceil = rs.getDouble(3);
                double incr = rs.getDouble(4);
                double maxBid = rs.getDouble(6);
                // System.out.println("Got autoBidder of " + autoBidder + " and maxBidder of " + maxBidder + ". ceil, incr, maxBid: " + ceil + " " + incr + " " + maxBid);
                if (autoBidder != maxBidder) {
                    if (maxBid + incr <= ceil) {
                        PreparedStatement pst = conn.prepareStatement("INSERT INTO bid (listingID, bidder, bidValue, bidDate) VALUES (?,?,?,NOW());");
                        pst.setInt(1, rs.getInt(1));
                        pst.setInt(2, autoBidder);
                        pst.setDouble(3, maxBid + incr);
                        pst.executeUpdate();
                        rs.close();
                        // re-query to get updated max-bids
                        rs = st.executeQuery("SELECT * FROM autobid JOIN bid USING(listingID) WHERE bidvalue = (SELECT MAX(bidvalue) FROM bid WHERE listingID = autobid.listingID)");
                    } else {
                        // add new alert and delete entry from autobid table
                        conn.createStatement().executeUpdate("DELETE FROM autobid WHERE listingID = " + rs.getInt(1) + " AND userID = " + autoBidder + ";");
                        String alertMsg = "Your Auto-Bid on item listing " + rs.getInt(1) + " has hit its ceiling of $" + ceil + ". You are no longer the highest bidder.";
                        conn.createStatement().executeUpdate("INSERT INTO alert (user, alertTopic, alertMessage) VALUES (" + autoBidder + ", '" + "Auto-bid Price Ceiling Reached" + "','" + alertMsg + "') ");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}