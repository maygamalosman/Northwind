/*1- overview Report :
KPI’s : 1-Net sales  */

Select sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales 
From [Order Details] As od

/*2-Count of customers */
Select count(cst.customerid)
from Customers as cst

/*3- count of orders */
Select count(ord.OrderID)
from Orders as ord

/*4 - Avg days to ship the order */

create view days_to_ship_the_order as(
Select   DATEDIFF(day,ord.OrderDate,ord.ShippedDate) As duration_to_ship_the_order,ord.OrderID
from Orders as ord
group by ord.OrderID,ord.OrderDate,ord.ShippedDate)

Select AVG(days.duration_to_ship_the_order)
from days_to_ship_the_order as days

/*Charts : 
Net sales  over the time (months ) */

Create view Net_sales_over_the_time_month_and_years As(
Select  count (od.orderid)As No_of_orders, sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales,MONTH(ord.OrderDate)as Month,year(ord.OrderDate)as Year
from [Order Details]as od
left join orders as ord on ord.OrderID=od.OrderID
group by  MONTH(ord.OrderDate),year(ord.OrderDate)
)
Select *
from Net_sales_over_the_time_month_and_years 
order by month

/*Top 5 customers by net sales */
Create view Top_5_customers_per_net_sales As(
Select top 5 ord.CustomerID, sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales
from [Order Details]as od
left join orders as ord on ord.OrderID=od.OrderID
group by ord.CustomerID
order by Net_sales desc)

select*
from Top_5_customers_per_net_sales

/*Top 5 products by net sales */

Create view Top_5_products_per_net_sales As(
Select top 5 p.ProductName, sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales
from [Order Details]as od
left join orders as ord on ord.OrderID=od.OrderID
join Products as p on p.ProductID=od.ProductID
group by p.ProductName
order by Net_sales desc)

select*
from Top_5_products_per_net_sales

/*Net sales by countries ( present it using maps is a plus  )*/
Create View Net_sales_for_countries As(
Select sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales ,ord.ShipCountry
From [Order Details] As od
left join orders as ord on ord.OrderID=od.OrderID
group by ord.ShipCountry)

Select* 
from Net_sales_for_countries 
order by Net_sales Desc

__________________________________________________________________

/*2-Revenue Report: 

1-	Net profit */

Create view profits As(
Select od.orderid,count (od.orderid)As No_of_orders, sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales ,sum(p.UnitPrice*od.Quantity)As unit_cost ,(sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount))*.07) As profit, MONTH(o.OrderDate)as month
from [Order Details] as OD
left join Products as P 
on p.ProductID=od.ProductID
join Orders as o
on o.OrderID=od.OrderID
group by od.orderid,o.Freight,o.OrderDate)

select sum(profit)
from profits

/*2-	Total Discounts*/
Select sum(od.UnitPrice*od.Quantity*od.Discount)As discounts 
from [Order Details] as OD

/*3-	Shipping Cost*/
Select sum(o.Freight)As Shipping Cost

from orders as o

/*Charts :

Top 5 countries by net sales */
Create view Top_5_countries_per_net_sales As(
Select top 5 ord.ShipCountry, sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales
from [Order Details]as od
left join orders as ord on ord.OrderID=od.OrderID
group by ord.ShipCountry
order by Net_sales desc)

select*
from Top_5_countries_per_net_sales


/*Net sales , profits and discounts over the time */ 
create view Net_sales_profits_discounts_over_the_times_per_months_years As (
Select sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales ,(sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount))*(.07)) As profit,sum(od.UnitPrice*od.Quantity*od.Discount) As Discount , MONTH(ord.OrderDate)as month,year(ord.OrderDate)as year
from [Order Details] as OD
left join Products as P 
on p.ProductID=od.ProductID
join Orders as ord
on ord.OrderID=od.OrderID
group by MONTH(ord.OrderDate),year(ord.OrderDate)
)
Select * 
from Net_sales_profits_discounts_over_the_times_per_months_years
order by year


/*Top 5 countries by discounts */

Create View Top_scountries_perDiscount as (
Select top 5 sum(od.UnitPrice*od.Quantity*od.Discount) As Discount ,ord.ShipCountry
from [Order Details] as OD
join Orders as ord
on ord.OrderID=od.OrderID
group by ord.ShipCountry)

Select * from Top_scountries_perDiscount
Pivot table to show the net sales , net profit and Net sales YOY  for each countries.
create view YOY AS(
Select sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales ,(sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount))*(.07)) As profit,sum(od.UnitPrice*od.Quantity*od.Discount) As Discount ,ord.ShipCountry As Country, MONTH(ord.OrderDate)as month,year(ord.OrderDate)As year
from [Order Details] as OD
left join Products as P 
on p.ProductID=od.ProductID
join Orders as ord
on ord.OrderID=od.OrderID
group by ord.ShipCountry,ord.OrderDate)

