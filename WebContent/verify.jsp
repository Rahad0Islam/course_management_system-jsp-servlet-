<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Email Verification</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f4f6f9;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .verify-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 400px;
            width: 100%;
            text-align: center;
        }
        .verify-inputs input {
            width: 48px;
            height: 55px;
            text-align: center;
            font-size: 22px;
            font-weight: bold;
            margin: 0 5px;
            border: 2px solid #ddd;
            border-radius: 8px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .verify-inputs input:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 6px rgba(13, 110, 253, 0.5);
            outline: none;
        }
        .btn-verify {
            margin-top: 25px;
            width: 100%;
            font-size: 18px;
            padding: 12px;
            border-radius: 10px;
        }
        .error-msg {
            color: red;
            margin-top: 15px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="verify-card">
        <h4 class="mb-3">🔒 Email Verification</h4>
        <p class="text-muted">Enter the 6-digit code sent to your email</p>
        
        <form action="verify" method="post" id="verifyForm">
            <div class="d-flex justify-content-center verify-inputs">
                <input type="text" name="digit1" maxlength="1" required>
                <input type="text" name="digit2" maxlength="1" required>
                <input type="text" name="digit3" maxlength="1" required>
                <input type="text" name="digit4" maxlength="1" required>
                <input type="text" name="digit5" maxlength="1" required>
                <input type="text" name="digit6" maxlength="1" required>
            </div>
            <input type="hidden" name="code" id="hiddenCode">
            <button type="submit" class="btn btn-primary btn-verify">Verify</button>
        </form>

        <% if (request.getParameter("error") != null) { %>
            <p class="error-msg">❌ Verification failed. Try again.</p>
        <% } %>
    </div>

    <!-- Auto move cursor between inputs -->
    <script>
        const inputs = document.querySelectorAll(".verify-inputs input");
        const hiddenCode = document.getElementById("hiddenCode");
        const form = document.getElementById("verifyForm");

        inputs.forEach((input, index) => {
            input.addEventListener("input", () => {
                if (input.value.length === 1 && index < inputs.length - 1) {
                    inputs[index + 1].focus();
                }
                if (index === inputs.length - 1) {
                    input.blur();
                }
            });

            input.addEventListener("keydown", (e) => {
                if (e.key === "Backspace" && !input.value && index > 0) {
                    inputs[index - 1].focus();
                }
            });
        });

        form.addEventListener("submit", () => {
            let code = "";
            inputs.forEach(input => code += input.value);
            hiddenCode.value = code;
        });
    </script>
</body>
</html>
