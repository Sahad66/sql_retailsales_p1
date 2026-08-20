--sql retails sales project-1



--create table 
DROP TABLE IF EXISTs retail_sales;
create table retail_sales
			(
				transection_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(20),
				age INT,
				category VARCHAR(15),
				quantity INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			);
drop table retail_sales

select * from retail_sales;
--count rows
select count(*) from retail_sales;

--Deta Cleaning

--NULL CHECK
select * from retail_sales
WHERE transection_id IS NULL

select * from retail_sales
WHERE sale_date IS NULL


select * from retail_sales
WHERE sale_time IS NULL


SELECT * FROM retail_sales
--null delelte
DELETE FROM retail_sales
WHERE 
    transection_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;



	--null delate 
	DELETE FROM retail_sales





-------------------------------------------------
-- How many Sales We have?
select count(*) as total_sale from retail_sales

---- How many UNIQUE Customers We have?
select count(DISTINCT customer_id) as customer_id from retail_sales

---- How many Category We have?
select DISTINCT category from retail_sales

-- Data  Analysis & Business kry problem and answear 

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


	-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

	select * 
	from retail_sales
	where sale_date = '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

	select 
		*
	from retail_sales
	where category = 'Clothing'
		AND 
		TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
		AND 
		quantity>=4
	
---- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
	select 
	category,
	sum(total_sale) as net_sale,
	count(*) as total_orders
	from retail_sales
	group by 1


---- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

	select
	round(avg(age),2 ) as avg_age
	from retail_sales
	where category = 'Beauty'
	



---- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > 1000


---- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
	category,
	gender,
	count(*) as total_transection
from retail_sales
group by 
		category,
		gender
order by 1



---- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select
	year ,
	month,
	avg_sales
from
	(select 
		EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
		avg(total_sale) as avg_sales,
		rank() over(partition by extract ( year from sale_date) order by avg (total_sale) desc)
	from retail_sales
	group by 1,2
	) as t1
where rank = 1
--order by 1,3 desc

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select 
	customer_id,
	sum(total_sales) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5 

---- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select
		category,
		count(distinct customer_id) as cnt_unique_cs
from retail_sales
group by category


---- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
as
	(
	select *,
		case 
			when extract(hour from sale_time) < 12 then 'Morning'
			when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
			else 'Evening'
		end as shift
	from retail_sales
)
select 
	shift,
	count(*) as total_orders
	from hourly_sale
group by shift





	

