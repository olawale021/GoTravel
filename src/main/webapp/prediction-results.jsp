<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Prediction Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Prediction Results</h2>

    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Predicted Revenue for <%= request.getAttribute("month") %></h5>

            <table class="table table-bordered mt-3">
                <thead>
                <tr>
                    <th>Metric</th>
                    <th>Value</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Map<String, Double> prediction = (Map<String, Double>) request.getAttribute("prediction");
                    String[] months = {"January", "February", "March", "April", "May", "June",
                            "July", "August", "September", "October", "November", "December"};

                    for (Map.Entry<String, Double> entry : prediction.entrySet()) {
                        String key = entry.getKey();
                        Double value = entry.getValue();
                %>
                <tr>
                    <td><%= key %></td>
                    <td>
                        <% if (key.equals("Year")) { %>
                        <%= value.intValue() %>
                        <% } else if (key.equals("Month")) { %>
                        <%= months[value.intValue() - 1] %>
                        <% } else { %>
                        $<%= String.format("%,.2f", value) %>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>

            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/sales-prediction" class="btn btn-primary">Make Another Prediction</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>