--------------------------------------------------
-- 1 Guests
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetGuest
    @Guest_ID INT = NULL OUTPUT,
    @FirstName NVARCHAR(100) = NULL,
    @LastName NVARCHAR(100) = NULL,
    @Phone VARCHAR(20) = NULL,
    @Email VARCHAR(100) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Guest_ID IS NULL
        BEGIN
            INSERT INTO Guests (FirstName, LastName, Phone, Email)
            VALUES (@FirstName, @LastName, @Phone, @Email)
            SET @Guest_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Guests
            SET FirstName = ISNULL(@FirstName, FirstName),
                LastName = ISNULL(@LastName, LastName),
                Phone = ISNULL(@Phone, Phone),
                Email = ISNULL(@Email, Email)
            WHERE Guest_ID = @Guest_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 2 Tables
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetTable
    @Table_ID INT = NULL OUTPUT,
    @Table_Number INT = NULL,
    @Capacity INT = NULL,
    @Location VARCHAR(50) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Table_ID IS NULL
        BEGIN
            INSERT INTO Tables (Table_Number, Capacity, Location)
            VALUES (@Table_Number, @Capacity, @Location)
            SET @Table_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Tables
            SET Table_Number = ISNULL(@Table_Number, Table_Number),
                Capacity = ISNULL(@Capacity, Capacity),
                Location = ISNULL(@Location, Location)
            WHERE Table_ID = @Table_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 3 Table_Status
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetTableStatus
    @Status_ID INT = NULL OUTPUT,
    @Table_ID INT = NULL,
    @Status VARCHAR(20) = NULL,
    @Status_Time DATETIME = NULL
