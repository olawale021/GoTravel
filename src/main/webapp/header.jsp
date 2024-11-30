<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GoTravel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            background-color: #f9f9f9;
            color: #333;
        }


        header {
            background-color: white;
            border-bottom: 1px solid #ddd;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        nav {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 64px;
        }

        .brand {
            display: flex;
            align-items: center;
            text-decoration: none;
        }

        .brand i {
            color: #007bff;
            font-size: 1.5rem;
            margin-right: 0.5rem;
        }

        .brand h1 {
            font-size: 1.5rem;
            color: #007bff;
        }

        nav ul {
            display: flex;
            align-items: center;
            gap: 1rem;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        nav ul li {
            position: relative;
        }

        nav ul li a {
            text-decoration: none;
            color: #555;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 0.25rem;
            transition: background-color 0.3s, color 0.3s;
        }

        nav ul li a:hover {
            background-color: #007bff;
            color: white;
        }

        nav ul li .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: white;
            border-radius: 0.25rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            list-style: none;
            padding: 0.5rem 0;
            z-index: 1000;
            min-width: 150px;
        }

        nav ul li .dropdown-menu li {
            padding: 0;
        }

        nav ul li .dropdown-menu li a {
            padding: 0.5rem 1rem;
            color: #555;
            display: block;
            text-align: left;
            text-decoration: none;
        }

        nav ul li .dropdown-menu li a:hover {
            background-color: #f1f1f1;
            color: #333;
        }


        nav ul li:hover .dropdown-menu {
            display: block;
        }
        .dropdown > a {
            display: inline-block;
            position: relative;
            padding-right: 1rem;
        }

        .dropdown > a::after {
            content: '\f0d7'; /* FontAwesome down-arrow icon */
            font-family: 'Font Awesome 5 Free', serif;
            font-weight: 900;
            margin-left: 0.5rem;
            font-size: 0.75rem;
            color: #555;
            vertical-align: middle;
        }

        .dropdown:hover > a::after {
            color: #007bff;
        }

        .active {
            color: #007bff !important;
            background-color: #e9f4ff !important;
        }

        @media (max-width: 768px) {
            nav ul {
                flex-wrap: wrap;
                gap: 0.5rem;
            }

            .brand h1 {
                font-size: 1.2rem;
            }

            nav ul li a {
                padding: 0.5rem 0.75rem;
            }

        }
    </style>
</head>
<body>
<header>
    <nav>
        <a href="${pageContext.request.contextPath}/" class="brand">
            <i class="fas fa-plane"></i>
            <h1>GoTravel</h1>
        </a>
        <ul>
            <!-- Always visible links -->
            <li><a href="${pageContext.request.contextPath}/browseTrips">
                <i class="fas fa-globe"></i> Browse Trips
            </a></li>
            <li><a href="${pageContext.request.contextPath}/sales-prediction">
                <i class="fas fa-chart-line"></i> Predict Revenue
            </a></li>

            <!-- Conditional links based on user session -->
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <c:if test="${sessionScope.user.role != 'admin'}">
                        <li><a href="${pageContext.request.contextPath}/myTrips">
                            <i class="fas fa-suitcase"></i> My Trips
                        </a></li>
                    </c:if>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li><a href="${pageContext.request.contextPath}/manageBookings">
                            <i class="fas fa-tasks"></i> Manage Bookings
                        </a></li>
                        <li><a href="${pageContext.request.contextPath}/manageTrips">
                            <i class="fas fa-tasks"></i> Manage Trips
                        </a></li>
                        <li><a href="${pageContext.request.contextPath}/addTrip">
                            <i class="fas fa-tasks"></i> Add Trips
                        </a></li>
                    </c:if>
                    <li class="dropdown">
                        <a href="#">
                            <i class="fas fa-user-circle"></i> ${sessionScope.user.username}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/profile">
                                <i class="fas fa-user"></i> Profile
                            </a></li>
                            <li><a href="${pageContext.request.contextPath}/settings">
                                <i class="fas fa-cog"></i> Settings
                            </a></li>
                            <li><a href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a></li>
                        </ul>
                    </li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/login">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a></li>
                    <li><a href="${pageContext.request.contextPath}/register">
                        <i class="fas fa-user-plus"></i> Register
                    </a></li>
                </c:otherwise>
            </c:choose>

        </ul>
    </nav>
</header>

</body>
</html>
