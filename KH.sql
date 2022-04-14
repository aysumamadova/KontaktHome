CREATE DATABASE KH
USE KH

CREATE TABLE Categories(
ID int identity (1,1) primary key,
Name nvarchar(255)
)
INSERT INTO Categories
VALUES('Smartfon'),
('Planset'),
('Qulaqciq')
SELECT * FROM Categories

SELECT Categories.ID,Categories.Name
FROM Categories

CREATE TABLE Products(
ID int identity (1,1) primary key,
Name nvarchar(255),
CategoriesID int references Categories(ID),
SalePrice float,
PurchasePrice float )

INSERT INTO Products
VALUES ('Iphone 13',1,2000,3000),
('Iphone 12',1,1500,2000),
('Iphone 11 pro',1,1000,1500),
('Iphone Xs',1,700,1000),
('Xiaomi p1',2,200,300),
('Xiaomi p2',2,100,250),
('Xiaomi p3',2,350,500),
('Airpods',3,200,500)

 SELECT * FROM Products

SELECT Products.ID,Products.Name,Products.SalePrice,Products.PurchasePrice,Products.CategoriesID
FROM Products


CREATE TABLE Cart(
ID int identity (1,1) primary key,
ProductsID int references Products(ID)
)

INSERT INTO Cart
VALUES (7),(6),(2),(3)

SELECT * FROM Cart

SELECT Cart.ID,Cart.ProductsID
FROM Cart

CREATE VIEW InfoCategories
AS
SELECT Categories.ID,Categories.Name
FROM Categories


ALTER VIEW InfoProducts
AS
SELECT Products.ID,Products.Name,Products.SalePrice,Products.PurchasePrice,Categories.Name AS'CateName'
FROM Products
join Categories
on Categories.ID=Products.CategoriesID

SELECT * FROM InfoProducts

CREATE VIEW InfoCart
AS
SELECT Products.Name,Products.SalePrice
FROM Cart
JOIN Products
ON Cart.ProductsID=Products.ID
SELECT * FROM InfoCart

CREATE PROCEDURE usp_sum
AS

SELECT SUM(Products.SalePrice) FROM Cart
JOIN Products 
ON Cart.ProductsID = Products.ID
EXEC  usp_sum

CREATE PROCEDURE usp_INSERT(@ProductsID INT)
AS
 INSERT INTO Cart(ProductsID)
 VALUES (@ProductsID)
 
 EXEC  usp_INSERT 1


 CREATE PROCEDURE usp_REMOVE(@ProductsID INT)
AS
  DELETE FROM Cart
where @ProductsID=Cart.ProductsID

EXEC  usp_REMOVE 1

SELECT * FROM Cart

CREATE TRIGGER InfoCartT
ON Cart
AFTER DELETE, INSERT
AS
BEGIN
SELECT Products.Name,Products.SalePrice
FROM Cart
JOIN Products
ON Cart.ProductsID=Products.ID
END

 EXEC  usp_INSERT 1









