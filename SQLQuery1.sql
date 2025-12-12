--DECLARE @sql NVARCHAR(MAX) = '';
--SELECT @sql += 'ALTER TABLE ' + OBJECT_NAME(parent_object_id) + ' DROP CONSTRAINT ' + name + ';'
--FROM sys.foreign_keys;
--EXEC sp_executesql @sql;
--GO

--IF OBJECT_ID('Delivery_Items', 'U') IS NOT NULL DROP TABLE Delivery_Items;
--IF OBJECT_ID('Deliveries', 'U') IS NOT NULL DROP TABLE Deliveries;
--IF OBJECT_ID('Payments', 'U') IS NOT NULL DROP TABLE Payments;
--IF OBJECT_ID('Order_Items', 'U') IS NOT NULL DROP TABLE Order_Items;
--IF OBJECT_ID('Combo_Components', 'U') IS NOT NULL DROP TABLE Combo_Components;
--IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
--IF OBJECT_ID('Reservations', 'U') IS NOT NULL DROP TABLE Reservations;
--IF OBJECT_ID('Group_Reservations', 'U') IS NOT NULL DROP TABLE Group_Reservations;
--IF OBJECT_ID('Promotions', 'U') IS NOT NULL DROP TABLE Promotions;
--IF OBJECT_ID('Product_Batches', 'U') IS NOT NULL DROP TABLE Product_Batches;
--IF OBJECT_ID('Inventory', 'U') IS NOT NULL DROP TABLE Inventory;
--IF OBJECT_ID('Menu', 'U') IS NOT NULL DROP TABLE Menu;
--IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
--IF OBJECT_ID('Guests', 'U') IS NOT NULL DROP TABLE Guests;
--IF OBJECT_ID('Table_Status', 'U') IS NOT NULL DROP TABLE Table_Status;
--IF OBJECT_ID('Tables', 'U') IS NOT NULL DROP TABLE Tables;
--GO

-- =============================
-- 1. Таблиця TABLES (Столи)
-- =============================
IF OBJECT_ID('Tables', 'U') IS NULL
BEGIN
CREATE TABLE Tables (
    Table_ID INT PRIMARY KEY IDENTITY(1,1),
    Table_Number INT NOT NULL,
    Capacity INT NOT NULL,
    Location VARCHAR(50)
);
END
GO

-- =============================
-- 2. Таблиця TABLE_STATUS (Статуси столів)
-- =============================
IF OBJECT_ID('Table_Status', 'U') IS NULL
BEGIN
CREATE TABLE Table_Status (
    Status_ID INT PRIMARY KEY IDENTITY(1,1),
    Table_ID INT NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Status_Time DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (Table_ID) REFERENCES Tables(Table_ID)
);
END
GO

-- =============================
-- 3. Таблиця GUESTS (Гості)
-- =============================
IF OBJECT_ID('Guests', 'U') IS NULL
BEGIN
CREATE TABLE Guests (
    Guest_ID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100)
);
END
GO

-- =============================
-- 4. Таблиця GROUP_RESERVATIONS (Групові резерви)
-- =============================
IF OBJECT_ID('Group_Reservations', 'U') IS NULL
BEGIN
CREATE TABLE Group_Reservations (
    Group_Reservation_ID INT PRIMARY KEY IDENTITY(1,1),
    Guest_ID INT,
    DateTime DATETIME NOT NULL,
    Number_of_People INT,
    Deposit DECIMAL(8,2),
    Price DECIMAL(8,2),
    Description NVARCHAR(200),
    FOREIGN KEY (Guest_ID) REFERENCES Guests(Guest_ID)
);
END
GO

-- =============================
-- 5. Таблиця RESERVATIONS (Резерви)
-- =============================
IF OBJECT_ID('Reservations', 'U') IS NULL
BEGIN
CREATE TABLE Reservations (
    Reservation_ID INT PRIMARY KEY IDENTITY(1,1),
    Table_ID INT,
    Guest_ID INT,
    DateTime DATETIME NOT NULL,
    Number_of_People INT,
    Deposit DECIMAL(8,2),
    Price DECIMAL(8,2),
    Group_Reservation_ID INT,
    FOREIGN KEY (Table_ID) REFERENCES Tables(Table_ID),
    FOREIGN KEY (Guest_ID) REFERENCES Guests(Guest_ID),
    FOREIGN KEY (Group_Reservation_ID) REFERENCES Group_Reservations(Group_Reservation_ID)
);
END
GO

-- =============================
-- 6. Таблиця MENU
-- =============================
IF OBJECT_ID('Menu', 'U') IS NULL
BEGIN
CREATE TABLE Menu (
    Item_ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(8,2) NOT NULL,
    Ingredients_List TEXT,
    Weight DECIMAL(6,2),
    Allergens TEXT,
    Type VARCHAR(20) DEFAULT 'окрема страва'
);
END
GO

