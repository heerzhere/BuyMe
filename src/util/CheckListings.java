
package util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import database.*;

public class CheckListings {

    public static void run() throws IOException {
        try {
            Connection conn = new Database().getConnection();
            Statement st = conn.createStatement();
            Statement temp;
            ResultSet rs = st.executeQuery("SELECT auctionItem.*, bid.bidValue as maxBid, bid.bidder FROM auctionItem JOIN bid USING(listingID) HAVING soldPrice IS NULL AND closingDate < NOW() AND bid.bidValue IN (SELECT MAX(bidvalue) FROM bid GROUP BY listingID HAVING listingID=auctionItem.listingID);");
            if (rs.next()) {
                rs.beforeFirst();
                temp = conn.createStatement();
                while (rs.next()) {
                    int listingID = rs.getInt("listingID");
                    double maxBid = rs.getDouble("maxBid");
                    double minSellPrice = rs.getDouble("minSellPrice");
                    int bidder = rs.getInt("bidder");
                    int seller = rs.getInt("seller");
                    // double listPrice = rs.getDouble("listPrice");
                    // out.println("<p>listingID, maxBid, listPrice, bidder: " + listingID + " " + maxBid + " " + listPrice + " " + bidder + " </p>");
                    if (maxBid >= minSellPrice) {
                        temp.executeUpdate("UPDATE auctionItem SET soldPrice=" + maxBid + ", purchaser=" + bidder + " WHERE listingID =" + listingID + ";");
                        String sellerAlert = "Your item " + listingID + " has sold for $" + maxBid;
                        String buyerAlert = "You won the auction for listing " + listingID + " for $" + maxBid + "!";
                        temp.executeUpdate("INSERT INTO alert (user, alertTopic, alertMessage) VALUES (" + seller + ", '" + "Sold!" + "','" + sellerAlert + "') ");
                        temp.executeUpdate("INSERT INTO alert (user, alertTopic, alertMessage) VALUES (" + bidder + ", '" + "You won!" + "','" + buyerAlert + "') ");
                    } else {
                        // create alert for seller that item didn't sell
	        			/*
	        			String sellerAlert = "Your item " + listingID + " did not reach the reserve";
	        			temp.executeUpdate("INSERT INTO alert (user, alertTopic, alertMessage) VALUES (" + seller + ", '" + "Reserve Not Met" + "','" + sellerAlert + "') ");
	        			*/
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}