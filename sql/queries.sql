--1. Create Account 
INSERT INTO "User" VALUES (12345678,'JP','JP%2210','jp2210@gmail.com');




--2. Update Personal Details 
UPDATE Trader SET Mobile_NO='+919192939495' WHERE Login_ID=12345678;




--3. Change Password
UPDATE "User" SET Password='JP#2210' WHERE Login_ID=12345678;




--4. Search a particular stock based on stock symbol
SELECT * FROM Stock WHERE StockSymbol='PTLOPBLEZSMRKLD';




--5. Search a particular stock based on company name
SELECT * FROM Stock WHERE Company_Name='Oozz';




--6. Search stocks whose current price is between 2000 to 5000
SELECT * FROM Stock WHERE Curr_Price>=2000 AND Curr_Price<=5000;


--7. Search  cheapest stock
SELECT * FROM Stock ORDER BY Curr_Price LIMIT 1;


--8. See stocks in ascending order of price
SELECT * FROM Stock ORDER BY Curr_Price;


--9. Search most expensive stock
SELECT * FROM Stock ORDER BY Curr_Price DESC LIMIT 1;


--10. See stocks in descending order of price
SELECT * FROM Stock ORDER BY Curr_Price DESC;






--11. Search a particular stock based on sector of the company
SELECT * FROM Stock JOIN Company ON Company_Name=Name  WHERE Sector='Media';






--12. Search a particular stock based on Revenue
SELECT * FROM Stock JOIN Company ON Company_Name=Name  WHERE Revenue>=10000000 AND Revenue<=100000000000;


--13. Search a stock whose company’s revenue is highest
SELECT * FROM Stock JOIN Company ON Company_Name=Name  ORDER BY Revenue DESC LIMIT 1;






--14. Search a Most bought Stock in specified duration
SELECT StockSymbol, StockExchange, SUM(Quantity) AS Total_Bought_Quantity
FROM (SELECT * FROM StockOrder WHERE Status='Approved' AND Buy_Or_Sell='Buy' AND purchase_Date>= DATE'2005-06-29' AND purchase_Date <= DATE '2022-06-29') AS Orders
GROUP BY StockSymbol, StockExchange
ORDER BY Total_Bought_Quantity DESC
LIMIT 1;


--15. Search a Most sold Stock in specified duration
SELECT StockSymbol,StockExchange,sum(Quantity) AS Total_Bought_Quantity
FROM (SELECT * FROM StockOrder WHERE Status='Approved' AND Buy_Or_Sell='Sell' purchase_Date>= DATE'2005-06-29' AND purchase_Date <= DATE '2022-06-29') AS Orders
GROUP BY StockSymbol,StockExchange ORDER BY Total_Bought_Quantity DESC LIMIT 1;




--16. Buy stock based on price
INSERT INTO StockOrder VALUES ('PTLOPBLEZSMRKLD','NSE',56426096,CURRENT_DATE,CURRENT_TIME,100,10,'Buy','Pending');




--17. Sell  stock based on price
INSERT INTO StockOrder VALUES ('PTLOPBLEZSMRKLD','NSE',56426096,CURRENT_DATE,CURRENT_TIME,100,10,'Sell','Pending');




--18. Overall buying of particular stock in interval
SELECT StockSymbol,StockExchange,sum(Quantity) AS Total_Bought_Quantity
FROM (SELECT * FROM StockOrder WHERE Status='Approved' AND Buy_Or_Sell='Buy' AND purchase_Date>=DATE '2005-06-29' AND purchase_Date<=DATE '2022-06-29') AS Orders
GROUP BY StockSymbol,StockExchange HAVING StockSymbol='PTLOPBLEZSMRKLD' AND StockExchange='NSE';


--19. Overall selling of particular stock in interval
SELECT StockSymbol,StockExchange,sum(Quantity) AS Total_Bought_Quantity
FROM (SELECT * FROM StockOrder WHERE Status='Approved' AND Buy_Or_Sell='Sell' AND purchase_Date>=DATE '2005-06-29' AND purchase_Date<=DATE '2022-06-29') AS Orders
GROUP BY StockSymbol,StockExchange HAVING StockSymbol='PTLOPBLEZSMRKLD' AND StockExchange='NSE';




