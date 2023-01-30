/*
Description :- 
		• This is a Retail Transations SQL Project. This database contains 1 table
		
Approach :- 
		• Understanding the dataset
		• Creating business questions
		• Analysing through SQL queries
*/

use aishdb


-- Importing data from csv file 'RetailTransactions.csv' attached in resources to 'Retail' table
select * from [dbo].[RetailTransactions]

-- total number of row in the table
select count(*) from [dbo].[RetailTransactions]  --75620

-- to Get an output with a total Order amount month wise sorted by months in a descening order
	select datepart(month, transaction_date) as mnth, count(1) as num, sum(convert(float,order_amt)) 
	from [dbo].[RetailTransactions]
	group by datepart(month, transaction_date)
	order by mnth desc 
SELECT
MONTH(transaction_date) AS Moth, sum(convert(float,order_amt))
FROM [dbo].[RetailTransactions]   
GROUP BY MONTH(transaction_date)
order BY MONTH(transaction_date) desc

-- to get the rank of total order month wise highest to lowest
with cte as (
	SELECT MONTH(transaction_date) AS Moth, sum(convert(float,order_amt)) total_order FROM [dbo].[RetailTransactions]   
	GROUP BY MONTH(transaction_date)
	)
select *, dense_rank() over(order by total_order desc) as rk from cte
--conclusion: in october, most of the transactions occured

-- to get an output which represents maximum ordered amount
		--(Method : view)
with cte as (
	SELECT MONTH(transaction_date) AS Moth, sum(convert(float,order_amt)) total_order FROM [dbo].[RetailTransactions]   
	GROUP BY MONTH(transaction_date)
	)
select *, max(total_order) over(order by total_order desc) as max_order_amt from cte
		--(Method : view)
SELECT 	Max(sales)
FROM    (SELECT datepart(month,transaction_date) as Moth, sum(convert(float,order_amt)) as Sales
      	 FROM [dbo].[RetailTransactions]   
         GROUP BY datepart(month,transaction_date)
     ) as Maxsales;


-- to get the min order amount(Method : subquery)
SELECT 	min(sales)
FROM    (SELECT datepart(month,transaction_date) as Moth, sum(convert(float,order_amt)) as Sales
      	 FROM [dbo].[RetailTransactions]   
         GROUP BY datepart(month,transaction_date)
     ) as Maxsales;

	
-- to get an output presenting total Order amount for each city from high to low
SELECT location_city, sum(convert(float,order_amt)) as sales
FROM [dbo].[RetailTransactions] 
GROUP BY location_city
ORDER BY sales desc;

-- to get an output presenting total Order amount for each state from high to low
SELECT location_state, sum(convert(float,order_amt)) as sales
FROM [dbo].[RetailTransactions]
GROUP BY location_state
ORDER BY sales desc

-- to get an output presenting total Order amount for each made by company in every hour
SELECT 	 datepart( hour, transaction_hour) as hours, sum(convert(float,order_amt)) as sales
FROM [dbo].[RetailTransactions]
GROUP BY datepart( hour, transaction_hour)
Order by sales desc;

-- to get an output presenting Count of rewards which were genuine
SELECT COUNT(rewards_number)
FROM [dbo].[RetailTransactions]
WHERE rewards_member = 'TRUE';

-- to get an output presenting Count of rewards which were fake
SELECT 	COUNT(rewards_number)
FROM [dbo].[RetailTransactions]
WHERE 	rewards_member = 'FALSE';


-- to calculate the Discount % given to Customers in each city.
SELECT 	 location_city, 
sum(convert(float,discount_amt)) / Sum(convert(float,order_amt)) * 100 ,
round(sum(convert(float,discount_amt)) * 100 /Sum(convert(float,order_amt)),2) as Discount_perc
FROM [dbo].[RetailTransactions]
GROUP BY location_city
ORDER BY Discount_perc desc;

-- to give an output which represents total, max, min, avg Ordered Amount by Customers in each city
SELECT location_city, sum(convert(float,order_amt)), 
AVG(convert(float,order_amt)),
min(convert(float,order_amt)),
max(convert(float,order_amt))
FROM [dbo].[RetailTransactions]
GROUP BY location_city
ORDER BY SUM(convert(float,order_amt)) desc;

-- to give an output which represents total, max, min, avg Discount given to Customers in each city
SELECT location_city, sum(convert(float,discount_amt)),Round(AVG(convert(float,discount_amt)),2),min(convert(float,discount_amt)),
max(convert(float,discount_amt))
FROM [dbo].[RetailTransactions]
GROUP BY location_city
ORDER BY sum(convert(float,discount_amt)) desc;

-- to get an output which represents total, max, min, avg No.of Orders by Customers in each city
SELECT location_city, sum(convert(float,num_of_items)),
round(AVG(convert(float,num_of_items)),2),
min(convert(float,num_of_items)),
max(convert(float,num_of_items))
FROM [dbo].[RetailTransactions]
GROUP BY location_city
ORDER BY sum(convert(float,num_of_items)) desc;


-- to get an output for total sales of a state with the maximum city
SELECT location_state, location_city, 
sum(convert(float,order_amt)) as Sales
FROM [dbo].[RetailTransactions]
GROUP BY  location_state, location_city
ORDER BY location_state, sum(convert(float,order_amt)) desc;
	  


