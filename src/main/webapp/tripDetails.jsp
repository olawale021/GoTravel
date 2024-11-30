<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${trip.name} - GoTravel</title>
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
            --error: #ef4444;
            --warning: #f59e0b;
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

        /* Page Header */
        .page-header {
            background: linear-gradient(to right, var(--primary), var(--accent));
            color: white;
            padding: 1.5rem 0 3rem; /* Reduced padding */
            margin-bottom: -1.5rem; /* Adjusted margin */
        }

        .page-title {
            font-size: 2rem; /* Reduced font size */
            font-weight: 700;
            margin-bottom: 0.5rem;
        }


        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .breadcrumb {
            display: flex;
            gap: 0.5rem;
            align-items: center;
            margin-bottom: 1rem;
            color: rgba(255, 255, 255, 0.9);
        }

        .breadcrumb a {
            color: white;
            text-decoration: none;
        }

        /* Main Content */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem 4rem;
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            position: relative;
        }

        /* Trip Details Card */
        .trip-details {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .trip-gallery {
            position: relative;
            height: 400px;
            overflow: hidden;
        }

        .trip-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .image-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
            padding: 2rem;
            color: white;
        }

        .trip-content {
            padding: 2rem;
        }

        .trip-description {
            color: var(--text-secondary);
            font-size: 1.1rem;
            line-height: 1.8;
            margin: 2rem 0;
        }

        /* Trip Info Sidebar */
        .trip-sidebar {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            height: auto;
            position: sticky;
            top: 1rem;
        }


        .price-tag {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        .info-grid {
            display: grid;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: var(--surface);
            border-radius: 0.75rem;
            transition: transform 0.2s ease;
        }

        .info-item:hover {
            transform: translateY(-2px);
        }

        .info-icon {
            width: 2.5rem;
            height: 2.5rem;
            background: white;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 1.2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 0.875rem;
            color: var(--text-secondary);
            margin-bottom: 0.25rem;
        }

        .info-value {
            font-weight: 600;
            color: var(--text);
        }

        /* Availability Badge */
        .availability {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 2rem;
        }

        .availability.available {
            background: #ecfdf5;
            color: var(--success);
        }

        .availability.limited {
            background: #fff7ed;
            color: var(--warning);
        }

        /* Buttons */
        .action-buttons {
            display: grid;
            gap: 1rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 1rem;
            border-radius: 0.75rem;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
        }

        .btn-secondary {
            background: white;
            color: var(--primary);
            border: 2px solid var(--primary);
        }

        .btn-secondary:hover {
            background: var(--surface);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.1);
        }

        /* Error Message */
        .error-message {
            background: #fee2e2;
            color: var(--error);
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        @media (max-width: 1024px) {
            .container {
                grid-template-columns: 1fr;
            }

            .trip-sidebar {
                position: static;
            }
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 2rem 0 4rem;
                margin-bottom: -2rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .trip-gallery {
                height: 300px;
            }

            .container {
                padding: 0 1rem 2rem;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/header.jsp" />

<!-- Page Header -->
<div class="page-header">
    <div class="header-content">
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <i class="fas fa-chevron-right"></i>
            <a href="${pageContext.request.contextPath}/browseTrips">Trips</a>
            <i class="fas fa-chevron-right"></i>
            <span>${trip.name}</span>
        </div>
        <h1 class="page-title">${trip.name}</h1>
        <p>${trip.destination}</p>
    </div>
</div>

<!-- Main Content -->
<c:if test="${not empty trip}">
    <div class="container">
        <!-- Trip Details -->
        <div class="trip-details">
            <div class="trip-gallery">
                <img src="${not empty trip.image ? trip.image : '/api/placeholder/800/400'}"
                     alt="${trip.name}"
                     class="trip-image">
                <div class="image-overlay">
                    <h2>${trip.destination}</h2>
                    <p>${trip.duration} days journey</p>
                </div>
            </div>
            <div class="trip-content">
                <p class="trip-description">${trip.description}</p>
            </div>
        </div>

        <!-- Trip Sidebar -->
        <div class="trip-sidebar">
            <div class="price-tag">$${trip.price}</div>

            <c:choose>
                <c:when test="${trip.slots > 10}">
                    <div class="availability available">
                        <i class="fas fa-check-circle"></i>
                        Available (${trip.slots} slots left)
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="availability limited">
                        <i class="fas fa-clock"></i>
                        Only ${trip.slots} slots left!
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="info-grid">
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Duration</div>
                        <div class="info-value">${trip.duration} days</div>
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-plane-departure"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Departure</div>
                        <div class="info-value">${trip.startDate}</div>
                    </div>
                </div>
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-plane-arrival"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">Return</div>
                        <div class="info-value">${trip.endDate}</div>
                    </div>
                </div>
            </div>

            <!-- Form to collect number of travelers -->
            <form action="${pageContext.request.contextPath}/book-trip" method="get" class="action-buttons">
                <input type="hidden" name="id" value="${trip.id}">
                <label for="travelers" style="display: block; margin-bottom: 0.5rem;">Number of Travelers:</label>
                <input type="number" id="travelers" name="travelers" class="filter-input"
                       min="1" max="${trip.slots}" value="1" required style="margin-bottom: 1rem;">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-ticket-alt"></i>
                    Book Now
                </button>
            </form>
            <a href="${pageContext.request.contextPath}/browseTrips" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i>
                Back to Trips
            </a>
        </div>

    </div>
</c:if>
</body>
</html>