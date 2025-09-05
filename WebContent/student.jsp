<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.rahad.dao.logindao"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: #fff;
            min-height: 100vh;
            padding: 40px;
        }
        .dashboard-card {
            background: #ffffff;
            color: #333;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 30px;
        }
        h2, h3 {
            color: #2575fc;
            font-weight: bold;
        }
        table {
            margin-top: 15px;
        }
        table th {
            background-color: #2575fc;
            color: white;
        }
        .btn-enroll {
            background-color: #6a11cb;
            color: #fff;
            border: none;
            padding: 6px 15px;
            border-radius: 5px;
            transition: 0.3s;
        }
        .btn-enroll:hover {
            background-color: #5a0fb8;
        }
        .btn-logout {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 8px;
            transition: 0.3s;
            margin-top: 20px;
        }
        .btn-logout:hover {
            background-color: #b02a37;
        }
    </style>
</head>
<body>
   <%
     response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
      String username = (String) session.getAttribute("username");
      String pass = (String) session.getAttribute("pass");
      
      logindao dao= new logindao();
      if(!dao.check(username,pass,"student")){
    	  response.sendRedirect("login.jsp");
      }
  %>

   %>
    <div class="container">
        <div class="dashboard-card">
            <h2 class="text-center">Welcome, ${sessionScope.username}</h2>

            <h3>📚 Registered Courses</h3>
            <table class="table table-striped table-hover">
                <tr>
                    <th>Course Name</th>
                    <th>Course Code</th>
                </tr>
                <%
                    ArrayList<String[]> registered = (ArrayList<String[]>) request.getAttribute("registeredCourses");
                    if (registered != null && !registered.isEmpty()) {
                        for (String[] row : registered) {
                %>
                <tr>
                    <td><%= row[0] %></td>
                    <td><%= row[1] %></td>
                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr><td colspan="2" class="text-center text-muted">No courses registered.</td></tr>
                <% } %>
            </table>

            <h3>📝 Available Courses</h3>
            <table class="table table-bordered table-hover">
                <tr>
                    <th>Course Name</th>
                    <th>Course Code</th>
                    <th>Action</th>
                </tr>
                <%
                    ArrayList<String[]> available = (ArrayList<String[]>) request.getAttribute("availableCourses");
                    if (available != null && !available.isEmpty()) {
                        for (String[] row : available) {
                %>
                <tr>
                    <td><%= row[0] %></td>
                    <td><%= row[1] %></td>
                    <td>
                        <form action="enroll" method="post">
                            <input type="hidden" name="course_code" value="<%= row[1] %>">
                            <button type="submit" class="btn-enroll">Enroll</button>
                        </form>
                    </td>
                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr><td colspan="3" class="text-center text-muted">No available courses.</td></tr>
                <% } %>
            </table>

            <form action="logout" method="post" class="text-center">
                <button type="submit" class="btn-logout">Logout</button>
            </form>
        </div>
    </div>
</body>
</html>
