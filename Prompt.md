Generate the initial codebase and documentation for Milestone 1 of a coursework project titled 'ChappaltoSneaker', an ethical sneakers shop web application, using Java, J2EE, MySQL, JSP, and CSS. The project must follow the Model-View-Controller (MVC) architecture, focus on an ethical topic (sustainable fashion), and meet academic requirements for a group project. Do not use frameworks like Bootstrap; use CSS media queries and Flexbox for responsiveness. Include the following components:
Development (Task A):
Database Design:
Create a MySQL database schema with three tables:
Users (id, username, password, email, role) for authentication with role-based access (admin/user).
Sneakers (id, name, description, price, stock, ethical_certification) for inventory.
Orders (id, user_id, sneaker_id, quantity, total_price, order_date) for purchases.
Define primary keys, foreign keys, and relationships (e.g., Users to Orders, Sneakers to Orders).
Provide SQL code with comments for table creation, ensuring normalization and data integrity.
MVC Structure and Java Classes:
Create a Java MVC structure with:
model package containing a User class (id, username, password, email, role) with getters and setters.
controller package containing a LoginController servlet to handle user authentication with MySQL, using HttpSession for session management and redirecting to 'dashboard.jsp' on success or 'login.jsp' with an error on failure.
util package containing a DBConnection class for MySQL connectivity.
Use proper Java naming conventions, add meaningful comments, and include basic exception handling.
Frontend (JSP and CSS):
Generate a login.jsp page with a form for username and password, styled with CSS using media queries and Flexbox for responsiveness (no Bootstrap).
Include JavaScript for client-side validation (check for empty fields) and display error messages from the server.
Ensure the design is user-friendly and aligns with ethical branding (e.g., clean, sustainable aesthetic).
Wireframes Description:
Provide a text description of wireframes for three pages:
Login page: Layout and elements (form, button, error area).
User dashboard: Layout for browsing sneakers (search bar, sneaker grid).
Admin dashboard: Layout for managing inventory (table, action buttons).

Documentation (Task B):

5. Introduction Section:
Write an introduction for a 16,000-word academic report, including:
Title: Descriptive project title.
Purpose: Why the project exists (e.g., promote ethical sneaker purchases).
Audience: Intended users (e.g., consumers, admins).
Aims and Objectives: Main goals (e.g., secure authentication, responsive UI).
List of Features: One-line descriptions of key functionalities.
Use clear, concise language suitable for an academic report.
Wireframes Section:
Write a concise wireframes section for the report, describing the layout and structure of the login page, user dashboard, and admin dashboard, tailored to an academic tone.
Requirements:
Use only Java, J2EE, MySQL, JSP, and CSS as specified.
Avoid external frameworks; focus on server-side logic with Java.
Ensure code is modular, readable, and includes validation/error handling where applicable.
For documentation, maintain an academic style and structure