package util;

import database.Database;

import java.sql.*;

public class Account {
    int accountNumber;
    String firstName;
    String lastName;
    String username;
    String password;
    String email;
    int accessLevel;
    int isActive;

    public Account() {
    }

    public Account(String usernameParameter) {
        Database db = new Database();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            st = conn.createStatement();

            // Create query for login validation
            rs = st.executeQuery("SELECT * FROM account WHERE username='" + usernameParameter + "';");
            if (rs.next()) {
                int accountNumber = rs.getInt("account_number");
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                String password = rs.getString("password");
                String email = rs.getString("email");
                int accessLevel = rs.getInt("access_level");
                int isActive = rs.getInt("is_active");

                this.setAccountNumber(accountNumber);
                this.setFirstName(firstName);
                this.setLastName(lastName);
                this.setUsername(usernameParameter);
                this.setPassword(password);
                this.setEmail(email);
                this.setAccessLevel(accessLevel);
                this.setIsActive(isActive);
            } else {
                System.out.println("No account found with that username");
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

    public Account(int accountNumber) {
        Database db = new Database();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
            // Open DB Connection and get parameters
            conn = db.getConnection();
            st = conn.createStatement();

            // Create query for login validation
            rs = st.executeQuery("SELECT * FROM account WHERE account_number='" + accountNumber + "';");
            if (rs.next()) {
                String username = rs.getString("username");
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                String password = rs.getString("password");
                String email = rs.getString("email");
                int accessLevel = rs.getInt("access_level");
                int isActive = rs.getInt("is_active");

                this.setAccountNumber(accountNumber);
                this.setFirstName(firstName);
                this.setLastName(lastName);
                this.setUsername(username);
                this.setPassword(password);
                this.setEmail(email);
                this.setAccessLevel(accessLevel);
                this.setIsActive(isActive);
            } else {
                System.out.println("No account found with that Account Number");
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

    public int getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(int accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getAccessLevel() {
        return accessLevel;
    }

    public void setAccessLevel(int accessLevel) {
        this.accessLevel = accessLevel;
    }

    public int getIsActive() {
        return isActive;
    }

    public void setIsActive(int isActive) {
        this.isActive = isActive;
    }

}
