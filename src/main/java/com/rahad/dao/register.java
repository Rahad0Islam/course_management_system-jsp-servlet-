package com.rahad.dao;

import java.sql.*;

public class register {
    public boolean set(String fullname, String username, String password, String gender, String role) throws ClassNotFoundException, SQLException {
     
        Class.forName("com.mysql.cj.jdbc.Driver");

     
        String url = "jdbc:mysql://localhost:3306/project";
        try (Connection con = DriverManager.getConnection(url, "root", "Rahad123!")) {

       
            String insert = "INSERT INTO signup_data (name, username, password, gender, role) VALUES (?, ?, ?, ?, ?)";

            try (PreparedStatement stm = con.prepareStatement(insert)) {
                stm.setString(1, fullname);
                stm.setString(2, username);
                stm.setString(3, password);
                stm.setString(4, gender);
                stm.setString(5, role);

                int rowsInserted = stm.executeUpdate();
                return rowsInserted > 0; 
            }
        }
    }
}
