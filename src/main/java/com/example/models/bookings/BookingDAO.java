package com.example.models.bookings;



import com.example.models.bookings.BookingModel;
import com.example.utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    public void addBooking(BookingModel booking) throws Exception {
        String query = "INSERT INTO Booking (trip_id, user_id, travelers_count, booking_status) VALUES (?, ?, ?, ?)";

        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {

            statement.setInt(1, booking.getTripId());
            statement.setInt(2, booking.getUserId());
            statement.setInt(3, booking.getTravelersCount());
            statement.setString(4, booking.getBookingStatus());

            statement.executeUpdate();
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    booking.setId(generatedKeys.getInt(1));
                }
            }
        }
    }

    public BookingModel getBookingById(int id) throws Exception {
        String query = "SELECT * FROM Booking WHERE id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    BookingModel booking = new BookingModel();
                    booking.setId(resultSet.getInt("id"));
                    booking.setTripId(resultSet.getInt("trip_id"));
                    booking.setUserId(resultSet.getInt("user_id"));
                    booking.setTravelersCount(resultSet.getInt("travelers_count"));
                    booking.setBookingDate(resultSet.getTimestamp("booking_date"));
                    booking.setBookingStatus(resultSet.getString("booking_status"));
                    return booking;
                }
            }
        }
        return null;
    }

    public List<BookingModel> getAllBookings() throws Exception {
        String query = "SELECT * FROM Booking";
        List<BookingModel> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                BookingModel booking = new BookingModel();
                booking.setId(resultSet.getInt("id"));
                booking.setTripId(resultSet.getInt("trip_id"));
                booking.setUserId(resultSet.getInt("user_id"));
                booking.setTravelersCount(resultSet.getInt("travelers_count"));
                booking.setBookingDate(resultSet.getTimestamp("booking_date"));
                booking.setBookingStatus(resultSet.getString("booking_status"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    public List<BookingModel> getBookingsByUserId(int userId) {
        List<BookingModel> bookings = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.connect();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BookingModel booking = new BookingModel();
                    booking.setId(rs.getInt("id"));
                    booking.setTripId(rs.getInt("trip_id"));
                    booking.setUserId(rs.getInt("user_id"));
                    booking.setTravelersCount(rs.getInt("travelers_count"));
                    booking.setBookingDate(rs.getTimestamp("booking_date"));
                    booking.setBookingStatus(rs.getString("booking_status"));
                    bookings.add(booking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bookings;
    }



    public void updateBookingStatus(int id, String status) throws Exception {
        String query = "UPDATE Booking SET booking_status = ? WHERE id = ?";
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, status);
            statement.setInt(2, id);
            statement.executeUpdate();
        }
    }

    public List<BookingModel> getAllBookingsWithDetails() throws Exception {
        String query = "SELECT b.*, t.name AS tripName, u.username AS userName " +
                "FROM Booking b " +
                "JOIN Trip t ON b.trip_id = t.id " +
                "JOIN User u ON b.user_id = u.id";
        List<BookingModel> bookings = new ArrayList<>();
        try (Connection connection = DatabaseConnection.connect();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            System.out.println("Executing query: " + query);
            for (BookingModel booking : bookings) {
                System.out.println("Booking ID: " + booking.getId() + ", Trip: " + booking.getTripName() + ", User: " + booking.getUserName());
            }

            while (resultSet.next()) {
                BookingModel booking = new BookingModel();
                booking.setId(resultSet.getInt("id"));
                booking.setTripId(resultSet.getInt("trip_id"));
                booking.setUserId(resultSet.getInt("user_id"));
                booking.setTravelersCount(resultSet.getInt("travelers_count"));
                booking.setBookingDate(resultSet.getTimestamp("booking_date"));
                booking.setBookingStatus(resultSet.getString("booking_status"));
                booking.setTripName(resultSet.getString("tripName"));
                booking.setUserName(resultSet.getString("userName"));
                bookings.add(booking);
            }
        }
        return bookings;
    }




}
