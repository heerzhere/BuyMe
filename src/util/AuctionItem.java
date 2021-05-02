package util;

import database.Database;

import java.sql.*;
import java.text.SimpleDateFormat;

public class AuctionItem {
    int listingId;
    String productId;
    String type;
    double listPrice;
    double minSellPrice;
    double soldPrice;
    String exteriorColor;
    String interiorColor;
    String model;
    String manufacturer;
    String condition;
    int capacity;
    String closingDate;
    int year;
    String listDate;
    int seller;
    int purchaser;


    public AuctionItem() {
    }

    public AuctionItem(int listingId) {
        Database db = new Database();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            st = conn.createStatement();

            // Create query for login validation
            rs = st.executeQuery("SELECT * FROM auctionItem WHERE listingID='" + listingId + "';");
            if (rs.next()) {
                this.setListingId(listingId);
                this.setProductId(rs.getString("productID"));
                this.setType(rs.getString("type"));
                this.setListPrice(rs.getDouble("listPrice"));
                this.setMinSellPrice(rs.getDouble("minSellPrice"));
                this.setSoldPrice(rs.getDouble("soldPrice"));
                this.setExteriorColor(rs.getString("exteriorColor"));
                this.setInteriorColor(rs.getString("interiorColor"));
                this.setModel(rs.getString("model"));
                this.setManufacturer(rs.getString("manufacturer"));
                this.setCondition(rs.getString("condition"));
                this.setCapacity(rs.getInt("capacity"));
                String closingDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a").format(rs.getTimestamp("closingDate"));
                this.setClosingDate(closingDate);
                this.setYear(rs.getInt("year"));
                String listDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a").format(rs.getTimestamp("listDate"));
                this.setListDate(listDate);
                this.setSeller(rs.getInt("seller"));
                this.setPurchaser(rs.getInt("purchaser"));
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

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        if (type == null || type.isEmpty()) {
            this.type = type;
        } else {
            this.type = type.substring(0, 1).toUpperCase() + type.substring(1);
        }
    }

    public double getListPrice() {
        return listPrice;
    }

    public void setListPrice(double listPrice) {
        this.listPrice = listPrice;
    }

    public double getMinSellPrice() {
        return minSellPrice;
    }

    public void setMinSellPrice(double minSellPrice) {
        this.minSellPrice = minSellPrice;
    }

    public double getSoldPrice() {
        return soldPrice;
    }

    public void setSoldPrice(double soldPrice) {
        this.soldPrice = soldPrice;
    }

    public String getExteriorColor() {
        return exteriorColor;
    }

    public void setExteriorColor(String exteriorColor) {
        this.exteriorColor = exteriorColor;
    }

    public String getInteriorColor() {
        return interiorColor;
    }

    public void setInteriorColor(String interiorColor) {
        this.interiorColor = interiorColor;
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
        if (condition == null || type.isEmpty()) {
            this.condition = condition;
        } else {
            this.condition = condition.substring(0, 1).toUpperCase() + condition.substring(1);
        }
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getClosingDate() {
        return closingDate;
    }

    public void setClosingDate(String closingDate) {
        this.closingDate = closingDate;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getListDate() {
        return listDate;
    }

    public void setListDate(String listDate) {
        this.listDate = listDate;
    }

    public int getSeller() {
        return seller;
    }

    public void setSeller(int seller) {
        this.seller = seller;
    }

    public int getPurchaser() {
        return purchaser;
    }

    public void setPurchaser(int purchaser) {
        this.purchaser = purchaser;
    }

    public String getAuctionItemName() {
        return  this.year+" "+this.manufacturer+" "+this.model;
    }
}
