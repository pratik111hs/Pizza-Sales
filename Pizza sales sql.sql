select SUM(total_price) as total_revenue from pizza_sales

select * from pizza_sales

select SUM(total_price)/COUNT(distinct order_id) as Avg_Order_Value
from pizza_sales

select SUM(quantity) as Total_Pizza_Sold
from pizza_sales

select Count(distinct order_id) as Total_Orders_Placed
from pizza_sales 

select SUM(quantity)/Count(distinct order_id) as Avg_Pizza_Per_Order
from pizza_sales

select CAST(CAST(SUM(quantity) AS decimal(10,2))/CAST(Count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_Pizza_Per_Order
from pizza_sales

-- Daily Trend For Total Orders --

select DATENAME(DW,order_date) as Order_Day , COUNT(distinct order_id ) as Total_Orders
from pizza_sales
group by  DATENAME(DW,order_date)

-- Monthly Trend fot Total Orders

select DATENAME(MONTH,order_date) as Order_Month , COUNT(distinct order_id ) as Total_Orders
from pizza_sales
group by  DATENAME(MONTH,order_date)
order by Total_Orders Desc


-- % of sales by pizza category --

select pizza_category ,SUM(total_price) as Total_Sales, SUM(total_price)/ (select sum(total_price) from pizza_sales) * 100  as Sales_Per_Category
from pizza_sales
group by pizza_category
order by Sales_Per_Category Desc

-- For January --

select pizza_category ,SUM(total_price) as Total_Sales, SUM(total_price)/
(select sum(total_price) from pizza_sales where Month(order_date) = 1) * 100  as Sales_Per_Category
from pizza_sales
where Month(order_date) = 1
group by pizza_category
order by Sales_Per_Category Desc

-- % of sales by pizza size --


select pizza_size ,CAST(SUM(total_price) as decimal(10,2)) as Total_Sales, CAST(SUM(total_price)/
(select sum(total_price) from pizza_sales ) * 100 as decimal(10,2))  as Sales_Per_Size
from pizza_sales
group by pizza_size
order by Sales_Per_Size Desc

-- for 1st quarter

select pizza_size ,CAST(SUM(total_price) as decimal(10,2)) as Total_Sales, CAST(SUM(total_price)/
(select sum(total_price) from pizza_sales where DATEPART(quarter,order_date)=1 ) * 100 as decimal(10,2))  as Sales_Per_Size
from pizza_sales
where DATEPART(quarter,order_date)=1
group by pizza_size
order by Sales_Per_Size Desc

-- Top 5 and Bottom 5 sellers by revenue,total quantity , total orders --

select top 5 pizza_name , sum(total_price) as Tot_Revenue
from pizza_sales
group by pizza_name
order by Tot_Revenue Desc

select top 5 pizza_name , sum(total_price) as Tot_Revenue
from pizza_sales
group by pizza_name
order by Tot_Revenue Asc

select top 5 pizza_name , sum(quantity) as Tot_Quantity
from pizza_sales
group by pizza_name
order by Tot_Quantity Desc

select top 5 pizza_name , sum(quantity) as Tot_Quantity
from pizza_sales
group by pizza_name
order by Tot_Quantity Asc

select top 5 pizza_name , count(distinct order_id) as Tot_Orders
from pizza_sales
group by pizza_name
order by Tot_Orders Desc

select top 5 pizza_name , count(distinct order_id) as Tot_Orders
from pizza_sales
group by pizza_name
order by Tot_Orders Asc
