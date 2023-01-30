--Checking Coffee Shop Data:
SELECT *
FROM PortfolioProject..Coffeeshop

--Checking Item and Price Data
SELECT *
FROM PortfolioProject..Itemsandprice

--Selecting Required Data:
SELECT Items, Price
FROM PortfolioProject..Itemsandprice

--Rearrange All Tables:
SELECT TransactionNo, Items, Day, Month, Year, DayType, Daypart
FROM PortfolioProject..Coffeeshop

--Joing Both Tables And Creating New Table:
SELECT TransactionNo, Coffeeshop.Items,Price, Day, Month, Year, DayType, Daypart
INTO CombinedTables
FROM PortfolioProject..Coffeeshop
INNER JOIN PortfolioProject..bakeryitem ON Itemsandprice.Items = Coffeeshop.Items;

--Checking New Table:
SELECT TransactionNo,Items,Price, Day, Month, Year, DayType, Daypart
FROM CombinedTables

--Customer Daily Count:
SELECT Day, Month, Year, DailyCustomers = COUNT(TransactionNo) 
FROM CombinedTables
GROUP BY Day, Month, Year ORDER BY DailyCustomers DESC;


--Total Customer Count Weekday And Weekend Per Year:
SELECT Year, DayType, Total=COUNT(TransactionNo)
FROM CombinedTables
WHERE DayType = 'Weekend' OR DayType = 'Weekday'
GROUP BY Year,DayType ORDER BY Year DESC


--Total Customer Count 2021 And 2020:
SELECT Year, Total=COUNT(Year)
FROM CombinedTables
WHERE Year = '2021' OR Year = '2020' 
GROUP BY Year

--Customer Count During Different Part Of Day:
SELECT  Daypart, DaypartCount= COUNT(Daypart)
FROM CombinedTables
WHERE Daypart IN ('Morning', 'Afternoon', 'Evening', 'Night')
GROUP BY Daypart ORDER BY DaypartCount DESC;

--Daily Items Count:
SELECT  Year, DayType, Daypart, DaypartCount= COUNT(Daypart)
FROM CombinedTables
WHERE Daypart IN ('Morning', 'Afternoon', 'Evening', 'Night')
GROUP BY Year, DayType, Daypart ORDER BY DaypartCount DESC;

--Overall Items Count:
SELECT Items, ItemCount= COUNT(Items)
FROM CombinedTables
GROUP BY Items ORDER BY COUNT(Items) DESC;

--Total Sale In 2021:
SELECT Year, Total = SUM(CAST(Price AS decimal(8,2))) 
FROM CombinedTables
 --WHERE Year = 2020
WHERE Year LIKE 2021
GROUP BY Year

--Total In Sale Per Year:
SELECT Year, TotalSaleGBP = SUM(CAST(Price AS decimal(8,2))) 
FROM CombinedTables
GROUP BY Year

--Customer Perchased More Than 5 Items:
SELECT TransactionNo, Itempurchased = COUNT(TransactionNo) 
FROM CombinedTables
GROUP BY TransactionNo
HAVING COUNT(TransactionNo) > 5
ORDER BY COUNT(TransactionNo)  DESC; 

--Coffee Sale Per Year:
SELECT Year, Items, ItemCount= COUNT(Items),TotalSaleGBP = SUM(CAST(Price AS decimal(8,2))) 
FROM CombinedTables
WHERE Items = 'Coffee'
GROUP BY Year, Items ORDER BY COUNT(Items) DESC;

--Coffee Sale Per Month:
SELECT Year, Month,DayType, Items, ItemCount= COUNT(Items),TotalSaleGBP = SUM(CAST(Price AS decimal(8,2))) 
FROM CombinedTables
WHERE Items = 'Coffee'
GROUP BY Year,Month,DayType, Items ORDER BY COUNT(Items) DESC;

--Coffee Sale Per Day:
SELECT Year,Day,Items, ItemCount= COUNT(Items),TotalSaleGBP = SUM(CAST(Price AS decimal(8,2))) 
FROM CombinedTables
WHERE Items = 'Coffee'
GROUP BY Year,Day,Items ORDER BY COUNT(Items) DESC;
