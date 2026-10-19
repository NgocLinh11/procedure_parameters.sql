USE classicmodels;

-- -------------------------------------------------------------
-- 1. THAM SỐ LOẠI IN: Tìm thông tin khách hàng theo customerNumber
-- -------------------------------------------------------------
DROP PROCEDURE IF EXISTS getCusById;

DELIMITER //
CREATE PROCEDURE getCusById(
    IN cusNum INT
)
BEGIN
    SELECT * 
    FROM customers 
    WHERE customerNumber = cusNum;
END //
DELIMITER ;

-- Gọi Stored Procedure
CALL getCusById(175);


-- -------------------------------------------------------------
-- 2. THAM SỐ LOẠI OUT: Đếm số lượng khách hàng theo thành phố
-- -------------------------------------------------------------
DROP PROCEDURE IF EXISTS GetCustomersCountByCity;

DELIMITER //
CREATE PROCEDURE GetCustomersCountByCity(
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //
DELIMITER ;

-- Gọi Stored Procedure và kiểm tra biến kết quả @total
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS TotalCustomersInLyon;


-- -------------------------------------------------------------
-- 3. THAM SỐ LOẠI INOUT: Tăng giá trị của biến đếm
-- -------------------------------------------------------------
DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER //
CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //
DELIMITER ;

-- Khởi tạo biến và gọi Stored Procedure nhiều lần
SET @counter = 1;

CALL SetCounter(@counter, 1); -- @counter = 2
CALL SetCounter(@counter, 1); -- @counter = 3
CALL SetCounter(@counter, 5); -- @counter = 8

SELECT @counter AS FinalCounterValue;