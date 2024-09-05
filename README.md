# :mag_right: Data-Driven Sprint Forecasting with SQL

[Overview](#overview) · [Key Objectives](#key-objectives) · [Methodology](#methodology)

***

## :eye: Overview

As a Scrum Master, I recognized the need for more data-driven insights to optimize sprint planning and improve team efficiency. To achieve this, I developed a series of SQL queries to extract valuable information from historical sprint data.

## 🎯 Key Objectives

The primary objectives of this analysis were to:

- **Enhance sprint planning**: Provide myself with data-backed forecasts to accurately estimate team capacity and workload.
- **Identify performance trends**: Analyze historical data to uncover patterns, identify bottlenecks, and pinpoint areas for improvement.
- **Improve team efficiency**: Implement targeted strategies based on data-driven insights to enhance team performance.

To achieve these objectives, I formulated data-driven questions to guide my analysis and compared the results for all sprints with the average of the last five sprints:

1. **Velocity**: _What is the team's average velocity (story points completed)?_
2. **Peak Performance**: _When did the team achieve its best overall performance in terms of story points completed?_ 
3. **Efficiency**: _How efficiently is the team utilizing its available hours?_
4. **Planned vs. Unplanned Work**: _What is the ratio of planned work completed to unplanned work completed?_ 
5. **Task Completion**: _What is the average completion rate of planned tasks?_
6. **Commitment vs. Delivery**: _What is the percentage of story points committed that were successfully completed during the sprint?_ 
7. **Defects**: _What percentage of the total sprint workload in story points is taken up by bugs?_
8. **Story Refinement**: _Is the team improving user stories refinement?_

You can find the analysis in the [Data-Driven Sprint Forecasting with SQL Solution](https://github.com/XaviVelasco/Scrum-Master-SQL-Project/blob/04769769a29a4eb95e527dcd65f9030dc59112df/Data-Driven%20Sprint%20Forecasting%20with%20SQL%20-%20Solution.md).

## 📖 Methodology:

- **Data Collection**: Gathered historical sprint data, including metrics such as team velocity, story points completed, unplanned tasks, and compliance rates.
- **Query Development**: Crafted SQL queries to extract relevant information from the data, focusing on key performance indicators and trends.
- **Data Analysis**: Analyzed the extracted data to identify patterns, correlations, and potential areas for optimization.

### Tables used

To provide a more realistic and challenging scenario analyzing the effectiveness of sprint planning, I've chosen to use two tables (_planned_ and _results_) instead of a single one. This allows me to practice complex SQL queries that involve combining data from multiple sources.

Each table column is described in detail below:

**_planned_ TABLE**
| Column name | Data type | Column description |
|---|:---:|---|
| sprint_id (🔑) | INT | Sprint Number | 
| team_hours | INT | Hours that the team is available to develop in this sprint |
| planned_issues | INT | Number of Issues or tasks that the team has planned to do in this sprint |
| planned_sp | INT | Total of the Story Points the team has commited to do in this sprint |


**_results_ TABLE**
| Column name | Data type | Column description |
|---|:---:|---|
| sprint_id (🔑) | INT | Sprint Number | 
| planned_issues_done | INT | Number of issues done that were planned |
| unplanned_issues_done | INT | Number of issues done that were NOT planned |
| bugs_issues | INT | Total Amount of bug issues done during this sprint (planned or unplanned) |
| planned_sp_done	| INT | Number of Story Points Done that were planned |
| unplanned_sp_done | INT | Number of Story Points Done that were NOT planned |
| bugs_sp | INT | SP of bugs done during this sprint (planned or unplanned) |


> [!IMPORTANT]
> This data used is based on real scrum teams but has been deliberately modified.
