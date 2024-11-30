<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f8f9fa;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 1rem;
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .header {
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .header h1 {
            font-size: 2rem;
            color: #2563eb;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 1.5rem;
        }

        .table th, .table td {
            padding: 0.75rem 1rem;
            border: 1px solid #ddd;
            text-align: left;
        }

        .table th {
            background: #f1f1f1;
            font-weight: bold;
        }

        .table tr:nth-child(even) {
            background: #f9f9f9;
        }

        .btn {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            border-radius: 0.3rem;
            border: none;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
        }

        .btn-confirm {
            background: #10b981;
            color: white;
        }

        .btn-confirm:hover {
            background: #059669;
        }

        .error-message {
            color: red;
            margin-bottom: 1rem;
            text-align: center;
        }
    </style>
</head>
<body>
<!-- Include header -->
<jsp:include page="/header.jsp" />

<div class="container">
    <div class="header">
        <h1>Manage Bookings</h1>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Trip Name</th>
            <th>User Name</th>
            <th>Booking Date</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="booking" items="${bookings}">
            <tr>
                <td>${booking.id}</td>
                <td>${booking.tripName}</td>
                <td>${booking.userName}</td>
                <td>${booking.bookingDate}</td>
                <td>${booking.bookingStatus}</td>
                <td>
                    <c:if test="${booking.bookingStatus != 'Confirmed'}">
                        <form action="${pageContext.request.contextPath}/manageBookings" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="confirm">
                            <input type="hidden" name="id" value="${booking.id}">
                            <button type="submit" class="btn btn-confirm">Confirm</button>
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>

    <c:if test="${empty bookings}">
        <p>No bookings available.</p>
    </c:if>
</div>
</body>
</html>
