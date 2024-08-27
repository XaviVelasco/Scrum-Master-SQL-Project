# 📌 Data-Driven Sprint Forecasting with SQL - Solution

## 📝 Table creation

First of all, I am going to create the database with all tables and data. I will be using MySQL to do this.

````sql
CREATE TABLE planned (
  sprint_id INT NOT NULL,
  team_hours INT NOT NULL,
  planned_issues INT NOT NULL,
  planned_sp INT NOT NULL,
  PRIMARY KEY (sprint_id)
);
````
````sql
CREATE TABLE results (
  sprint_id INT NOT NULL,
  planned_issues_done INT NOT NULL,
  unplanned_issues_done INT NOT NULL,
  bugs_issues INT NOT NULL,
  planned_sp_done INT NOT NULL,
  unplanned_sp_done INT NOT NULL,
  bugs_sp INT NOT NULL,
  PRIMARY KEY (sprint_id)
);
````

## ❓ Questions and Answers

### 1. **Velocity**: _What is the team's average velocity (story points completed)?_
### 2. **Peak Performance**: _When did the team achieve its best overall performance in terms of story points completed?_ 
### 3. **Efficiency**: _How efficiently is the team utilizing its available hours?_
### 4. **Planned vs. Unplanned Work**: _What is the ratio of planned story points completed to unplanned story points completed?_ 
### 5. **Task Completion**: _What is the average completion rate of planned tasks?_
### 6. **Unplanned Work**: _What percentage of the total sprint workload is taken up by unplanned work?_
### 7. **Unplanned Issues**: _What is the average number of unplanned issues introduced per sprint?_ 
### 8. **Story Refinement**: _Is the team improving stories refinement?_
### 9. **Defects**: _What percentage of the total sprint workload is taken up by bugs?_
### 10. **Commitment vs. Delivery**: _What is the percentage of story points committed that were successfully completed during the sprint?_ 
