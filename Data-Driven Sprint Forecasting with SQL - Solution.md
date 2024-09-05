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
<details>
  <summary>3. <b>Efficiency:</b> How efficiently is the team utilizing its available hours?</summary>
<br>

- First of all, I will calculate which sprints were the most and least efficient by dividing the total story points by the team hours. I'll also find the average efficiency.
  
   - **Min Effinciency**
      ````sql
      SELECT results.sprint_id AS sprint, ROUND((planned_sp_done + unplanned_sp_done) / (team_hours),3) AS Min_Efficiency
      FROM results
      JOIN planned ON results.sprint_id = planned.sprint_id
      GROUP BY sprint
      ORDER BY Min_Efficiency ASC
      LIMIT 1;
      ````
      ![image](https://github.com/user-attachments/assets/0efb3a71-5061-42db-8cab-f304a06be630)

       _Min efficiency_: At sprint 62, having 0.1403 story points per hour.
   
   - **Max Efficiency**
 
      ````sql
      SELECT results.sprint_id AS sprint, ROUND((planned_sp_done + unplanned_sp_done) / (team_hours),3) AS Max_Efficiency
      FROM results
      JOIN planned ON results.sprint_id = planned.sprint_id
      GROUP BY sprint
      ORDER BY Max_Efficiency DESC
      LIMIT 1;
      ````
      ![image](https://github.com/user-attachments/assets/c0b1c064-7fee-4cbe-aa9b-aae8a45946f1)
      
      _Max efficiency_: At sprint 58, having 0.296 story points per hour.
     
   - **Avg Efficiency** 

      ````sql
      SELECT ROUND(AVG(planned_sp_done + unplanned_sp_done) / AVG(team_hours), 3) AS Avg_Efficiency
      FROM results
      JOIN planned ON results.sprint_id = planned.sprint_id;
      ````
      ![image](https://github.com/user-attachments/assets/617d39a5-b08d-4a5a-ac98-2a4e2f4a7973)
      
      _Avg efficiency_: On average, the team does 0.199 story points per hour.

- I will calculate the efficiency variation using a subquery to determine the **standard deviation**.

  **If the deviation is positive**, it indicates that the sprint's efficiency is higher than the average efficiency. This means the sprint performed better than the overall average in terms of delivering story points per team hour.

  **If the deviation is negative**, it means the sprint's efficiency was lower than the average efficiency. This suggests that the sprint underperformed in terms of delivering story points per team hour. 

   - How did efficiency vary across **all sprints**? 
      
      ````sql
      SELECT results.sprint_id AS Sprint,
        ROUND(SUM(planned_sp_done + unplanned_sp_done) / SUM(team_hours),3) AS Efficiency,
        ROUND(SUM(planned_sp_done + unplanned_sp_done) / SUM(team_hours),3) - (
          SELECT ROUND(AVG(Efficiency),3)
          FROM (
            SELECT (AVG(planned_sp_done + unplanned_sp_done) / AVG(team_hours)) AS Efficiency
            FROM results
            JOIN planned ON results.sprint_id = planned.sprint_id
            GROUP BY results.sprint_id
          ) AS Sprint_Avg_Subquery) AS Std_Deviation
      FROM results
      JOIN planned ON results.sprint_id = planned.sprint_id
      GROUP BY results.sprint_id
      ORDER BY results.sprint_id ASC;
      ````
      ![image](https://github.com/user-attachments/assets/641ae03d-3dd8-41f2-847d-c990406f9f19)


   - To assess the team's performance, let's analyze their efficiency during the **past five sprints**: 
      
      ````sql
      SELECT results.sprint_id AS Sprint,
        ROUND(SUM(planned_sp_done + unplanned_sp_done) / SUM(team_hours),3) AS Efficiency,
        ROUND(SUM(planned_sp_done + unplanned_sp_done) / SUM(team_hours),3) - (
          SELECT ROUND(AVG(Efficiency),3)
          FROM (
            SELECT (AVG(planned_sp_done + unplanned_sp_done) / AVG(team_hours)) AS Efficiency
            FROM results
            JOIN planned ON results.sprint_id = planned.sprint_id
            GROUP BY results.sprint_id
          ) AS Sprint_Avg_Subquery) AS Std_Deviation
      FROM results
      JOIN planned ON results.sprint_id = planned.sprint_id
      GROUP BY results.sprint_id
      ORDER BY results.sprint_id DESC
      LIMIT 5;
      ````
      ![image](https://github.com/user-attachments/assets/5e7a880f-f8e5-45df-920c-5a38ca67d39d)


    Over the last 5 sprints, we've observed a **negative deviation**, indicating that **their performance is below the overall average**. Now as Scrum Master our duty will be to try to find out the reasons in order to improve the team's performance.
***
</details>

<details>
  <summary>4. <b>Planned vs. Unplanned Work:</b> What is the ratio of planned work completed to unplanned work completed?</summary>
<br>

   - **Issues comparison**
     
     - For all the sprints:

     ````sql
     SELECT ROUND((sum(planned_issues_done) / sum(planned_issues_done + unplanned_issues_done)) * 100, 2)
             AS '% issues planned', 
          	ROUND((sum(unplanned_issues_done) / sum(planned_issues_done + unplanned_issues_done)) * 100, 2)
             AS '% issues unplanned'
     FROM results;
     ````
     ![image](https://github.com/user-attachments/assets/ed764f74-3a35-407a-a882-92a33ce00c16)

     **Unplanned issues** represent 26.04% of the total work performed. 

     - For the last 5 sprints:


     ````sql
     SELECT ROUND((sum(planned_issues_done) / sum(planned_issues_done + unplanned_issues_done)) * 100, 2)
             AS '% issues planned', 
          	ROUND((sum(unplanned_issues_done) / sum(planned_issues_done + unplanned_issues_done)) * 100, 2)
             AS '% issues unplanned'
     FROM results
     WHERE sprint_id >= (
           SELECT MAX(sprint_id) - 4
           FROM results
           );
     ````
     ![image](https://github.com/user-attachments/assets/fe913f72-df27-4c34-b67c-01820ab2b15d)

     **Unplanned issues** comprised 25.45% of the total work during the last five sprints, which is just a bit lower than the average unplanned rate across all sprints.

   - **Story points comparison**
     
      - For all the sprints:

        ````sql
        SELECT ROUND((sum(planned_sp_done) / sum(planned_sp_done + unplanned_sp_done)) * 100, 2)
                  AS '% SP planned',
               ROUND((sum(unplanned_sp_done) / sum(planned_sp_done + unplanned_sp_done)) * 100, 2)
                  AS '% SP unplanned'
        FROM results;
        ````
        ![image](https://github.com/user-attachments/assets/c9d2797e-93e5-420e-ab09-df3646bab171)
  
        **Unplanned SP** represent 20.37% of the total work performed. 


      - For the last 5 sprints:

        ````sql
        SELECT ROUND((sum(planned_sp_done) / sum(planned_sp_done + unplanned_sp_done)) * 100, 2)
                AS '% SP planned', 
               ROUND((sum(unplanned_sp_done) / sum(planned_sp_done + unplanned_sp_done)) * 100, 2)
                AS '% SP unplanned'
        FROM results
        WHERE sprint_id >= (
              SELECT MAX(sprint_id) - 4
              FROM results);
        ````
        ![image](https://github.com/user-attachments/assets/97dee76d-bffb-4650-9bba-c90637f35c98)

        **Unplanned SP** accounted for 13.13% of the total work effort during the past five sprints. This rate is lower than the average unplanned percentage across all sprints, indicating a positive trend towards reduced unplanned work.

   - **Conclusion**

     Although if we look at the issues of the last five sprints it might seem that unplanned work has hardly been reduced, if we look at the story points we do observe a notable trend towards the reduction of this unplanned work.

</details>

<details>
  <summary>5. <b>Task Completion:</b> What is the average completion rate of planned tasks?</summary>
<br>

When the team plans the sprint, they commit to specific issues or story points. Here, I will measure how many of the committed issues or SP were actually completed.

  - I will calculate the average percentage of _planned issues done_ out of _planned issues_ for evey sprint to evaluate the team's consistency in completing planned work.
      
    ````sql
    SELECT results.sprint_id AS Sprint, planned_sp AS 'SP Planned', planned_sp_done AS 'SP Done', 
          ROUND(SUM(planned_sp_done) / SUM(planned_sp) * 100, 2) AS '% Done'
    FROM results
    JOIN planned ON results.sprint_id = planned.sprint_id
    GROUP BY Sprint;
    ````
    ![image](https://github.com/user-attachments/assets/bddf596e-e238-4355-9e4e-067d6f71ab1a)

  - Now I will calculate average percentage for all the sprints:
    ````sql
    SELECT ROUND((SUM(planned_sp_done) / SUM(planned_sp)) * 100 ,2) AS Avg_ratio
    FROM results
    JOIN planned ON results.sprint_id = planned.sprint_id;
    ````
    ![image](https://github.com/user-attachments/assets/671a185c-5191-401f-b3ef-4c1af39119b5)

    **Average completion rate for all the sprints is 73.00%.**

  - Now I will calculate average percentage for the last five sprints:

    ````sql
    SELECT ROUND((SUM(planned_sp_done) / SUM(planned_sp)) * 100 ,2) AS Avg_ratio
    FROM results
    JOIN planned ON results.sprint_id = planned.sprint_id
    WHERE results.sprint_id >= (
    		SELECT MAX(sprint_id) - 4
    		FROM results);
    ````
    ![image](https://github.com/user-attachments/assets/7c5d50b6-2eeb-4168-b6b6-e302d3ec7a69)

    **Average completion rate over the last five sprints is 83.23%.**

  - Then, I will calculate the average percentage for each of the last five sprints to observe whether the team's consistency trend increases or not from the average across all the sprints:
    ````sql
    
     SELECT results.sprint_id AS sprint, ROUND((SUM(planned_sp_done) / SUM(planned_sp)) * 100 ,2) AS total_done,
        ROUND((SUM(planned_sp_done) / SUM(planned_sp)) * 100 ,2) - (
          SELECT ROUND((SUM(planned_sp_done) / SUM(planned_sp)) * 100 ,2) AS total_done
          FROM results
          JOIN planned ON results.sprint_id = planned.sprint_id
          ) AS Deviation
     FROM results
     JOIN planned ON results.sprint_id = planned.sprint_id
     	WHERE results.sprint_id >= (
     		SELECT MAX(sprint_id) - 4
     		FROM results)
     GROUP BY sprint;
     ````
     ![image](https://github.com/user-attachments/assets/fa1f60c4-8b0a-431f-8b7c-7c15c7c926a2)

  - **Conclusion:**
    
     During the last few sprints, especially the last four, **there is a clear tendency to meet the initially planned story points**. For this reason, we can say that **the team is achieving greater compliance** with the commitment initially made in the sprint planning.

<br>
</details>

<details>
  <summary>6. <b>Commitment vs. Delivery:</b> What is the percentage of story points committed that were successfully completed during the sprint? </summary>
<br>
  
Unlike the previous question, we are going to calculate the **capacity compliance** that the team plans at the beginning of each sprint. That is, whether or not it has delivered the number of story points that it has committed to or planned during the sprint planning event. 

````sql

SELECT results.sprint_id AS Sprint, planned_sp AS Commited, (planned_sp_done + unplanned_sp_done) AS Delivered, 
    ROUND(((planned_sp_done + unplanned_sp_done) / planned_sp) * 100, 1) AS '% Compliance'
FROM results
JOIN planned 
ON results.sprint_id = planned.sprint_id
GROUP BY sprint;

````        
![image](https://github.com/user-attachments/assets/85ad48ab-5116-44bc-a294-3c0e88dd2375)

Our **sprint data reveals fluctuations in story point delivery**. While some sprints have fallen short of committed points, others have exceeded calculated capacity. As a Scrum Master, I'll investigate these discrepancies to identify underlying causes and implement corrective measures. This could involve refining estimation techniques, adjusting workload expectations, or addressing external factors impacting productivity. By aligning delivery with commitments, we can enhance team efficiency and predictability.

<br>
</details>
<details>
  <summary>7. <b>Defects:</b> What percentage of the total sprint workload in story points is taken up by bugs?</summary>
<br>
I'm going to calculate what percentage of our work is spent fixing bugs and technical debt. I'll look at all the story points we've done, both planned and unplanned, and see how many of those were for fixing problems.


````sql
SELECT results.sprint_id AS Sprint, planned_sp_done + unplanned_sp_done AS 'Total SP', bugs_sp AS 'Bugs (SP)',
  ROUND((bugs_sp / (planned_sp_done + unplanned_sp_done)) * 100,2) AS '%_Bugs' 
FROM results
JOIN planned
ON results.sprint_id = planned.sprint_id
GROUP BY Sprint;
````
![image](https://github.com/user-attachments/assets/aa3171cb-d81c-4535-b53d-c8bcb5207d0b)
<br>
</details>
<details>
  <summary>8. <b>Story Refinement:</b> Is the team improving stories refinement?</summary>
<br>
I would like to know if the team is improving its issue refinement by being more accurate when estimating during the planning event. Our main objective is to reduce story point estimation per issue as much as possible. To track progress, I will calculate the average story points per issue in each sprint.

  - First, I will calculate the average ratio for all the sprints:
      
    ````sql
    SELECT ROUND(AVG(planned_sp / planned_issues),2) AS 'All sprints'
    FROM planned;
    ````
  

  - Now I will calculate what is the ratio for each sprint:
    ````sql
    SELECT sprint_id AS Sprint, ROUND(AVG(planned_sp / planned_issues),2) AS Ratio
    FROM planned
    GROUP BY sprint;
    ````

  - Then I will calculate average ratio for the first 5 sprints...
    ````sql
    SELECT ROUND(AVG(planned_sp / planned_issues),2) AS 'First 5 spr'
    FROM planned
    WHERE sprint_id >= (
    	SELECT MIN(sprint_id) + 4
    	FROM planned);
    ````

  - ... and now for the last 5 sprints in order to compare them:
    ````sql
    SELECT ROUND(AVG(planned_sp / planned_issues),2) AS 'Last 5 spr'
    FROM planned
    WHERE sprint_id >= (
    	SELECT MAX(sprint_id) - 4
    	FROM planned);
    ````
    
<br>
</details>
