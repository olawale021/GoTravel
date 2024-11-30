<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to GoTravel</title>
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
            --success: #10b981;
            --warning: #f59e0b;
            --error: #ef4444;
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

        /* Hero Section */
        .hero {
            position: relative;
            min-height: 600px;
            background: linear-gradient(
                    to right,
                    rgba(37, 99, 235, 0.9),
                    rgba(14, 165, 233, 0.85)
            ),
            url('/api/placeholder/1920/600') center/cover;
            display: flex;
            align-items: center;
            overflow: hidden;
        }

        .hero-container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 4rem 2rem;
            width: 100%;
            color: white;
        }

        .hero-content {
            max-width: 650px;
            animation: fadeInUp 0.8s ease;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 1.5rem;
            letter-spacing: -0.02em;
        }

        .hero-subtitle {
            font-size: 1.25rem;
            opacity: 0.9;
            margin-bottom: 2.5rem;
            max-width: 600px;
            line-height: 1.8;
        }

        /* Features Section */
        .features {
            padding: 5rem 2rem;
            background: var(--background);
        }

        .features-container {
            max-width: 1280px;
            margin: 0 auto;
        }

        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .section-title h2 {
            font-size: 2.5rem;
            color: var(--text);
            margin-bottom: 1rem;
            font-weight: 700;
        }

        .section-title p {
            color: var(--text-secondary);
            font-size: 1.125rem;
            max-width: 600px;
            margin: 0 auto;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            padding: 2rem 0;
        }

        .feature-card {
            background: var(--background);
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1),
            0 2px 4px -1px rgba(0, 0, 0, 0.06);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            cursor: pointer;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1),
            0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        .feature-icon {
            width: 3.5rem;
            height: 3.5rem;
            background: var(--primary);
            color: white;
            border-radius: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .feature-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--text);
        }

        .feature-description {
            color: var(--text-secondary);
            line-height: 1.7;
        }

        /* CTA Section */
        .cta-section {
            background: var(--surface);
            padding: 5rem 2rem;
        }

        .cta-container {
            max-width: 1280px;
            margin: 0 auto;
            text-align: center;
        }

        .cta-box {
            background: white;
            padding: 3rem;
            border-radius: 1.5rem;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
            margin-top: 3rem;
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem 2rem;
            border-radius: 0.75rem;
            font-weight: 600;
            font-size: 1rem;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }
        .hero-search-form {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .search-input {
            flex: 1;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            border: 2px solid var(--primary);
            border-radius: 0.5rem;
            outline: none;
        }

        .search-input:focus {
            border-color: var(--primary-dark);
            box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.25);
        }

        .btn-primary {
            background: var(--primary);
            color: white;
            border: 2px solid var(--primary);
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            border-color: var(--primary-dark);
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

        /* Stats Section */
        .stats-section {
            padding: 4rem 2rem;
            background: linear-gradient(to right, var(--primary), var(--accent));
            color: white;
        }

        .stats-grid {
            max-width: 1280px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            text-align: center;
        }

        .stat-item {
            padding: 1.5rem;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 1rem;
            opacity: 0.9;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }

            .hero-subtitle {
                font-size: 1.125rem;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/header.jsp" />

<!-- Hero Section -->
<section class="hero">
    <div class="hero-container">
        <div class="hero-content">
            <h1 class="hero-title">Your Journey Begins with GoTravel</h1>
            <p class="hero-subtitle">
                Discover extraordinary destinations, create unforgettable memories, and experience the world with confidence.
            </p>

            <!-- Search Form -->
            <form action="${pageContext.request.contextPath}/browseTrips" method="get" class="hero-search-form">
                <input type="text" name="search" placeholder="Search destinations, trips, or activities..." class="search-input" value="${param.search}" />
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i> Search
                </button>
            </form>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/browseTrips" class="btn btn-primary">
                            <i class="fas fa-compass"></i> Explore Destinations
                        </a>
                        <a href="${pageContext.request.contextPath}/myTrips" class="btn btn-secondary">
                            <i class="fas fa-suitcase"></i> View My Trips
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> Start Your Journey
                        </a>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">
                            <i class="fas fa-sign-in-alt"></i> Sign In
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>


    </div>
</section>


<!-- Stats Section -->
<section class="stats-section">
    <div class="stats-grid">
        <div class="stat-item">
            <div class="stat-number">50K+</div>
            <div class="stat-label">Happy Travelers</div>
        </div>
        <div class="stat-item">
            <div class="stat-number">100+</div>
            <div class="stat-label">Destinations</div>
        </div>
        <div class="stat-item">
            <div class="stat-number">4.8</div>
            <div class="stat-label">Average Rating</div>
        </div>
        <div class="stat-item">
            <div class="stat-number">24/7</div>
            <div class="stat-label">Support</div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="features">
    <div class="features-container">
        <div class="section-title">
            <h2>Why Choose GoTravel</h2>
            <p>Experience the difference with our premium travel services and dedicated support</p>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-globe-americas"></i>
                </div>
                <h3 class="feature-title">Curated Destinations</h3>
                <p class="feature-description">
                    Explore handpicked destinations worldwide, each vetted for quality and authenticity to ensure exceptional travel experiences.
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h3 class="feature-title">Secure Booking</h3>
                <p class="feature-description">
                    Book with confidence using our secure payment system. Every transaction is protected and guaranteed.
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-headset"></i>
                </div>
                <h3 class="feature-title">24/7 Support</h3>
                <p class="feature-description">
                    Our dedicated support team is always ready to assist you before, during, and after your journey.
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-tag"></i>
                </div>
                <h3 class="feature-title">Best Value</h3>
                <p class="feature-description">
                    Get the best deals on flights, accommodations, and experiences with our price match guarantee.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
    <div class="cta-container">
        <div class="cta-box">
            <h2>Ready to Start Your Adventure?</h2>
            <p style="color: var(--text-secondary); margin: 1rem 0;">
                Join thousands of satisfied travelers who have chosen GoTravel for their journeys.
            </p>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/trips" class="btn btn-primary">
                            <i class="fas fa-search"></i> Find Your Next Trip
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">
                            <i class="fas fa-user-plus"></i> Create Free Account
                        </a>
                        <a href="${pageContext.request.contextPath}/about" class="btn btn-secondary">
                            <i class="fas fa-info-circle"></i> Learn More
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>
</body>
</html>