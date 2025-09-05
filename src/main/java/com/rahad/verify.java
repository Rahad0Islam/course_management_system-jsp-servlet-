package com.rahad;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.rahad.dao.register;

@WebServlet("/verify")
public class verify extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Collect digits from form (6 input fields)
        String inputCode = 
                request.getParameter("digit1") +
                request.getParameter("digit2") +
                request.getParameter("digit3") +
                request.getParameter("digit4") +
                request.getParameter("digit5") +
                request.getParameter("digit6");

        HttpSession session = request.getSession();
        String correctCode = (String) session.getAttribute("verificationCode");

        if (inputCode != null && inputCode.equals(correctCode)) {
            // Retrieve user data from session
            String fullname = (String) session.getAttribute("fullname");
            String username = (String) session.getAttribute("username");
            String password = (String) session.getAttribute("password");
            String gender   = (String) session.getAttribute("gender");
            String role     = (String) session.getAttribute("role");
            String email    = (String) session.getAttribute("email");

            register reg = new register();
            try {
                boolean success = reg.set(fullname, username, password, gender, role);
                if (success) {
                    // Invalidate session (remove all attributes)
                    session.invalidate();
                    response.sendRedirect("login.jsp");
                } else {
                    response.getWriter().println("<h2>❌ Registration failed. Please try again.</h2>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.getWriter().println("<h2>❌ Server error. Please try again later.</h2>");
            }
        } else {
            response.sendRedirect("verify.jsp?error=1");
        }
    }
}
