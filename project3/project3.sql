-- ============================
-- 1. DROP TABLES (for clean re-run)
-- ============================
DROP TABLE IF EXISTS OrderDetails CASCADE;
DROP TABLE IF EXISTS OrderHeader CASCADE;
DROP TABLE IF EXISTS Cart CASCADE;
DROP TABLE IF EXISTS ProductsMenu CASCADE;
DROP TABLE IF EXISTS Users CASCADE;

-- ============================
-- 2. CREATE TABLES
-- ============================

-- Products Menu
CREATE TABLE ProductsMenu (
    Id SERIAL PRIMARY KEY,         
    Name VARCHAR(100) NOT NULL,          
    Price DECIMAL(10, 2) NOT NULL        
);

-- Cart
CREATE TABLE Cart (
    ProductId INT PRIMARY KEY,             
    Qty INT NOT NULL CHECK (Qty > 0),                   
    FOREIGN KEY (ProductId) REFERENCES ProductsMenu(Id) 
);

-- Users
CREATE TABLE Users (
    User_ID SERIAL PRIMARY KEY,    
    Username VARCHAR(100) NOT NULL
);

-- Orders (header info)
CREATE TABLE OrderHeader (
    OrderID SERIAL PRIMARY KEY,   
    UserID INT NOT NULL,
    OrderDate TIMESTAMP NOT NULL DEFAULT NOW(),
    FOREIGN KEY (UserID) REFERENCES Users(User_ID)
);

-- Order details (items per order)
CREATE TABLE OrderDetails (
    OrderHeader INT NOT NULL,           
    ProdID INT NOT NULL,                 
    Qty INT NOT NULL CHECK (Qty > 0),                    
    FOREIGN KEY (OrderHeader) REFERENCES OrderHeader(OrderID), 
    FOREIGN KEY (ProdID) REFERENCES ProductsMenu(Id),          
    PRIMARY KEY (OrderHeader, ProdID)  
);

-- ============================
-- 3. INSERT SAMPLE DATA
-- ============================
INSERT INTO ProductsMenu (Name, Price) VALUES
('Coke', 10.00),
('Chips', 5.00),
('Bread', 15.00),
('Milk', 12.50);

INSERT INTO Users (Username) VALUES
('Kayla'),
('Sandra'),
('Samuel');

INSERT INTO Cart (ProductId, Qty) VALUES
(1, 1),  -- Coke
(2, 2);  -- Chips

SELECT * FROM Cart;

-- ============================
-- 4. ADD ITEM TO CART
-- ============================
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 2) THEN
        UPDATE Cart
        SET Qty = Qty + 1
        WHERE ProductId = 2;
    ELSE
        INSERT INTO Cart (ProductId, Qty)
        VALUES (2, 1);
    END IF;
END $$;

-- ============================
-- 5. REMOVE ITEM FROM CART
-- ============================
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 2 AND Qty > 1) THEN
        UPDATE Cart
        SET Qty = Qty - 1
        WHERE ProductId = 2;
    ELSE
        DELETE FROM Cart
        WHERE ProductId = 2;
    END IF;
END $$;

-- ============================
-- 6. CHECKOUT PROCESS
-- ============================
DO $$
DECLARE
    newOrderID INT;
    customerID INT := 3; -- Change this to target a specific user
BEGIN
    -- Step 1: Create order header
    INSERT INTO OrderHeader (UserID)
    VALUES (customerID)
    RETURNING OrderID INTO newOrderID;

    -- Step 2: Add order details from cart
    INSERT INTO OrderDetails (OrderHeader, ProdID, Qty)
    SELECT newOrderID, ProductId, Qty FROM Cart;

    -- Step 3: Empty the cart
    DELETE FROM Cart;
END $$;

-- ============================
-- 7. VIEW ALL ORDERS
-- ============================
SELECT oh.OrderID, oh.OrderDate, u.Username, p.Name, od.Qty
FROM OrderHeader oh
JOIN Users u ON oh.UserID = u.User_ID
JOIN OrderDetails od ON oh.OrderID = od.OrderHeader
JOIN ProductsMenu p ON od.ProdID = p.Id
ORDER BY oh.OrderID;

-- ============================
-- 8. VIEW SPECIFIC ORDER (example: OrderID = 1)
-- ============================
SELECT oh.OrderID, oh.OrderDate, u.Username, p.Name, od.Qty
FROM OrderHeader oh
JOIN Users u ON oh.UserID = u.User_ID
JOIN OrderDetails od ON oh.OrderID = od.OrderHeader
JOIN ProductsMenu p ON od.ProdID = p.Id
WHERE oh.OrderID = 3;
