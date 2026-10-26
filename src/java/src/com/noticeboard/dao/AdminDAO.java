package com.noticeboard.dao;

import com.noticeboard.util.DBConnection;

import java.sql.*;

public class AdminDAO {

    public boolean loginAdmin(String email, String password) {
        String sql = "SELECT id FROM admin WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public String getAdminName(String email) {
        String sql = "SELECT full_name FROM admin WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("full_name");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Admin";
    }
}
