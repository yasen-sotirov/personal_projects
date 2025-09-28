# 	"DATABASE MANAGEMENT SYSTEM"   
#	софтуера, с който работим. Изпълнява инструкции и връща резултат
# 	https://www.youtube.com/watch?v=SpfIwlAYaKk&ab_channel=freeCodeCamp.org
# 	https://www.youtube.com/watch?v=qw--VYLpxG4&t=94s&ab_channel=freeCodeCamp.org
# 	https://www.youtube.com/@DatabaseStar/videos


    
    

--     IN ОПЕРАТОР - връща всички записи съдържащи "Sales" 
--         WHERE departments IN ("Sales")
--         
--     
--   
--             
--     REGEXP
--         WHERE FirstName regexp("^SA")  
--         
--         

--     
--     
--     ВРЪЩА ПРИ NULL    
--         WHERE isnull(ManagerID);
--   




-- NULL
--     АКО НЕ Е НИЩО
--         WHERE manager_id IS NOT NULL
--     
--     ЗАМЕНЯ ЕЛЕМЕНТ АКО Е NULL
--         coalesce(middle_name, "")   - от много изброени елементи заменя първия NULL
--         ifnull(middle_name, "")     - заменя само един елемент
--         




-- ИЗПУСКА РЕДА, АКО Е NULL
--     coalesce(middlename, " ")


-- УСЛОВИЕ
--     SELECT IF(middle is NULL, concat(first, " ", last), concat(first, " ", middle, " ", last)


-- ДАТА и ЧАС ФОРМАТИРАНЕ
--     SELECT year(e.HireDate), month(e.HireDate)






-- ===== ВСИКИ ПРИМЕРИ =====

--     ========================================
--         ТАБЛИЦИ MANY-TO-MANY   -    ordering_api_db_v2
        
#	ВРЪЩА ИНФО 
    SELECT o.id, o.delivery_date, p.name, p.price
    FROM orders o
    JOIN orders_products o_p   ON o.id = o_p.order_id
    JOIN products p            ON p.id = o_p.product_id
    
    SELECT o.id as order_id, o.delivery_date,
           p.id as product_id, p.name as product
    FROM orders o, products p
    WHERE o.id IN (SELECT order_id  FROM orders_products  WHERE product_id = p.id);
     
    
    

    
    
    
#	ВРЪЩА СТОЙНОСТТА НА ПОРЪЧКАТА
    SELECT o.id AS order_id, 
           SUM(p.price) AS "total price"
    FROM orders o
    JOIN orders_products op ON  o.id = op.order_id
    JOIN products p ON          p.id = op.product_id
    WHERE p.id IN (7, 10, 11);
    
    














#    ОБЕДИНЯВА КОЛОНИ В ЕДНА
-- Write a SQL to find the full name of each employee.
-- SELECT concat(firstname, " ", coalesce(middlename, " "), " ", lastname) as "Full name" FROM employees;
-- SELECT concat_ws(" ", firstname, coalesce(middlename, " "), lastname) as "Full name" FROM employees;
-- SELECT IF(middlename is NULL, concat(firstname, " ", lastname), concat(firstname, " ", middlename, " ", lastname) as "Full name" from employees; 










#    ВРЪЩА РЕЗУЛТАТ ОТ SELF RELATION 



-- Write a SQL query to find the names of all employees who are hired before their managers.
-- SELECT concat(e.firstname, " ", e.lastname) as "employee name", e.HireDate as "hire date", concat(m.firstname, " ", m.lastname) as "manager name", m.HireDate as "hire date"
-- FROM employees as e, employees as m
-- WHERE e.HireDate < m.HireDate and e.ManagerID = m.EmployeeID; 




#   ТЪРСИ ПО ЧАСТ ОТ ДУМА
-- Write a SQL query to find the names of all employees whose first name starts with "SA".
-- SELECT firstname FROM employees WHERE firstname regexp("^SA");
-- SELECT firstname FROM employees WHERE left(firstname, 2) = "sa";







#	ПРОМЕНЯ СЪЩЕСТВУВАЩ ОБЕКТ
UPDATE employees 
SET Salary = 25000, ManagerID = 45
WHERE  employeeID = 294;
-- задължително по PRIMARY KEY





