   --==============================================
   --1) Guests 
   --============================================== 
CREATE OR ALTER PROCEDURE dbo.sp_GetGuests
    @Guest_ID INT = NULL,
    @Name NVARCHAR(100) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'Guest_ID',
    @SortDirection BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH Filtered AS (
        SELECT g.*, COUNT(*) OVER() AS TotalCount
        FROM dbo.Guests g
        WHERE (@Guest_ID IS NULL OR g.Guest_ID = @Guest_ID)
          AND (@Name IS NULL OR g.FirstName LIKE @Name + '%' OR g.LastName LIKE @Name + '%')
    )
    SELECT * FROM Filtered
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'Guest_ID' THEN CAST(Guest_ID AS SQL_VARIANT)
                WHEN 'FirstName' THEN CAST(FirstName AS SQL_VARIANT)
                WHEN 'LastName' THEN CAST(LastName AS SQL_VARIANT)
                WHEN 'Email' THEN CAST(Email AS SQL_VARIANT)
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'Guest_ID' THEN CAST(Guest_ID AS SQL_VARIANT)
                WHEN 'FirstName' THEN CAST(FirstName AS SQL_VARIANT)
                WHEN 'LastName' THEN CAST(LastName AS SQL_VARIANT)
                WHEN 'Email' THEN CAST(Email AS SQL_VARIANT)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO

   --==============================================
   --2) Tables 
   --============================================== 
CREATE OR ALTER PROCEDURE dbo.sp_GetTables
    @Table_ID INT = NULL,
    @Table_Number INT = NULL,
    @Location VARCHAR(50) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'Table_ID',
    @SortDirection BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH Filtered AS (
        SELECT t.*, COUNT(*) OVER() AS TotalCount
        FROM dbo.Tables t
        WHERE (@Table_ID IS NULL OR t.Table_ID = @Table_ID)
          AND (@Table_Number IS NULL OR t.Table_Number = @Table_Number)
          AND (@Location IS NULL OR t.Location LIKE @Location + '%')
    )
    SELECT * FROM Filtered
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'Table_ID' THEN CAST(Table_ID AS SQL_VARIANT)
                WHEN 'Table_Number' THEN CAST(Table_Number AS SQL_VARIANT)
                WHEN 'Capacity' THEN CAST(Capacity AS SQL_VARIANT)
                WHEN 'Location' THEN CAST(Location AS SQL_VARIANT)
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'Table_ID' THEN CAST(Table_ID AS SQL_VARIANT)
                WHEN 'Table_Number' THEN CAST(Table_Number AS SQL_VARIANT)
                WHEN 'Capacity' THEN CAST(Capacity AS SQL_VARIANT)
                WHEN 'Location' THEN CAST(Location AS SQL_VARIANT)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO

   --==============================================
   --3) Table_Status 
   --============================================== 
CREATE OR ALTER PROCEDURE dbo.sp_GetTableStatus
    @Status_ID INT = NULL,
    @Table_ID INT = NULL,
    @Status VARCHAR(20) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'Status_Time',
    @SortDirection BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH Filtered AS (
        SELECT ts.*, t.Table_Number, COUNT(*) OVER() AS TotalCount
        FROM dbo.Table_Status ts
        LEFT JOIN dbo.Tables t ON ts.Table_ID = t.Table_ID
        WHERE (@Status_ID IS NULL OR ts.Status_ID = @Status_ID)
          AND (@Table_ID IS NULL OR ts.Table_ID = @Table_ID)
          AND (@Status IS NULL OR ts.Status = @Status)
    )
    SELECT * FROM Filtered
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'Status_Time' THEN CAST(Status_Time AS SQL_VARIANT)
                WHEN 'Status' THEN CAST(Status AS SQL_VARIANT)
                WHEN 'Table_Number' THEN CAST(Table_Number AS SQL_VARIANT)
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'Status_Time' THEN CAST(Status_Time AS SQL_VARIANT)
                WHEN 'Status' THEN CAST(Status AS SQL_VARIANT)
                WHEN 'Table_Number' THEN CAST(Table_Number AS SQL_VARIANT)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO

   --==============================================
   --4) Menu
   --============================================== 
CREATE OR ALTER PROCEDURE dbo.sp_GetMenu
    @Item_ID INT = NULL,
    @Name NVARCHAR(100) = NULL,
    @Type VARCHAR(20) = NULL,
    @MinPrice DECIMAL(8,2) = NULL,
    @MaxPrice DECIMAL(8,2) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'Item_ID',
    @SortDirection BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH Filtered AS (
        SELECT m.*, COUNT(*) OVER() AS TotalCount
        FROM dbo.Menu m
        WHERE (@Item_ID IS NULL OR m.Item_ID = @Item_ID)
          AND (@Name IS NULL OR m.Name LIKE @Name + '%')
          AND (@Type IS NULL OR m.Type = @Type)
          AND (@MinPrice IS NULL OR m.Price >= @MinPrice)
          AND (@MaxPrice IS NULL OR m.Price <= @MaxPrice)
    )
    SELECT * FROM Filtered
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'Item_ID' THEN CAST(Item_ID AS SQL_VARIANT)
                WHEN 'Name' THEN CAST(Name AS SQL_VARIANT)
                WHEN 'Price' THEN CAST(Price AS SQL_VARIANT)
                WHEN 'Type' THEN CAST(Type AS SQL_VARIANT)
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'Item_ID' THEN CAST(Item_ID AS SQL_VARIANT)
                WHEN 'Name' THEN CAST(Name AS SQL_VARIANT)
                WHEN 'Price' THEN CAST(Price AS SQL_VARIANT)
                WHEN 'Type' THEN CAST(Type AS SQL_VARIANT)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO

--   ==============================================
--   5) Inventory
--   ============================================== 
CREATE OR ALTER PROCEDURE dbo.sp_GetInventory
    @Product_ID INT = NULL,
    @Name NVARCHAR(100) = NULL,
    @Unit_of_Measure VARCHAR(20) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'Product_ID',
    @SortDirection BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH Filtered AS (
        SELECT i.*, COUNT(*) OVER() AS TotalCount
        FROM dbo.Inventory i
        WHERE (@Product_ID IS NULL OR i.Product_ID = @Product_ID)
          AND (@Name IS NULL OR i.Name LIKE @Name + '%')
          AND (@Unit_of_Measure IS NULL OR i.Unit_of_Measure = @Unit_of_Measure)
    )
    SELECT * FROM Filtered
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'Product_ID' THEN CAST(Product_ID AS SQL_VARIANT)
                WHEN 'Name' THEN CAST(Name AS SQL_VARIANT)
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'Product_ID' THEN CAST(Product_ID AS SQL_VARIANT)
                WHEN 'Name' THEN CAST(Name AS SQL_VARIANT)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO

--   ==============================================
--   6) Employees 
--   ==============================================
CREATE OR ALTER PROCEDURE dbo.sp_GetEmployees
    @Employee_ID INT = NULL,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @Position NVARCHAR(50) = NULL,
    @PageSize INT = 20,
    @PageNumber INT = 1,
    @SortColumn VARCHAR(128) = 'Employee_ID',
    @SortDirection BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH Filtered AS (
        SELECT e.*, COUNT(*) OVER() AS TotalCount
        FROM dbo.Employees e
        WHERE (@Employee_ID IS NULL OR e.Employee_ID = @Employee_ID)
          AND (@FirstName IS NULL OR e.First_Name LIKE @FirstName + '%')
          AND (@LastName IS NULL OR e.Last_Name LIKE @LastName + '%')
          AND (@Position IS NULL OR e.Position LIKE @Position + '%')
    )
    SELECT * FROM Filtered
    ORDER BY
        CASE WHEN @SortDirection = 0 THEN
            CASE @SortColumn
                WHEN 'Employee_ID' THEN CAST(Employee_ID AS SQL_VARIANT)
                WHEN 'First_Name' THEN CAST(First_Name AS SQL_VARIANT)
                WHEN 'Last_Name' THEN CAST(Last_Name AS SQL_VARIANT)
                WHEN 'Position' THEN CAST(Position AS SQL_VARIANT)
            END
        END ASC,
        CASE WHEN @SortDirection = 1 THEN
            CASE @SortColumn
                WHEN 'Employee_ID' THEN CAST(Employee_ID AS SQL_VARIANT)
                WHEN 'First_Name' THEN CAST(First_Name AS SQL_VARIANT)
                WHEN 'Last_Name' THEN CAST(Last_Name AS SQL_VARIANT)
                WHEN 'Position' THEN CAST(Position AS SQL_VARIANT)
            END
        END DESC
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO

--   ==============================================
-- 1) Guests
--   ==============================================
PRINT '=== Guests (Сторінка 1, PageSize=20, Сортування за Guest_ID ASC) ===';
EXEC dbo.sp_GetGuests 
    @PageSize = 20, 
    @PageNumber = 1, 
    @SortColumn = 'Guest_ID', 
    @SortDirection = 0;

--   ==============================================
-- 2) Tables
--   ==============================================
PRINT '=== Tables (Сторінка 1, PageSize=20, Сортування за Table_ID ASC) ===';
EXEC dbo.sp_GetTables 
    @PageSize = 20, 
    @PageNumber = 1, 
    @SortColumn = 'Table_ID', 
    @SortDirection = 0;

--   ==============================================
-- 3) Table_Status
--   ==============================================
PRINT '=== Table Status (Сторінка 1, PageSize=20, Сортування за Status_Time DESC) ===';
EXEC dbo.sp_GetTableStatus 
    @PageSize = 20, 
    @PageNumber = 1, 
    @SortColumn = 'Status_Time', 
    @SortDirection = 1;

--   ==============================================
-- 4) Menu
--   ==============================================
PRINT '=== Menu (Сторінка 1, PageSize=20, Сортування за Price ASC) ===';
EXEC dbo.sp_GetMenu 
    @PageSize = 20, 
    @PageNumber = 1, 
    @SortColumn = 'Price', 
    @SortDirection = 0;

--   ==============================================
-- 5) Inventory
--   ==============================================
PRINT '=== Inventory (Сторінка 1, PageSize=20, Сортування за Name ASC) ===';
EXEC dbo.sp_GetInventory 
    @PageSize = 20, 
    @PageNumber = 1, 
    @SortColumn = 'Name', 
    @SortDirection = 0;

--   ==============================================
-- 6) Employees
--   ==============================================
PRINT '=== Employees (Сторінка 1, PageSize=20, Сортування за Employee_ID ASC) ===';
EXEC dbo.sp_GetEmployees 
    @PageSize = 20, 
    @PageNumber = 1, 
    @SortColumn = 'Employee_ID', 
    @SortDirection = 0;