AS
BEGIN
    BEGIN TRY
        IF @Status_ID IS NULL
        BEGIN
            INSERT INTO Table_Status (Table_ID, Status, Status_Time)
            VALUES (@Table_ID, @Status, ISNULL(@Status_Time, GETDATE()))
            SET @Status_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Table_Status
            SET Table_ID = ISNULL(@Table_ID, Table_ID),
                Status = ISNULL(@Status, Status),
                Status_Time = ISNULL(@Status_Time, Status_Time)
            WHERE Status_ID = @Status_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 4 Menu
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetMenu
    @Item_ID INT = NULL OUTPUT,
    @Name NVARCHAR(100) = NULL,
    @Price DECIMAL(8,2) = NULL,
    @Ingredients_List TEXT = NULL,
    @Weight DECIMAL(6,2) = NULL,
    @Allergens TEXT = NULL,
    @Type VARCHAR(20) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Item_ID IS NULL
        BEGIN
            INSERT INTO Menu (Name, Price, Ingredients_List, Weight, Allergens, Type)
            VALUES (@Name, @Price, @Ingredients_List, @Weight, @Allergens, @Type)
            SET @Item_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Menu
            SET Name = ISNULL(@Name, Name),
                Price = ISNULL(@Price, Price),
                Ingredients_List = ISNULL(@Ingredients_List, Ingredients_List),
                Weight = ISNULL(@Weight, Weight),
                Allergens = ISNULL(@Allergens, Allergens),
                Type = ISNULL(@Type, Type)
            WHERE Item_ID = @Item_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 5 Inventory
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetInventory
    @Product_ID INT = NULL OUTPUT,
    @Name VARCHAR(100) = NULL,
    @Unit_of_Measure VARCHAR(20) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Product_ID IS NULL
        BEGIN
            INSERT INTO Inventory (Name, Unit_of_Measure)
            VALUES (@Name, @Unit_of_Measure)
            SET @Product_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Inventory
            SET Name = ISNULL(@Name, Name),
                Unit_of_Measure = ISNULL(@Unit_of_Measure, Unit_of_Measure)
            WHERE Product_ID = @Product_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 6 Employees
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetEmployee
    @Employee_ID INT = NULL OUTPUT,
    @First_Name NVARCHAR(50) = NULL,
    @Last_Name NVARCHAR(50) = NULL,
    @Position NVARCHAR(50) = NULL,
    @Phone VARCHAR(13) = NULL,
    @Hire_Date DATE = NULL,
    @Release_Date DATE = NULL,
    @Salary DECIMAL(8,2) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Employee_ID IS NULL
        BEGIN
            INSERT INTO Employees (First_Name, Last_Name, Position, Phone, Hire_Date, Release_Date, Salary)
            VALUES (@First_Name, @Last_Name, @Position, @Phone, @Hire_Date, @Release_Date, @Salary)
            SET @Employee_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Employees
            SET First_Name = ISNULL(@First_Name, First_Name),
                Last_Name = ISNULL(@Last_Name, Last_Name),
                Position = ISNULL(@Position, Position),
                Phone = ISNULL(@Phone, Phone),
                Hire_Date = ISNULL(@Hire_Date, Hire_Date),
                Release_Date = ISNULL(@Release_Date, Release_Date),
                Salary = ISNULL(@Salary, Salary)
            WHERE Employee_ID = @Employee_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 7 Orders
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetOrder
    @Order_ID INT = NULL OUTPUT,
    @Guest_ID INT = NULL,
    @Table_ID INT = NULL,
    @Employee_ID INT = NULL,
    @Reservation_ID INT = NULL,
    @DateTime DATETIME = NULL,
    @Status VARCHAR(20) = NULL,
    @Total_Amount DECIMAL(10,2) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Order_ID IS NULL
        BEGIN
            INSERT INTO Orders (Guest_ID, Table_ID, Employee_ID, Reservation_ID, DateTime, Status, Total_Amount)
            VALUES (@Guest_ID, @Table_ID, @Employee_ID, @Reservation_ID, @DateTime, @Status, @Total_Amount)
            SET @Order_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Orders
            SET Guest_ID = ISNULL(@Guest_ID, Guest_ID),
                Table_ID = ISNULL(@Table_ID, Table_ID),
                Employee_ID = ISNULL(@Employee_ID, Employee_ID),
                Reservation_ID = ISNULL(@Reservation_ID, Reservation_ID),
                DateTime = ISNULL(@DateTime, DateTime),
                Status = ISNULL(@Status, Status),
                Total_Amount = ISNULL(@Total_Amount, Total_Amount)
            WHERE Order_ID = @Order_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 8 Order_Items
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetOrderItem
    @Order_ID INT,
    @Item_ID INT,
    @Quantity DECIMAL(8,2) = NULL,
    @Position_Amount DECIMAL(8,2) = NULL
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS(SELECT 1 FROM Order_Items WHERE Order_ID = @Order_ID AND Item_ID = @Item_ID)
        BEGIN
            INSERT INTO Order_Items (Order_ID, Item_ID, Quantity, Position_Amount)
            VALUES (@Order_ID, @Item_ID, ISNULL(@Quantity,1), @Position_Amount)
        END
        ELSE
        BEGIN
            UPDATE Order_Items
            SET Quantity = ISNULL(@Quantity, Quantity),
                Position_Amount = ISNULL(@Position_Amount, Position_Amount)
            WHERE Order_ID = @Order_ID AND Item_ID = @Item_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 9 Payments
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetPayment
    @Payment_ID INT = NULL OUTPUT,
    @Order_ID INT = NULL,
    @Amount DECIMAL(8,2) = NULL,
    @Method VARCHAR(20) = NULL,
    @DateTime DATETIME = NULL
AS
BEGIN
    BEGIN TRY
        IF @Payment_ID IS NULL
        BEGIN
            INSERT INTO Payments (Order_ID, Amount, Method, DateTime)
            VALUES (@Order_ID, @Amount, @Method, ISNULL(@DateTime, GETDATE()))
            SET @Payment_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Payments
            SET Order_ID = ISNULL(@Order_ID, Order_ID),
                Amount = ISNULL(@Amount, Amount),
                Method = ISNULL(@Method, Method),
                DateTime = ISNULL(@DateTime, DateTime)
            WHERE Payment_ID = @Payment_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 10 Promotions
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetPromotion
    @Promotion_ID INT = NULL OUTPUT,
    @Name VARCHAR(100) = NULL,
    @Discount DECIMAL(5,2) = NULL,
    @Start_Date DATE = NULL,
    @End_Date DATE = NULL,
    @Products TEXT = NULL
