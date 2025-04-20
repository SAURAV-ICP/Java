<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sneakerethics.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SneakerEthics - Admin Dashboard</title>
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
        
        .admin-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .add-button {
            background-color: var(--primary-color);
            color: white;
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        
        .sneaker-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        
        .sneaker-table th,
        .sneaker-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .sneaker-table th {
            background-color: var(--primary-color);
            color: white;
        }
        
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }
        
        .edit-button,
        .delete-button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            color: white;
        }
        
        .edit-button {
            background-color: #3498db;
        }
        
        .delete-button {
            background-color: var(--error-color);
        }
        
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
        }
        
        .modal-content {
            background: white;
            width: 90%;
            max-width: 500px;
            margin: 2rem auto;
            padding: 2rem;
            border-radius: 10px;
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .close-button {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
        }
        
        @media (max-width: 768px) {
            .sneaker-table {
                display: block;
                overflow-x: auto;
            }
            
            .action-buttons {
                flex-direction: column;
                gap: 0.3rem;
            }
            
            .edit-button,
            .delete-button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="header">
            <h1>Admin Dashboard</h1>
            <div class="user-info">
                <span>Welcome, <%= ((User)session.getAttribute("user")).getUsername() %></span>
                <a href="../logout" class="logout-button">Logout</a>
            </div>
        </div>
        
        <div class="admin-actions">
            <button class="add-button" onclick="showAddModal()">Add New Sneaker</button>
        </div>
        
        <table class="sneaker-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Ethical Certification</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="sneakerTableBody">
                <!-- Sneaker data will be dynamically loaded here -->
            </tbody>
        </table>
    </div>
    
    <!-- Add/Edit Sneaker Modal -->
    <div id="sneakerModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalTitle">Add New Sneaker</h2>
                <button class="close-button" onclick="closeModal()">&times;</button>
            </div>
            <form id="sneakerForm" onsubmit="return handleSneakerSubmit(event)">
                <input type="hidden" id="sneakerId" name="id">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" required></textarea>
                </div>
                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="number" id="price" name="price" step="0.01" required>
                </div>
                <div class="form-group">
                    <label for="stock">Stock</label>
                    <input type="number" id="stock" name="stock" required>
                </div>
                <div class="form-group">
                    <label for="certification">Ethical Certification</label>
                    <input type="text" id="certification" name="certification" required>
                </div>
                <button type="submit" class="add-button">Save Sneaker</button>
            </form>
        </div>
    </div>
    
    <script>
        // Modal functions
        function showAddModal() {
            document.getElementById('modalTitle').textContent = 'Add New Sneaker';
            document.getElementById('sneakerForm').reset();
            document.getElementById('sneakerId').value = '';
            document.getElementById('sneakerModal').style.display = 'block';
        }
        
        function showEditModal(sneaker) {
            document.getElementById('modalTitle').textContent = 'Edit Sneaker';
            document.getElementById('sneakerId').value = sneaker.id;
            document.getElementById('name').value = sneaker.name;
            document.getElementById('description').value = sneaker.description;
            document.getElementById('price').value = sneaker.price;
            document.getElementById('stock').value = sneaker.stock;
            document.getElementById('certification').value = sneaker.certification;
            document.getElementById('sneakerModal').style.display = 'block';
        }
        
        function closeModal() {
            document.getElementById('sneakerModal').style.display = 'none';
        }
        
        // Form submission handler
        function handleSneakerSubmit(event) {
            event.preventDefault();
            // TODO: Implement AJAX form submission
            console.log('Form submitted');
            closeModal();
            return false;
        }
        
        // Load sneakers when page loads
        function loadSneakers() {
            // TODO: Implement AJAX loading functionality
            console.log('Loading sneakers...');
        }
        
        window.onload = loadSneakers;
    </script>
</body>
</html> 