Select * 
from YOY 

______________________________________________________________________

/*Customers Report :
1-  avg net sales  per customer 
2- avg profit   per customer 
4-	avg shipping cost per customer */ 

Select C.CustomerID,c.CompanyName,Avg (o.Freight) Avg_Frieght_cost,Avg((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Avg_Net_sales ,(Avg((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount))*.07) As Avg_profit,Avg(od.UnitPrice*od.Quantity*od.Discount) As Avg_Discount 
from Customers as C
join orders As o
on c.CustomerID=o.CustomerID
join [Order Details] as od
on o.OrderID=od.OrderID
join Products as p
on od.ProductID=p.ProductID
group by C.CustomerID,c.CompanyName

 /*Charts :

Count of customers over the time */
create view Customer_over_years as (
Select count(c.customerid)as coustomer_count ,year(o.OrderDate)As year
from customers as c
left join Orders as O
on c.customerid=o.CustomerID
group by year(o.OrderDate))


/*Count of customers by countries */

Create View customers_by_countries As (
Select count(c.customerid)as coustomer_count ,o.ShipCountry as Country
from customers as c
left join Orders as O
on c.customerid=o.CustomerID
group by o.ShipCountry)

Select *
from customers_by_countries


/*Count of new customers and repeated customers ( new customers :  who have not any purchases in 1996 or 1997 only in 1998  and they will be considered as new customers at that  case )*/

alter table customers
add customer_type nvarchar(30)

update customers 
set customer_type=(
Select case
when min (year(orderdate))<'1998' then 'loyal Customer'
else 'New customer'
end
from orders 
where Orders.customerid=Customers.customerid
group by orders.customerid)

Select *
from Customers

create view customer_type as (
select customerid,customer_type
from Customers)

/* Products report : 

1-Avg Net profit per order 
2- Avg Shipping cost per order 
3 - Avg Net sales per order */


Select  Avg((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As avg_Net_sales,
(Avg((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount))*(.07)) As Avg_profit,
Avg(od.UnitPrice*od.Quantity*od.Discount) As Avg_Discount ,Avg(o.Freight) As Avg_fright
from [Order Details]as od
join orders as o
  on od.orderid=o.OrderID

/*count of products */
select count(productid) 
from products
/*count of categories */
select count(categoryid) 
from products

/*percentage of discontinued products and products are selling */
	

WITH ProductCounts AS (
    SELECT
        COUNT(*) OVER () AS total_products,
        SUM(CASE WHEN discontinued <> 0 THEN 1 ELSE 0 END) OVER () AS discontinued_count,
        SUM(CASE WHEN discontinued = 0 THEN 1 ELSE 0 END) OVER () AS selling_count
    FROM products
),
PercentageCalculations AS (
    SELECT
        discontinued_count,
        selling_count,
        total_products,
        (discontinued_count * 100.0 / total_products) AS discontinued_percentage,
        (selling_count * 100.0 / total_products) AS selling_percentage
    FROM ProductCounts
)
SELECT TOP 1
    discontinued_count,
    selling_count,
    total_products,
    FORMAT(discontinued_percentage, 'N2') AS discontinued_percentage,
    FORMAT(selling_percentage, 'N2') AS selling_percentage
FROM PercentageCalculations;




/*Charts : 
1-Top 5 products  by net sales */
Create view Top_5_products_per_net_sales As(
Select top 5 p.ProductName, sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales
from [Order Details]as od
left join orders as ord on ord.OrderID=od.OrderID
join Products as p on p.ProductID=od.ProductID
group by p.ProductName
order by Net_sales desc)






/*Net sales and profits by categories */           
create view profit_netsales_by_Categories as(
Select Cat.CategoryName,sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales,
(sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount))*(.07)) As profit
from [Order Details] as od
join products as p on p.ProductID=od.ProductID
join Categories as cat on p.CategoryID=cat.CategoryID
group by Cat.CategoryName)
Select *
from profit_netsales_by_Categories


Create View Product_sales_profit as(
Select p.Productname,sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Net_sales,
(sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount))*(.07)) As profit
from [Order Details] as od
join products as p on p.ProductID=od.ProductID
group by p.Productname)
Select*
from Product_sales_profit


/*2-	Employee Report 

net sales per employee  or avg , count Orders per employee  or avg */

Select (E.FirstName +' '+E.LastName) AS name, sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Total_sales,
Avg((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Avg_sales,
Count(od.orderid)As Count_of_orders ,
(sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount))*(.07)) As profit
From [order details] as od
join orders as o
on od.orderid=o.orderid
join employees as e
on o.employeeid=e.employeeid
group by e.FirstName, e.LastName;

