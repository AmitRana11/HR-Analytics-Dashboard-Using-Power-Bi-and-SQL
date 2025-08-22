USE HR_Analytics_db

SELECT *FROM HR_Analytics

SELECT COUNT( *) AS Total_Rows
FROM HR_Analytics

--- DATA CLEANING---

--  1. REMOVE UNNECESSARY COLUMN

ALTER TABLE  HR_Analytics
DROP COLUMN YearsWithCurrManager,StockOptionLevel,RelationshipSatisfaction;

-- 2. Check duplicate data in column . 

-- Check duplicate in EmpID's

SELECT  EmpID , COUNT(*) AS DuplicateCount FROM HR_Analytics
GROUP BY EmpID 
HAVING COUNT(*) > 1 ;

-- Remove duplicates in columns 

 WITH CTE AS( 
    SELECT * ,
            ROW_NUMBER() OVER (PARTITION BY EmpID ORDER BY EmpID) AS row_num 
    FROM HR_Analytics
    )
    DELETE FROM CTE WHERE row_num > 1 ;

--3. Update inconsistent values in BusinessTravel

 UPDATE  HR_Analytics
SET BusinessTravel = 'Travel_Rarely'
WHERE BusinessTravel IN ('TravelRarely');

-- Update Over18 Column 

UPDATE HR_Analytics
SET Over18 = 'Yes'
WHERE Over18 = 'Y';


-- Problems

--- 1.Total Employees 

SELECT COUNT(EmpID) AS Total_Employees
FROM HR_Analytics

--2. Avg Age of Employees 

SELECT ROUND(AVG(CAST(Age AS FLOAT)),0) AS Avg_Age
FROM HR_Analytics;


--3. Avg Year of Employees at Company. 

SELECT  AVG(YearsAtCompany) AS Avg_Years_At_Company
FROM HR_Analytics;

--4. Overall Attrition Count

SELECT Attrition , COUNT(*)  as  EmployeeCount
FROM HR_Analytics
GROUP BY Attrition;

 --5. Avg Salary of Employees

SELECT (CONCAT(AVG(MonthlyIncome),' K'))  AS Avg_Salary 
FROM HR_Analytics;

--6. Overall Attrition Rate

SELECT
    CAST(
    (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS decimal(5,2))AS Attrition_Rate 
FROM HR_Analytics;


-- 7. Attrition by Department

SELECT  Department ,COUNT(*) AS Employee_Left
FROM HR_Analytics
WHERE Attrition ='Yes'
GROUP BY Department 
ORDER BY Employee_Left desc;

--8. Attrition by Gender

SELECT Gender, Attrition, COUNT(*) AS Employee_Left
FROM HR_Analytics
GROUP BY Gender, Attrition;

--9. Attrition Percentage by Department

SELECT 
    Department,
    CAST(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Attrition_Percentage
FROM HR_Analytics

GROUP BY Department
ORDER BY Attrition_Percentage DESC;

--10. Attrition by Job Role

SELECT JobRole, COUNT(*) AS Employees_Left
FROM HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY Employees_Left DESC;

--11. Total Employees by Departments

SELECT 
    Department,
    COUNT(*) AS Total_Employees
FROM HR_Analytics
GROUP BY Department
ORDER BY Total_Employees DESC;
 

--12.  Total Employees by Job Role

SELECT 
    JobRole,
    COUNT(*) AS Total_Employees
FROM HR_Analytics
GROUP BY JobRole
ORDER BY Total_Employees DESC;

--13. Attrition by Age Group 

SELECT AgeGroup, COUNT(*) AS Employees_Left
FROM HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY AgeGroup
ORDER BY Employees_Left DESC;


-- 14.  Attrition by Salary Slab .

SELECT SalarySlab, COUNT(*) AS Employees_Left
FROM HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY SalarySlab
ORDER BY Employees_Left DESC;


--15. Attrition by Gender 

SELECT Gender, COUNT(*) AS Employees_Left
FROM HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY Gender
ORDER BY Employees_Left DESC;


---16. Attrition by Marital Status 

SELECT MaritalStatus , Attrition ,COUNT(*) As Employee_Count
FROM HR_Analytics
GROUP BY MaritalStatus , Attrition
ORDER BY MaritalStatus, Attrition;

-- 17. Average Salary by Job Role

SELECT JobRole, AVG(MonthlyIncome) AS Avg_Salary
FROM HR_Analytics
GROUP BY JobRole
ORDER BY Avg_Salary DESC;

--18 . Attrition by Years at Company

SELECT YearsAtCompany, COUNT(*) AS Employees_Left
FROM HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY YearsAtCompany
ORDER BY YearsAtCompany;

-- 19.  Performance Rating vs Attrition

SELECT PerformanceRating, COUNT(*) AS Employees_Left
FROM HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY PerformanceRating;

--20.Attrition by Business Travel  


SELECT BusinessTravel, COUNT(*) AS Employees_Left
FROM HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY BusinessTravel
ORDER BY Employees_Left DESC;

--21. Attrition by Overtime

SELECT OverTime, COUNT(*) AS Employees_Left
FROM HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY OverTime;

--22. Average Years in Current Role by Job Role

SELECT JobRole, AVG(YearsInCurrentRole) AS Avg_YearsInRole
FROM HR_Analytics
GROUP BY JobRole;

--23. Attrition by Years Since Last Promotion

SELECT YearsSinceLastPromotion , COUNT(*) AS Employee_Left
FROM HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;

--24. Job Satisfaction by Job Role

SELECT JobRole, AVG(JobSatisfaction) AS Avg_JobSatisfaction
FROM HR_Analytics
GROUP BY JobRole
ORDER BY Avg_JobSatisfaction DESC;

--25. Attrition by Work-Life Balance Rating

SELECT WorkLifeBalance, COUNT(*) AS Employees_Left
FROM HR_Analytics
WHERE Attrition = 'Yes'
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;


-----************************ END**************************----



SELECT *FROM HR_Analytics

