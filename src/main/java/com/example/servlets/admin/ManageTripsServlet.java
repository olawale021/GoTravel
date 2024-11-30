package com.example.servlets.admin;

import com.example.models.trips.TripDAO;
import com.example.models.trips.TripModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageTrips")
public class ManageTripsServlet extends HttpServlet {

    private TripDAO tripDAO;

    @Override
    public void init() throws ServletException {
        tripDAO = new TripDAO();
    }

    private boolean isAdminLoggedIn(HttpServletRequest request) {
        // Check if the user session exists and the role is "admin"
        Object userRole = request.getSession().getAttribute("role");
        return userRole != null && "admin".equalsIgnoreCase(userRole.toString());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdminLoggedIn(request)) {
            // Redirect to login page if user is not an admin
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<TripModel> trips = tripDAO.getAllTrips();
            request.setAttribute("trips", trips);
            request.getRequestDispatcher("manage-trips.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to fetch trips.");
            request.getRequestDispatcher("manage-trips.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdminLoggedIn(request)) {
            // Redirect to login page if user is not an admin
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("delete".equalsIgnoreCase(action)) {
                // Delete Trip
                int id = Integer.parseInt(request.getParameter("id"));
                tripDAO.deleteTrip(id);
                response.sendRedirect(request.getContextPath() + "/manageTrips");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to delete trip: " + e.getMessage());
            request.getRequestDispatcher("manage-trips.jsp").forward(request, response);
        }
    }
}