/*count of employees or avg */
Select count(e.employeeid) as employees 
from employees as e

/*count of supervisors  or avg */

Select  COUNT(e.employeeid) AS Count_of_Supervisors
from Employees as e
where e.reportsto <5 or e.reportsto is NULL


/*Charts : 
         Monthly  Net sales by employees //
          Count of the orders and net sales by the employees  (employee performance )*/

Create view Employee_sales_orders_profit_per_month as(
Select (E.FirstName +' '+E.LastName) AS name, sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Total_sales,
Avg((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) As Avg_sales,
sum(od.orderid)As Count_of_orders ,
(sum((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount))*(.07)) As profit,MONTH(o.OrderDate)as month,year(o.OrderDate)As year
From [order details] as od
join orders as o
on od.orderid=o.orderid
join employees as e
on o.employeeid=e.employeeid
group by E.FirstName, E.LastName,MONTH(o.OrderDate),year(o.OrderDate))
Select* from  Employee_sales_orders_profit_per_month 
order by profit desc

 /*Delayed orders and on time orders by employees */
create view  late_ontime_orders as (
Select e.FirstName + ' ' + e.LastName as Name, count(o.OrderID) as Count_of_Orders,
    sum(case
            when o.ShippedDate <= o.RequiredDate then 1 
            else 0 
        end) as Count_of_On_Time,
    sum(case 
            when o.ShippedDate > o.RequiredDate then 1 
            else 0 
        end) as Count_of_Delayed
from Orders o
join Employees e on o.EmployeeID = e.EmployeeID
	where ShippedDate IS NOT NULL
group by e.FirstName,e.LastName
)

Select*
from late_ontime_orders
order by name


/*3-	Shippers Report :  

Shipping cost by order */
Select o.orderid,sum (o.Freight) fright_cost
from orders as o
group by o.orderid



/*Avg days to ship */
create view days_to_ship_the_order as(
Select   DATEDIFF(day,ord.OrderDate,ord.ShippedDate) As duration_to_ship_the_order,ord.OrderID
from Orders as ord
group by ord.OrderID,ord.OrderDate,ord.ShippedDate)

Select AVG(days.duration_to_ship_the_order)
from days_to_ship_the_order as days






/*Charts : 
 

Shipping cost by the shippers  */
Create view Shipping_cost_per_company As(
Select s.companyname As company,sum (o.freight) as shipping_cost
from orders as o
join shippers as s
on s.shipperid=o.shipvia
group by s.companyname)
 Select *
 from Shipping_cost_per_company
order by shipping_cost DESC

/*On time  vs delayed  orders  by shipper ( delivery performance ) */

create view delivery_performance as (
Select s.companyname As company,
    sum(case
            when o.ShippedDate <= o.RequiredDate then 1 
            else 0 
        end) as orderst_of_On_Time,
    sum(case 
            when o.ShippedDate > o.RequiredDate then 1 
            else 0 
        end) as orders_Delayed
from orders as o
join shippers as s
on o.ShipVia=s.ShipperID
where ShippedDate IS NOT NULL
group by s.companyname
)

Select * from  delivery_performance


/*Shipping cost by the countries and shippers */
Create view shipcost_country_company As (
Select s.companyname As company,sum (o.Freight)As shipping_cost,o.shipcountry
from orders as o
join shippers as s
on o.ShipVia=s.ShipperID
group by s.companyname,o.shipcountry)

Select*
from shipcost_country_company




/*Shippers table to show the next details : */





Create View Shipping_companies_performance_per_years as (
select s.CompanyName,count(o.orderid) count_of_orders,
	sum(case
            when o.ShippedDate <= o.RequiredDate then 1 
            else 0 
        end) as orderst_of_On_Time,
    sum(case 
            when o.ShippedDate > o.RequiredDate then 1 
            else 0 
        end) as orders_Delayed,
    AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) AS Avg_Days_To_Ship,
   ( sum(od.UnitPrice * od.Quantity * p.UnitPrice) / SUM(od.Quantity)) AS Avg_Shipping_Cost_Per_Order,sum(od.UnitPrice * od.Quantity) AS Net_Sales,year(o.ShippedDate) as year

from Orders o

JOIN [Order Details] od 
on o.OrderID = od.OrderID
join Products p
on od.ProductID = p.ProductID
JOIN  Shippers s 
on o.ShipVia = s.ShipperID
where o.ShippedDate IS NOT NULL
group by s.CompanyName,year(o.ShippedDate))

Select *
from Shipping_companies_performance_per_years