AS
BEGIN
    BEGIN TRY
        IF @Promotion_ID IS NULL
        BEGIN
            INSERT INTO Promotions (Name, Discount, Start_Date, End_Date, Products)
            VALUES (@Name, @Discount, @Start_Date, @End_Date, @Products)
            SET @Promotion_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Promotions
            SET Name = ISNULL(@Name, Name),
                Discount = ISNULL(@Discount, Discount),
                Start_Date = ISNULL(@Start_Date, Start_Date),
                End_Date = ISNULL(@End_Date, End_Date),
                Products = ISNULL(@Products, Products)
            WHERE Promotion_ID = @Promotion_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 11 Product_Batches
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetProductBatch
    @Batch_ID INT = NULL OUTPUT,
    @Product_ID INT = NULL,
    @Quantity DECIMAL(10,2) = NULL,
    @Delivery_Date DATE = NULL,
    @Expiry_Date DATE = NULL,
    @Purchase_Price DECIMAL(8,2) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Batch_ID IS NULL
        BEGIN
            INSERT INTO Product_Batches (Product_ID, Quantity, Delivery_Date, Expiry_Date, Purchase_Price)
            VALUES (@Product_ID, @Quantity, @Delivery_Date, @Expiry_Date, @Purchase_Price)
            SET @Batch_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Product_Batches
            SET Product_ID = ISNULL(@Product_ID, Product_ID),
                Quantity = ISNULL(@Quantity, Quantity),
                Delivery_Date = ISNULL(@Delivery_Date, Delivery_Date),
                Expiry_Date = ISNULL(@Expiry_Date, Expiry_Date),
                Purchase_Price = ISNULL(@Purchase_Price, Purchase_Price)
            WHERE Batch_ID = @Batch_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 12 Deliveries
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetDelivery
    @Delivery_ID INT = NULL OUTPUT,
    @Supplier VARCHAR(100) = NULL,
    @Date DATE = NULL,
    @Total_Amount DECIMAL(10,2) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Delivery_ID IS NULL
        BEGIN
            INSERT INTO Deliveries (Supplier, Date, Total_Amount)
            VALUES (@Supplier, @Date, @Total_Amount)
            SET @Delivery_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Deliveries
            SET Supplier = ISNULL(@Supplier, Supplier),
                Date = ISNULL(@Date, Date),
                Total_Amount = ISNULL(@Total_Amount, Total_Amount)
            WHERE Delivery_ID = @Delivery_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 13 Delivery_Items
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetDeliveryItem
    @Delivery_ID INT,
    @Product_ID INT,
    @Batch_ID INT = NULL,
    @Quantity DECIMAL(10,2) = NULL,
    @Unit_Price DECIMAL(8,2) = NULL
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS(SELECT 1 FROM Delivery_Items WHERE Delivery_ID = @Delivery_ID AND Product_ID = @Product_ID)
        BEGIN
            INSERT INTO Delivery_Items (Delivery_ID, Product_ID, Batch_ID, Quantity, Unit_Price)
            VALUES (@Delivery_ID, @Product_ID, @Batch_ID, @Quantity, @Unit_Price)
        END
        ELSE
        BEGIN
            UPDATE Delivery_Items
            SET Batch_ID = ISNULL(@Batch_ID, Batch_ID),
                Quantity = ISNULL(@Quantity, Quantity),
                Unit_Price = ISNULL(@Unit_Price, Unit_Price)
            WHERE Delivery_ID = @Delivery_ID AND Product_ID = @Product_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 14 Reservations
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetReservation
    @Reservation_ID INT = NULL OUTPUT,
    @Table_ID INT = NULL,
    @Guest_ID INT = NULL,
    @DateTime DATETIME = NULL,
    @Number_of_People INT = NULL,
    @Deposit DECIMAL(8,2) = NULL,
    @Price DECIMAL(8,2) = NULL,
    @Group_Reservation_ID INT = NULL
