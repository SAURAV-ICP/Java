<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - Register</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .register-form {
            max-width: 500px;
            margin: 0 auto;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .password-requirements {
            font-size: 0.8rem;
            color: #666;
            margin-top: 0.5rem;
        }
        
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <h1>SneakerEthics</h1>
            <p class="tagline">Join the Sustainable Fashion Movement</p>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("success") != null) { %>
                <div class="success-message">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>
            
            <form action="register" method="POST" class="register-form" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required 
                           pattern="[a-zA-Z0-9_]{3,20}" 
                           title="Username must be 3-20 characters long and can only contain letters, numbers, and underscores">
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required 
                           pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" 
                           title="Password must contain at least one number, one uppercase and lowercase letter, and be at least 8 characters long">
                    <div class="password-requirements">
                        Password must contain at least one number, one uppercase and lowercase letter, and be at least 8 characters long
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                
                <button type="submit" class="login-button">Register</button>
            </form>
            
            <div class="register-link">
                <p>Already have an account? <a href="login.jsp">Login here</a></p>
            </div>
        </div>
    </div>
    
    <script>
        function validateForm() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html> 