package com.example.servlets.admin;

import com.example.models.trips.TripDAO;
import com.example.models.trips.TripModel;
import com.example.models.trips.TripTypeDAO;
import com.example.models.trips.TripTypeModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/editTrip")
public class EditTripServlet extends HttpServlet {

    private TripDAO tripDAO;
    private TripTypeDAO tripTypeDAO;

    @Override
    public void init() throws ServletException {
        tripDAO = new TripDAO();
        tripTypeDAO = new TripTypeDAO();
    }

    private boolean isAdminLoggedIn(HttpServletRequest request) {
        // Check if the session attribute "role" is set to "admin"
        Object role = request.getSession().getAttribute("role");
        return role != null && "admin".equalsIgnoreCase(role.toString());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdminLoggedIn(request)) {
            // Redirect to login page if not an admin
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            TripModel trip = tripDAO.getTripById(id);

            // Fetch available trip types
            List<TripTypeModel> tripTypes = tripTypeDAO.getAllTripTypes();

            // Pass trip and trip types to JSP
            request.setAttribute("trip", trip);
            request.setAttribute("tripTypes", tripTypes);

            request.getRequestDispatcher("edit-trips.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to fetch trip details: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manageTrips");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdminLoggedIn(request)) {
            // Redirect to login page if not an admin
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            TripModel trip = new TripModel();
            trip.setId(id);
            trip.setName(request.getParameter("name"));
            trip.setDestination(request.getParameter("destination"));
            trip.setDuration(Integer.parseInt(request.getParameter("duration")));
            trip.setPrice(Double.parseDouble(request.getParameter("price")));
            trip.setSlots(Integer.parseInt(request.getParameter("slots")));
            trip.setTripTypeId(Integer.parseInt(request.getParameter("tripTypeId")));
            trip.setStartDate(LocalDate.parse(request.getParameter("startDate")));
            trip.setEndDate(LocalDate.parse(request.getParameter("endDate")));
            trip.setDescription(request.getParameter("description"));
            trip.setImage(request.getParameter("image"));

            tripDAO.updateTrip(trip);
            response.sendRedirect(request.getContextPath() + "/manageTrips");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to update trip: " + e.getMessage());
            request.getRequestDispatcher("edit-trips.jsp").forward(request, response);
        }
    }
}