--20. Add Stock from Watchlist
INSERT INTO STOCK_WATCHLIST VALUES ('PTLOPBLEZSMRKLD','NSE',56426096);


--21. Remove Stock from Watchlist
DELETE FROM STOCK_WATCHLIST WHERE StockSymbol='PTLOPBLEZSMRKLD' AND StockExchange='NSE' AND Login_ID=56426096;




--22. Search upcoming IPO
SELECT * FROM IPO WHERE Startdate>=CURRENT_DATE;




--23. Bid for IPO
INSERT INTO Bidded VALUES ('Oozz','NSE','2005-04-07','2005-04-27',56426096,'PENDING',1);




--24. Add IPO from Watchlist
INSERT INTO IPO_WATCHLIST VALUES ('Oozz','NSE','2005-04-07','2005-04-27',56426096);


--25. Remove IPO from Watchlist
DELETE FROM IPO_WATCHLIST WHERE Company_Name='Oozz' AND Stockexchange='NSE' AND Startdate='2005-04-07' AND Enddate='2005-04-27' AND Login_ID=56426096;






--26. Find Listing Date for IPO
SELECT Listing_Date FROM IPO WHERE Company_Name='Oozz' AND Stockexchange='NSE' AND Startdate='2005-04-07' AND Enddate='2005-04-27';




--27. See current holdings of Stock
SELECT * FROM Owns WHERE Login_ID=56426096;




--28. See list of IPO for which user applied
SELECT * FROM Bidded WHERE Login_ID=56426096;








--29. Add Bank Account
INSERT INTO Bank_Account VALUES ('State Bank Of India','203124203123','SBIN0016737',56426096);




--30. Add Money in Bank Account From Wallet
INSERT INTO Transaction VALUES ('DT222222228','Net Banking','Credit',20000,'State Bank Of India','APPROVED','203124203123',CURRENT_DATE,CURRENT_TIME);
UPDATE Trader SET Wallet_Amount=Wallet_Amount+20000;






--31. Withdraw Money in Bank Account From Wallet
INSERT INTO Transaction VALUES ('DT222222229','Net Banking','Debit',20000,'State Bank Of India','APPROVED','203124203123',CURRENT_DATE,CURRENT_TIME);
UPDATE Trader SET Wallet_Amount=Wallet_Amount-20000;






--32. Overall Transaction Report for a Bank Account of Trader
SELECT * FROM Transaction WHERE Bank_Ac_No='203124203123' AND Bank_Name='SBIN0016737';


--33. Total Credited money in particular Bank Account
SELECT sum(Amount)
FROM (SELECT * FROM Transaction WHERE Credit_or_Debit='Credit') AS credit_transaction
GROUP BY Bank_Ac_No,Bank_Name HAVING Bank_Ac_No='203124203123' AND Bank_Name='SBIN0016737';


--34. Total Debited  money in particular Bank Account
SELECT sum(Amount)
FROM (SELECT * FROM Transaction WHERE Credit_or_Debit='Debit') AS debit_transaction
GROUP BY Bank_Ac_No,Bank_Name HAVING Bank_Ac_No='203124203123' AND Bank_Name='SBIN0016737';












--35. Search and get details of Mutual Fund
SELECT * FROM Mutual_Funds WHERE MFSymbol='ZOR2X' AND StockExchange='BSE';








--36. See the collection of stocks for Mutual fund for given duration
SELECT * FROM Is_Collection_Of WHERE MFSymbol='ZOR2X' AND MF_StockExchange='BSE' AND Duration && tstzrange('2000-01-01', '2016-12-31', '[]');


--37. Buy Mutual Funds
INSERT INTO Mutual_Funds_Orders VALUES ('ZOR2X','BSE',56426096,CURRENT_DATE,CURRENT_TIME,100,10,'Buy','Pending');


--38. Sell Mutual Funds
INSERT INTO Mutual_Funds_Orders VALUES ('ZOR2X','BSE',56426096,CURRENT_DATE,CURRENT_TIME,10,10,'Sell','Pending');




