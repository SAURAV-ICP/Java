package com.sneakerethics.dao;

import com.sneakerethics.model.Order;
import com.sneakerethics.util.DatabaseUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    // Get all orders
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }

    // Get order by ID
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get orders by user ID
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Update order status
    public boolean updateOrderStatus(int id, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, id);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete order
    public boolean deleteOrder(int orderId) {
        String sql = "DELETE FROM orders WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int createOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, sneaker_id, quantity, total_price, status, " +
                    "shipping_address, shipping_city, shipping_state, shipping_zip, order_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getUserId());
            stmt.setInt(2, order.getSneakerId());
            stmt.setInt(3, order.getQuantity());
            stmt.setDouble(4, order.getTotalPrice());
            stmt.setString(5, order.getStatus());
            stmt.setString(6, order.getShippingAddress());
            stmt.setString(7, order.getShippingCity());
            stmt.setString(8, order.getShippingState());
            stmt.setString(9, order.getShippingZip());
            stmt.setTimestamp(10, Timestamp.valueOf(order.getOrderDate()));

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean updateOrder(Order order) {
        String sql = "UPDATE orders SET status = ?, shipping_address = ?, shipping_city = ?, " +
                    "shipping_state = ?, shipping_zip = ? WHERE id = ? AND user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, order.getStatus());
            stmt.setString(2, order.getShippingAddress());
            stmt.setString(3, order.getShippingCity());
            stmt.setString(4, order.getShippingState());
            stmt.setString(5, order.getShippingZip());
            stmt.setInt(6, order.getId());
            stmt.setInt(7, order.getUserId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setSneakerId(rs.getInt("sneaker_id"));
        order.setQuantity(rs.getInt("quantity"));
        order.setTotalPrice(rs.getDouble("total_price"));
        order.setStatus(rs.getString("status"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setShippingCity(rs.getString("shipping_city"));
        order.setShippingState(rs.getString("shipping_state"));
        order.setShippingZip(rs.getString("shipping_zip"));
        
        Timestamp orderDate = rs.getTimestamp("order_date");
        if (orderDate != null) {
            order.setOrderDate(orderDate.toLocalDateTime());
        } else {
            order.setOrderDate(LocalDateTime.now());
        }
        
        return order;
    }
} 