AS
BEGIN
    BEGIN TRY
        IF @Reservation_ID IS NULL
        BEGIN
            INSERT INTO Reservations (Table_ID, Guest_ID, DateTime, Number_of_People, Deposit, Price, Group_Reservation_ID)
            VALUES (@Table_ID, @Guest_ID, @DateTime, @Number_of_People, @Deposit, @Price, @Group_Reservation_ID)
            SET @Reservation_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Reservations
            SET Table_ID = ISNULL(@Table_ID, Table_ID),
                Guest_ID = ISNULL(@Guest_ID, Guest_ID),
                DateTime = ISNULL(@DateTime, DateTime),
                Number_of_People = ISNULL(@Number_of_People, Number_of_People),
                Deposit = ISNULL(@Deposit, Deposit),
                Price = ISNULL(@Price, Price),
                Group_Reservation_ID = ISNULL(@Group_Reservation_ID, Group_Reservation_ID)
            WHERE Reservation_ID = @Reservation_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 15 Group_Reservations
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetGroupReservation
    @Group_Reservation_ID INT = NULL OUTPUT,
    @Guest_ID INT = NULL,
    @DateTime DATETIME = NULL,
    @Number_of_People INT = NULL,
    @Deposit DECIMAL(8,2) = NULL,
    @Price DECIMAL(8,2) = NULL,
    @Description NVARCHAR(200) = NULL
AS
BEGIN
    BEGIN TRY
        IF @Group_Reservation_ID IS NULL
        BEGIN
            INSERT INTO Group_Reservations (Guest_ID, DateTime, Number_of_People, Deposit, Price, Description)
            VALUES (@Guest_ID, @DateTime, @Number_of_People, @Deposit, @Price, @Description)
            SET @Group_Reservation_ID = SCOPE_IDENTITY()
        END
        ELSE
        BEGIN
            UPDATE Group_Reservations
            SET Guest_ID = ISNULL(@Guest_ID, Guest_ID),
                DateTime = ISNULL(@DateTime, DateTime),
                Number_of_People = ISNULL(@Number_of_People, Number_of_People),
                Deposit = ISNULL(@Deposit, Deposit),
                Price = ISNULL(@Price, Price),
                Description = ISNULL(@Description, Description)
            WHERE Group_Reservation_ID = @Group_Reservation_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 16 Combo_Components
--------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.sp_SetComboComponent
    @Combo_ID INT,
    @Item_ID INT,
    @Quantity INT = NULL
AS
BEGIN
    BEGIN TRY
        -- Перевіряємо, чи існує запис
        IF NOT EXISTS(SELECT 1 FROM Combo_Components WHERE Combo_ID = @Combo_ID AND Item_ID = @Item_ID)
        BEGIN
            -- Вставка нового запису
            INSERT INTO Combo_Components (Combo_ID, Item_ID, Quantity)
            VALUES (@Combo_ID, @Item_ID, ISNULL(@Quantity, 1))
        END
        ELSE
        BEGIN
            -- Оновлення існуючого запису
            UPDATE Combo_Components
            SET Quantity = ISNULL(@Quantity, Quantity)
            WHERE Combo_ID = @Combo_ID AND Item_ID = @Item_ID
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--------------------------------------------------
-- 1) Guests
--------------------------------------------------
DECLARE @Guest_ID INT;
EXEC dbo.sp_SetGuest 
    @Guest_ID = @Guest_ID OUTPUT, 
    @FirstName = N'Ivan', 
    @LastName  = N'Petrov', 
    @Phone     = '123456789', 
    @Email     = 'ivan.petrov@example.com';
SELECT @Guest_ID AS NewGuestID;

-- Оновлення
EXEC dbo.sp_SetGuest 
    @Guest_ID = @Guest_ID, 
    @Phone = '123456780';

--------------------------------------------------
-- 2) Employees
--------------------------------------------------
DECLARE @Employee_ID INT;
EXEC dbo.sp_SetEmployee 
    @Employee_ID = @Employee_ID OUTPUT, 
    @First_Name = N'Olga', 
    @Last_Name  = N'Kovalenko', 
    @Position   = N'Waiter', 
    @Phone      = '987654321', 
    @Hire_Date  = '2023-01-01', 
    @Salary     = 1500;
