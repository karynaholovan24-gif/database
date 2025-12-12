-- =============================
-- 1. TABLES (Столи)
-- =============================
ALTER TABLE Tables
ADD CONSTRAINT UQ_Tables_TableNumber UNIQUE(Table_Number),
    CONSTRAINT CHK_Tables_Capacity CHECK (Capacity > 0);
   
-- =============================
-- 2. TABLE_STATUS (Статуси столів)
-- =============================
ALTER TABLE Table_Status
ADD CONSTRAINT FK_TableStatus_Table FOREIGN KEY (Table_ID) REFERENCES Tables(Table_ID),
    CONSTRAINT CHK_TableStatus_Status CHECK (Status IN ('вільний','зарезервований','зайнятий')),
    CONSTRAINT CHK_TableStatus_StatusTime CHECK (Status_Time IS NOT NULL);

-- =============================
-- 3. GUESTS (Гості)
-- =============================
ALTER TABLE Guests
ADD CONSTRAINT CHK_Guests_FirstName CHECK (FirstName NOT LIKE '%[^А-Яа-яA-Za-z''-]%'),
    CONSTRAINT CHK_Guests_LastName CHECK (LastName NOT LIKE '%[^А-Яа-яA-Za-z''-]%'),
    CONSTRAINT CHK_Guests_Phone CHECK (Phone NOT LIKE '%[^0-9+]%'),
    CONSTRAINT CHK_Guests_Email CHECK (Email LIKE '%_@_%._%');

-- =============================
-- 4. GROUP_RESERVATIONS
-- =============================
ALTER TABLE Group_Reservations
ADD CONSTRAINT FK_GroupRes_Guest FOREIGN KEY (Guest_ID) REFERENCES Guests(Guest_ID),
    CONSTRAINT CHK_GroupRes_NumberOfPeople CHECK (Number_of_People > 0),
    CONSTRAINT CHK_GroupRes_Deposit CHECK (Deposit >= 0),
    CONSTRAINT CHK_GroupRes_Price CHECK (Price >= 0);

-- =============================
-- 5. RESERVATIONS
-- =============================
ALTER TABLE Reservations
ADD CONSTRAINT FK_Res_Table FOREIGN KEY (Table_ID) REFERENCES Tables(Table_ID),
    CONSTRAINT FK_Res_Guest FOREIGN KEY (Guest_ID) REFERENCES Guests(Guest_ID),
    CONSTRAINT FK_Res_Group FOREIGN KEY (Group_Reservation_ID) REFERENCES Group_Reservations(Group_Reservation_ID),
    CONSTRAINT CHK_Res_NumberOfPeople CHECK (Number_of_People > 0),
    CONSTRAINT CHK_Res_Deposit CHECK (Deposit >= 0),
    CONSTRAINT CHK_Res_Price CHECK (Price >= 0);

-- =============================
-- 6. MENU
-- =============================
ALTER TABLE Menu
ADD CONSTRAINT CHK_Menu_Price CHECK (Price >= 0),
    CONSTRAINT CHK_Menu_Weight CHECK (Weight >= 0 OR Weight IS NULL);

ALTER TABLE Menu
ADD CONSTRAINT CHK_Menu_Type CHECK (Type IN ('окрема страва','комплексне меню'));

-- =============================
-- 7. COMBO_COMPONENTS
-- =============================
ALTER TABLE Combo_Components
ADD CONSTRAINT FK_Combo_Combo FOREIGN KEY (Combo_ID) REFERENCES Menu(Item_ID),
    CONSTRAINT FK_Combo_Item FOREIGN KEY (Item_ID) REFERENCES Menu(Item_ID),
    CONSTRAINT CHK_Combo_Quantity CHECK (Quantity > 0);

-- =============================
-- 8. EMPLOYEES
-- =============================
ALTER TABLE Employees
ADD CONSTRAINT CHK_Employees_FirstName CHECK (First_Name NOT LIKE '%[0-9]%'),
    CONSTRAINT CHK_Employees_LastName CHECK (Last_Name NOT LIKE '%[0-9]%'),
    CONSTRAINT CHK_Employees_Phone CHECK (Phone NOT LIKE '%[^0-9+]%'),
    CONSTRAINT CHK_Employees_Salary CHECK (Salary >= 0),
    CONSTRAINT CHK_Employees_HireRelease CHECK (Release_Date IS NULL OR Release_Date >= Hire_Date);

