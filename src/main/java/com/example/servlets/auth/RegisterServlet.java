package com.example.servlets.auth;

import com.example.models.users.UserDAO;
import com.example.models.users.UserModel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO(); // Initialize UserDAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = "general_user"; // Default role is general_user

        // Validate inputs
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("error", "Username and Password are required!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Check if the username already exists
        if (userDAO.getUserByUsername(username) != null) {
            request.setAttribute("error", "Username is already taken.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Create a new UserModel and add it to the database
        UserModel newUser = new UserModel(0, username, null, password, role);
        if (userDAO.addUser(newUser)) {
            // Registration successful, redirect to login
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Registration failed
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Display the registration page
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}
