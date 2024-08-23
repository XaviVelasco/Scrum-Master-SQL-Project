# 📊 Scrum Master's SQL queries

## :eye: Overview

As a Scrum Master, I developed this dashboard to monitor and manage the performance of the development team. I have continuously adapted and added new features and visualizations as needed. Currently, I update the dashboard whenever I require new insights or need to analyze data for forecasting.

This Excel workbook offers a comprehensive overview of a Scrum team's performance, organized into three worksheets:

- Sprint_details
- Data 
- Pivot Tables
- Dashboard

You can check the Excel file [here](https://github.com/XaviVelasco/Scrum-Master-Excel-Dashboard/blob/edf5446b645b270483108baeb54e9e1fd64d4e51/Excel%20-%20Scrum%20Master%20Dashboard.xlsx).

***

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

<kbd>![SM Excel Dashboard - Sprint_details](https://github.com/XaviVelasco/Scrum-Master-Excel-Dashboard/blob/7b672422b64f23ce5f58c4dfe3f2107d1c6df52a/assets/img/SM%20Excel%20Dashboard%20-%20Data%20table.png)

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
