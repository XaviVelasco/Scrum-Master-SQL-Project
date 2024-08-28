# 📌 Data-Driven Sprint Forecasting with SQL - Solution

## 📝 Table creation

I'll start by creating and populating the tables in the _scrum_master_ database using **MySQL Workbench**.

<details>
  <summary>TABLE 1: <i>planned</i></summary>
  
````sql
CREATE TABLE scrum_master.planned (
  sprint_id INT NOT NULL,
  team_hours INT NOT NULL,
  planned_issues INT NOT NULL,
  planned_sp INT NOT NULL,
  PRIMARY KEY (sprint_id)
);

INSERT INTO scrum_master.planned (
  sprint_id,
  team_hours,
  planned_issues,
  planned_sp
  )
VALUES
  (41, 535, 16, 104),
  (42, 513, 16, 108),
  (43, 374, 12, 80),
  (44, 411, 14, 89),
  (45, 397, 14, 95),
  (46, 437, 16, 98),
  (47, 435, 17, 112),
  (48, 334, 14, 82),
  (49, 453, 19, 105),
  (50, 527, 23, 123),
  (51, 343, 16, 98),
  (52, 399, 19, 120),
  (53, 402, 20, 115),
  (54, 314, 16, 83),
  (55, 520, 21, 107),
  (56, 535, 23, 102),
  (57, 378, 19, 79),
  (58, 311, 14, 77),
  (59, 549, 21, 103),
  (60, 522, 21, 113),
  (61, 515, 26, 136),
  (62, 449, 19, 84),
  (63, 509, 18, 65),
  (64, 394, 13, 57),
  (65, 431, 17, 67),
  (66, 364, 11, 61);
````

</details>

<details>
  <summary>TABLE 2: <i>results</i></summary>
  
````sql
 CREATE TABLE scrum_master.results (
  sprint_id INT NOT NULL,
  planned_issues_done INT NOT NULL,
  unplanned_issues_done INT NOT NULL,
  bugs_issues INT NOT NULL,
  planned_sp_done INT NOT NULL,
  unplanned_sp_done INT NOT NULL,
  bugs_sp INT NOT NULL,
  PRIMARY KEY (sprint_id)
);

INSERT INTO scrum_master.results (
  sprint_id,
  planned_issues_done,
  unplanned_issues_done,
  bugs_issues,
  planned_sp_done,
  unplanned_sp_done,
  bugs_sp
  )
VALUES
  (41, 10, 7, 0, 63, 28, 0),
  (42, 11, 6, 1, 64, 25, 3),
  (43, 11, 6, 2, 45, 22, 5),
  (44, 11, 8, 1, 48, 27, 2),
  (45, 12, 5, 3, 59, 15, 6),
  (46, 8, 4, 1, 65, 19, 8),
  (47, 12, 4, 2, 71, 14, 3),
  (48, 13, 6, 4, 58, 9, 12),
  (49, 8, 8, 5, 75, 17, 12),
  (50, 16, 4, 5, 81, 29, 15),
  (51, 10, 5, 3, 48, 25, 14),
  (52, 16, 2, 2, 80, 6, 6),
  (53, 17, 3, 4, 76, 13, 8),
  (54, 14, 4, 6, 59, 12, 8),
  (55, 18, 3, 4, 102, 17, 12),
  (56, 20, 4, 1, 96, 23, 5),
  (57, 16, 2, 4, 78, 23, 12),
  (58, 9, 2, 1, 64, 28, 3),
  (59, 15, 7, 5, 95, 23, 10),
  (60, 12, 4, 2, 78, 21, 8),
  (61, 21, 5, 3, 115, 22, 7),
  (62, 10, 3, 2, 54, 9, 5),
  (63, 6, 4, 1, 58, 14, 3),
  (64, 12, 3, 1, 52, 9, 6),
  (65, 8, 2, 3, 57, 6, 5),
  (66, 5, 2, 2, 57, 4, 6);
````
</details>

## ❓ Questions and Answers

<details>
  <summary>1. <b>Velocity</b>: What is the team's average velocity (story points completed)?</summary>
<br>

- Taking in account all the springs:

