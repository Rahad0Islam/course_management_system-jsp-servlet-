<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <!-- Bootstrap CSS -->
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
    </style>
</head>
<body>

<div class="container">
    <div class="signup-container">
        <h3 class="text-center mb-4">Create Your Account</h3>
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
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
