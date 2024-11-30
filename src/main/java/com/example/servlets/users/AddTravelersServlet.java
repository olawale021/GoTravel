package com.example.servlets.users;

import com.example.models.bookings.BookingDAO;
import com.example.models.bookings.BookingModel;
import com.example.models.travelers.TravelerDAO;
import com.example.models.travelers.TravelerModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addTravelers")
public class AddTravelersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get booking ID from request
            String bookingIdParam = request.getParameter("bookingId");
            if (bookingIdParam == null || bookingIdParam.isEmpty()) {
                request.setAttribute("error", "Booking ID is missing.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            int bookingId = Integer.parseInt(bookingIdParam);

            // Fetch booking details using BookingDAO
            BookingDAO bookingDAO = new BookingDAO();
            BookingModel booking = bookingDAO.getBookingById(bookingId);

            if (booking == null) {
                request.setAttribute("error", "Booking not found.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            // Pass booking details to the JSP
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("travelersDetails.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading the traveler details form.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve booking ID
            String bookingIdParam = request.getParameter("bookingId");
            if (bookingIdParam == null || bookingIdParam.isEmpty()) {
                request.setAttribute("error", "Booking ID is missing.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            int bookingId = Integer.parseInt(bookingIdParam);

            // Retrieve traveler names from the form
            String[] travelerNames = request.getParameterValues("travelerNames");
            if (travelerNames == null || travelerNames.length == 0) {
                request.setAttribute("error", "No traveler details provided.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            // Save traveler details to the database
            TravelerDAO travelerDAO = new TravelerDAO();
            for (String name : travelerNames) {
                TravelerModel traveler = new TravelerModel();
                traveler.setBookingId(bookingId);
                traveler.setName(name);
                travelerDAO.addTraveler(traveler);
            }

            // Redirect to confirmation page
            request.setAttribute("message", "Traveler details added successfully!");
            request.getRequestDispatcher("confirmation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while saving traveler details.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
