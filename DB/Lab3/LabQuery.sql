use labor_sql

/** 1 **/
SELECT model, speed, hd, price FROM dbo.laptop WHERE hd < 12 ORDER BY price DESC;
/** 2 **/
SELECT * FROM dbo.outcome WHERE MONTH(date) = 3;
/** 3 **/
SELECT product.maker, laptop.model FROM product
INNER JOIN laptop ON laptop.model = product.model
WHERE laptop.price > 600;
/** 4 **/
SELECT DISTINCT [maker] FROM product
WHERE [type] = 'pc' AND NOT [maker] <> ALL (SELECT [maker] FROM product WHERE [type] = 'laptop');
/** 5 **/
SELECT DISTINCT [maker] FROM product p
WHERE [maker] <> ALL(SELECT [maker] FROM product WHERE [type] = 'printer');
/** 6 **/
PRINT N'середня ціна = ';
SELECT AVG([price]) FROM laptop;
/** 7 **/
SELECT product.maker, printer.price FROM product
INNER JOIN printer ON printer.model = product.model
WHERE printer.color = 'n' AND price < (SELECT AVG(price) FROM printer);
/** 8 **/
SELECT [maker], COUNT(pc.[model]) pc_num,
COUNT(laptop.[model]) laptop_num,
COUNT(printer.[model]) printer_num 
FROM product
LEFT JOIN pc ON product.model = pc.model
LEFT JOIN laptop ON product.model = laptop.model
LEFT JOIN printer ON product.model = printer.model
GROUP BY [maker];
/** 9 **/
SELECT income.point, income.[date], SUM(inc) inc, SUM([out]) AS out FROM income
FULL OUTER JOIN outcome ON income.point = outcome.point
GROUP BY income.[point], income.[date];
/** 10 **/
SELECT [maker], product.[model], [type], [price] 
FROM product 
FULL OUTER JOIN pc ON product.model = pc.model
WHERE [maker] = 'B' AND price IS NOT NULL
UNION
SELECT [maker], product.[model], [type], [price] FROM product 
FULL OUTER JOIN laptop ON product.model = laptop.model
WHERE [maker] = 'B' AND price IS NOT NULL
UNION
SELECT [maker], product.[model], product.[type], [price] FROM product 
FULL OUTER JOIN printer ON product.model = printer.model
WHERE [maker] = 'B' AND price IS NOT NULL;

