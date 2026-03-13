CREATE DATABASE manufacturing_project;
USE manufacturing_project;

           ## KPI's

## TOTAL PRODUCTION

SELECT SUM(`Produced Qty`) AS total_production
FROM manufacturing_data;


## TOTAL REJECTED QUANTITY

SELECT SUM(`Rejected Qty`) AS total_rejected
FROM manufacturing_data;



## DEFECT PERCENTAGE RATE

SELECT ROUND(SUM(`Rejected Qty`) * 100.0 /
NULLIF(SUM(`Produced Qty`),0),2) 
AS defect_rate_percent
FROM manufacturing_data;



## TOTAL PRODUCTION values


SELECT ROUND(SUM(`TotalValue`), 2) AS total_value
FROM manufacturing_data;



## PRODUCTION BY DEPARTMENT

SELECT `Department Name`,
SUM(`Produced Qty`) AS total_production
FROM manufacturing_data
GROUP BY `Department Name`
ORDER BY total_production DESC;

              

              ##CHARTS
              

 ## TOP 5 ITEMS BY PRODUCTION

 SELECT `Item Name`,
SUM(`Produced Qty`) AS total_production
FROM manufacturing_data
GROUP BY `Item Name`
ORDER BY total_production DESC
LIMIT 5;



## ITEM WISE REJECTION RATE

SELECT 
`Item Name`,
SUM(`Produced Qty`) AS produced,
SUM(`Rejected Qty`) AS rejected,
ROUND(SUM(`Rejected Qty`) * 100.0 /
NULLIF(SUM(`Produced Qty`),0),2) AS rejection_rate_percent
FROM manufacturing_data
GROUP BY `Item Name`
ORDER BY rejection_rate_percent DESC;



## PRODUCTION BY EMPLOYEE

SELECT `Emp Name`,
SUM(`Produced Qty`) AS total_production
FROM manufacturing_data
GROUP BY `Emp Name`
ORDER BY total_production DESC;



## MONTHLY PRODUCTION TREND

SELECT DATE_FORMAT(`Doc Date`, '%Y-%m') AS month,
SUM(`Produced Qty`) AS monthly_production
FROM manufacturing_data
GROUP BY DATE_FORMAT(`Doc Date`, '%Y-%m')
ORDER BY month;



## MACHINE PERFORMANCE RANKING

SELECT `Machine Code`,
SUM(`Produced Qty`) AS total_production,
RANK() OVER (ORDER BY SUM(`Produced Qty`) DESC) AS production_rank
FROM manufacturing_data
GROUP BY `Machine Code`;