<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Trips - Admin Panel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Scoped styles for Manage Trips page */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: #f3f4f6;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 2rem;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .header h1 {
            font-size: 2rem;
            font-weight: bold;
            margin: 0;
            color: #2563eb;
        }

        .header a {
            background: #2563eb;
            color: #ffffff;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .header a:hover {
            background: #1e40af;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            overflow: hidden;
            border-radius: 8px;
        }

        .table th,
        .table td {
            padding: 1rem;
            text-align: left;
        }

        .table th {
            background: #f1f5f9;
            color: #1e293b;
            font-weight: bold;
        }

        .table td {
            background: #ffffff;
            color: #475569;
            vertical-align: middle;
        }

        .table tr:nth-child(even) td {
            background: #f8fafc;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn.edit {
            background: #2563eb;
            color: white;
        }

        .btn.delete {
            background: #ef4444;
            color: white;
        }

        .btn.edit:hover {
            background: #1e40af;
        }

        .btn.delete:hover {
            background: #dc2626;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: #64748b;
            font-size: 1.25rem;
        }

        .empty-state i {
            font-size: 3rem;
            color: #94a3b8;
            margin-bottom: 1rem;
        }

        /* Modal Styles */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
            text-align: center;
        }

        .modal h2 {
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }

        .modal p {
            margin-bottom: 1.5rem;
            color: #475569;
        }

        .modal .modal-actions {
            display: flex;
            justify-content: space-between;
            gap: 1rem;
        }

        .modal .btn {
            flex: 1;
            font-size: 1rem;
            padding: 0.75rem;
        }

        .modal .btn.cancel {
            background: #64748b;
        }

        .modal .btn.confirm {
            background: #ef4444;
        }

        .modal .btn.cancel:hover {
            background: #475569;
        }

        .modal .btn.confirm:hover {
            background: #dc2626;
        }

        .modal-overlay.show {
            display: flex;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const deleteForms = document.querySelectorAll(".delete-form");
            const modal = document.querySelector(".modal-overlay");
            const confirmBtn = document.querySelector(".btn.confirm");
            const cancelBtn = document.querySelector(".btn.cancel");
            let formToSubmit = null;

            deleteForms.forEach(form => {
                form.addEventListener("submit", e => {
                    e.preventDefault();
                    formToSubmit = form;
                    modal.classList.add("show");
                });
            });

            confirmBtn.addEventListener("click", () => {
                if (formToSubmit) formToSubmit.submit();
            });

            cancelBtn.addEventListener("click", () => {
                modal.classList.remove("show");
                formToSubmit = null;
            });
        });
    </script>
</head>
<body>
<jsp:include page="/header.jsp" />

<div class="container">
    <div class="header">
        <h1>Manage Trips</h1>
        <a href="${pageContext.request.contextPath}/addTrip"><i class="fas fa-plus-circle"></i> Add New Trip</a>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div style="color: red; margin-bottom: 1rem;">
            <i class="fas fa-exclamation-triangle"></i> ${error}
        </div>
    </c:if>

    <!-- Trips Table -->
    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Destination</th>
            <th>Price</th>
            <th>Slots</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="trip" items="${trips}">
            <tr>
                <td>${trip.id}</td>
                <td>${trip.name}</td>
                <td>${trip.destination}</td>
                <td>£${trip.price}</td>
                <td>${trip.slots}</td>
                <td>
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/editTrip?id=${trip.id}" class="btn edit">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <form action="${pageContext.request.contextPath}/manageTrips" method="post" class="delete-form">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${trip.id}">
                            <button type="submit" class="btn delete">
                                <i class="fas fa-trash-alt"></i> Delete
                            </button>
                        </form>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Empty State -->
    <c:if test="${empty trips}">
        <div class="empty-state">
            <i class="fas fa-info-circle"></i>
            <p>No trips available. Add a new trip to get started.</p>
        </div>
    </c:if>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal-overlay">
    <div class="modal">
        <h2>Confirm Deletion</h2>
        <p>Are you sure you want to delete this trip? This action cannot be undone.</p>
        <div class="modal-actions">
            <button class="btn cancel">Cancel</button>
            <button class="btn confirm">Confirm</button>
        </div>
    </div>
</div>
</body>
</html>
