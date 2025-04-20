-- SneakerEthics Database Schema
-- Created for ethical sneakers shop web application

-- Create the database
CREATE DATABASE IF NOT EXISTS sneakerethics;
USE sneakerethics;

-- Drop existing tables if they exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS sneakers;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role ENUM('admin', 'user') NOT NULL DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create sneakers table
CREATE TABLE IF NOT EXISTS sneakers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    ethical_certification VARCHAR(100),
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    sneaker_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (sneaker_id) REFERENCES sneakers(id)
);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, password, email, role) 
VALUES ('admin', 'admin123', 'admin@sneakerethics.com', 'admin');

-- Insert sample sneakers
INSERT INTO sneakers (name, description, price, stock, ethical_certification) VALUES
('Eco Runner', 'Sustainable running shoes made from recycled materials', 99.99, 50, 'Fair Trade Certified'),
('Green Stride', 'Environmentally friendly walking shoes', 79.99, 30, 'B Corp Certified'),
('Earth Walker', 'Vegan sneakers with minimal environmental impact', 89.99, 25, 'Carbon Neutral Certified');

-- Create indexes for better performance
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_sneakers_name ON sneakers(name);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_sneaker_id ON orders(sneaker_id); 