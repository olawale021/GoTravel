package com.example.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String DATABASE_URL = "jdbc:sqlite:/Users/olawale/Desktop/Devs/GoTravel/gotravel.db"; // Path to your SQLite database

    /**
     * Establishes a connection to the SQLite database.
     *
     * @return Connection object
     */
    public static Connection connect() {
        Connection connection = null;
        try {
            // Load the SQLite JDBC driver (optional in modern versions)
            Class.forName("org.sqlite.JDBC");

            // Connect to the database
            connection = DriverManager.getConnection(DATABASE_URL);

            // Print success message
            System.out.println("Connected to the database successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("SQLite JDBC driver not found. Please add it to your library.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Failed to connect to the database.");
            e.printStackTrace();
        }
        return connection;
    }

    public static void main(String[] args) {
        // Test the connection
        connect();
    }
}
