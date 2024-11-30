package com.example.servlets.trips;



import com.example.models.bookings.BookingModel;
import com.example.models.bookings.BookingDAO;
import com.example.models.trips.TripModel;
import com.example.models.trips.TripDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/book-trip")
public class BookTripServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the trip ID and travelers count from the request parameters
            String tripIdParam = request.getParameter("id");
            String travelersParam = request.getParameter("travelers");

            if (tripIdParam == null || tripIdParam.isEmpty()) {
                request.setAttribute("error", "Trip ID is missing.");
                request.getRequestDispatcher("tripDetails.jsp").forward(request, response);
                return;
            }

            if (travelersParam == null || travelersParam.isEmpty()) {
                request.setAttribute("error", "Number of travelers is missing.");
                request.getRequestDispatcher("tripDetails.jsp").forward(request, response);
                return;
            }

            int tripId = Integer.parseInt(tripIdParam);
            int travelersCount = Integer.parseInt(travelersParam);

            // Fetch trip details using TripDAO
            TripDAO tripDAO = new TripDAO();
            TripModel trip = tripDAO.getTripById(tripId);

            if (trip == null) {
                request.setAttribute("error", "Trip not found.");
                request.getRequestDispatcher("tripDetails.jsp").forward(request, response);
                return;
            }

            // Retrieve the logged-in user's ID from the session
            Object userObject = request.getSession().getAttribute("user");
            if (userObject == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            int userId = ((com.example.models.users.UserModel) userObject).getId();

            // Create a new BookingModel and set its details
            BookingModel booking = new BookingModel();
            booking.setTripId(tripId);
            booking.setUserId(userId); // Set the user ID
            booking.setTravelersCount(travelersCount);
            booking.setBookingStatus("Pending");

            // Use BookingDAO to save the booking to the database
            BookingDAO bookingDAO = new BookingDAO();
            bookingDAO.addBooking(booking);

            // Pass the booking and trip details to the confirmation page
            request.setAttribute("trip", trip);
            request.setAttribute("booking", booking);

            // Forward to confirmation page
            request.getRequestDispatcher("bookingConfirmation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your booking.");
            request.getRequestDispatcher("tripDetails.jsp").forward(request, response);
        }
    }
}

