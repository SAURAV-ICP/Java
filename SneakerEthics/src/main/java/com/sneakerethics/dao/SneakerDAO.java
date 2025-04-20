package com.sneakerethics.dao;

import com.sneakerethics.model.Sneaker;
import com.sneakerethics.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SneakerDAO {
    // SQL queries
    private static final String INSERT_SNEAKER = "INSERT INTO sneakers (name, description, price, stock, ethical_certification, image_url) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String GET_ALL_SNEAKERS = "SELECT * FROM sneakers ORDER BY created_at DESC";
    private static final String GET_SNEAKER_BY_ID = "SELECT * FROM sneakers WHERE id = ?";
    private static final String UPDATE_SNEAKER = "UPDATE sneakers SET name = ?, description = ?, price = ?, stock = ?, ethical_certification = ?, image_url = ? WHERE id = ?";
    private static final String DELETE_SNEAKER = "DELETE FROM sneakers WHERE id = ?";
    private static final String SEARCH_SNEAKERS = "SELECT * FROM sneakers WHERE name LIKE ? OR description LIKE ?";

    // Add a new sneaker
    public boolean addSneaker(Sneaker sneaker) {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_SNEAKER, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, sneaker.getName());
            stmt.setString(2, sneaker.getDescription());
            stmt.setDouble(3, sneaker.getPrice());
            stmt.setInt(4, sneaker.getStock());
            stmt.setString(5, sneaker.getEthicalCertification());
            stmt.setString(6, sneaker.getImageUrl());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        sneaker.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all sneakers
    public List<Sneaker> getAllSneakers() {
        List<Sneaker> sneakers = new ArrayList<>();
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(GET_ALL_SNEAKERS)) {
            
            while (rs.next()) {
                sneakers.add(extractSneakerFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return sneakers;
    }

    // Get sneaker by ID
    public Sneaker getSneakerById(int id) {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_SNEAKER_BY_ID)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractSneakerFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update sneaker
    public boolean updateSneaker(Sneaker sneaker) {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_SNEAKER)) {
            
            stmt.setString(1, sneaker.getName());
            stmt.setString(2, sneaker.getDescription());
            stmt.setDouble(3, sneaker.getPrice());
            stmt.setInt(4, sneaker.getStock());
            stmt.setString(5, sneaker.getEthicalCertification());
            stmt.setString(6, sneaker.getImageUrl());
            stmt.setInt(7, sneaker.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete sneaker
    public boolean deleteSneaker(int id) {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_SNEAKER)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Search sneakers
    public List<Sneaker> searchSneakers(String query) {
        List<Sneaker> sneakers = new ArrayList<>();
        String searchQuery = "%" + query + "%";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SEARCH_SNEAKERS)) {
            
            stmt.setString(1, searchQuery);
            stmt.setString(2, searchQuery);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    sneakers.add(extractSneakerFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return sneakers;
    }

    // Helper method to extract sneaker from ResultSet
    private Sneaker extractSneakerFromResultSet(ResultSet rs) throws SQLException {
        Sneaker sneaker = new Sneaker();
        sneaker.setId(rs.getInt("id"));
        sneaker.setName(rs.getString("name"));
        sneaker.setDescription(rs.getString("description"));
        sneaker.setPrice(rs.getDouble("price"));
        sneaker.setStock(rs.getInt("stock"));
        sneaker.setEthicalCertification(rs.getString("ethical_certification"));
        sneaker.setImageUrl(rs.getString("image_url"));
        sneaker.setCreatedAt(rs.getTimestamp("created_at"));
        sneaker.setUpdatedAt(rs.getTimestamp("updated_at"));
        return sneaker;
    }
} 