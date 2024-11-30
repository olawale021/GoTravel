package com.example.utils;

import weka.core.Instances;
import weka.core.DenseInstance;
import weka.core.converters.ArffLoader;
import weka.classifiers.functions.LinearRegression;
import weka.core.SerializationHelper;
import java.io.File;

public class SalesPrediction {
    public static void main(String[] args) {
        try {
            // Load ARFF file
            ArffLoader loader = new ArffLoader();
            loader.setFile(new File("/resources/sales_dataset.arff"));
            Instances dataset = loader.getDataSet();
            dataset.setClassIndex(3); // Set Revenue as class attribute

            // Build Linear Regression model
            LinearRegression model = new LinearRegression();
            model.buildClassifier(dataset);

            // Save the model and dataset structure
            SerializationHelper.write("/resources/sales_model.model", model);
            SerializationHelper.write("/resources/sales_header.arff", new Instances(dataset, 0));

            // Print model details
            System.out.println("Linear Regression Model:");
            System.out.println(model);
            System.out.println("\nModel saved successfully!");

            // Example predictions
            System.out.println("\nPredictions for 2024 with 10% increased advertising cost:");
            for (int i = 0; i < dataset.numInstances(); i++) {
                DenseInstance newInstance = new DenseInstance(4);
                newInstance.setDataset(dataset);
                newInstance.setValue(0, 2024); // Year
                newInstance.setValue(1, i + 1); // Month (1-12)
                double originalCost = dataset.instance(i).value(2);
                double increasedCost = originalCost * 1.1;
                newInstance.setValue(2, increasedCost);

                double predictedRevenue = model.classifyInstance(newInstance);
                System.out.printf("Month %d: Advertising Cost = %.2f, Predicted Revenue = %.2f%n",
                        i + 1, increasedCost, predictedRevenue);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}