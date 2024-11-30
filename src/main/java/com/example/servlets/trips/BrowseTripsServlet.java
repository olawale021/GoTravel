package com.example.servlets.trips;


import com.example.models.trips.TripDAO;
import com.example.models.trips.TripModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/browseTrips")
public class BrowseTripsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get search parameters from the request
            String searchQuery = request.getParameter("search");
            String maxPriceStr = request.getParameter("maxPrice");
            String duration = request.getParameter("duration");

            Double maxPrice = null;
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }

            // Fetch trips using TripDAO based on search parameters
            TripDAO tripDAO = new TripDAO();
            List<TripModel> trips;

            if (searchQuery != null || maxPrice != null || duration != null) {
                trips = tripDAO.searchTrips(searchQuery, maxPrice, duration);
            } else {
                trips = tripDAO.getAllTrips();
            }

            // Set trips as a request attribute
            request.setAttribute("trips", trips);

            // Forward to the JSP to display trips
            request.getRequestDispatcher("browseTrips.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load trips. Please try again.");
            request.getRequestDispatcher("browseTrips.jsp").forward(request, response);
        }
    }
}