--39. Overall Buying of particular Mutual fund in specified duration
SELECT MFSymbol,StockExchange,sum(Quantity) AS Total_Bought_Quantity
FROM (SELECT * FROM Mutual_Funds_Orders WHERE Status='Approved' AND Buy_Or_Sell='Buy' AND purchase_Date>=DATE '2005-05-06' AND purchase_Date<=DATE '2022-01-31') AS Orders
GROUP BY MFSymbol,StockExchange HAVING MFSymbol='ZOR2X' AND StockExchange='BSE';






--40. Add Mutual Fund from watchlist
INSERT INTO Mutual_Fund_Watchlist VALUES ('ZOR2X','BSE',56426096);








--41. Remove Mutual Fund from watchlist
DELETE FROM Mutual_Fund_Watchlist WHERE MFSymbol='ZOR2X' AND StockExchange='BSE' AND Login_ID=56426096;






--42. Search Mutual Funds whose price is between 800 and 10000
SELECT * FROM Mutual_Funds WHERE Curr_Price>=800 AND Curr_Price<=10000;


--43. Search cheapest Mutual Fund
SELECT * FROM Mutual_Funds ORDER BY Curr_Price LIMIT 1;


--44. See Mutual funds in ascending order of price
SELECT * FROM Mutual_Funds ORDER BY Curr_Price;


--45. Search most expensive stock
SELECT * FROM Mutual_Funds ORDER BY Curr_Price DESC LIMIT 1;


--46. See Mutual funds in descending order of price
SELECT * FROM Mutual_Funds ORDER BY Curr_Price DESC;




--47. Search a blogs from keywords
SELECT * FROM Blogs WHERE Title='#Healthy#';




--48. Search a blogs from a particular author
SELECT * FROM Blogs NATURAL JOIN has_written NATURAL JOIN "User" WHERE Name='Genni';








--49. Search company information
SELECT * FROM Company JOIN Stock ON Name=Company_Name WHERE Company_Name='Oozz';




--50. See sector wise holdings 
SELECT Sector,sum(Quantity) AS Total_Quantity  FROM (Company JOIN Stock ON Name=Company_Name) NATURAL JOIN Owns GROUP BY Sector;




--51. List of companies in which user have invested
SELECT Company_Name FROM (Company JOIN Stock ON Name=Company_Name) NATURAL JOIN Owns WHERE Login_ID=56426096;




--52. Average Buying Price of particular user for all stock
SELECT
    StockExchange,StockSymbol,buying_price_totals.total_buying_price / quantity_totals.total_quantity AS average_buying_price
FROM
    (SELECT
         StockSymbol, StockExchange, SUM(Quantity * Threshold_Value) AS total_buying_price
     FROM
         StockOrder
     WHERE
         Login_ID = 56426096 AND Buy_Or_Sell='Buy' AND Status='Approved'
     GROUP BY
         StockSymbol, StockExchange) AS buying_price_totals
 NATURAL JOIN
    (SELECT
         StockSymbol, StockExchange, SUM(Quantity) AS total_quantity
     FROM
         StockOrder
     WHERE
         Login_ID = 56426096 AND Buy_Or_Sell='Buy' AND Status='Approved'
     GROUP BY
         StockSymbol, StockExchange) AS quantity_totals;


--53. Total invested value in stock
SELECT
    sum((buying_price_totals.total_buying_price / quantity_totals.total_quantity)*(Quantity)) AS Total_Investment
FROM
    (SELECT
         StockSymbol, StockExchange, SUM(Quantity * Threshold_Value) AS total_buying_price
     FROM
         StockOrder
     WHERE
         Login_ID = 56426096 AND Buy_Or_Sell='Buy' AND Status='Approved'
     GROUP BY
         StockSymbol, StockExchange) AS buying_price_totals
 NATURAL JOIN
    (SELECT
         StockSymbol, StockExchange, SUM(Quantity) AS total_quantity
     FROM
         StockOrder
     WHERE
         Login_ID = 56426096 AND Buy_Or_Sell='Buy' AND Status='Approved'
     GROUP BY
         StockSymbol, StockExchange) AS quantity_totals
 NATURAL JOIN Owns;


