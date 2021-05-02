package util;

import database.Database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

public class Bid {
    int listingId;
    int bidder;
    double bidValue;
    String bidDate;

    public Bid() {
    }

    public Bid(int listingId, double bidValue) {
        Database db = new Database();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            st = conn.createStatement();

            // Create query for login validation
            rs = st.executeQuery("SELECT * FROM bid WHERE listingID='" + listingId + "' AND bidValue='" + bidValue + "';");
            if (rs.next()) {
                this.setListingId(listingId);
                this.setBidder(rs.getInt("bidder"));
                this.setBidValue(rs.getDouble("bidValue"));
                String bidDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a").format(rs.getTimestamp("bidDate"));
                this.setBidDate(bidDate);
            } else {
                System.out.println("No auction item found with that listingId");
            }
        } catch (SQLException se) {
            System.out.println("Error connecting to MYSQL server.");
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close
            try {
                if (rs != null) rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (st != null) st.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            try {
                if (conn != null) db.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }


    public int getListingId() {
        return listingId;
    }

    public void setListingId(int listingId) {
        this.listingId = listingId;
    }

    public int getBidder() {
        return bidder;
    }

    public void setBidder(int bidder) {
        this.bidder = bidder;
    }

    public double getBidValue() {
        return bidValue;
    }

    public void setBidValue(double bidValue) {
        this.bidValue = bidValue;
    }

    public String getBidDate() {
        return bidDate;
    }

    public void setBidDate(String bidDate) {
        this.bidDate = bidDate;
    }
}
