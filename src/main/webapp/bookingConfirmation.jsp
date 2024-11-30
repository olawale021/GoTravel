<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Booking Confirmation</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f8fafc;
      color: #0f172a;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 800px;
      margin: 2rem auto;
      padding: 2rem;
      background: white;
      border-radius: 1rem;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }

    h1 {
      color: #2563eb;
      font-size: 2rem;
    }

    .details {
      margin: 1rem 0;
    }

    .details h3 {
      margin: 0.5rem 0;
    }

    .details p {
      margin: 0.25rem 0;
    }

    .btn {
      display: inline-block;
      background: #2563eb;
      color: white;
      padding: 0.75rem 1.5rem;
      border-radius: 0.5rem;
      text-decoration: none;
      font-weight: bold;
      margin-top: 1rem;
    }

    .btn:hover {
      background: #1e40af;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Booking Confirmed!</h1>
  <div class="details">
    <h3>Trip Details:</h3>
    <p><strong>Trip Name:</strong> ${trip.name}</p>
    <p><strong>Destination:</strong> ${trip.destination}</p>
    <p><strong>Duration:</strong> ${trip.duration} days</p>
    <p><strong>Number of Travelers:</strong> ${booking.travelersCount}</p>
  </div>

  <!-- Link to Add Traveler Details -->
  <c:if test="${booking.travelersCount > 1}">
    <p>You need to provide details for the travelers. Click the link below to continue:</p>
    <a href="${pageContext.request.contextPath}/addTravelers?bookingId=${booking.id}" class="btn">Add Traveler Details</a>
  </c:if>

  <!-- Back to Trips Link -->
  <a href="${pageContext.request.contextPath}/browseTrips" class="btn">Back to Trips</a>
</div>
</body>
</html>
