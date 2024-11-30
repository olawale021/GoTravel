package com.example.models.trips;

import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TripTypeDAO {

    public void addTripType(TripTypeModel tripType) throws SQLException {
        String sql = "INSERT INTO tripType (name) VALUES (?)";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, tripType.getName());
            stmt.executeUpdate();
        }
    }

    public TripTypeModel getTripTypeById(int id) throws SQLException {
        String sql = "SELECT * FROM tripType WHERE id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRowToTripType(rs);
            }
        }
        return null;
    }

    public List<TripTypeModel> getAllTripTypes() throws SQLException {
        List<TripTypeModel> tripTypes = new ArrayList<>();
        String sql = "SELECT * FROM tripType";
        try (Connection connection = DatabaseConnection.connect();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                tripTypes.add(mapRowToTripType(rs));
            }
        }
        return tripTypes;
    }

    public void deleteTripType(int id) throws SQLException {
        String sql = "DELETE FROM tripType WHERE id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    private TripTypeModel mapRowToTripType(ResultSet rs) throws SQLException {
        TripTypeModel tripType = new TripTypeModel();
        tripType.setId(rs.getInt("id"));
        tripType.setName(rs.getString("name"));
        return tripType;
    }
}
