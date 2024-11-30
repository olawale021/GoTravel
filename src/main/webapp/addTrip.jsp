<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Trip</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Scoped styles for Add Trip form */
        .add-trip-container {
            max-width: 800px;
            margin: 3rem auto;
            padding: 2rem;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            font-family: 'Segoe UI', Tahoma, sans-serif;
        }

        .add-trip-container h1 {
            font-size: 2rem;
            color: #2563eb;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .add-trip-container form {
            display: grid;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 600;
            color: #475569;
            margin-bottom: 0.5rem;
        }

        input, select, textarea, button {
            padding: 0.75rem 1rem;
            font-size: 1rem;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #f9fafb;
            transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #2563eb;
            outline: none;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.2);
        }

        button {
            background: #2563eb;
            color: #ffffff;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: background 0.2s ease-in-out, transform 0.2s ease-in-out;
        }

        button:hover {
            background: #1e40af;
            transform: translateY(-2px);
        }

        .success-message {
            color: #065f46;
            background: #d1fae5;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            text-align: center;
        }

        .error-message {
            color: #b91c1c;
            background: #fee2e2;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            text-align: center;
        }

        .header-placeholder {
            margin-bottom: 2rem;
        }

        @media (max-width: 768px) {
            .add-trip-container {
                padding: 1.5rem;
            }

            .add-trip-container h1 {
                font-size: 1.75rem;
            }

            button {
                padding: 0.75rem;
            }
        }
    </style>
</head>
<body>
<!-- Include the header JSP -->
<jsp:include page="/header.jsp" />

<!-- Add Trip Form Container -->
<div class="add-trip-container">
    <h1><i class="fas fa-plane-departure"></i> Add a New Trip</h1>

    <!-- Display success or error message -->
    <c:if test="${not empty message}">
        <div class="success-message">
            <i class="fas fa-check-circle"></i> ${message}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>

    <!-- Add Trip Form -->
    <form action="addTrip" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="name">Trip Name</label>
            <input type="text" id="name" name="name" placeholder="Enter trip name" required>
        </div>

        <div class="form-group">
            <label for="destination">Destination</label>
            <input type="text" id="destination" name="destination" placeholder="Enter destination" required>
        </div>

        <div class="form-group">
            <label for="duration">Duration (days)</label>
            <input type="number" id="duration" name="duration" placeholder="Enter duration in days" min="1" required>
        </div>

        <div class="form-group">
            <label for="price">Price (£)</label>
            <input type="number" id="price" name="price" placeholder="Enter price" step="0.01" required>
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description" rows="4" placeholder="Describe the trip"></textarea>
        </div>

        <div class="form-group">
            <label for="tripTypeId">Trip Type</label>
            <select id="tripTypeId" name="tripTypeId" required>
                <option value="" disabled selected>Select a trip type</option>
                <c:forEach var="tripType" items="${tripTypes}">
                    <option value="${tripType.id}">${tripType.name}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="startDate">Start Date</label>
            <input type="date" id="startDate" name="startDate" required>
        </div>

        <div class="form-group">
            <label for="endDate">End Date</label>
            <input type="date" id="endDate" name="endDate" required>
        </div>

        <div class="form-group">
            <label for="slots">Available Slots</label>
            <input type="number" id="slots" name="slots" placeholder="Enter available slots" min="1" required>
        </div>

        <div class="form-group">
            <label for="image">Upload Image</label>
            <input type="file" id="image" name="image" accept="image/*">
        </div>

        <button type="submit"><i class="fas fa-save"></i> Add Trip</button>
    </form>
</div>
</body>
</html>
