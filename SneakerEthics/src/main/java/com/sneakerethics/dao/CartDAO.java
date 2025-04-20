package com.sneakerethics.dao;

import com.sneakerethics.model.CartItem;
import com.sneakerethics.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT c.*, s.name as sneaker_name, s.image_url FROM cart_items c " +
                    "JOIN sneakers s ON c.sneaker_id = s.id " +
                    "WHERE c.user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setId(rs.getInt("id"));
                item.setUserId(rs.getInt("user_id"));
                item.setSneakerId(rs.getInt("sneaker_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                item.setSneakerName(rs.getString("sneaker_name"));
                item.setImageUrl(rs.getString("image_url"));
                cartItems.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public boolean addToCart(CartItem item) {
        String sql = "INSERT INTO cart_items (user_id, sneaker_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, item.getUserId());
            stmt.setInt(2, item.getSneakerId());
            stmt.setInt(3, item.getQuantity());
            stmt.setDouble(4, item.getPrice());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    item.setId(generatedKeys.getInt(1));
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCartItem(CartItem item) {
        String sql = "UPDATE cart_items SET quantity = ? WHERE id = ? AND user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, item.getQuantity());
            stmt.setInt(2, item.getId());
            stmt.setInt(3, item.getUserId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeFromCart(int cartItemId, int userId) {
        String sql = "DELETE FROM cart_items WHERE id = ? AND user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartItemId);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean clearCart(int userId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
} 