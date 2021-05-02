package util;

import database.Database;

import java.sql.*;
import java.text.SimpleDateFormat;

public class WishlistItem {
    int user;
    String model;
    String manufacturer;
    String condition;
    double maxPrice;
    boolean isAvailable;

    public WishlistItem() {
    }

    public WishlistItem(int user, String model, String manufacturer, String condition, double maxPrice) {
        Database db = new Database();
        Connection conn = null;
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            String query = "SELECT * FROM wishlist WHERE user=? AND model=? AND manufacturer=? AND `condition`=? AND maxPrice=?;";
            ps = conn.prepareStatement(query);
            // Add parameters to query
            ps.setInt(1, user);
            ps.setString(2, model);
            ps.setString(3, manufacturer);
            ps.setString(4, condition);
            ps.setDouble(5, maxPrice);

            // Create query for login validation
            rs = ps.executeQuery();
            if (rs.next()) {
                this.user = user;
                this.model = model;
                this.manufacturer = manufacturer;
                this.condition = condition;
                this.maxPrice = maxPrice;
                this.isAvailable = rs.getBoolean("isAvailable");
            } else {
                System.out.println("No wishlist item");
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
                if (conn != null) db.closeConnection(conn);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public int getUser() {
        return user;
    }

    public void setUser(int user) {
        this.user = user;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(double maxPrice) {
        this.maxPrice = maxPrice;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public String getWishlistItemName() {
        return this.getCondition() + " " + this.manufacturer + " " + this.model;
    }
}
