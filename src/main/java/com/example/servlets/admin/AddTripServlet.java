package com.example.servlets.admin;

import com.example.models.trips.TripDAO;
import com.example.models.trips.TripModel;
import com.example.models.trips.TripTypeDAO;
import com.example.models.trips.TripTypeModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.util.Base64;
import java.util.List;

@WebServlet("/addTrip")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB max file size
public class AddTripServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is logged in and has the correct role
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Fetch trip types dynamically
            TripTypeDAO tripTypeDAO = new TripTypeDAO();
            List<TripTypeModel> tripTypes = tripTypeDAO.getAllTripTypes();

            // Set trip types as a request attribute
            request.setAttribute("tripTypes", tripTypes);

            // Forward to the JSP for displaying the form
            request.getRequestDispatcher("addTrip.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load trip types. Please try again.");
            request.getRequestDispatcher("addTrip.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if the user is logged in and has the correct role
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Retrieve form data
            String name = request.getParameter("name");
            String destination = request.getParameter("destination");
            int duration = Integer.parseInt(request.getParameter("duration"));
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            int tripTypeId = Integer.parseInt(request.getParameter("tripTypeId"));
            LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
            LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));
            int slots = Integer.parseInt(request.getParameter("slots"));

            // Handle image upload and convert to Base64
            Part imagePart = request.getPart("image");
            String imageBase64 = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                try (InputStream imageStream = imagePart.getInputStream()) {
                    byte[] imageBytes = imageStream.readAllBytes();
                    imageBase64 =  "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageBytes);
                }
            }

            // Create a new TripModel
            TripModel trip = new TripModel();
            trip.setName(name);
            trip.setDestination(destination);
            trip.setDuration(duration);
            trip.setPrice(price);
            trip.setDescription(description);
            trip.setTripTypeId(tripTypeId);
            trip.setStartDate(startDate);
            trip.setEndDate(endDate);
            trip.setSlots(slots);
            trip.setImage(imageBase64);

            // Save the trip using TripDAO
            TripDAO tripDAO = new TripDAO();
            tripDAO.addTrip(trip);

            request.setAttribute("message", "Trip added successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to add the trip. Please try again.");
        }

        // Forward back to the form with a message
        request.getRequestDispatcher("addTrip.jsp").forward(request, response);
    }
}
