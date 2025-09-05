package com.rahad;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/admin")
public class admin extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Rahad123!");

            if ("addCourse".equals(action)) {
                String courseName = request.getParameter("course_name");
                String courseCode = request.getParameter("course_code");

                String insertQuery = "INSERT INTO course_data (course_name, course_code, student_list, teacher_list) VALUES (?, ?, JSON_ARRAY(), JSON_ARRAY())";
                PreparedStatement pst = con.prepareStatement(insertQuery);
                pst.setString(1, courseName);
                pst.setString(2, courseCode);
                pst.executeUpdate();

            } else if ("assignTeacher".equals(action)) {
                String courseName = request.getParameter("course_name");
                String teacherUsername = request.getParameter("teacher_name");

                String getCodeQuery = "SELECT course_code FROM course_data WHERE course_name = ?";
                PreparedStatement getCodeStmt = con.prepareStatement(getCodeQuery);
                getCodeStmt.setString(1, courseName);
                ResultSet rs = getCodeStmt.executeQuery();

                if (rs.next()) {
                    String courseCode = rs.getString("course_code");

                    String checkQuery = "SELECT JSON_CONTAINS(teacher_list, '\"" + teacherUsername + "\"') AS assigned FROM course_data WHERE course_code = ?";
                    PreparedStatement checkStmt = con.prepareStatement(checkQuery);
                    checkStmt.setString(1, courseCode);
                    ResultSet checkRs = checkStmt.executeQuery();

                    if (checkRs.next() && checkRs.getInt("assigned") == 0) {
                        String updateQuery = "UPDATE course_data SET teacher_list = JSON_ARRAY_APPEND(teacher_list, '$', ?) WHERE course_code = ?";
                        PreparedStatement updateStmt = con.prepareStatement(updateQuery);
                        updateStmt.setString(1, teacherUsername);
                        updateStmt.setString(2, courseCode);
                        updateStmt.executeUpdate();
                    }
                }

            } else if ("removeCourse".equals(action)) {
                String courseName = request.getParameter("course_name");

                String deleteQuery = "DELETE FROM course_data WHERE course_name = ?";
                PreparedStatement deleteStmt = con.prepareStatement(deleteQuery);
                deleteStmt.setString(1, courseName);
                deleteStmt.executeUpdate();
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin.jsp");
    }
}
