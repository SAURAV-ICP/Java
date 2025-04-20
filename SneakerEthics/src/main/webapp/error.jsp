<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - SneakerEthics</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .error-container {
            text-align: center;
            padding: 2rem;
        }
        
        .error-code {
            font-size: 4rem;
            color: var(--error-color);
            margin-bottom: 1rem;
        }
        
        .error-message {
            font-size: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .home-link {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        
        .home-link:hover {
            background-color: var(--secondary-color);
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">
            <%= response.getStatus() %>
        </div>
        <div class="error-message">
            <% if (response.getStatus() == 404) { %>
                Page not found
            <% } else if (response.getStatus() == 500) { %>
                Internal server error
            <% } else { %>
                An error occurred
            <% } %>
        </div>
        <a href="login.jsp" class="home-link">Return to Home</a>
    </div>
</body>
</html> 