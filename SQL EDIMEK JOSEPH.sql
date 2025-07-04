create database SQLproject

-------IMPORT CSV FILE INTO DB------
--KMS Sql Case Study.CSV

select * from kms

---------- 1 WHICH PRODUCT CATEGORY HAD THE HIGHEST SALES?-----------

-- Answer - TECHNOLOGY with total sales 5984248.1754

---ANALYSIS---
select [product_category],
sum(sales) As totalsales
from [KMS]
group by [product_category]
order by totalsales desc


----------2 WHAT ARE THE TOP 3 AND BOTTOM 3 REGIONS IN TERMS OF SALES?--------

-- Answer Top 3 
-- WEST with sales 3597549.2698
-- ONTARIO with sales 3063212.4763 
-- and PRARIE with 2837304.6050

---ANALYSIS---
select top 3 [region],
sum(sales) As totalsales
from [KMS]
group by [region]
order by totalsales desc

--Answer for bottom 3
--NUNAVUT with sales 116376.4838
--NORTHWEST TERRITORIES with sales 800847.3309
--YUKON with sales 975867.3757

---ANALYSIS---
select top 3 [region],
sum(sales) As totalsales
from [KMS]
group by [region]
order by totalsales asc

----------3 WHAT WERE THE TOTAL SALES OF APPLIANCES IN ONTARIO?---------

--Answer - 202346.8396

---ANALYSIS---
select Region,
sum(sales) As Total_sales_of_appliances
from [KMS]
where product_Sub_Category = 'Appliances'
     and Province = 'Ontario'
group by Region;


----------4 ADVISE THE MANAGEMENT OF KMS ON WHAT TO DO TO INCREASE THE REVENUE FROM THE BOTTOM 10 CUSTOMERS

---ANALYSIS----
select top 10 [customer_Name], 
sum(sales) As Totalsales
from [KMS]
group by customer_Name
order by [Totalsales] asc;

--Answer - KMS should render services and sell product that is the felt need of a locality
-- they should sometimes offer discount to customer. 
--Looking at region like NUNAVUT there is not profit at all, so the company should know what the area needs and supply with an affordable price, so that those bottom customers can be among the top and boost the profit.

---ANALYSIS----
select Region,
sum(sales) As Total_sales_of_Profit
from [KMS]
where product_Sub_Category = 'profit'
     and Province = 'Nunavut'
group by Region;


----------5 KMS incurred the most shipping cost using which shipping method?

--Answer- DELIVERY TRUCK with shipping cost 51971.9397

--ANALYSIS---
select top 1 [ship_mode], 
sum(shipping_cost) As [Total Shipping Cost]
from [KMS]
group by ship_mode
order by [total shipping cost] desc


----------6 WHO ARE THE MOST VALUABLE CUSTOMERS, AND WHAT PRODUCTS OR SERVICES DO THEY TYPICALLY PURCHASE? ---------

--ANALYSIS--
select [customer_name], product_name,
sum(sales) as totalsales
from [KMS]
group by customer_name, product_name
order by [totalsales] desc;


----------7 WHICH SMALL BUSINESS CUSTOMER HAD THE HIGHEST SALES?------------

--Answer - DENNIS KANE with sales 75967.5932

--ANALYSIS--
select top 1 [customer_name], customer_segment,
sum(sales) as [totalsales]
from [KMS]where customer_segment = 'small business'
group by customer_name, customer_segment
order by [totalsales] desc;


----------8 WHICH CORPORATE CUSTOMER PLACED THE MOST NUMBER OF ORDERS IN 2009 - 2012?---------

--Answer - ADAM HART with total order 19

--ANALYSIS--
select top 1 [customer_name], customer_segment,
count(order_id) as totalorder
from [KMS]
where customer_segment = 'corporate' 
and order_date between '2009' and '2012'
group by customer_name, customer_segment
order by [totalorder] desc;


----------9 WHICH CONSUMER CUSTOMER WAS THE MOST PROFITABLE ONE?--------

--Answer - EMILY PHAN with profit 34005.4392

--ANALYSIS--
select top 1 [customer_name], customer_segment,
sum(profit) as totalprofit
from [KMS]
where customer_segment = 'consumer' 
group by customer_name, customer_segment
order by [totalprofit] desc;


----------10 WHICH CUSTOMER RETURNED ITEMS, AND WHAT SEGMENT DO THEY BELONG TO?--------

--Answer-


--ANALYSIS-
SELECT DISTINCT o.[order_ID], o.[customer_name], o.[customer_segment],
FROM [dbo].[KMS],
join [dbo].[order_status]r ON o.[orderid] = r.[order_ID]
where r.Status = 'returned';


----------11 IF THE DELIVERY TRUCK IS THE MOST ECONOMICAL BUT THE SLOWEST SHIPPING METHOD AND EXPRESS AIR IS THE FASTEST BUT THE MOST EXPENSIVE ONE, DO YOU THINK THE COMPANY APPROPRIATELY SPENT SHIPPING COSTS BASED ON THE ORDER PRIORITY? EXPLAIN YOUR ANSWER

select [order_priority], [ship_mode], count([order_id]) as ordercount,
round(sum(sales - profit),2) AS estimatedshippingcost,
AVG(DATEDIFF(day,[order_date],[ship_date])) AS Avgshipdays
FROM [KMS]
GROUP BY [order_priority], [ship_mode]
ORDER BY [Order_priority],[ship_mode] desc;
