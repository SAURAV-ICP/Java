package com.sneakerethics.dao;

import com.sneakerethics.model.Order;
import com.sneakerethics.model.Sneaker;
import com.sneakerethics.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAO {
    private static final String INSERT_ORDER_ITEM = "INSERT INTO order_items (order_id, sneaker_id, quantity, price) VALUES (?, ?, ?, ?)";
    private static final String GET_ORDER_ITEMS = "SELECT oi.*, s.* FROM order_items oi JOIN sneakers s ON oi.sneaker_id = s.id WHERE oi.order_id = ?";
    private static final String DELETE_ORDER_ITEMS = "DELETE FROM order_items WHERE order_id = ?";

    public boolean addOrderItem(Order.OrderItem orderItem) {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_ORDER_ITEM, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, orderItem.getOrderId());
            stmt.setInt(2, orderItem.getSneakerId());
            stmt.setInt(3, orderItem.getQuantity());
            stmt.setDouble(4, orderItem.getPrice());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                return false;
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    orderItem.setId(generatedKeys.getInt(1));
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Order.OrderItem> getOrderItems(int orderId) {
        List<Order.OrderItem> items = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_ORDER_ITEMS)) {
            
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Order.OrderItem item = extractOrderItem(rs);
                Sneaker sneaker = extractSneaker(rs);
                item.setSneaker(sneaker);
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public boolean deleteOrderItems(int orderId) {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_ORDER_ITEMS)) {
            
            stmt.setInt(1, orderId);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Order.OrderItem extractOrderItem(ResultSet rs) throws SQLException {
        Order.OrderItem item = new Order.OrderItem();
        item.setId(rs.getInt("id"));
        item.setOrderId(rs.getInt("order_id"));
        item.setSneakerId(rs.getInt("sneaker_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setPrice(rs.getDouble("price"));
        return item;
    }

    private Sneaker extractSneaker(ResultSet rs) throws SQLException {
        Sneaker sneaker = new Sneaker();
        sneaker.setId(rs.getInt("s.id"));
        sneaker.setName(rs.getString("s.name"));
        sneaker.setDescription(rs.getString("s.description"));
        sneaker.setPrice(rs.getDouble("s.price"));
        sneaker.setStock(rs.getInt("s.stock"));
        sneaker.setEthicalCertification(rs.getString("s.ethical_certification"));
        sneaker.setImageUrl(rs.getString("s.image_url"));
        return sneaker;
    }
} 