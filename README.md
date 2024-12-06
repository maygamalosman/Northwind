EADME: Northwind Performance Dashboard Project
![Uploading North Wind.jpg…]()

Project Overview

This project analyzes the Northwind Traders Database, providing insights into sales performance, customer behavior, product trends, employee contributions, shipping efficiency, and overall financial metrics. A dynamic dashboard is created using Power BI or Excel, showcasing KPIs and charts for key metrics to support data-driven decision-making.
Data Source

The project uses the Northwind Traders Database, which includes:

    Suppliers
    Customers
    Employees
    Products
    Orders and Order Details
    Shippers

Key Insights and Metrics
1. Overview Report

    KPIs:
        Net Sales: Sum of sales after discounts.
        Count of Customers: Total unique customers.
        Count of Orders: Total sales transactions.
        Average Days to Ship Orders: Average shipping duration.

    Charts:
        Net Sales Over Time (Monthly).
        Top 5 Customers and Products by Net Sales.
        Net Sales by Country (with optional geographic map visualization).

2. Revenue Report

    KPIs:
        Net Profit: Profit calculated as 7% of net sales.
        Total Discounts: Total value of discounts applied.
        Shipping Costs: Aggregated shipping fees.

    Charts:
        Top 5 Countries by Net Sales.
        Net Sales, Profits, and Discounts Over Time.
        Top 5 Countries by Discounts.

    Pivot Table:
        Net Sales, Profits, and Discounts YoY per Country.

3. Customers Report

    Metrics:
        Average Net Sales, Profit, and Shipping Cost per Customer.
        New vs. Loyal Customers (based on purchasing history).

    Charts:
        Count of Customers Over Time.
        Customer Distribution by Country.

4. Products Report

    Metrics:
        Average Net Sales, Profit, and Shipping Cost per Order.
        Product and Category Count.
        Percentage of Discontinued vs. Active Products.

    Charts:
        Top 5 Products by Net Sales.
        Net Sales and Profits by Category.

5. Employees Report

    Metrics:
        Net Sales and Order Count per Employee.
        Average Sales and Profits per Employee.
        Employee Delayed vs. On-Time Orders.

    Charts:
        Monthly Net Sales by Employees.
        Performance: Count of Orders and Sales per Employee.

6. Shippers Report

    Metrics:
        Shipping Costs by Order, Country, and Shipper.
        Average Days to Ship.
        Delivery Performance: On-Time vs. Delayed Orders.

    Charts:
        Shipping Costs by Shippers.
        On-Time vs. Delayed Orders by Shipper.

How to Use

    Load Data: Import the Northwind Database into Power BI or Excel.
    SQL Queries: Run the SQL scripts provided to extract and preprocess the data.
    Transform Data: Use Power Query (in Power BI/Excel) to clean and structure the data.
    Visualizations:
        Use Power BI: Create tables, charts, and maps using DAX measures for KPIs.
        Use Excel: Pivot Tables, slicers, and conditional formatting for dashboards.

Key Features of the Dashboard

    Interactivity: Filter by time, customers, countries, employees, and shippers.
    Dynamic Visuals: Charts, maps, and KPIs updated with each interaction.
    Export Options: Easily export insights as reports or images.

File Structure

    SQL Queries: Scripts to generate views and extract insights.
    Power BI/Excel File: Dashboard file containing visuals and calculated fields.
    README.md: Guide to understanding and using the project.

Future Enhancements

    Add predictive models for sales forecasting.
    Integrate more advanced performance metrics for employees and shippers.
    Implement more detailed customer segmentation for targeted strategies.

Getting Started

    Clone the repository:

    git clone https://github.com/<username>/Northwind-Performance-Dashboard.git

    Open the provided SQL scripts and execute them in your database.
    Open the Power BI or Excel file and connect it to your data source.
    Explore the insights and customize as needed.

Requirements

    Software:
        Power BI or Excel (2019+).
        SQL Server or compatible database engine.
    Skills:
        Basic SQL knowledge.
        Familiarity with data visualization tools.
