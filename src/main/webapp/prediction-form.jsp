<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sales Revenue Prediction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Sales Revenue Prediction</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <div class="card">
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/sales-prediction" method="post">
                <div class="mb-3">
                    <label for="year" class="form-label">Year:</label>
                    <input type="number" class="form-control" id="year" name="year" value="2024" required>
                </div>

                <div class="mb-3">
                    <label for="month" class="form-label">Month:</label>
                    <select class="form-select" id="month" name="month" required>
                        <option value="1">January</option>
                        <option value="2">February</option>
                        <option value="3">March</option>
                        <option value="4">April</option>
                        <option value="5">May</option>
                        <option value="6">June</option>
                        <option value="7">July</option>
                        <option value="8">August</option>
                        <option value="9">September</option>
                        <option value="10">October</option>
                        <option value="11">November</option>
                        <option value="12">December</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="advertisingCost" class="form-label">Advertising Cost:</label>
                    <input type="number" step="0.01" class="form-control" id="advertisingCost" name="advertisingCost" required>
                </div>

                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="increase10Percent" name="increase10Percent" value="true">
                    <label class="form-check-label" for="increase10Percent">Increase advertising cost by 10%</label>
                </div>

                <button type="submit" class="btn btn-primary">Predict Revenue</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>