CREATE SCHEMA TRADEMORE;
SET SEARCH_PATH TO TRADEMORE;
CREATE TABLE "User"(
	Login_ID NUMERIC(8,0) PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	Password VARCHAR(30) NOT NULL,
	Email VARCHAR(30) NOT NULL
);
CREATE TABLE Trader(
	Login_ID NUMERIC(8,0) PRIMARY KEY,
	Profile_Picture BYTEA NOT NULL,
	Address VARCHAR(50),
	PAN_No CHAR(10) NOT NULL,
	Mobile_NO VARCHAR(20) NOT NULL,
	Type VARCHAR(10) NOT NULL,
	Wallet_Amount NUMERIC(15,2),
	FOREIGN KEY (Login_ID) REFERENCES "User"(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Admin(
	Login_ID NUMERIC(8,0) PRIMARY KEY,
	FOREIGN KEY (Login_ID) REFERENCES "User"(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE Bank_Account(
	Bank_Name VARCHAR(40),
	Bank_Ac_No VARCHAR(14),
	IFSC_Code CHAR(11) NOT NULL,
	Login_ID NUMERIC(8,0),
	PRIMARY KEY(Bank_Name,Bank_Ac_No),
	FOREIGN KEY (Login_ID) REFERENCES Trader(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE
	
);

CREATE TABLE Transaction(
	Transaction_ID VARCHAR(30) PRIMARY KEY,
	Mode VARCHAR(15) NOT NULL,
	Credit_or_Debit VARCHAR(6) NOT NULL,
	Amount NUMERIC(15,2) NOT NULL,
	Bank_Name VARCHAR(40),
	Status VARCHAR(10) NOT NULL,
	Bank_Ac_No VARCHAR(14),
	TransactionDate DATE NOT NULL,
    TransactionTime TIME NOT NULL,
	FOREIGN KEY (Bank_Name,Bank_Ac_No) REFERENCES Bank_Account(Bank_Name,Bank_Ac_No) ON DELETE SET NULL
);

CREATE TABLE Company(
	Name VARCHAR(50) PRIMARY KEY,
	Sector VARCHAR(40) NOT NULL,
	Revenue NUMERIC(20,2) NOT NULL
);

CREATE TABLE Promoter(
	Company_Name VARCHAR(50),
	Promoter_Name VARCHAR(40),
	PRIMARY KEY(Company_Name,Promoter_Name),
	FOREIGN KEY (Company_Name) REFERENCES Company(Name) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IPO(
	Company_Name VARCHAR(25),
	Stockexchange VARCHAR(5),
	Startdate DATE,
	Enddate DATE,
	Listing_Date DATE NOT NULL,
	Min_Investment NUMERIC(15,2) NOT NULL,
	Max_Investment NUMERIC(15,2) NOT NULL,
	LotSize NUMERIC(10,0) NOT NULL,
	PRIMARY KEY(Company_Name,Stockexchange,Startdate,Enddate),
	FOREIGN KEY (Company_Name) REFERENCES Company(Name) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Bidded(
	Company_Name VARCHAR(25),
	Stockexchange VARCHAR(5),
	Startdate DATE,
	Enddate DATE,
	Login_ID NUMERIC(8,0),
	Status VARCHAR(15) NOT NULL,
	Bidded_Lots NUMERIC(10,0),
	PRIMARY KEY(Company_Name,Stockexchange,Startdate,Enddate,Login_ID),
	FOREIGN KEY (Login_ID) REFERENCES Trader(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Company_Name,Stockexchange,Startdate,Enddate) REFERENCES IPO(Company_Name,Stockexchange,Startdate,Enddate) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IPO_WATCHLIST(
	Company_Name VARCHAR(25),
	Stockexchange VARCHAR(5),
	Startdate DATE,
	Enddate DATE,
	Login_ID NUMERIC(8,0),
	PRIMARY KEY(Company_Name,Stockexchange,Startdate,Enddate,Login_ID),
	FOREIGN KEY (Company_Name,Stockexchange,Startdate,Enddate) REFERENCES IPO(Company_Name,Stockexchange,Startdate,Enddate) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Login_ID) REFERENCES Trader(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Stock(
	StockSymbol VARCHAR(15),
	StockExchange VARCHAR(5),
	Curr_Price NUMERIC(15,2) NOT NULL,
	Total_Qty NUMERIC(10,0) NOT NULL,
	Company_Name VARCHAR(25),
	PRIMARY KEY(StockSymbol,StockExchange),
	FOREIGN KEY (Company_Name) REFERENCES Company(Name) ON UPDATE CASCADE ON DELETE CASCADE
	
);

CREATE TABLE StockOrder(
	StockSymbol VARCHAR(15),
	StockExchange VARCHAR(5),
	Login_ID NUMERIC(8,0),
	purchase_Date DATE,
	purchase_Time TIME,
	Threshold_Value NUMERIC(10,2),
	Quantity NUMERIC(10,0) NOT NULL,
	Buy_Or_Sell VARCHAR(4) NOT NULL,
	STATUS VARCHAR(15) NOT NULL,
	PRIMARY KEY(StockSymbol,StockExchange,purchase_Date,purchase_Time,Login_ID),
	FOREIGN KEY (StockSymbol,StockExchange) REFERENCES Stock(StockSymbol,StockExchange) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Login_ID) REFERENCES Trader(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE STOCK_WATCHLIST(
	StockSymbol VARCHAR(15),
	StockExchange VARCHAR(5),
	Login_ID NUMERIC(8,0),
	PRIMARY KEY(StockSymbol,StockExchange,Login_ID),
	FOREIGN KEY (StockSymbol,StockExchange) REFERENCES Stock(StockSymbol,StockExchange) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Login_ID) REFERENCES Trader(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Owns(
	StockSymbol VARCHAR(15),
	StockExchange VARCHAR(5),
	Login_ID NUMERIC(8,0),
	Quantity NUMERIC(10,0) NOT NULL,
	PRIMARY KEY(StockSymbol,StockExchange,Login_ID),
	FOREIGN KEY (StockSymbol,StockExchange) REFERENCES Stock(StockSymbol,StockExchange) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Login_ID) REFERENCES Trader(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE
	
);

CREATE TABLE Blogs(
	BlogID NUMERIC(15,0) PRIMARY KEY,
	Blog_Title VARCHAR(100) NOT NULL,
	Blog_Description TEXT,
	PublishDate DATE NOT NULL,
	PublishTime TIME NOT NULL
	
);

CREATE TABLE has_written(
	BlogID NUMERIC(15,0),
	Login_ID NUMERIC(8,0),
	PRIMARY KEY(BlogID,Login_ID),
	FOREIGN KEY (Login_ID) REFERENCES Admin(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (BlogID) REFERENCES Blogs(BlogID) ON UPDATE CASCADE ON DELETE CASCADE
	
);

CREATE TABLE Mutual_Funds(
	MFSymbol VARCHAR(7),
	StockExchange VARCHAR(4),
	MFName VARCHAR(50) NOT NULL,
	CurrPrice NUMERIC(10,2) NOT NULL,
	Quantity NUMERIC(10,0) NOT NULL,
	PRIMARY KEY(MFSymbol,StockExchange)
	
);

CREATE TABLE Is_Collection_Of(
	MFSymbol VARCHAR(7),
	MF_StockExchange VARCHAR(4),
	StockSymbol VARCHAR(15),
	Stock_StockExchange VARCHAR(4),
	Duration TSRANGE,
	Quantity NUMERIC(10,0) NOT NULL,
	PRIMARY KEY(MFSymbol,MF_StockExchange,StockSymbol,Stock_StockExchange,Duration),
	FOREIGN KEY (StockSymbol,Stock_StockExchange) REFERENCES Stock(StockSymbol,StockExchange) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (MFSymbol,MF_StockExchange) REFERENCES Mutual_Funds(MFSymbol,StockExchange) ON UPDATE CASCADE ON DELETE CASCADE
);



CREATE TABLE Mutual_Funds_Orders(
	MFSymbol VARCHAR(7),
	StockExchange VARCHAR(4),
	Login_ID NUMERIC(8,0),
	purchase_Date DATE,
	purchase_Time TIME,
	Threshold_Value NUMERIC(10,2),
	Quantity NUMERIC(10,0) NOT NULL,
	Buy_Or_Sell VARCHAR(4) NOT NULL,
	STATUS VARCHAR(15) NOT NULL,
	PRIMARY KEY(MFSymbol,StockExchange,purchase_Date,purchase_Time,Login_ID),
	FOREIGN KEY (MFSymbol,StockExchange) REFERENCES Mutual_Funds(MFSymbol,StockExchange) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Login_ID) REFERENCES Trader(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE
	
); 

CREATE TABLE Mutual_Fund_Invest(
	MFSymbol VARCHAR(7),
	StockExchange VARCHAR(5),
	Login_ID NUMERIC(8,0),
	Quantity NUMERIC(10,0) NOT NULL,
	PRIMARY KEY(MFSymbol,StockExchange,Login_ID),
	FOREIGN KEY (MFSymbol,StockExchange) REFERENCES Mutual_Funds(MFSymbol,StockExchange) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Login_ID) REFERENCES Trader(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Mutual_Fund_Watchlist(
	MFSymbol VARCHAR(7),
	StockExchange VARCHAR(5),
	Login_ID NUMERIC(8,0),
	PRIMARY KEY(MFSymbol,StockExchange,Login_ID),
	FOREIGN KEY (MFSymbol,StockExchange) REFERENCES Mutual_Funds(MFSymbol,StockExchange) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Login_ID) REFERENCES Trader(Login_ID) ON UPDATE CASCADE ON DELETE CASCADE
);

