SELECT @Employee_ID AS NewEmployeeID;

-- Оновлення
EXEC dbo.sp_SetEmployee 
    @Employee_ID = @Employee_ID, 
    @Position = N'Senior Waiter';

--------------------------------------------------
-- 3) Tables
--------------------------------------------------
DECLARE @Table_ID INT;
EXEC dbo.sp_SetTable 
    @Table_ID = @Table_ID OUTPUT, 
    @Table_Number = 1, 
    @Capacity = 4, 
    @Location = N'Main Hall';
SELECT @Table_ID AS NewTableID;

-- Оновлення
EXEC dbo.sp_SetTable 
    @Table_ID = @Table_ID, 
    @Capacity = 6;

--------------------------------------------------
-- 4) Table_Status
--------------------------------------------------
DECLARE @Status_ID INT;
EXEC dbo.sp_SetTableStatus 
    @Status_ID = @Status_ID OUTPUT, 
    @Table_ID = @Table_ID, 
    @Status = N'Available';
SELECT @Status_ID AS NewStatusID;

-- Оновлення
EXEC dbo.sp_SetTableStatus 
    @Status_ID = @Status_ID, 
    @Status = N'Occupied';

--------------------------------------------------
-- 5) Menu
--------------------------------------------------
DECLARE @Item_ID INT;
EXEC dbo.sp_SetMenu 
    @Item_ID = @Item_ID OUTPUT, 
    @Name = N'Pizza Margherita', 
    @Price = 8.50, 
    @Type = N'Food';
SELECT @Item_ID AS NewItemID;

-- Оновлення
EXEC dbo.sp_SetMenu 
    @Item_ID = @Item_ID, 
    @Price = 9.00;

--------------------------------------------------
-- 6) Inventory
--------------------------------------------------
DECLARE @Product_ID INT;
EXEC dbo.sp_SetInventory 
    @Product_ID = @Product_ID OUTPUT, 
    @Name = N'Tomato', 
    @Unit_of_Measure = N'kg';
SELECT @Product_ID AS NewProductID;

-- Оновлення
EXEC dbo.sp_SetInventory 
    @Product_ID = @Product_ID, 
    @Unit_of_Measure = N'grams';

--------------------------------------------------
-- 7) Orders
--------------------------------------------------
DECLARE @Order_ID INT;
DECLARE @Now1 DATETIME = GETDATE();
EXEC dbo.sp_SetOrder 
    @Order_ID = @Order_ID OUTPUT, 
    @Guest_ID = @Guest_ID, 
    @Table_ID = @Table_ID, 
    @Employee_ID = @Employee_ID,  
    @DateTime = @Now1, 
    @Status = N'New', 
    @Total_Amount = 8.50;
SELECT @Order_ID AS NewOrderID;

-- Оновлення
EXEC dbo.sp_SetOrder 
    @Order_ID = @Order_ID, 
    @Status = N'Paid';

--------------------------------------------------
-- 8) Order_Items
--------------------------------------------------
EXEC dbo.sp_SetOrderItem 
    @Order_ID = @Order_ID, 
    @Item_ID = @Item_ID, 
    @Quantity = 1, 
    @Position_Amount = 8.50;

-- Оновлення
EXEC dbo.sp_SetOrderItem 
    @Order_ID = @Order_ID, 
    @Item_ID = @Item_ID, 
    @Quantity = 2;

--------------------------------------------------
-- 9) Payments
--------------------------------------------------
DECLARE @Payment_ID INT;
DECLARE @Now2 DATETIME = GETDATE();
EXEC dbo.sp_SetPayment 
    @Payment_ID = @Payment_ID OUTPUT, 
    @Order_ID = @Order_ID, 
    @Amount = 8.50, 
    @Method = N'Cash', 
    @DateTime = @Now2;
SELECT @Payment_ID AS NewPaymentID;

-- Оновлення
EXEC dbo.sp_SetPayment 
    @Payment_ID = @Payment_ID, 
    @Amount = 9.00;

