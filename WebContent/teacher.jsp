<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Teacher Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background: linear-gradient(135deg, #ff7eb3 0%, #ff758c 100%);
            color: #333;
            min-height: 100vh;
            padding-top: 80px; /* space for navbar */
        }
        .navbar-custom {
            background: #ff4081;
            padding: 15px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        }
        .navbar-custom .navbar-brand {
            color: white;
            font-weight: bold;
        }
        .btn-logout {
            background: white;
            color: #ff4081;
            border: none;
            font-weight: bold;
            padding: 6px 15px;
            border-radius: 20px;
            transition: 0.3s;
        }
        .btn-logout:hover {
            background: #e63770;
            color: white;
        }
        .dashboard-card {
            background: #fff;
            color: #333;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 30px;
        }
        h2, h3 {
            color: #ff4081;
            font-weight: bold;
        }
        table th {
            background-color: #ff4081;
            color: white;
            text-align: center;
        }
        .btn-view {
            background-color: #ff4081;
            color: #fff;
            border: none;
            padding: 6px 15px;
            border-radius: 5px;
            transition: 0.3s;
        }
        .btn-view:hover {
            background-color: #e63770;
        }
        .btn-close-list {
            background: #ff4081;
            color: white;
            border: none;
            padding: 5px 12px;
            border-radius: 5px;
            float: right;
            font-size: 14px;
        }
        .btn-close-list:hover {
            background: #e63770;
        }
        ul {
            list-style-type: none;
            padding-left: 0;
        }
        ul li {
            background: #f8f9fa;
            margin: 5px 0;
            padding: 8px 15px;
            border-radius: 8px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <!-- Top Navbar -->
    <nav class="navbar navbar-custom fixed-top">
        <div class="container-fluid">
            <span class="navbar-brand">Teacher Dashboard</span>
            <form action="logout" method="post" class="d-inline">
                <button type="submit" class="btn-logout">Logout</button>
            </form>
        </div>
    </nav>

    <div class="container">
        <div class="dashboard-card">
            <h2 class="text-center">Welcome, ${sessionScope.username}</h2>

            <h3>📘 Your Courses</h3>
            <table class="table table-striped table-hover">
                <tr>
                    <th>Course Name</th>
                    <th>Course Code</th>
                    <th>Action</th>
                </tr>
                <%
                    ArrayList<String[]> courses = (ArrayList<String[]>) request.getAttribute("teacherCourses");
                    if (courses != null && !courses.isEmpty()) {
                        for (String[] row : courses) {
                %>
                <tr>
                    <td><%= row[0] %></td>
                    <td><%= row[1] %></td>
                    <td>
                        <form action="teacher" method="get">
                            <input type="hidden" name="course_code" value="<%= row[1] %>">
                            <button type="submit" class="btn-view">View Students</button>
                        </form>
                    </td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr>
                    <td colspan="3" class="text-center text-muted">No courses assigned.</td>
                </tr>
                <% } %>
            </table>

            <%
                String selectedCode = (String) request.getAttribute("selectedCourseCode");
                ArrayList<String> students = (ArrayList<String>) request.getAttribute("enrolledStudents");
                if (selectedCode != null && students != null && !students.isEmpty()) {
            %>
            <div class="mt-4">
                <h3>
                    👨‍🎓 Enrolled Students for Course: <%= selectedCode %>
                    <button class="btn-close-list" data-bs-toggle="collapse" data-bs-target="#studentList">Minimize</button>
                </h3>
                <div id="studentList" class="collapse show mt-3">
                    <ul>
                        <% for (String student : students) { %>
                            <li><%= student.trim() %></li>
                        <% } %>
                    </ul>
                </div>
            </div>
            <% } else if (selectedCode != null) { %>
            <p class="text-muted mt-3">No students enrolled in this course yet.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
