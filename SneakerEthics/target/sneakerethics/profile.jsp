<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile - SneakerEthics</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/profile.css">
</head>
<body>
    <header>
        <nav>
            <div class="logo">
                <a href="index.jsp">SneakerEthics</a>
            </div>
            <ul class="nav-links">
                <li><a href="index.jsp">Home</a></li>
                <li><a href="cart.jsp">Cart</a></li>
                <li><a href="orders.jsp">Orders</a></li>
                <li><a href="profile.jsp" class="active">Profile</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main class="profile-container">
        <h1>My Profile</h1>
        
        <div class="profile-grid">
            <div class="profile-section">
                <h2>Personal Information</h2>
                <form id="profile-form" class="profile-form">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" required>
                    </div>
                    <button type="submit" class="btn-primary">Update Profile</button>
                </form>
            </div>

            <div class="profile-section">
                <h2>Change Password</h2>
                <form id="password-form" class="profile-form">
                    <div class="form-group">
                        <label for="currentPassword">Current Password</label>
                        <input type="password" id="currentPassword" name="currentPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="newPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm New Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <button type="submit" class="btn-primary">Change Password</button>
                </form>
            </div>
        </div>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            loadProfile();
            
            document.getElementById('profile-form').addEventListener('submit', function(e) {
                e.preventDefault();
                updateProfile();
            });
            
            document.getElementById('password-form').addEventListener('submit', function(e) {
                e.preventDefault();
                changePassword();
            });
        });

        function loadProfile() {
            fetch('/SneakerEthics/api/profile')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to load profile');
                    }
                    return response.json();
                })
                .then(profile => {
                    document.getElementById('username').value = profile.username;
                    document.getElementById('email').value = profile.email;
                    document.getElementById('fullName').value = profile.fullName;
                })
                .catch(error => {
                    console.error('Error:', error);
                    showAlert('Failed to load profile', 'error');
                });
        }

        function updateProfile() {
            const formData = new FormData(document.getElementById('profile-form'));
            const data = Object.fromEntries(formData.entries());

            fetch('/SneakerEthics/api/profile', {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to update profile');
                }
                return response.json();
            })
            .then(profile => {
                showAlert('Profile updated successfully', 'success');
            })
            .catch(error => {
                console.error('Error:', error);
                showAlert('Failed to update profile', 'error');
            });
        }

        function changePassword() {
            const formData = new FormData(document.getElementById('password-form'));
            const data = Object.fromEntries(formData.entries());

            if (data.newPassword !== data.confirmPassword) {
                showAlert('New passwords do not match', 'error');
                return;
            }

            fetch('/SneakerEthics/api/profile/password', {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to change password');
                }
                return response.json();
            })
            .then(result => {
                showAlert('Password changed successfully', 'success');
                document.getElementById('password-form').reset();
            })
            .catch(error => {
                console.error('Error:', error);
                showAlert('Failed to change password', 'error');
            });
        }

        function showAlert(message, type) {
            const alertDiv = document.createElement('div');
            alertDiv.className = `alert alert-${type}`;
            alertDiv.textContent = message;
            
            document.body.appendChild(alertDiv);
            
            setTimeout(() => {
                alertDiv.remove();
            }, 3000);
        }
    </script>
</body>
</html> 