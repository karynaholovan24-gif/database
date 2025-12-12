-------------------------
-- 1. Guests
-------------------------
ALTER TABLE Guests ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Guests_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Guests_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Guests
SET (SYSTEM_VERSIONING = ON (
        HISTORY_TABLE = dbo.Guests_History
    ));
GO

UPDATE Guests
SET LastName = 'Голіней'
WHERE Guest_ID = 1;

SELECT 
Guest_ID,
LastName + ' ' + FirstName
ValidFrom,
ValidTo
FROM Guests
FOR SYSTEM_TIME ALL
WHERE Guest_ID = 1
ORDER BY ValidTo;

-------------------------
-- 2. Employees
-------------------------
ALTER TABLE Employees ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Employees_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Employees_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Employees
SET (SYSTEM_VERSIONING = ON (
        HISTORY_TABLE = dbo.Employees_History
    ));
GO


-------------------------
-- 3. Tables
-------------------------
ALTER TABLE Tables ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Tables_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Tables_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Tables
SET (SYSTEM_VERSIONING = ON (
        HISTORY_TABLE = dbo.Tables_History
    ));
GO


-------------------------
-- 4. Menu
-------------------------
ALTER TABLE Menu ADD
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN
        CONSTRAINT DF_Menu_ValidFrom DEFAULT SYSUTCDATETIME(),
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN
        CONSTRAINT DF_Menu_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

ALTER TABLE Menu
SET (SYSTEM_VERSIONING = ON (
        HISTORY_TABLE = dbo.Menu_History
    ));
GO

SELECT * FROM dbo.Guests_History WHERE Guest_ID = 1 ORDER BY ValidFrom;

