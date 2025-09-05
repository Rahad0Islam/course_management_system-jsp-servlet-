package com.rahad;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/enroll")
public class enroll extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        String courseCode = request.getParameter("course_code");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Rahad123!");

            // Check if already enrolled
            String checkQuery = "SELECT JSON_CONTAINS(student_list, '\"" + username + "\"') AS enrolled FROM course_data WHERE course_code = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setString(1, courseCode);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt("enrolled") == 0) {
                // Append student to JSON array
                String updateQuery = "UPDATE course_data SET student_list = JSON_ARRAY_APPEND(student_list, '$', ?) WHERE course_code = ?";
                PreparedStatement updateStmt = con.prepareStatement(updateQuery);
                updateStmt.setString(1, username);
                updateStmt.setString(2, courseCode);
                updateStmt.executeUpdate();
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("student");
    }
}
