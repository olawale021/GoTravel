package com.example.models.trips;

import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


public class TripDAO {

    public void addTrip(TripModel trip) throws SQLException {
        String sql = "INSERT INTO trip (name, destination, duration, price, description, trip_type_id, start_date, end_date, slots, image) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, trip.getName());
            stmt.setString(2, trip.getDestination());
            stmt.setInt(3, trip.getDuration());
            stmt.setDouble(4, trip.getPrice());
            stmt.setString(5, trip.getDescription());
            stmt.setInt(6, trip.getTripTypeId());
            stmt.setString(7, trip.getStartDate().toString());
            stmt.setString(8, trip.getEndDate().toString());
            stmt.setInt(9, trip.getSlots());
            stmt.setString(10, trip.getImage());
            stmt.executeUpdate();
        }
    }

    public TripModel getTripById(int id) throws SQLException {
        String sql = "SELECT * FROM trip WHERE id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapRowToTrip(rs);
            }
        }
        return null;
    }

    public List<TripModel> getAllTrips() throws SQLException {
        List<TripModel> trips = new ArrayList<>();
        String sql = "SELECT * FROM trip";
        try (Connection connection = DatabaseConnection.connect();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                trips.add(mapRowToTrip(rs));
            }
        }
        return trips;
    }

    public void updateTrip(TripModel trip) throws SQLException {
        String sql = "UPDATE trip SET name = ?, destination = ?, duration = ?, price = ?, description = ?, trip_type_id = ?, start_date = ?, end_date = ?, slots = ?, image = ? WHERE id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, trip.getName());
            stmt.setString(2, trip.getDestination());
            stmt.setInt(3, trip.getDuration());
            stmt.setDouble(4, trip.getPrice());
            stmt.setString(5, trip.getDescription());
            stmt.setInt(6, trip.getTripTypeId());
            stmt.setString(7, trip.getStartDate().toString());
            stmt.setString(8, trip.getEndDate().toString());
            stmt.setInt(9, trip.getSlots());
            stmt.setString(10, trip.getImage());
            stmt.setInt(11, trip.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteTrip(int id) throws SQLException {
        String sql = "DELETE FROM trip WHERE id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    private TripModel mapRowToTrip(ResultSet rs) throws SQLException {
        TripModel trip = new TripModel();
        trip.setId(rs.getInt("id"));
        trip.setName(rs.getString("name"));
        trip.setDestination(rs.getString("destination"));
        trip.setDuration(rs.getInt("duration"));
        trip.setPrice(rs.getDouble("price"));
        trip.setDescription(rs.getString("description"));
        trip.setTripTypeId(rs.getInt("trip_type_id"));
        trip.setStartDate(LocalDate.parse(rs.getString("start_date")));
        trip.setEndDate(LocalDate.parse(rs.getString("end_date")));
        trip.setSlots(rs.getInt("slots"));
        trip.setImage(rs.getString("image"));
        return trip;
    }

    public List<TripModel> searchTrips(String searchQuery, Double maxPrice, String duration) throws Exception {
            List<TripModel> trips = new ArrayList<>();

            String sql = "SELECT * FROM trip WHERE 1=1";

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                sql += " AND (name LIKE ? OR destination LIKE ?)";
            }
            if (maxPrice != null) {
                sql += " AND price <= ?";
            }
            if (duration != null && !duration.isEmpty()) {
                String[] durationRange = duration.split("-");
                if (durationRange.length == 2) {
                    sql += " AND duration BETWEEN ? AND ?";
                } else if (duration.equals("8+")) {
                    sql += " AND duration >= 8";
                }
            }

            try (Connection connection = DatabaseConnection.connect();
                 PreparedStatement stmt = connection.prepareStatement(sql)) {

                int paramIndex = 1;

                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    stmt.setString(paramIndex++, "%" + searchQuery + "%");
                    stmt.setString(paramIndex++, "%" + searchQuery + "%");
                }
                if (maxPrice != null) {
                    stmt.setDouble(paramIndex++, maxPrice);
                }
                if (duration != null && !duration.isEmpty()) {
                    String[] durationRange = duration.split("-");
                    if (durationRange.length == 2) {
                        stmt.setInt(paramIndex++, Integer.parseInt(durationRange[0]));
                        stmt.setInt(paramIndex++, Integer.parseInt(durationRange[1]));
                    }
                }

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        TripModel trip = new TripModel();
                        trip.setId((int) rs.getLong("id"));
                        trip.setName(rs.getString("name"));
                        trip.setDestination(rs.getString("destination"));
                        trip.setDuration(rs.getInt("duration"));
                        trip.setSlots(rs.getInt("slots"));
                        trip.setDescription(rs.getString("description"));
                        trip.setPrice(rs.getDouble("price"));
                        trip.setImage(rs.getString("image"));
                        trips.add(trip);
                    }
                }
            }
            return trips;
    }
}

