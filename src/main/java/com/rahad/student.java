package com.rahad;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/student")
public class student extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");

        ArrayList<String[]> registeredCourses = new ArrayList<>();
        ArrayList<String[]> availableCourses = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Rahad123!");

            // Registered courses
            String query1 = "SELECT course_name, course_code, teacher_list FROM course_data WHERE JSON_CONTAINS(student_list, '\"" + username + "\"')";
            Statement st1 = con.createStatement();
            ResultSet rs1 = st1.executeQuery(query1);
            while (rs1.next()) {
                registeredCourses.add(new String[] {
                    rs1.getString("course_name"),
                    rs1.getString("course_code"),
                    rs1.getString("teacher_list")
                });
            }

            // Available courses
            String query2 = "SELECT course_name, course_code FROM course_data WHERE NOT JSON_CONTAINS(student_list, '\"" + username + "\"')";

            Statement st2 = con.createStatement();
            ResultSet rs2 = st2.executeQuery(query2);
            while (rs2.next()) {
                availableCourses.add(new String[] {
                    rs2.getString("course_name"),
                    rs2.getString("course_code")
                });
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("registeredCourses", registeredCourses);
        request.setAttribute("availableCourses", availableCourses);
        RequestDispatcher rd = request.getRequestDispatcher("student.jsp");
        rd.forward(request, response);
    }
}
