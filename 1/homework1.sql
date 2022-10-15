--Q1 Get all unique ShipNames from the Order table that contain a hyphen '-'.
--Details: In addition, get all the characters preceding the (first) hyphen. Return ship 
--names alphabetically. Your first row should look like Bottom-Dollar Markets|Bottom
SELECT
	DISTINCT ShipName,
	SUBSTRING(ShipName, 0, INSTR(shipname, "-"))
FROM
	"Order" o
WHERE
	ShipName LIKE "%-%"
ORDER BY
	ShipName ;

--Q2 Indicate if an order's ShipCountry is in North America. For our purposes, this 
--is 'USA', 'Mexico', 'Canada'
--Details: You should print the Order Id, ShipCountry, and another column that is 
--either 'NorthAmerica' or 'OtherPlace' depending on the Ship Country.
--Order by the primary key (Id) ascending and return 20 rows starting from Order 
--Id 15445 Your output should look 
--like 15445|France|OtherPlace or 15454|Canada|NorthAmerica

SELECT
	*
FROM
	(
	SELECT
		DISTINCT Id ,
		ShipCountry,
		"NorthAmerica" AS "InNorthAmerica"
	FROM
		"Order" o
	WHERE
		ShipCountry IN ("USA", "Mexico", "Canada")
		AND 
		Id >= 15445
UNION
	SELECT
		DISTINCT Id ,
		ShipCountry,
		"OtherPlace" AS "InNorthAmerica"
	FROM
		"Order" o
	WHERE
		ShipCountry NOT IN ("USA", "Mexico", "Canada")
		AND 
		Id >= 15445)
ORDER BY
	Id ASC
LIMIT 20;

--Q3 For each Shipper, find the percentage of orders which are late.
--Details: An order is considered late if ShippedDate > RequiredDate. Print the 
--following format, order by descending precentage, rounded to the nearest 
--hundredths, like United Package|23.44
SELECT
	t1.CompanyName,ROUND((late + 0.0) / (total + 0.0),4) * 100 AS "DelayPercent"
FROM
	(
	SELECT
		COUNT(*) late,
		CompanyName
	FROM
		"Order" o
	JOIN Shipper s ON
		o.ShipVia = s.Id
	WHERE
		o.ShippedDate > o.RequiredDate
	GROUP BY
		s.Id) t1,
	(
	SELECT
		COUNT(*) total,
		CompanyName
	FROM
		"Order" o
	JOIN Shipper s ON
		o.ShipVia = s.Id
	GROUP BY
		s.Id) t2
	WHERE t1.CompanyName = t2.CompanyName
	ORDER BY DelayPercent DESC;

--Q4 Compute some statistics about categories of products
--Details: Get the number of products, average unit price (rounded to 2 decimal 
--places), minimum unit price, maximum unit price, and total units on order for 
--categories containing greater than 10 products.
--Order by Category Id. Your output should look like Beverages|12|37.98|4.5|263.5|60
SELECT
	CategoryName,
	COUNT(*) ProductNumber,
	ROUND(AVG(UnitPrice),2) AvgUnitPrice,
	MIN(UnitPrice) MinUnitPrice,
	MAX(UnitPrice) MaxUnitPrice,
	SUM(UnitsOnOrder) UnitsOnOrderSum
FROM
	Category c
JOIN Product p ON
	c.Id = p.CategoryId
GROUP BY
	p.CategoryId
HAVING ProductNumber > 10
ORDER BY CategoryId;





SELECT COUNT(*) total FROM "Order" o JOIN Shipper s ON o.ShipVia = s.Id  GROUP BY s.Id T
ON LC.Id = T.Id;
SELECT * FROM OrderDetail od ;
SELECT * FROM Employee e ;
SELECT * FROM Category c ;
SELECT * FROM Supplier s2 ;
SELECT * FROM Shipper s ;
SELECT * FROM Territory t ;
SELECT * FROM Customer c ;
SELECT * FROM CustomerCustomerDemo  cd ;
SELECT * FROM Product p ;
SELECT * FROM Region r ;