--54. See total current value of holdings
SELECT sum(Quantity*Curr_Price) AS curr_holdings FROM Stock NATURAL JOIN Owns GROUP BY Login_ID HAVING Login_ID=56426096;




--55. Total unrealised profit/loss for particular user
SELECT
    sum((curr_price-(buying_price_totals.total_buying_price / quantity_totals.total_quantity))*(Quantity)) AS Total_Unrealised_Profit_OR_Loss
FROM
    (SELECT
         StockSymbol, StockExchange, SUM(Quantity * Threshold_Value) AS total_buying_price
     FROM
         StockOrder
     WHERE
         Login_ID = 56426096 AND Buy_Or_Sell='Buy' AND Status='Approved'
     GROUP BY
         StockSymbol, StockExchange) AS buying_price_totals
 NATURAL JOIN
    (SELECT
         StockSymbol, StockExchange, SUM(Quantity) AS total_quantity
     FROM
         StockOrder
     WHERE
         Login_ID = 56426096 AND Buy_Or_Sell='Buy' AND Status='Approved'
     GROUP BY
         StockSymbol, StockExchange) AS quantity_totals
 NATURAL JOIN Owns
 NATURAL JOIN Stock;


--56. Write Blogs
 INSERT INTO Blogs VALUES (4521,'Stock Market','Stock is main entity in Stock Market.',CURRENT_DATE,CURRENT_TIME);
INSERT INTO has_written VALUES(4521,24722292);




--57. Total payable fees  in term of brokerage rate for specified interval for particular user
SELECT sum(Quantity*Threshold_Value*Brokerage_Rate) As total_return_in_term_of_brokerage_rate
 FROM (SELECT * FROM StockOrder WHERE Status='Approved' AND purchase_Date>=DATE '2005-12-31' AND purchase_Date<=CURRENT_DATE)
 GROUP BY Login_ID
 HAVING Login_ID=56426096;




--58. Add new company
INSERT INTO Company VALUES ('HDFC LIFE PVT LIMITED'  ,'BANKING',10000000000);




--59. Add Stock by admin
 INSERT INTO Stock VALUES ('HDFCLIFE','NSE',100,200,'HDFC LIFE PVT LIMITED');


--60. Remove IPO by admin
DELETE FROM Stock WHERE StockSymbol='HDFCLIFE' AND StockExchange='NSE';




--61. Add IPO by admin
INSERT INTO IPO VALUES ('HDFC LIFE PVT LIMITED','NSE','2024-02-02','2024-02-06','2024-02-13',10000,20000,20);


--62. Remove IPO by admin
DELETE FROM IPO WHERE Company_Name='HDFC LIFE PVT LIMITED' AND StockExchange='NSE';




--63. Add Mutual Funds by admin
 INSERT INTO Mutual_Funds VALUES ('VSMPXZY','NSE','HDFC LIFE PVT LIMITED',10000,250000);


--64. Remove Mutual Funds by admin
 DELETE FROM Mutual_Funds WHERE MFName='VSMPXZY' AND StockExchange='NSE';


--65. Update status of stock order by admin
UPDATE StockOrder SET STATUS='Approved' WHERE StockSymbol='PKRQBEOYDJYXNLQ' AND StockExchange='BSE' AND Login_ID=65469628 AND purchase_Date='2024-06-29' AND purchase_Time='3:00 PM';


--66. Update status of Mutual fund order by admin
UPDATE Mutual_Funds_Orders SET STATUS='Approved' WHERE MFSymbol='VYU9X' AND StockExchange='NSE' AND Login_ID=65469628 AND purchase_Date='2024-06-29' AND purchase_Time='3:00 PM';


--67. Update status of IPO bid by admin
UPDATE Bidded SET STATUS='Approved' WHERE Company_Name='Topdrive' AND StockExchange='NSE' AND Login_ID=32118456 AND Startdate='2005-04-29' AND Enddate='2005-06-18';


--68. Update status of Transaction Status by admin
UPDATE Transaction SET STATUS='Approved' WHERE Transaction_ID='1325185782';