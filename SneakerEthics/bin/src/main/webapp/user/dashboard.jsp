<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sneakerethics.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - Dashboard</title>
    <link rel="stylesheet" href="../assets/css/style.css">
    <style>
        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .search-bar {
            width: 100%;
            max-width: 500px;
            margin: 0 auto 2rem;
        }
        
        .search-bar input {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        .sneaker-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
        }
        
        .sneaker-card {
            background: white;
            border-radius: 10px;
            padding: 1rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .sneaker-image {
            width: 100%;
            height: 200px;
            background: #f5f5f5;
            border-radius: 5px;
            margin-bottom: 1rem;
        }
        
        .sneaker-info h3 {
            margin: 0 0 0.5rem;
            color: var(--text-color);
        }
        
        .sneaker-price {
            color: var(--primary-color);
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .ethical-badge {
            display: inline-block;
            background: var(--primary-color);
            color: white;
            padding: 0.3rem 0.6rem;
            border-radius: 3px;
            font-size: 0.8rem;
            margin-top: 0.5rem;
        }
        
        .logout-button {
            background-color: var(--error-color);
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 1rem;
            }
            
            .sneaker-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="header">
            <h1>Welcome to SneakerEthics</h1>
            <div class="user-info">
                <span>Welcome, <%= ((User)session.getAttribute("user")).getUsername() %></span>
                <a href="../logout" class="logout-button">Logout</a>
            </div>
        </div>
        
        <div class="search-bar">
            <input type="text" placeholder="Search for sneakers..." onkeyup="searchSneakers(this.value)">
        </div>
        
        <div class="sneaker-grid" id="sneakerGrid">
            <!-- Sneaker cards will be dynamically loaded here -->
        </div>
    </div>
    
    <script>
        // Function to search sneakers (to be implemented with AJAX)
        function searchSneakers(query) {
            // TODO: Implement AJAX search functionality
            console.log('Searching for:', query);
        }
        
        // Function to load sneakers (to be implemented with AJAX)
        function loadSneakers() {
            // TODO: Implement AJAX loading functionality
            console.log('Loading sneakers...');
        }
        
        // Load sneakers when page loads
        window.onload = loadSneakers;
    </script>
</body>
</html> 