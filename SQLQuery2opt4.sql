--Q1
select p.ProductID,p.Name,p.Color,p.ListPrice from Production.Product p
--Q2
select p.ProductID,p.Name,p.Color,p.ListPrice from Production.Product p
where ListPrice!=0.00
--Q3
select p.ProductID,p.Name,p.Color,p.ListPrice from Production.Product p
where Color is null 
--Q4
select p.ProductID,p.Name,p.Color,p.ListPrice from Production.Product p
where not Color is null 
--Q5
select p.ProductID,p.Name,p.Color,p.ListPrice from Production.Product p
where NOT Color is null and ListPrice!=0.00
--Q6 concat : nối cột
select concat(p.Name ,': ', p.Color) as 'Name And Color' from Production.Product p
where not Color is null 
--Q7
select concat('Name: ',p.Name ,' -- COLOR: ', p.Color) as 'Name And Color' from Production.Product p
where not Color is null 
--Q8
select p.ProductID,p.Name from Production.Product p
where 400<=ProductID and ProductID<500
--Q9
select p.ProductID,p.Name,p.Color from Production.Product p
where Color in ('Black','Blue')
--c2
select p.ProductID,p.Name,p.Color from Production.Product p
where Color='Black' or Color='Blue'
--Q10
select p.Name , p.ListPrice from Production.Product p
where Name like 'S%'
--Q11
select p.Name , p.ListPrice from Production.Product p
where Name like 'S%' or Name like 'A%'
--Q12
select p.Name , p.ListPrice from Production.Product p
where Name like 'SPO[^k]%' 
--Q13
select distinct p.Color  from Production.Product p
 --Q14
 select distinct p.ProductSubcategoryID , p.Color from Production.Product p
where not ProductSubcategoryID is null and not Color is null order by ProductSubcategoryID asc
--Q15
SELECT ProductSubCategoryID
      , LEFT([Name],35) AS [Name]
      , Color, ListPrice
FROM Production.Product
WHERE Color IN ('Red','Black')
       AND ProductSubCategoryID = 1
	   or ListPrice BETWEEN 1000 AND 2000
     
ORDER BY ProductID

--16

select Name,isnull(Color,'Unknown') Color, ListPrice from Production.Product 


--ex2
--Q1
select COUNT(ProductID)from Production.Product
--Q2
select COUNT(ProductID)from Production.Product where not ProductSubcategoryID is null
--Q3
select ProductSubcategoryID, count(*)  CountedProducts from Production.Product
group by ProductSubcategoryID
--Q4 having nằm dưới group by (nhớ chứ k cay vãi)
select count(*)  from Production.Product 
group by  ProductSubcategoryID 
having ProductSubcategoryID is null
--?
select count(*)  from Production.Product
where ProductSubcategoryID is null
group by ProductSubcategoryID
--Q5

select distinct ProductID ,sum(Quantity)  TheSum from Production.ProductInventory
group by ProductID
--Q6
select distinct ProductID ,sum(Quantity)  TheSum from Production.ProductInventory
where LocationID =40 
group by ProductID
having sum(Quantity)<100
--Q7

select distinct Shelf, ProductID ,sum(Quantity)  TheSum from Production.ProductInventory
where LocationID =40 
group by Shelf,ProductID
having sum(Quantity)<100 

--Q8
select avg(Quantity) from Production.ProductInventory
where LocationID=10
--Q9
select ProductID, Shelf,avg(Quantity) as 'TheAvg' from Production.ProductInventory
where  LocationID=10 and Shelf!='N/A'
group by rollup(Shelf,ProductID ) 
order by Shelf
--Q10
select Color,Class,count(*) as TheCount, AVG(ListPrice) as AvgPrice from Production.Product
where Color is not null and Class is not null  
group by
grouping sets (Color,Class)
--Q11

SELECT ProductSubcategoryID
      , COUNT(Name) as Counted
	  ,grouping (ProductSubcategoryID)  as IsGrandTotal
FROM Production.Product
GROUP BY ROLLUP (ProductSubcategoryID)
order by ProductSubcategoryID