package com.rahad;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rahad.dao.logindao;


@WebServlet("/login")
public class login extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		   String username=request.getParameter("username");
	       String pass=request.getParameter("pass");
	       String role=request.getParameter("role");
	       
	       HttpSession session=request.getSession();
	       session.setAttribute("username", username);
	       session.setAttribute("pass", pass);
	       
	       logindao dao= new logindao();
	       try {
			if(dao.check(username,pass,role)) {
			   if(role.equals("teacher")) {
				    response.sendRedirect("teacher");
			   }
			   else if(role.equals("student")) {
				    response.sendRedirect("student");
			   }
			   else if(role.equals("admin")) {
				      System.out.println("admin");
				    response.sendRedirect("admin");
			   }
			   else {
				   response.sendRedirect("login.jsp?error=invalid");
			   }
			   
			}
			else {
				 response.sendRedirect("login.jsp?error=invalid");
			}
		} catch (ClassNotFoundException | SQLException | IOException e) {
			response.sendRedirect("login.jsp?error=invalid");
			e.printStackTrace();
		}
	}

}
