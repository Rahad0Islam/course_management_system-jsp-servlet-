package com.rahad;

import java.io.IOException;
import java.sql.*;
import java.util.Random;
import javax.mail.MessagingException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/signup")
public class signup extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Collect form data
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmpassword = request.getParameter("confirmpassword");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");
        String email = request.getParameter("email");

        // Basic validation
        if (!password.equals(confirmpassword) || fullname == null || username == null || password == null) {
            response.sendRedirect("signup.jsp?error=validation");
            return;
        }

        // Check for duplicate username
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Rahad123!");
                 PreparedStatement stm = con.prepareStatement("SELECT * FROM signup_data WHERE username = ?")) {
                stm.setString(1, username);
                ResultSet rs = stm.executeQuery();
                if (rs.next()) {
                    response.sendRedirect("signup.jsp?error=duplicate");
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=validation");
            return;
        }

        // Generate verification code
        String code = String.valueOf(100000 + new Random().nextInt(900000));

        // Send email
        try {
            EmailSender.sendCode(email, code);
        } catch (MessagingException e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=email");
            return;
        }

        // Store user data in session
        HttpSession session = request.getSession();
        session.setAttribute("verificationCode", code);
        session.setAttribute("fullname", fullname);
        session.setAttribute("username", username);
        session.setAttribute("password", password);
        session.setAttribute("gender", gender);
        session.setAttribute("role", role);
        session.setAttribute("email", email);

        // Redirect to verification page
        response.sendRedirect("verify.jsp");
    }
}
