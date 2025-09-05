package com.rahad;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rahad.dao.register;


@WebServlet("/signup")
public class signup extends HttpServlet {


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String fullname=request.getParameter("fullname");
		 String username=request.getParameter("username");
		 String password=request.getParameter("password");
		 String confirmpassword=request.getParameter("confirmpassword");
		 String gender=request.getParameter("gender");
		 String role=request.getParameter("role");
		 System.out.println("Received: " + fullname + ", " + username + ", " + gender + ", " + role);

		 if(!password.equals(confirmpassword)|| fullname==null || username==null || password==null) {
			  response.sendRedirect("signup.jsp");
			  return ;
		 }
		 
		 register reg=new register();
		 try {
			if(reg.set(fullname, username, password, gender, role)) {
				 response.sendRedirect("login.jsp");
			 }
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			 response.sendRedirect("login.jsp");
		}
		 
	}

}
