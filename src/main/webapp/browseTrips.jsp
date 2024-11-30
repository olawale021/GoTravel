<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Trips - GoTravel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #2563eb;
            --primary-dark: #1e40af;
            --secondary: #64748b;
            --accent: #0ea5e9;
            --background: #ffffff;
            --surface: #f8fafc;
            --text: #0f172a;
            --text-secondary: #475569;
            --border: #e2e8f0;
            --success: #10b981;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        body {
            background-color: var(--surface);
            color: var(--text);
            line-height: 1.6;
        }

        /* Page Container */
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Page Header */
        .page-header {
            margin-bottom: 2rem;
            text-align: center;
            padding: 1.5rem 0; /* Reduced padding */
            background: linear-gradient(to right, var(--primary), var(--accent));
            color: white;
        }

        .page-title {
            font-size: 2rem; /* Reduced font size */
            font-weight: 700;
            margin-bottom: 0.5rem; /* Adjusted margin */
        }

        .page-subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.9rem; /* Reduced font size */
            max-width: 600px;
            margin: 0 auto;
        }


        /* Filters Section */
        .filters {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            align-items: center;
            background: white;
            padding: 1rem;
            border-radius: 1rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .filter-input {
            flex: 1;
            min-width: 200px;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border);
            border-radius: 0.5rem;
            font-size: 0.875rem;
        }

        .filter-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        /* Trips Grid */
        /* Trips Grid */
        .trips-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); /* Reduced min-width */
            gap: 1.5rem; /* Reduced gap */
            margin-top: 2rem;
        }

        .trip-card {
            background: white;
            border-radius: 0.75rem;
            overflow: hidden;
            box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            height: 380px; /* Reduced height */
        }

        .trip-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 12px -3px rgba(0, 0, 0, 0.1);
        }

        .trip-image {
            width: 100%;
            height: 120px; /* Reduced height */
            object-fit: cover;
        }

        .trip-content {
            padding: 0.75rem; /* Reduced padding */
            height: calc(100% - 120px); /* Adjust height based on image */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* Ensure footer aligns at the bottom */
        }

        .trip-description {
            color: var(--text-secondary);
            font-size: 0.8rem;
            margin-bottom: 0.5rem; /* Reduced margin */
            display: -webkit-box;
            -webkit-line-clamp: 2; /* Reduced number of lines */
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .trip-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 0.5rem; /* Reduced padding */
            border-top: 1px solid var(--border);
        }

        .trip-price {
            font-size: 1rem; /* Reduced font size */
            font-weight: 600;
            color: var(--primary);
        }

        .book-btn {
            background: var(--primary);
            color: white;
            padding: 0.4rem 0.8rem; /* Reduced padding */
            border-radius: 0.4rem; /* Smaller border radius */
            text-decoration: none;
            font-weight: 500;
            font-size: 0.8rem; /* Reduced font size */
            transition: all 0.2s ease;
        }

        .book-btn:hover {
            background: var(--primary-dark);
        }


        .slots-available {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.25rem 0.75rem;
            background: #ecfdf5;
            color: var(--success);
            border-radius: 1rem;
            font-size: 0.75rem;
            font-weight: 500;
        }

        /* Error Message */
        .error-message {
            background: #fee2e2;
            color: #dc2626;
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 3rem;
            color: var(--secondary);
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .trips-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/header.jsp" />

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <h1 class="page-title">Discover Amazing Trips</h1>
        <p class="page-subtitle">Explore our handpicked selection of extraordinary destinations</p>
    </div>
</div>

<div class="container">
    <!-- Filters -->
    <div class="filters">
        <form action="${pageContext.request.contextPath}/browseTrips" method="get">
            <input type="text" name="search" class="filter-input" placeholder="Search destinations..." value="${param.search}">
            <input type="number" name="maxPrice" class="filter-input" placeholder="Max price" value="${param.maxPrice}">
            <select name="duration" class="filter-input">
                <option value="">Duration</option>
                <option value="1-3" ${param.duration == '1-3' ? 'selected' : ''}>1-3 days</option>
                <option value="4-7" ${param.duration == '4-7' ? 'selected' : ''}>4-7 days</option>
                <option value="8+" ${param.duration == '8+' ? 'selected' : ''}>8+ days</option>
            </select>
            <button type="submit" class="book-btn">Apply Filters</button>
        </form>
        <a href="${pageContext.request.contextPath}/browseTrips" class="btn btn-secondary">
            <i class="fas fa-times-circle"></i> Clear Filters
        </a>
    </div>


    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i>
                ${error}
        </div>
    </c:if>

    <!-- Trips Grid -->
    <div class="trips-grid">
        <c:forEach var="trip" items="${trips}">
            <div class="trip-card">
                <img src="${not empty trip.image ? trip.image : '/api/placeholder/400/200'}"
                     alt="${trip.name}"
                     class="trip-image">
                <div class="trip-content">
                    <h3 class="trip-title">${trip.name}</h3>
                    <div class="trip-info">
                        <div class="info-item">
                            <i class="fas fa-map-marker-alt"></i>
                                ${trip.destination}
                        </div>
                        <div class="info-item">
                            <i class="fas fa-clock"></i>
                                ${trip.duration} days
                        </div>
                        <div class="info-item">
                            <i class="fas fa-users"></i>
                            <span class="slots-available">
                                    <i class="fas fa-check-circle"></i>
                                    ${trip.slots} slots left
                                </span>
                        </div>
                    </div>
                    <p class="trip-description">${trip.description}</p>
                    <div class="trip-footer">
                        <div class="trip-price">£${trip.price}</div>
                        <a href="${pageContext.request.contextPath}/tripDetails?id=${trip.id}" class="book-btn">
                            View Details
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Empty State -->
    <c:if test="${empty trips}">
        <div class="empty-state">
            <i class="fas fa-compass"></i>
            <h2>No Trips Available</h2>
            <p>We're currently preparing new and exciting destinations for you.<br>Please check back later!</p>
        </div>
    </c:if>
</div>
</body>
</html>