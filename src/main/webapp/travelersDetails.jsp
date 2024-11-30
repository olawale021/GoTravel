<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Traveler Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8fafc;
            margin: 0;
            padding: 0;
            color: #0f172a;
        }

        .container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #2563eb;
            font-size: 1.8rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #e2e8f0;
            border-radius: 0.5rem;
            font-size: 1rem;
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
    <h1>Add Traveler Details</h1>
    <form action="${pageContext.request.contextPath}/addTravelers" method="post">
        <input type="hidden" name="bookingId" value="${booking.id}">
        <c:forEach var="i" begin="1" end="${booking.travelersCount}">
            <div class="form-group">
                <label for="traveler-${i}">Traveler ${i} Name:</label>
                <input type="text" id="traveler-${i}" name="travelerNames" required>
            </div>
        </c:forEach>
        <button type="submit" class="btn">Submit</button>
    </form>
</div>
</body>
</html>
