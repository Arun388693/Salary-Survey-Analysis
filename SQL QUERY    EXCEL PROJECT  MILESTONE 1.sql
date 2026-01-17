create database salary_survey;
use university;
select * from salary_survey;

SELECT COUNT(*) AS total_rows
FROM salary_survey;

DESCRIBE salary_survey;


#--- (a.) AVERAGE SALARY BY INDUSTRY & GENDER:

SELECT 
    Industry,
    Gender,
    ROUND(AVG(`total_compensation`)) AS Average_Salary
FROM salary_survey
GROUP BY Industry, Gender;








#--- (b.) TOTAL SALARY COMPENSATION by JOB TITLE:


SELECT
    `Job Title`,
    SUM(`Total_Compensation`) AS total_compensation
FROM salary_survey
GROUP BY `Job Title`
ORDER BY total_compensation DESC;


#--- (c.) SALARY DISTRIBUTION by EDUCATION LEVEL :
SELECT
    `Highest Level of Education Completed` AS Education_Level,
    ROUND(AVG(total_compensation)) AS Avg_Salary,
    MIN(total_compensation) AS Min_Salary,
    MAX(total_compensation) AS Max_Salary
FROM salary_survey
WHERE total_compensation IS NOT NULL
GROUP BY `Highest Level of Education Completed`
ORDER BY Avg_Salary DESC;

#--- (d.) NUMBER of EMPLOYESS by INDUSTRY & YEARS of EXPERIENCE :
SELECT
    `Industry`,
    `Years of Professional Experience Overall`,
    COUNT(*) AS Number_of_Employees
FROM salary_survey
WHERE
    `Industry` IS NOT NULL
    AND `Years of Professional Experience Overall` IS NOT NULL
GROUP BY
    `Industry`,
    `Years of Professional Experience Overall`
ORDER BY
    `Industry`,
    `Years of Professional Experience Overall`




#--- (e.) MEDIAN SALARY by AGE RANGE & GENDER :

SELECT
    `Age Range`,
    Gender,
    SUBSTRING_INDEX(
        SUBSTRING_INDEX(
            GROUP_CONCAT(total_compensation ORDER BY total_compensation),
            ',',
            CEIL(COUNT(*) / 2)
        ),
        ',',
        -1
    ) AS Median_Salary
FROM salary_survey
WHERE
    total_compensation IS NOT NULL
    AND `Age Range` IS NOT NULL
    AND Gender IS NOT NULL
GROUP BY
    `Age Range`,
    Gender



DESCRIBE salary;


#--- (f.) JOB TITLES with THE HIGHEST SALARY in EACH COUNTRY  :
SELECT
    Country,
    `Job Title`,
    MAX(total_compensation) AS Highest_Salary
FROM salary_survey
GROUP BY
    Country,
    `Job Title`
ORDER BY
    Country,
    Highest_Salary DESC



#--- (g.) AVERAGE SALARY by CITY & INDUSTRY :

SELECT
    City,
    Industry,
    ROUND(AVG(total_compensation), 0) AS Avg_Salary
FROM salary_survey
WHERE total_compensation IS NOT NULL
GROUP BY
    City,
    Industry
ORDER BY
    Industry,
    Avg_Salary DESC


SET SESSION group_concat_max_len = 1000000;





#--- (h.) PERCENTAGE of EMPLOYEES with ADDITIONAL MONETARY COMPENSATION by GENDER  :
SELECT
    Gender,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN `Additional Monetary Compensation` IS NOT NULL
                     AND `Additional Monetary Compensation` > 0
                THEN 1 ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS Percentage_With_Additional_Comp
FROM salary_survey
GROUP BY Gender


#--- (i.) TOTAL COMPENSATION by JOB TITLE & YEARS of EXPERIENCE  :

    SELECT
    `Job Title`,
    `Years of Professional Experience Overall`,
    SUM(total_compensation) AS Total_Compensation
FROM salary_survey
WHERE total_compensation IS NOT NULL
GROUP BY
    `Job Title`,
    `Years of Professional Experience Overall`
ORDER BY
    `Job Title`,
    Total_Compensation DESC



#--- (j.) AVERAGE SALARY by INDUSTRY, GENDER & EDUCATION LEVEL :

SELECT
    Industry,
    Gender,
    `Highest Level of Education Completed`,
    ROUND(AVG(total_compensation), 0) AS Avg_Salary
FROM salary_survey
WHERE total_compensation IS NOT NULL
GROUP BY
    Industry,
    Gender,
    `Highest Level of Education Completed`
ORDER BY
    Industry,
    Avg_Salary DESC



ALTER TABLE salary_survey
CHANGE `Annual Salary Fixed2` total_compensation DECIMAL(15,2);



