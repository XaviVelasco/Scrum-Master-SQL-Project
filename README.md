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

To analyze the effectiveness of sprint planning, I compared data from the _planned_ and _results_ tables using SQL queries in Google Cloud's _Big Query_. Each table column is described in detail below:

### PLANNED TABLE
| Column name | Column description |
|---|---|
| Sprint | (Primary Key) Sprint Number | 
| Hours |Hours that the team is available to develop in this sprint |
| Planned Issues | Number of Issues or tasks that the team has planned to do in this sprint |
| Planned SP | Total of the Story Points the team has commited to do in this sprint |


### RESULTS TABLE
| Column name | Column description |
|---|---|
| Sprint | (Primary Key) Sprint Number | 
| Planned Issues Done | Number of issues done that were planned |
| Unplanned Issues Done | Number of issues done that were NOT planned |
| Bugs (Issues) | Total Amount of bug issues done during this sprint (planned or unplanned) |
| Planned SP Done	| Number of Story Points Done that were planned |
| Unplanned SP Done | Number of Story Points Done that were NOT planned |
| Bugs (SP) | SP of bugs done during this sprint (planned or unplanned) |

You can check the SQL file [here](https://github.com/XaviVelasco/).

> [!IMPORTANT]
> This data used is based on real scrum teams but has been deliberately modified.

## 📈 Expected Outcomes:

- **Improved sprint planning**: More accurate forecasts and resource allocation based on historical data.
- **Enhanced team performance**: Identification of areas for improvement and implementation of targeted strategies.
- **Data-driven decision-making**: A framework for making informed decisions based on evidence.

## 🛠️ Tools and Technologies:

SQL (e.g., PostgreSQL, MySQL, SQL Server)

## :abacus: Skills and formulas used