````sql
SELECT COUNT(sprint_id) AS Sprints, ROUND(AVG(planned_sp_done + unplanned_sp_done)) AS Avg_SP_Done
FROM results;
````
![image](https://github.com/user-attachments/assets/91a2acc2-8327-4a7f-990b-3be3a28e5c46)

There are 26 sprints in total, and **the overall average story points done are 87**. 

- Considering only the last 5 sprints:

````sql
SELECT ROUND(AVG(planned_sp_done + unplanned_sp_done)) AS Avg_SP_Done
FROM results
WHERE sprint_id >= (
    SELECT MAX(sprint_id) - 4
    FROM results
    );
````
![image](https://github.com/user-attachments/assets/713df9e7-f33e-4900-8575-92a781a7dda3)

In this case, **the average story points done are 64**.

***

</details>
<details>
  <summary>2. <b>Peak Performance:</b> When did the team achieve its best overall performance in terms of story points completed?</summary>
<br>
  
- Taking in account all the springs:
  
````sql
SELECT sprint_id AS Sprint, (planned_sp_done + unplanned_sp_done) AS Total_SP
FROM results
ORDER BY Total_SP DESC
LIMIT 1;
````
![image](https://github.com/user-attachments/assets/425fe96b-e07c-48de-a49e-e214994a2616)

The team achieved its best overall performance in **sprint 61 with 137 story points**.

- Considering only the last 5 sprints:
  
````sql
SELECT sprint_id AS Sprint,  (planned_sp_done + unplanned_sp_done) AS Total_SP
FROM results
WHERE sprint_id >= (
  SELECT MAX(sprint_id) - 4
  FROM results
  )
ORDER BY Total_SP DESC
LIMIT 1;
````
![image](https://github.com/user-attachments/assets/043528a0-b16a-4d97-900a-4754bb904f95)

Regarding only the last 5 sprints, the team achieved its best performance in **sprint 63 with 72 story points**.

***
</details>
### Aqui
<details>
  <summary>3. <b>Efficiency:</b>How efficiently is the team utilizing its available hours?</summary>
<br>

- First of all, I will calculate which sprints were the most and least efficient by dividing the total story points by the team hours. I'll also find the average efficiency. 

_MIN EFFICIENCY:_

````sql
SELECT results.sprint_id AS sprint, ROUND((planned_sp_done + unplanned_sp_done) / (team_hours),3) AS Min_Efficiency
FROM results
JOIN planned ON results.sprint_id = planned.sprint_id
GROUP BY sprint
ORDER BY Min_Efficiency ASC
LIMIT 1;
````
![image](https://github.com/user-attachments/assets/0efb3a71-5061-42db-8cab-f304a06be630)

**Min efficiency:** At sprint 62, having 0.1403 story points per hour.

_MAX EFFICIENCY:_
````sql
SELECT results.sprint_id AS sprint, ROUND((planned_sp_done + unplanned_sp_done) / (team_hours),3) AS Max_Efficiency
FROM results
JOIN planned ON results.sprint_id = planned.sprint_id
GROUP BY sprint
ORDER BY Max_Efficiency DESC
LIMIT 1;
````
![image](https://github.com/user-attachments/assets/c0b1c064-7fee-4cbe-aa9b-aae8a45946f1)

**Max efficiency:** At sprint 58, having 0.296 story points per hour.

_AVG EFFICIENCY:_
````sql
SELECT ROUND(AVG(planned_sp_done + unplanned_sp_done) / AVG(team_hours), 3) AS Avg_Efficiency
FROM results
JOIN planned ON results.sprint_id = planned.sprint_id;
````
![image](https://github.com/user-attachments/assets/617d39a5-b08d-4a5a-ac98-2a4e2f4a7973)

**Avg efficiency:** On average, the team does 0.199 story points per hour.

- Now I will calculate average sprint efficiency by dividing total story points by team hours:
  
````sql
SELECT ROUND(SUM(planned_sp_done + unplanned_sp_done) / SUM(team_hours), 3) AS Avg_Efficiency
FROM results
JOIN planned ON results.sprint_id = planned.sprint_id
GROUP BY Avg_Efficiency;
````
![image](https://github.com/user-attachments/assets/5446861a-f5b2-452c-8ab4-5b6d6cccf26d)

**Average efficiency** 0.296.

***
</details>
<details>
  <summary>4. <b>Planned vs. Unplanned Work:</b> What is the ratio of planned story points completed to unplanned story points completed?</summary>
<br>
To ask this question, we are going to 

</details>
<details>
  <summary>5. <b>Task Completion:</b> What is the average completion rate of planned tasks?</summary>
<br>
To ask this question, we are going to 
<br>
</details>
<details>
  <summary>6. <b>Unplanned Work:</b> What percentage of the total sprint workload is taken up by unplanned work?</summary>
<br>
To ask this question, we are going to 
<br>
</details>
<details>
  <summary>7. <b>Unplanned Issues:</b> What is the average number of unplanned issues introduced per sprint?</summary>
<br>
To ask this question, we are going to 
<br>
</details>
<details>
  <summary>8. <b>Story Refinement:</b> Is the team improving stories refinement?</summary>
<br>
To ask this question, we are going to 
<br>
</details>
<details>
  <summary>9. <b>Defects:</b> What percentage of the total sprint workload is taken up by bugs?</summary>
<br>
To ask this question, we are going to 
<br>
</details>
<details>
  <summary>10. <b>Commitment vs. Delivery:</b> What is the percentage of story points committed that were successfully completed during the sprint?</summary>
<br>
To ask this question, we are going to 
<br>
</details>
