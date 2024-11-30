<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Trip - Admin Panel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f6f7;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            max-width: 900px;
            margin: 3rem auto;
            padding: 2rem;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 2rem;
            margin-bottom: 1.5rem;
            text-align: center;
            color: #2563eb;
        }

        form {
            display: grid;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            margin-bottom: 0.5rem;
            color: #475569;
        }

        input, select, textarea {
            padding: 0.75rem;
            font-size: 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 100%;
            background: #f9f9f9;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #2563eb;
            outline: none;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s ease-in-out;
        }

        .btn-primary {
            background: #2563eb;
            color: white;
        }

        .btn-primary:hover {
            background: #1e40af;
        }

        .btn-secondary {
            background: #64748b;
            color: white;
        }

        .btn-secondary:hover {
            background: #475569;
        }

        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1rem;
        }

        .error-message {
            background: #fee2e2;
            color: #dc2626;
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1.5rem;
        }

        .success-message {
            background: #d1fae5;
            color: #065f46;
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 768px) {
            .form-actions {
                flex-direction: column-reverse;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Edit Trip</h1>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>

    <!-- Success Message -->
    <c:if test="${not empty success}">
        <div class="success-message">
            <i class="fas fa-check-circle"></i> ${success}
        </div>
    </c:if>

    <!-- Edit Trip Form -->
    <form action="${pageContext.request.contextPath}/editTrip" method="post">
        <!-- Hidden Input for ID -->

        <input type="hidden" name="id" value="${trip.id}" />

        <div class="form-group">
            <label for="name">Trip Name</label>
            <input type="text" id="name" name="name" value="${trip.name}" placeholder="Enter trip name" required />
        </div>

        <div class="form-group">
            <label for="destination">Destination</label>
            <input type="text" id="destination" name="destination" value="${trip.destination}" placeholder="Enter trip destination" required />
        </div>

        <div class="form-group">
            <label for="duration">Duration (days)</label>
            <input type="number" id="duration" name="duration" value="${trip.duration}" min="1" placeholder="Enter trip duration in days" required />
        </div>

        <div class="form-group">
            <label for="price">Price (£)</label>
            <input type="number" id="price" name="price" value="${trip.price}" step="0.01" placeholder="Enter trip price" required />
        </div>

        <div class="form-group">
            <label for="slots">Available Slots</label>
            <input type="number" id="slots" name="slots" value="${trip.slots}" min="1" placeholder="Enter available slots" required />
        </div>
        <div class="form-group">
            <label for="tripTypeId">Trip Type</label>
            <select id="tripTypeId" name="tripTypeId" required>
                <c:forEach var="type" items="${tripTypes}">
                    <option value="${type.id}" ${trip.tripTypeId == type.id ? 'selected' : ''}>
                            ${type.name}
                    </option>
                </c:forEach>
            </select>
        </div>


        <div class="form-group">
            <label for="startDate">Start Date</label>
            <input type="date" id="startDate" name="startDate" value="${trip.startDate}" required />
        </div>

        <div class="form-group">
            <label for="endDate">End Date</label>
            <input type="date" id="endDate" name="endDate" value="${trip.endDate}" required />
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description" rows="4" placeholder="Enter trip description" required>${trip.description}</textarea>
        </div>

        <div class="form-group">
            <label for="image">Image URL</label>
            <input type="text" id="image" name="image" value="${trip.image}" placeholder="Enter image URL" required />
        </div>

        <div class="form-actions">
            <a href="${pageContext.request.contextPath}/manageTrips" class="btn btn-secondary">Cancel</a>
            <button type="submit" class="btn btn-primary">Save Changes</button>
        </div>
    </form>
</div>
</body>
</html>
