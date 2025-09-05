package com.rahad;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/teacher")
public class teacher extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String teacherName = (String) request.getSession().getAttribute("username");

        ArrayList<String[]> teacherCourses = new ArrayList<>();
        ArrayList<String> enrolledStudents = new ArrayList<>();

        String selectedCourseCode = request.getParameter("course_code");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Rahad123!");

            // Get courses assigned to this teacher
            String query1 = "SELECT course_name, course_code FROM course_data WHERE JSON_CONTAINS(teacher_list, '\"" + teacherName + "\"')";
            Statement st1 = con.createStatement();
            ResultSet rs1 = st1.executeQuery(query1);
            while (rs1.next()) {
                teacherCourses.add(new String[] {
                    rs1.getString("course_name"),
                    rs1.getString("course_code")
                });
            }

            // If a course is selected, extract student list
            if (selectedCourseCode != null) {
                String query2 = "SELECT JSON_EXTRACT(student_list, '$') AS students FROM course_data WHERE course_code = ?";
                PreparedStatement pst = con.prepareStatement(query2);
                pst.setString(1, selectedCourseCode);
                ResultSet rs2 = pst.executeQuery();
                if (rs2.next()) {
                    String rawJson = rs2.getString("students");
                    rawJson = rawJson.replace("[", "").replace("]", "").replace("\"", "");
                    String[] students = rawJson.split(",");
                    enrolledStudents.addAll(Arrays.asList(students));
                }
                request.setAttribute("selectedCourseCode", selectedCourseCode);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("teacherCourses", teacherCourses);
        request.setAttribute("enrolledStudents", enrolledStudents);
        RequestDispatcher rd = request.getRequestDispatcher("teacher.jsp");
        rd.forward(request, response);
    }
}
