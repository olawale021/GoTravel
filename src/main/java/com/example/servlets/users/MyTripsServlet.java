package com.example.servlets.users;


import com.example.models.bookings.BookingDAO;
import com.example.models.bookings.BookingModel;
import com.example.models.trips.TripDAO;
import com.example.models.trips.TripModel;
import com.example.models.users.UserModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/myTrips")
public class MyTripsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the logged-in user object from the session
            HttpSession session = request.getSession();
            Object userObject = session.getAttribute("user");

            if (userObject == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Assuming userObject is of a UserModel type, extract the userId
            UserModel user = (UserModel) userObject;
            int userId = user.getId(); // Get the userId from the user object

            // Log the userId
            System.out.println("Logged-in user ID: " + userId);

            // Fetch bookings for the user
            BookingDAO bookingDAO = new BookingDAO();
            List<BookingModel> bookings = bookingDAO.getBookingsByUserId(userId);

            // Log the number of bookings
            System.out.println("Number of bookings retrieved: " + bookings.size());

            // Fetch trip details for each booking
            TripDAO tripDAO = new TripDAO();
            List<TripModel> trips = new ArrayList<>();
            for (BookingModel booking : bookings) {
                TripModel trip = tripDAO.getTripById(booking.getTripId());
                if (trip != null) {
                    trips.add(trip);
                }
            }

            // Log the number of trips retrieved
            System.out.println("Number of trips retrieved: " + trips.size());

            // Set trips and bookings as request attributes
            request.setAttribute("trips", trips);
            request.setAttribute("bookings", bookings);

            // Forward to the JSP to display the trips
            request.getRequestDispatcher("myTrips.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading your trips.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}