-- =============================
-- 9. ORDERS
-- =============================
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Guest FOREIGN KEY (Guest_ID) REFERENCES Guests(Guest_ID),
    CONSTRAINT FK_Orders_Table FOREIGN KEY (Table_ID) REFERENCES Tables(Table_ID),
    CONSTRAINT FK_Orders_Employee FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID),
    CONSTRAINT FK_Orders_Reservation FOREIGN KEY (Reservation_ID) REFERENCES Reservations(Reservation_ID),
    CONSTRAINT CHK_Orders_TotalAmount CHECK (Total_Amount >= 0);

ALTER TABLE Orders
ADD CONSTRAINT CHK_Order_Status CHECK (Status IN ('активне','виконуване','виконане','скасоване','закрите'));

-- =============================
-- 10. ORDER_ITEMS
-- =============================
ALTER TABLE Order_Items
ADD CONSTRAINT FK_OrderItems_Order FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    CONSTRAINT FK_OrderItems_Item FOREIGN KEY (Item_ID) REFERENCES Menu(Item_ID),
    CONSTRAINT CHK_OrderItems_Quantity CHECK (Quantity > 0),
    CONSTRAINT CHK_OrderItems_PositionAmount CHECK (Position_Amount >= 0);

-- =============================
-- 11. PAYMENTS
-- =============================
ALTER TABLE Payments
ADD CONSTRAINT FK_Payments_Order FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    CONSTRAINT CHK_Payments_Amount CHECK (Amount >= 0);

ALTER TABLE Payments
ADD CONSTRAINT CHK_Payment_Method CHECK (Method IN ('готівка','безготівка'));

-- =============================
-- 12. PROMOTIONS
-- =============================
ALTER TABLE Promotions
ADD CONSTRAINT CHK_Promotions_Discount CHECK (Discount >= 0);

-- =============================
-- 13. INVENTORY
-- =============================
ALTER TABLE Inventory
ADD CONSTRAINT CHK_Inventory_Name CHECK (Name NOT LIKE '%[0-9]%');

-- =============================
-- 14. PRODUCT_BATCHES
-- =============================
ALTER TABLE Product_Batches
ADD CONSTRAINT FK_ProductBatches_Product FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID),
    CONSTRAINT CHK_ProductBatches_Quantity CHECK (Quantity >= 0),
    CONSTRAINT CHK_ProductBatches_Price CHECK (Purchase_Price >= 0),
    CONSTRAINT CHK_ProductBatches_Dates CHECK (Expiry_Date >= Delivery_Date);

-- =============================
-- 15. DELIVERIES
-- =============================
ALTER TABLE Deliveries
ADD CONSTRAINT CHK_Deliveries_TotalAmount CHECK (Total_Amount >= 0);

-- =============================
-- 16. DELIVERY_ITEMS
-- =============================
ALTER TABLE Delivery_Items
ADD CONSTRAINT FK_DeliveryItems_Delivery FOREIGN KEY (Delivery_ID) REFERENCES Deliveries(Delivery_ID),
    CONSTRAINT FK_DeliveryItems_Product FOREIGN KEY (Product_ID) REFERENCES Inventory(Product_ID),
    CONSTRAINT FK_DeliveryItems_Batch FOREIGN KEY (Batch_ID) REFERENCES Product_Batches(Batch_ID),
    CONSTRAINT CHK_DeliveryItems_Quantity CHECK (Quantity > 0),
    CONSTRAINT CHK_DeliveryItems_UnitPrice CHECK (Unit_Price >= 0);

-- Спроба додати некоректного гостя (має містити цифри у імені)
INSERT INTO Guests (FirstName, LastName, Phone, Email) VALUES ('Іван!','Петренко','+380501112233','ivan@example.com');

-- Спроба додати некоректний email
INSERT INTO Guests (FirstName, LastName, Phone, Email) VALUES ('Іван','Петренко','+380501112233','ivanexample.com');

-- Спроба додати некоректний телефон
INSERT INTO Guests (FirstName, LastName, Phone, Email) VALUES ('Іван','Петренко','+abc123','ivan@example.com');

-- Спроба додати некоректну суму замовлення
INSERT INTO Orders (Guest_ID, Table_ID, Employee_ID, Reservation_ID, DateTime, Status, Total_Amount)
VALUES (1, 1, 1, 1, GETDATE(), 'активне', -100);

-- Спроба додати коректні дані
INSERT INTO Guests (FirstName, LastName, Phone, Email) VALUES ('Іван','Петренко','+380501112233','ivan@example.com');

SELECT * FROM Guests;