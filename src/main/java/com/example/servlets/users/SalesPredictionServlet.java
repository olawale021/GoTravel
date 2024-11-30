package com.example.servlets.users;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import weka.classifiers.functions.LinearRegression;
import weka.core.DenseInstance;
import weka.core.Instances;
import weka.core.SerializationHelper;
import weka.core.converters.ArffLoader;
import java.io.File;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/sales-prediction")
public class SalesPredictionServlet extends HttpServlet {
    private LinearRegression model;
    private Instances datasetStructure;

    @Override
    public void init() throws ServletException {
        try {
            // Resolve ARFF file path
            String arffPath = getServletContext().getRealPath("/WEB-INF/sales_dataset.arff");
            System.out.println("Resolved ARFF Path: " + arffPath);

            // Validate file existence
            File arffFile = new File(arffPath);
            if (!arffFile.exists()) {
                throw new ServletException("ARFF file not found at: " + arffPath);
            }

            // Load ARFF file
            ArffLoader loader = new ArffLoader();
            loader.setFile(arffFile);
            Instances dataset = loader.getDataSet();
            dataset.setClassIndex(dataset.numAttributes() - 1); // Set last attribute as class (Revenue)

            // Save dataset structure for predictions
            datasetStructure = new Instances(dataset, 0);

            // Train model
            model = new LinearRegression();
            model.buildClassifier(dataset);

            // Save the model
            String modelPath = getServletContext().getRealPath("/WEB-INF/sales_model.model");
            System.out.println("Model will be saved to: " + modelPath);
            SerializationHelper.write(modelPath, model);

        } catch (Exception e) {
            throw new ServletException("Failed to initialize sales prediction model", e);
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the prediction form page
        request.getRequestDispatcher("prediction-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get parameters from request
            int year = Integer.parseInt(request.getParameter("year"));
            int month = Integer.parseInt(request.getParameter("month")); // Changed to parse as integer
            double advertisingCost = Double.parseDouble(request.getParameter("advertisingCost"));
            boolean increaseBy10Percent = "true".equals(request.getParameter("increase10Percent"));

            if (increaseBy10Percent) {
                advertisingCost *= 1.1; // Increase by 10%
            }

            // Make prediction
            DenseInstance instance = new DenseInstance(4);
            instance.setDataset(datasetStructure);
            instance.setValue(0, year);
            instance.setValue(1, month); // Using numeric month value
            instance.setValue(2, advertisingCost);

            double predictedRevenue = model.classifyInstance(instance);

            // Store results
            Map<String, Double> prediction = new LinkedHashMap<>();
            prediction.put("Year", (double) year);
            prediction.put("Month", (double) month);
            prediction.put("Advertising Cost", advertisingCost);
            prediction.put("Predicted Revenue", predictedRevenue);

            // Add results to request
            request.setAttribute("prediction", prediction);
            request.setAttribute("month", getMonthName(month)); // Convert numeric month to name

            // Forward to results page
            request.getRequestDispatcher("prediction-results.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Error making prediction: " + e.getMessage());
            request.getRequestDispatcher("prediction-form.jsp").forward(request, response);
        }
    }

    // Helper method to convert numeric month to name
    private String getMonthName(int month) {
        String[] months = {"January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"};
        return months[month - 1]; // Adjust for 0-based array
    }
}