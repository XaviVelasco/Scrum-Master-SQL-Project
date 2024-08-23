# :mag_right: Data-Driven Sprint Forecasting with SQL

## :eye: Overview

As a Scrum Master, I recognized the need for more data-driven insights to optimize sprint planning and improve team efficiency. To achieve this, I developed a series of SQL queries to extract valuable information from historical sprint data.

## 🔑 Key Objectives

- **Enhance sprint planning**: Provide myself with data-backed forecasts to accurately estimate team capacity and workload.
- **Identify performance trends**: Analyze historical data to uncover patterns, identify bottlenecks, and pinpoint areas for improvement.
- **Improve team efficiency**: Implement targeted strategies based on data-driven insights to enhance team performance.

## 📖 Methodology:

- **Data Collection**: Gathered historical sprint data, including metrics such as team velocity, story points completed, unplanned tasks, and compliance rates.
- **Query Development**: Crafted SQL queries to extract relevant information from the data, focusing on key performance indicators and trends.
- **Data Analysis**: Analyzed the extracted data to identify patterns, correlations, and potential areas for optimization.

You can check the SQL file [here](https://github.com/XaviVelasco/).

## 📈 Expected Outcomes:

- **Improved sprint planning**: More accurate forecasts and resource allocation based on historical data.
- **Enhanced team performance**: Identification of areas for improvement and implementation of targeted strategies.
- **Data-driven decision-making**: A framework for making informed decisions based on evidence.

## 🛠️ Tools and Technologies:

SQL (e.g., PostgreSQL, MySQL, SQL Server)
Data visualization tools (optional, e.g., Tableau, Power BI)
Version control (e.g., Git)

## :abacus: Skills and formulas used

This project demonstrates a range of data analysis skills that are crucial for understanding the performance of a Scrum team, including data cleaning, aggregation, and visualization, as well as the application of various Excel formulas and tools. Below is a detailed breakdown of the skills and specific Excel functions utilized:

- **Data Management**:
     - Data Backup and Handling: Ensuring data integrity by maintaining backup sheets.
     - Manual Data Entry and Validation: Ensuring that all sprint data is accurately entered and validated, eliminating errors that could affect calculations and visualizations.
     - Data Cleaning: Preparing the raw data for analysis, removing inconsistencies and ensuring accuracy.
     - Data Structuring: Organizing data in a table format with clear headers and consistent data types, making it easier to analyze and create pivot tables. Cross-sheet references to ensure that the data is always consistent.
     - Conditional Formatting: To highlight key performance indicators (KPIs) and other important data points visually.


- **Analytical Skills**:
     - PivotTables: Used to dynamically summarize data, allowing for quick analysis of key metrics across different sprints.
     - Filtering and Slicing: Pivot tables enable quick filtering of data by sprint, issue type, or any other relevant category, which helps in identifying trends and making data-driven decisions.

- **Visualization Skills**:

     - Dashboard Creation: Crafting a dashboard that visualizes key metrics and trends, making complex data easily understandable.
     - Conditional Formatting: Used to highlight important data points, such as compliance rates and sprint performance, providing quick visual cues.

- **Formulas and Functions**:

     - This Excel contains advanced use of Excel functions such as VLOOKUP, SUM, AVERAGE, ROUNDUP, and arithmetic operations to process and analyze the data.

***

## :spiral_notepad: Worksheet explanation

### Sprint_details

This Excel sheet is used to manually enter new data observed in the sprints, which will then be used for the rest of the tables and the creation of the team's control dashboard.
Below you can find the description of the data (columns) used in this sheet:

| Column name | Column description |
|---|---|
| Sprint | Sprint Number | 
| Hours |Hours that the team is available to develop in this sprint |
| Planned Issues | Number of Issues or tasks that the team has planned to do in this sprint |
| Planned SP | Total of the Story Points the team has commited to do in this sprint |
| Planned Issues Done | Number of issues done that were planned |
| Unplanned Issues Done | Number of issues done that were NOT planned |
| Bugs (Issues) | Total Amount of bug issues done during this sprint (planned or unplanned) |
| Planned SP Done	| Number of Story Points Done that were planned |
| Unplanned SP Done | Number of Story Points Done that were NOT planned |
| Bugs (SP)	| SP of bugs done during this sprint (planned or unplanned) |

> [!IMPORTANT]
> This data used is based on real scrum teams but has been deliberately modified.

> [!NOTE]
> The *referenced* data is obtained from the *Sprint_details* sheet.

***
