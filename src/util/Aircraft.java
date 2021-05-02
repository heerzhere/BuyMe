package util;

import database.Database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Aircraft extends AuctionItem{
    int listingId;
    String airCategory;
    int engineHours;
    String avionics;

    public Aircraft() {
    }

    public Aircraft(int listingId) {
        Database db = new Database();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            st = conn.createStatement();

            // Create query for login validation
            rs = st.executeQuery("SELECT * FROM aircraft WHERE listingID='" + listingId + "';");
            if (rs.next()) {
                this.setListingId(listingId);
                this.setAirCategory(rs.getString("airCategory"));
                this.setEngineHours(rs.getInt("engineHours"));
                this.setAvionics(rs.getString("avionics"));
            } else {
                System.out.println("No aircraft auction item found with that listingId");
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

    public String getAirCategory() {
        return airCategory;
    }

    public void setAirCategory(String airCategory) {
        this.airCategory = airCategory;
    }

    public int getEngineHours() {
        return engineHours;
    }

    public void setEngineHours(int engineHours) {
        this.engineHours = engineHours;
    }

    public String getAvionics() {
        return avionics;
    }

    public void setAvionics(String avionics) {
        this.avionics = avionics;
    }
}
