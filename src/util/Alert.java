package util;

import database.Database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

public class Alert {
    int alertID;
    int user;
    String alertTopic;
    String alertMessage;
    boolean isRead;

    public Alert() {
    }

    public Alert(int alertID) {
        Database db = new Database();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            st = conn.createStatement();

            // Create query for login validation
            rs = st.executeQuery("SELECT * FROM alert WHERE alertID='" + alertID + "';");
            if (rs.next()) {
                this.setAlertID(alertID);
                this.setUser(rs.getInt("user"));
                this.setAlertTopic(rs.getString("alertTopic"));
                this.setAlertMessage(rs.getString("alertMessage"));
                this.setRead(rs.getBoolean("isRead"));
            } else {
                System.out.println("No alerts found in the system");
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

    public Alert(int alertID, int user) {
        Database db = new Database();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            st = conn.createStatement();

            // Create query for login validation
            rs = st.executeQuery("SELECT * FROM alert WHERE alertID='" + alertID + "' AND user='"+user+"';");
            if (rs.next()) {
                this.setAlertID(alertID);
                this.setUser(rs.getInt("user"));
                this.setAlertTopic(rs.getString("alertTopic"));
                this.setAlertMessage(rs.getString("alertMessage"));
                this.setRead(rs.getBoolean("isRead"));
            } else {
                System.out.println("No alerts found in the system");
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

    public int getAlertID() {
        return alertID;
    }

    public void setAlertID(int alertID) {
        this.alertID = alertID;
    }

    public int getUser() {
        return user;
    }

    public void setUser(int user) {
        this.user = user;
    }

    public String getAlertTopic() {
        return alertTopic;
    }

    public void setAlertTopic(String alertTopic) {
        this.alertTopic = alertTopic;
    }

    public String getAlertMessage() {
        return alertMessage;
    }

    public void setAlertMessage(String alertMessage) {
        this.alertMessage = alertMessage;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean read) {
        isRead = read;
    }
}
