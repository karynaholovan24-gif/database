-- =============================
-- 1. Вибрати всі вільні столи
-- =============================
SELECT t.Table_ID, t.Table_Number, t.Capacity, t.Location, ts.Status
FROM Tables t
JOIN Table_Status ts ON t.Table_ID = ts.Table_ID
WHERE ts.Status = 'вільний';

-- =============================
-- 2. Вибрати всі активні замовлення разом з інформацією про гостей
-- =============================
SELECT o.Order_ID, o.DateTime, o.Status, o.Total_Amount,
       g.FirstName, g.LastName
FROM Orders o
JOIN Guests g ON o.Guest_ID = g.Guest_ID
WHERE o.Status = 'активне';

-- =============================
-- 3. Вибрати повну інформацію про замовлення, включно з позиціями меню
-- =============================
SELECT o.Order_ID, g.FirstName, g.LastName, m.Name AS Menu_Item,
       oi.Quantity, oi.Position_Amount
FROM Orders o
JOIN Guests g ON o.Guest_ID = g.Guest_ID
JOIN Order_Items oi ON oi.Order_ID = o.Order_ID
JOIN Menu m ON m.Item_ID = oi.Item_ID;

-- =============================
-- 4. Показати всі резервації з деталями столу та гостя
-- =============================
SELECT r.Reservation_ID, r.DateTime, r.Number_of_People,
       t.Table_Number, g.FirstName, g.LastName
FROM Reservations r
JOIN Tables t ON r.Table_ID = t.Table_ID
JOIN Guests g ON r.Guest_ID = g.Guest_ID;

-- =============================
-- 5. Показати групові резервації з кількістю людей та сумою
-- =============================
SELECT gr.Group_Reservation_ID, g.FirstName, g.LastName,
       gr.DateTime, gr.Number_of_People, gr.Price
FROM Group_Reservations gr
JOIN Guests g ON gr.Guest_ID = g.Guest_ID;

-- =============================
-- 6. Показати всі поставки з постачальниками та сумою
-- =============================
SELECT d.Delivery_ID, d.Supplier, d.Date, d.Total_Amount,
       di.Product_ID, di.Quantity, di.Unit_Price
FROM Deliveries d
JOIN Delivery_Items di ON d.Delivery_ID = di.Delivery_ID;

-- =============================
-- 7. Переглянути склад разом з партіями продуктів
-- =============================
SELECT i.Product_ID, i.Name, pb.Batch_ID, pb.Quantity, pb.Delivery_Date, pb.Expiry_Date
FROM Inventory i
LEFT JOIN Product_Batches pb ON i.Product_ID = pb.Product_ID;

-- =============================
-- 8. Відобразити всі комбо-меню з їх компонентами
-- =============================
SELECT c.Combo_ID, m1.Name AS Combo_Name, m2.Name AS Component_Name, c.Quantity
FROM Combo_Components c
JOIN Menu m1 ON c.Combo_ID = m1.Item_ID
JOIN Menu m2 ON c.Item_ID = m2.Item_ID;

-- =============================
-- 9. Переглянути платежі разом з інформацією про замовлення
-- =============================
SELECT p.Payment_ID, p.Amount, p.Method, p.DateTime,
       o.Order_ID, o.Total_Amount
FROM Payments p
JOIN Orders o ON p.Order_ID = o.Order_ID;

-- =============================
-- 10. Показати працівників та їхні активні замовлення
-- =============================
SELECT e.Employee_ID, e.First_Name, e.Last_Name, o.Order_ID, o.Status
FROM Employees e
LEFT JOIN Orders o ON e.Employee_ID = o.Employee_ID;
