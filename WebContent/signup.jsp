<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .signup-container {
            max-width: 450px;
            margin: 60px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }
        .form-label {
            font-weight: 600;
            color: #333;
        }
        h3 {
            color: #2575fc;
            font-weight: bold;
        }
        .btn-custom {
            background-color: #2575fc;
            border: none;
            color: #fff;
            font-weight: bold;
            padding: 10px;
            border-radius: 8px;
            transition: background 0.3s ease;
        }
        .btn-custom:hover {
            background-color: #6a11cb;
        }
        .error-message {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
        }
        span:hover{
            text-decoration: underline;
            color:green;
         }
    </style>
</head>
<body>

<div class="container">
    <div class="signup-container">
        <h3 class="text-center mb-4">Create Your Account</h3>

        <!-- Error Message Block -->
        <%
            String error = request.getParameter("error");
            if ("duplicate".equals(error)) {
        %>
            <div class="error-message">❌ Username already exists. Please choose another.</div>
        <% } else if ("email".equals(error)) { %>
            <div class="error-message">❌ Failed to send verification email. Please check your email address.</div>
        <% } else if ("validation".equals(error)) { %>
            <div class="error-message">❌ Please fill all fields correctly and make sure passwords match.</div>
        <% } %>

        <form action="signup" method="post">
            <!-- Full Name -->
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="fullname" class="form-control" placeholder="Enter your full name" required>
            </div>

            <!-- Username -->
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" placeholder="Choose a username" required>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="Enter a strong password" required>
            </div>

            <!-- Confirm Password -->
            <div class="mb-3">
                <label class="form-label">Confirm Password</label>
                <input type="password" name="confirmpassword" class="form-control" placeholder="Re-enter password" required>
            </div>

            <!-- Gender -->
            <div class="mb-3">
                <label class="form-label d-block">Gender</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" value="Male" required>
                    <label class="form-check-label">Male</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" value="Female" required>
                    <label class="form-check-label">Female</label>
                </div>
            </div>

            <!-- Role -->
            <div class="mb-3">
                <label class="form-label d-block">Role</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="role" value="Teacher" required>
                    <label class="form-check-label">Teacher</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="role" value="Student" required>
                    <label class="form-check-label">Student</label>
                </div>
            </div>

            <button type="submit" class="btn btn-custom w-100">Sign Up</button>
        </form>

        <!-- Styled Login Link -->
        <div class="text-center mt-3">
            <a href="login.jsp" class="text-decoration-none text-primary fw-bold">
                Already have an account? <span>Log in</span>
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
