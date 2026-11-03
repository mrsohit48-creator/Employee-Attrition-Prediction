use employee_attrition;

SELECT
    COUNT(*) AS TotalEmployees
FROM employees;



SELECT
    COUNT(*) AS EmployeesLeft
FROM employees
WHERE Attrition = 'Yes';



SELECT
    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft,

    ROUND(
        SUM(
            CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS AttritionRate

FROM employees;




SELECT
    d.DepartmentName,

    COUNT(e.EmployeeID) AS TotalEmployees,

    SUM(
        CASE
            WHEN e.Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft

FROM employees e

JOIN departments d
    ON e.DepartmentID = d.DepartmentID

GROUP BY d.DepartmentName

ORDER BY EmployeesLeft DESC;



SELECT
    d.DepartmentName,

    COUNT(e.EmployeeID) AS TotalEmployees,

    ROUND(
        SUM(
            CASE
                WHEN e.Attrition = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(e.EmployeeID),
        2
    ) AS AttritionPercentage

FROM employees e

JOIN departments d
    ON e.DepartmentID = d.DepartmentID

GROUP BY d.DepartmentName

ORDER BY AttritionPercentage DESC;



SELECT
    Gender,

    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft

FROM employees

GROUP BY Gender;


SELECT
    JobRole,

    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft

FROM employees

GROUP BY JobRole

ORDER BY EmployeesLeft DESC;



SELECT
    e.Attrition,

    COUNT(e.EmployeeID) AS TotalEmployees,

    ROUND(AVG(s.MonthlyIncome), 2) AS AverageMonthlyIncome

FROM employees e

JOIN salaries s
    ON e.EmployeeID = s.EmployeeID

GROUP BY e.Attrition;



SELECT
    a.OverTime,

    COUNT(e.EmployeeID) AS TotalEmployees,

    SUM(
        CASE
            WHEN e.Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft

FROM employees e

JOIN attendance a
    ON e.EmployeeID = a.EmployeeID

GROUP BY a.OverTime;



SELECT
    p.JobSatisfaction,

    COUNT(e.EmployeeID) AS TotalEmployees,

    SUM(
        CASE
            WHEN e.Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft

FROM employees e

JOIN performance p
    ON e.EmployeeID = p.EmployeeID

GROUP BY p.JobSatisfaction

ORDER BY p.JobSatisfaction;



SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and Above'
    END AS AgeGroup,

    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft

FROM employees

GROUP BY AgeGroup

ORDER BY MIN(Age);



SELECT
    e.EmployeeID,
    e.JobRole,
    e.YearsAtCompany,
    p.YearsSinceLastPromotion,
    e.Attrition

FROM employees e

JOIN performance p
    ON e.EmployeeID = p.EmployeeID

WHERE p.YearsSinceLastPromotion >= 5

ORDER BY p.YearsSinceLastPromotion DESC;



SELECT
    e.EmployeeID,
    e.DepartmentID,
    e.JobRole,
    p.JobSatisfaction,
    e.Attrition

FROM employees e

JOIN performance p
    ON e.EmployeeID = p.EmployeeID

WHERE p.JobSatisfaction <= 2

ORDER BY p.JobSatisfaction;




SELECT
    CASE
        WHEN YearsAtCompany < 2 THEN 'Less than 2 years'
        WHEN YearsAtCompany BETWEEN 2 AND 5 THEN '2-5 years'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 years'
        ELSE 'More than 10 years'
    END AS ExperienceGroup,

    COUNT(*) AS TotalEmployees,

    SUM(
        CASE
            WHEN Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft

FROM employees

GROUP BY ExperienceGroup

ORDER BY MIN(YearsAtCompany);



SELECT
    e.EmployeeID,
    e.JobRole,
    d.DepartmentName,
    s.MonthlyIncome,
    e.Attrition

FROM employees e

JOIN salaries s
    ON e.EmployeeID = s.EmployeeID

JOIN departments d
    ON e.DepartmentID = d.DepartmentID

ORDER BY s.MonthlyIncome DESC

LIMIT 10;



SELECT
    a.BusinessTravel,

    COUNT(e.EmployeeID) AS TotalEmployees,

    SUM(
        CASE
            WHEN e.Attrition = 'Yes' THEN 1
            ELSE 0
        END
    ) AS EmployeesLeft

FROM employees e

JOIN attendance a
    ON e.EmployeeID = a.EmployeeID

GROUP BY a.BusinessTravel

ORDER BY EmployeesLeft DESC;



CREATE OR REPLACE VIEW employee_hr_summary AS

SELECT
    e.EmployeeID,
    e.Age,
    e.Gender,
    e.Attrition,
    e.JobRole,

    d.DepartmentName,

    s.MonthlyIncome,

    a.OverTime,
    a.BusinessTravel,

    p.JobSatisfaction,
    p.PerformanceRating,
    p.WorkLifeBalance,

    e.YearsAtCompany

FROM employees e

JOIN departments d
    ON e.DepartmentID = d.DepartmentID

JOIN salaries s
    ON e.EmployeeID = s.EmployeeID

JOIN attendance a
    ON e.EmployeeID = a.EmployeeID

JOIN performance p
    ON e.EmployeeID = p.EmployeeID;
    
    
SELECT *
FROM employee_hr_summary
LIMIT 20;