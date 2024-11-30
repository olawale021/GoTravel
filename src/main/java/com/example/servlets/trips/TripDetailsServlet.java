package com.example.servlets.trips;


import com.example.models.trips.TripDAO;
import com.example.models.trips.TripModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/tripDetails")
public class TripDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve the trip ID from the request parameter
            String tripIdParam = request.getParameter("id");
            if (tripIdParam == null || tripIdParam.isEmpty()) {
                request.setAttribute("error", "Trip ID is missing.");
                request.getRequestDispatcher("tripDetails.jsp").forward(request, response);
                return;
            }

            int tripId = Integer.parseInt(tripIdParam);

            // Fetch trip details using TripDAO
            TripDAO tripDAO = new TripDAO();
            TripModel trip = tripDAO.getTripById(tripId);

            if (trip == null) {
                request.setAttribute("error", "Trip not found.");
            } else {
                request.setAttribute("trip", trip);
            }

            // Forward to the JSP to display trip details
            request.getRequestDispatcher("tripDetails.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading the trip details.");
            request.getRequestDispatcher("tripDetails.jsp").forward(request, response);
        }
    }
}
