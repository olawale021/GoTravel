<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Trips | Travel Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .trip-card {
            transition: transform 0.2s ease-in-out;
            border-left: 4px solid #0d6efd;
        }
        .trip-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .trip-icon {
            color: #0d6efd;
        }
        .empty-trips {
            min-height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8f9fa;
            border-radius: 10px;
        }
        .page-header {
            background-color: #f8f9fa;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-bottom: 1px solid #e9ecef;
        }
        .home-button {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .home-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body class="bg-light">
<div class="page-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col">
                <h1 class="display-4 fw-bold">
                    <i class="fas fa-plane-departure me-3 text-primary"></i>My Trips
                </h1>
                <p class="lead text-muted">View your travel itineraries</p>
            </div>
        </div>
    </div>
</div>

<div class="container mb-5">
    <c:if test="${not empty trips}">
        <div class="row row-cols-1 row-cols-md-2 g-4">
            <c:forEach var="trip" items="${trips}">
                <div class="col">
                    <div class="card trip-card h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h5 class="card-title mb-0 fw-bold">${trip.name}</h5>
                                <span class="badge bg-primary rounded-pill">
                                        ${trip.duration} days
                                    </span>
                            </div>
                            <div class="d-flex align-items-center">
                                <i class="fas fa-map-marker-alt trip-icon me-2"></i>
                                <p class="card-text text-muted mb-0">${trip.destination}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty trips}">
        <div class="empty-trips">
            <div class="text-center">
                <i class="fas fa-suitcase-rolling fa-3x text-muted mb-3"></i>
                <h3 class="text-muted">No Trips Found</h3>
                <p class="text-muted mb-4">You haven't booked any trips yet.</p>
                <a href="#" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Plan Your First Trip
                </a>
            </div>
        </div>
    </c:if>
</div>

<!-- Home Button -->
<a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg rounded-circle home-button"
   title="Back to Home">
    <i class="fas fa-home"></i>
</a>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>