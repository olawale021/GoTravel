package com.example.servlets.admin;

import com.example.models.bookings.BookingDAO;
import com.example.models.bookings.BookingModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageBookings")
public class ManageBookingsServlet extends HttpServlet {

    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Fetch all bookings with trip and user details
            List<BookingModel> bookings = bookingDAO.getAllBookingsWithDetails();
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("manage-bookings.jsp").forward(request, response);

            System.out.println("Total bookings retrieved: " + bookings.size());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to fetch bookings: " + e.getMessage());
            request.getRequestDispatcher("manage-bookings.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("confirm".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                bookingDAO.updateBookingStatus(id, "Confirmed");
            }
            response.sendRedirect(request.getContextPath() + "/manageBookings");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to process the request: " + e.getMessage());
            request.getRequestDispatcher("manage-bookings.jsp").forward(request, response);
        }
    }
}