--------------------------------------------------
-- 10) Promotions
--------------------------------------------------
DECLARE @Promotion_ID INT;
EXEC dbo.sp_SetPromotion 
    @Promotion_ID = @Promotion_ID OUTPUT, 
    @Name = N'Summer Sale', 
    @Discount = 10, 
    @Start_Date = '2025-06-01', 
    @End_Date = '2025-06-30', 
    @Products = N'Pizza Margherita';
SELECT @Promotion_ID AS NewPromotionID;

-- Оновлення
EXEC dbo.sp_SetPromotion 
    @Promotion_ID = @Promotion_ID, 
    @Discount = 15;

--------------------------------------------------
-- 11) Product_Batches
--------------------------------------------------
DECLARE @Batch_ID INT;
EXEC dbo.sp_SetProductBatch 
    @Batch_ID = @Batch_ID OUTPUT, 
    @Product_ID = @Product_ID, 
    @Quantity = 100, 
    @Delivery_Date = '2025-12-01', 
    @Expiry_Date = '2026-01-01', 
    @Purchase_Price = 1.00;
SELECT @Batch_ID AS NewBatchID;

-- Оновлення
EXEC dbo.sp_SetProductBatch 
    @Batch_ID = @Batch_ID, 
    @Quantity = 150;

--------------------------------------------------
-- 12) Deliveries
--------------------------------------------------
DECLARE @Delivery_ID INT;
EXEC dbo.sp_SetDelivery 
    @Delivery_ID = @Delivery_ID OUTPUT, 
    @Supplier = N'Fresh Farm', 
    @Date = '2025-12-01', 
    @Total_Amount = 100.00;
SELECT @Delivery_ID AS NewDeliveryID;

-- Оновлення
EXEC dbo.sp_SetDelivery 
    @Delivery_ID = @Delivery_ID, 
    @Total_Amount = 120.00;

--------------------------------------------------
-- 13) Delivery_Items
--------------------------------------------------
EXEC dbo.sp_SetDeliveryItem 
    @Delivery_ID = @Delivery_ID, 
    @Product_ID = @Product_ID, 
    @Batch_ID = @Batch_ID, 
    @Quantity = 50, 
    @Unit_Price = 1.00;

-- Оновлення
EXEC dbo.sp_SetDeliveryItem 
    @Delivery_ID = @Delivery_ID, 
    @Product_ID = @Product_ID, 
    @Quantity = 60;

--------------------------------------------------
-- 14) Reservations
--------------------------------------------------
DECLARE @Reservation_ID INT;
EXEC dbo.sp_SetReservation 
    @Reservation_ID = @Reservation_ID OUTPUT, 
    @Table_ID = @Table_ID, 
    @Guest_ID = @Guest_ID, 
    @DateTime = '2025-12-10 19:00', 
    @Number_of_People = 2, 
    @Deposit = 20.00, 
    @Price = 40.00;
SELECT @Reservation_ID AS NewReservationID;

-- Оновлення
EXEC dbo.sp_SetReservation 
    @Reservation_ID = @Reservation_ID, 
    @Number_of_People = 3;

--------------------------------------------------
-- 15) Group_Reservations
--------------------------------------------------
DECLARE @Group_Reservation_ID INT;
EXEC dbo.sp_SetGroupReservation 
    @Group_Reservation_ID = @Group_Reservation_ID OUTPUT, 
    @Guest_ID = @Guest_ID, 
    @DateTime = '2025-12-10 19:00', 
    @Number_of_People = 4, 
    @Deposit = 40.00, 
    @Price = 80.00, 
    @Description = N'Family dinner';
SELECT @Group_Reservation_ID AS NewGroupReservationID;

-- Оновлення
EXEC dbo.sp_SetGroupReservation 
    @Group_Reservation_ID = @Group_Reservation_ID, 
    @Number_of_People = 5;

--------------------------------------------------
-- 16) Combo_Components
--------------------------------------------------
EXEC dbo.sp_SetComboComponent 
    @Combo_ID = @Item_ID, 
    @Item_ID = @Item_ID, 
    @Quantity = 2;

-- Оновлення
EXEC dbo.sp_SetComboComponent 
    @Combo_ID = @Item_ID, 
    @Item_ID = @Item_ID, 
    @Quantity = 3;
