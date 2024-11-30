<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Traveler Details Confirmation</title>
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

        p {
            margin: 1rem 0;
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
    <h1>Success!</h1>
    <p>${message}</p>
    <a href="${pageContext.request.contextPath}/" class="btn">Back to Home</a>
</div>
</body>
</html>
