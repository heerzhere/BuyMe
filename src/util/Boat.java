package util;

import database.Database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Boat extends AuctionItem{
    int listingId;
    String engineType;
    String boatType;
    String hullMaterial;
    String primaryFuelType;

    public Boat() {
    }

    public Boat(int listingId) {
        Database db = new Database();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            st = conn.createStatement();

            // Create query for login validation
            rs = st.executeQuery("SELECT * FROM boat WHERE listingID='" + listingId + "';");
            if (rs.next()) {
                this.setListingId(listingId);
                this.setEngineType(rs.getString("engineType"));
                this.setBoatType(rs.getString("boatType"));
                this.setHullMaterial(rs.getString("hullMaterial"));
                this.setPrimaryFuelType(rs.getString("primaryFuelType"));
            } else {
                System.out.println("No boat auction item found with that listingId");
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

    public String getEngineType() {
        return engineType;
    }

    public void setEngineType(String engineType) {
        this.engineType = engineType;
    }

    public String getBoatType() {
        return boatType;
    }

    public void setBoatType(String boatType) {
        this.boatType = boatType;
    }

    public String getHullMaterial() {
        return hullMaterial;
    }

    public void setHullMaterial(String hullMaterial) {
        this.hullMaterial = hullMaterial;
    }

    public String getPrimaryFuelType() {
        return primaryFuelType;
    }

    public void setPrimaryFuelType(String primaryFuelType) {
        this.primaryFuelType = primaryFuelType;
    }
}
