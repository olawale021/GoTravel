package com.example.models.travelers;



import com.example.models.travelers.TravelerModel;
import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TravelerDAO {
    public void addTraveler(TravelerModel traveler) throws Exception {
        String query = "INSERT INTO Traveler (booking_id, name) VALUES (?, ?)";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, traveler.getBookingId());
            statement.setString(2, traveler.getName());

            statement.executeUpdate();
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    traveler.setId(generatedKeys.getInt(1));
                }
            }
        }
    }

    public List<TravelerModel> getTravelersByBookingId(int bookingId) throws Exception {
        String query = "SELECT * FROM Traveler WHERE booking_id = ?";
        List<TravelerModel> travelers = new ArrayList<>();

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, bookingId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    TravelerModel traveler = new TravelerModel();
                    traveler.setId(resultSet.getInt("id"));
                    traveler.setBookingId(resultSet.getInt("booking_id"));
                    traveler.setName(resultSet.getString("name"));
                    travelers.add(traveler);
                }
            }
        }
        return travelers;
    }
}