-- =============================
-- 7. Таблиця COMBO_COMPONENTS
-- =============================
IF OBJECT_ID('Combo_Components', 'U') IS NULL
BEGIN
CREATE TABLE Combo_Components (
    Combo_ID INT,
    Item_ID INT,
    Quantity INT DEFAULT 1,
    PRIMARY KEY (Combo_ID, Item_ID),
    FOREIGN KEY (Combo_ID) REFERENCES Menu(Item_ID),
    FOREIGN KEY (Item_ID) REFERENCES Menu(Item_ID)
);
END
GO

-- =============================
-- 8. Таблиця EMPLOYEES
-- =============================
IF OBJECT_ID('Employees', 'U') IS NULL
BEGIN
CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY IDENTITY(1,1),
    First_Name NVARCHAR(50) NOT NULL,
    Last_Name NVARCHAR(50) NOT NULL,
    Position NVARCHAR(50),
    Phone VARCHAR(13),
    Hire_Date DATE,
    Release_Date DATE,
    Salary DECIMAL(8,2)
);
END
GO

-- =============================
-- 9. Таблиця ORDERS
-- =============================
IF OBJECT_ID('Orders', 'U') IS NULL
BEGIN
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY IDENTITY(1,1),
    Guest_ID INT,
    Table_ID INT,
    Employee_ID INT,
    Reservation_ID INT,
    DateTime DATETIME NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'активне',
    Total_Amount DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (Guest_ID) REFERENCES Guests(Guest_ID),
    FOREIGN KEY (Table_ID) REFERENCES Tables(Table_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
    FOREIGN KEY (Reservation_ID) REFERENCES Reservations(Reservation_ID)
);
END
GO

-- =============================
-- 10. Таблиця ORDER_ITEMS
-- =============================
IF OBJECT_ID('Order_Items', 'U') IS NULL
BEGIN
CREATE TABLE Order_Items (
    Order_ID INT,
    Item_ID INT,
    Quantity DECIMAL(8,2) DEFAULT 1,
    Position_Amount DECIMAL(8,2),
    PRIMARY KEY (Order_ID, Item_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Item_ID) REFERENCES Menu(Item_ID)
);
END
GO

-- =============================
-- 11. Таблиця PAYMENTS
-- =============================
IF OBJECT_ID('Payments', 'U') IS NULL
BEGIN
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY IDENTITY(1,1),
    Order_ID INT,
    Amount DECIMAL(8,2),
    Method VARCHAR(20),
    DateTime DATETIME,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);
END
GO

-- =============================
-- 12. Таблиця PROMOTIONS
-- =============================
IF OBJECT_ID('Promotions', 'U') IS NULL
BEGIN
CREATE TABLE Promotions (
    Promotion_ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    Discount DECIMAL(5,2),
    Start_Date DATE,
    End_Date DATE,
    Products TEXT
);
END
GO

-- =============================
-- 13. Таблиця INVENTORY
-- =============================
IF OBJECT_ID('Inventory', 'U') IS NULL
BEGIN
CREATE TABLE Inventory (
    Product_ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Unit_of_Measure VARCHAR(20)
);
END
GO

-- =============================
-- 14. Таблиця PRODUCT_BATCHES
-- =============================
IF OBJECT_ID('Product_Batches', 'U') IS NULL
BEGIN
CREATE TABLE Product_Batches (
    Batch_ID INT PRIMARY KEY IDENTITY(1,1),
    Product_ID INT,
    Quantity DECIMAL(10,2),
    Delivery_Date DATE,
    Expiry_Date DATE,
    Purchase_Price DECIMAL(8,2),
    FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID)
);
END
GO

-- =============================
-- 15. Таблиця DELIVERIES
-- =============================
IF OBJECT_ID('Deliveries', 'U') IS NULL
BEGIN
CREATE TABLE Deliveries (
    Delivery_ID INT PRIMARY KEY IDENTITY(1,1),
    Supplier VARCHAR(100),
    Date DATE,
    Total_Amount DECIMAL(10,2)
);
END
GO

-- =============================
-- 16. Таблиця DELIVERY_ITEMS
-- =============================
IF OBJECT_ID('Delivery_Items', 'U') IS NULL
BEGIN
CREATE TABLE Delivery_Items (
    Delivery_ID INT,
    Product_ID INT,
    Batch_ID INT,
    Quantity DECIMAL(10,2),
    Unit_Price DECIMAL(8,2),
    PRIMARY KEY (Delivery_ID, Product_ID),
    FOREIGN KEY (Delivery_ID) REFERENCES Deliveries(Delivery_ID),
    FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID),
    FOREIGN KEY (Batch_ID) REFERENCES Product_Batches(Batch_ID)
);
END
GO