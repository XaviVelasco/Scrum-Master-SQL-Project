# :mag_right: Data-Driven Sprint Forecasting with SQL

## :eye: Overview

As a Scrum Master, I recognized the need for more data-driven insights to optimize sprint planning and improve team efficiency. To achieve this, I developed a series of SQL queries to extract valuable information from historical sprint data.

## 🎯 Key Objectives

The primary objectives of this analysis were to:

- **Enhance sprint planning**: Provide myself with data-backed forecasts to accurately estimate team capacity and workload.
- **Identify performance trends**: Analyze historical data to uncover patterns, identify bottlenecks, and pinpoint areas for improvement.
- **Improve team efficiency**: Implement targeted strategies based on data-driven insights to enhance team performance.

To achieve these objectives, I formulated data-driven questions to guide my analysis:

1. Avg team's velocity
2. What is the trend in unplanned work across sprints?
3. What is the average completion rate of planned tasks across all sprints?

## 📖 Methodology:

- **Data Collection**: Gathered historical sprint data, including metrics such as team velocity, story points completed, unplanned tasks, and compliance rates.
- **Query Development**: Crafted SQL queries to extract relevant information from the data, focusing on key performance indicators and trends.
- **Data Analysis**: Analyzed the extracted data to identify patterns, correlations, and potential areas for optimization.

To analyze the effectiveness of sprint planning, I compared data from the _planned_ and _results_ tables using SQL queries in Google Cloud's _Big Query_. Each table column is described in detail below:

### PLANNED TABLE
| Column name | Column description |
|---|---|
| sprint_id (🔑) | Sprint Number | 
| hours |Hours that the team is available to develop in this sprint |
| planned_issues | Number of Issues or tasks that the team has planned to do in this sprint |
| planned_sp | Total of the Story Points the team has commited to do in this sprint |


### RESULTS TABLE
| Column name | Column description |
|---|---|
| sprint_id (🔑) | Sprint Number | 
| planned_issues_done | Number of issues done that were planned |
| unplanned_issues_done | Number of issues done that were NOT planned |
| bugs_issues | Total Amount of bug issues done during this sprint (planned or unplanned) |
| planned_sp_done	| Number of Story Points Done that were planned |
| unplanned_sp_done | Number of Story Points Done that were NOT planned |
| bugs_sp | SP of bugs done during this sprint (planned or unplanned) |

You can check the SQL file [here](https://github.com/XaviVelasco/).

> [!IMPORTANT]
> This data used is based on real scrum teams but has been deliberately modified.

## 📈 Expected Outcomes:

- **Improved sprint planning**: More accurate forecasts and resource allocation based on historical data.
- **Enhanced team performance**: Identification of areas for improvement and implementation of targeted strategies.
- **Data-driven decision-making**: A framework for making informed decisions based on evidence.

