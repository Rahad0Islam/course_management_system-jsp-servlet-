<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            min-height: 100vh;
            padding: 30px;
            color: #fff;
        }
        .dashboard-card {
            background: #ffffff;
            color: #333;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0px 5px 15px rgba(0,0,0,0.2);
        }
        h2, h3 {
            color: #2575fc;
            font-weight: bold;
        }
        .btn-custom {
            background-color: #2575fc;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 8px 15px;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background-color: #1a5ed6;
        }
        .logout-btn {
            position: absolute;
            top: 20px;
            right: 30px;
            background: #ff4d4d;
            border: none;
            color: white;
            border-radius: 6px;
            padding: 8px 15px;
            font-size: 14px;
            transition: 0.3s;
        }
        .logout-btn:hover {
            background: #cc0000;
        }
    </style>
</head>
<body>
    <form action="logout" method="post">
        <button type="submit" class="logout-btn">Logout</button>
    </form>

    <div class="container">
        <h2 class="text-center mb-4">👨‍💼 Admin Panel</h2>

        <!-- Add New Course -->
        <div class="dashboard-card">
            <h3>➕ Add New Course</h3>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="addCourse">
                <div class="mb-3">
                    <label class="form-label">Course Name</label>
                    <input type="text" name="course_name" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Course Code</label>
                    <input type="text" name="course_code" class="form-control" required>
                </div>
                <button type="submit" class="btn-custom">Add Course</button>
            </form>
        </div>

        <!-- Assign Teacher to Course -->
        <div class="dashboard-card">
            <h3>👨‍🏫 Assign Teacher to Course</h3>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="assignTeacher">

                <div class="mb-3">
                    <label class="form-label">Course Name</label>
                    <input list="courseList" name="course_name" class="form-control" required>
                    <datalist id="courseList">
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Rahad123!");
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery("SELECT course_name FROM course_data");
                                while (rs.next()) {
                        %>
                            <option value="<%= rs.getString("course_name") %>">
                        <%
                                }
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </datalist>
                </div>

                <div class="mb-3">
                    <label class="form-label">Teacher Username</label>
                    <input list="teacherList" name="teacher_name" class="form-control" required>
                    <datalist id="teacherList">
                        <%
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Rahad123!");
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery("SELECT username FROM signup_data WHERE role = 'teacher'");
                                while (rs.next()) {
                        %>
                            <option value="<%= rs.getString("username") %>">
                        <%
                                }
                                con.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </datalist>
                </div>

                <button type="submit" class="btn-custom">Assign Teacher</button>
            </form>
        </div>

        <!-- Remove Course -->
        <div class="dashboard-card">
            <h3>🗑️ Remove Course</h3>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="removeCourse">
                <div class="mb-3">
                    <label class="form-label">Select Course</label>
                    <input list="courseList" name="course_name" class="form-control" required>
                </div>
                <button type="submit" class="btn-custom">Remove Course</button>
            </form>
        </div>
    </div>
</body>
</html>
