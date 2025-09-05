package com.rahad.dao;

import java.sql.*;



public class logindao {
    public boolean check(String uname,String pass,String role) throws ClassNotFoundException, SQLException {
    	String search="select * from signup_data where username=? and password=? and role=?" ;
    	Class.forName("com.mysql.cj.jdbc.Driver");

    	String url="jdbc:mysql://localhost:3306/project";
    	Connection con=DriverManager.getConnection(url,"root","Rahad123!");
    	PreparedStatement stm=con.prepareStatement(search);
    	stm.setString(1,uname);
    	stm.setString(2,pass);
    	stm.setString(3,role);
    	ResultSet rs=stm.executeQuery();
    	if(rs.next()) {
    		 return true;
    	}
    	
    	 return false;
    }
}
