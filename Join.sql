SELECT orders.*,
       accounts.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

ALIAS
FROM tablename AS t1
JOIN tablename2 AS t2
ALBO
FROM tablename t1
JOIN tablename2 t2
Zmiana nazwy tabeli:
Select t1.column1 aliasname, t2.column2 aliasname2
FROM tablename AS t1
JOIN tablename2 AS t2

SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
WHERE a.name = 'Walmart';

SELECT r.name the_region_name, s.name the_sales_rep_name, a.name account_name
FROM accounts AS a
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id
ORDER BY account_name; //moze byc a.name

SELECT r.name region_name, a.name account_name, (o.total_amt_usd / (o.total + 0.01)) unit_price
FROM region AS r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts AS a
ON s.id = a.sales_rep_id
JOIN orders AS o
ON a.id = o.account_id;

//outer joins (LEFT JOIN to to samo co LEFT OUTER JOIN, RIGHT JOIN, FULL OUTER JOIN)

// ON ....
  WHERE //pokazuje wyniki jakiego przedstawiciela
  AND // pokazuje wiecej wynikow, bez imiona przedstawiciela

  SELECT r.name regionName, s.name salesRepName, a.name accountName
  FROM region r
  JOIN sales_reps s
  ON r.id = s.region_id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  WHERE r.name = 'Midwest'
  ORDER BY a.name;

SELECT r.name regionName, s.name salesRepName, a.name accountName
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;

SELECT r.name regionName, s.name salesRepName, a.name accountName
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND s.name LIKE '%K%' // w odpowiedzi '% K%'
ORDER BY accountName;

SELECT r.name regionName, a.name accountName, o.total_amt_usd/(o.total+0.01) unitPrice
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100;

SELECT r.name regionName, a.name accountName, o.total_amt_usd/(o.total+0.01) unitPrice
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unitPrice;

SELECT r.name regionName, a.name accountName, o.total_amt_usd/(o.total+0.01) unitPrice
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unitPrice DESC;

SELECT DISTINCT w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
AND a.id = 1001; // w odpowiedzi '1001'

SELECT w.occurred_at, a.name, o.total, o.total_amt_usd
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN orders o
ON a.id = o.account_id
WHERE w.occurred_at BETWEEN '2015-01-01' AND '2016-01-01' // w odpowiedzi '01-01-2015' AND '01-01-2016'

// cross join mnozy rzedy jakichs tabel, union laczy dwie np. dwie tabele w jedna, self join porownuje dwie rzeczy z jednej tabeli

// WHERE ... IS NOT NULL // nie uzywamy = bo null to nie value tylko property of data

SELECT COUNT(accounts.id)
FROM accounts;

// SUM treats NULL as zero

SELECT SUM(o.poster_qty) poster, SUM(o.standard_qty) standard, SUM(o.total_amt_usd) total, (o.standard_amt_usd + o.gloss_amt_usd) four, (SUM(o.standard_amt_usd))/(SUM(o.standard_qty)) five
FROM orders o;

// AVG nie bierze pod uwage NULL i trzeba uzyc SUM i COUNT zeby znalezc srednia

  SELECT MIN(o.occurred_at)
FROM orders o;

SELECT o.occurred_at, o.id
FROM orders o
ORDER BY o.occurred_at
LIMIT 1;

SELECT MAX(w.occurred_at)
FROM web_events w;

SELECT w.occurred_at
FROM web_events w
ORDER BY w.occurred_at DESC
LIMIT 1;

SELECT AVG(o.standard_amt_usd) t1, AVG(o.gloss_amt_usd) t2, AVG(o.poster_amt_usd) t3, AVG(o.standard_qty) t4, AVG(o.gloss_qty) t5, AVG(o.poster_qty) t6
FROM orders o;

//MEDIAN uzywajac SUBQUERY
//MEDIAN

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

//MEDIAN
//MEDIAN

// WHERE
  GROUP BY
  ORDER BY
//

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY o.occurred_at DESC;

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY a.name;

SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

SELECT COUNT(w.id), w.channel // w odpowiedzi COUNT(*)
FROM web_events w
GROUP BY w.channel;

SELECT a.primary_poc, w.occurred_at
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;

SELECT a.name, MIN(o.total_amt_usd) sum // MIN bierze pod uwage 0 a SUM pomija 0
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY sum;

SELECT r.name, COUNT(s.id) co // w odpowiedzi COUNT(*)
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY co;

SELECT a.name, AVG(o.standard_qty) st_avg, AVG(o.gloss_qty) glo_avg, AVG(o.poster_qty) pos_avg
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

SELECT a.name, AVG(o.standard_amt_usd) st, AVG(o.gloss_amt_usd) glo, AVG(o.poster_amt_usd) pos
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name;

SELECT s.name, w.channel, COUNT(*) numberofoccurrences
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY s.name, w.channel
ORDER BY numberofoccurrences DESC;

SELECT r.name, w.channel, COUNT(*) numberofoccurrences
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY r.name, w.channel
ORDER BY numberofoccurrences DESC;

//Use DISTINCT to test if there are any accounts associated with more than one region.
SELECT a.id as "account id", r.id as "region id",
a.name as "account name", r.name as "region name"
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id;

SELECT DISTINCT id, name
FROM accounts;

// Have any sales reps worked on more than one account?
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

SELECT DISTINCT id, name
FROM sales_reps;

// WHERE returs data on a LOGICAL CONDITION, HAVING on LOGICAL STATEMENTS incolving aggregation
// kolejnosc FROM, JOIN i ON, WHERE potem GROUP BY, HAVING, ORDER BY

//How many of the sales reps have more than 5 accounts that they manage?
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

// wyrzuca liczbe powtorzen
SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
     FROM accounts a
     JOIN sales_reps s
     ON s.id = a.sales_rep_id
     GROUP BY s.id, s.name
     HAVING COUNT(*) > 5
     ORDER BY num_accounts) AS Table1;

SELECT a.id, a.name, COUNT(*) num_accounts
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name, a.id
HAVING COUNT(*) > 20
ORDER BY num_accounts;

SELECT a.name, COUNT(o.id) num_accounts
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
HAVING COUNT(*) > 20
ORDER BY num_accounts DESC;

SELECT a.name, SUM(o.total_amt_usd) num_accounts
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY num_accounts DESC;

SELECT a.name, SUM(o.total_amt_usd) num_accounts
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY num_accounts DESC;

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name, a.id
ORDER BY total_spent DESC
LIMIT 1;

SELECT a.name, MIN(o.total_amt_usd) num_accounts
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY num_accounts
LIMIT 1;

SELECT a.name, COUNT(w.channel) num_accounts
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
WHERE w.channel = 'facebook'
GROUP BY a.name
HAVING COUNT(w.channel) > 6
ORDER BY num_accounts

// w odpowiedzi
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;

SELECT a.name, COUNT(w.channel) num_accounts
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY a.name
ORDER BY num_accounts DESC
LIMIT 1;

//w odpowiedzi
SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;

// DATE_TRUNC allows you to truncate your date
DATE_PART can be useful for pulling a specific portion of a date
DATE_PART('dow', occurred_at) AS day_of_wek,
DATE_TRUNC('day', occurred_at) AS day_of_wek
//

SELECT DATE_TRUNC('year', occurred_at) AS year, SUM(o.total_amt_usd) AS money
FROM orders o
GROUP BY year
ORDER BY money DESC;

//lepsza wersja tego pierwszego
SELECT DATE_PART('year', occurred_at) AS month, SUM(o.total_amt_usd) AS money
FROM orders o
GROUP BY month
ORDER BY money DESC;

SELECT DATE_PART('month', occurred_at) AS month, SUM(o.total_amt_usd) AS money
FROM orders o
WHERE occured_at BETWEEN '2014-01-01' AND '2017-01-01' // bo w 2013 i 2017 byly tylko pojedyncze miesiace i jest nierowno
GROUP BY month
ORDER BY money DESC;

SELECT DATE_PART('year', occurred_at) AS y, COUNT(o.total) AS orders
FROM orders o
GROUP BY 1
ORDER BY 2 DESC;

// odpowiedz
SELECT DATE_PART('year', occurred_at) ord_year,  COUNT(*) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT DATE_PART('month', occurred_at) AS m, COUNT(*) AS orders
FROM orders o
WHERE occured_at BETWEEN '2014-01-01' AND '2017-01-01' // bo w 2013 i 2017 byly tylko pojedyncze miesiace i jest nierowno
GROUP BY 1
ORDER BY 2 DESC;

SELECT a.name, DATE_TRUNC('month', occurred_at) AS y_m, SUM(o.gloss_amt_usd) AS orders
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1, 2
HAVING a.name = 'Walmart'
ORDER BY 3 DESC;

//odpowiedz do powyzszego
SELECT DATE_TRUNC('month', o.occurred_at) ord_date, SUM(o.gloss_amt_usd) tot_spent
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

// evenly represented czyli jest tyle samo miesiecy z zamowieniami w kazdym roku

SELECT account_id, CASE WHEN standard_qty = 0 OR standard_qty IS NULL THEN 0
                        ELSE standard_amt_usd/standard_qty END AS unit_price
FROM orders
LIMIT 10;

SELECT a.id, o.total_amt_usd teee, CASE WHEN  o.total_amt_usd > 3000 THEN 'Large' ELSE 'Small' END AS sizeOF
FROM accounts a
JOIN orders o
ON a.id = o.account_id

//w odpowiedzi
SELECT account_id, total_amt_usd,
CASE WHEN total_amt_usd > 3000 THEN 'Large'
ELSE 'Small' END AS order_level
FROM orders;

SELECT a.id, o.total teee,
CASE WHEN  o.total > 2000 THEN 'At Least 2000'
	WHEN o.total < 2000 AND o.total > 1000 THEN 'Between 1000 and 2000'
    ELSE 'Less than 1000' END AS sizeOF
FROM accounts a
JOIN orders o
ON a.id = o.account_id;

//odpowiedzi
SELECT CASE WHEN total >= 2000 THEN 'At Least 2000'
   WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
   ELSE 'Less than 1000' END AS order_category,
COUNT(*) AS order_count
FROM orders
GROUP BY 1;

SELECT a.name, SUM(o.total_amt_usd) teee,
CASE WHEN  SUM(o.total_amt_usd) > 200000 THEN 'greater than 200,000'
	WHEN SUM(o.total_amt_usd) < 200000 AND SUM(o.total_amt_usd) > 100000 THEN '200,000 and 100,000'
    ELSE 'under 100,000' END AS sizeOF
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC

SELECT a.name, SUM(o.total_amt_usd) teee,
CASE WHEN  SUM(o.total_amt_usd) > 200000 THEN 'greater than 200,000'
	WHEN SUM(o.total_amt_usd) < 200000 AND SUM(o.total_amt_usd) > 100000 THEN '200,000 and 100,000'
    ELSE 'under 100,000' END AS sizeOF
FROM accounts a
JOIN orders o
ON a.id = o.account_id
WHERE o.occurred_at > '2015-12-31'
GROUP BY 1
ORDER BY 2 DESC

SELECT s.name, COUNT(o.total) teee,
CASE WHEN  COUNT(o.total) > 200 THEN 'top'
    ELSE 'not' END AS sizeOF
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC

SELECT s.name, COUNT(o.total) teee, SUM(o.total_amt_usd) kasakasa,
CASE WHEN  COUNT(o.total) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
WHEN COUNT(o.total) < 200 AND COUNT(o.total) > 150 OR SUM(o.total_amt_usd) < 750000 AND SUM(o.total_amt_usd) > 500000 THEN 'middle'
    ELSE 'low' END AS sizeOF
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 3 DESC

//odpowiedzi
SELECT s.name, COUNT(*), SUM(o.total_amt_usd) total_spent,
     CASE WHEN COUNT(*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top'
     WHEN COUNT(*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'middle'
     ELSE 'low' END AS sales_rep_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY 3 DESC;

SELECT c.Email, c.FirstName, c.LastName, g.Name
FROM Customer c
JOIN Invoice i
ON c.CustomerId = i.CustomerId
JOIN InvoiceLine il
ON i.InvoiceId = il.InvoiceId
JOIN Track t
ON il.TrackId = t.TrackId
JOIN Genre g
ON t.GenreId = g.GenreId
WHERE g.Name = 'Rock'
GROUP BY 1
ORDER BY 1;

SELECT a.ArtistId, a.Name, COUNT(g.Name)
FROM Artist a
JOIN Album al
ON a.ArtistId = al.ArtistId
JOIN Track t
ON al.AlbumId = t.AlbumId
JOIN Genre g
ON t.GenreId = g.GenreId
WHERE g.Name = 'Rock'
GROUP BY 1,2
HAVING COUNT(g.Name) > 50
ORDER BY 3 DESC
LIMIT 10;

SELECT a.Name, SUM(il.Quantity * t.UnitPrice) Amountspent
FROM Artist a
JOIN Album al
ON a.ArtistId = al.ArtistId
JOIN Track t
ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il
ON t.TrackId = il.TrackId
JOIN Invoice i
ON il.InvoiceId = i.InvoiceId
JOIN Customer c
ON i.CustomerId = c.CustomerId
GROUP BY 1
ORDER BY 2 DESC;

SELECT a.Name, SUM(il.Quantity * t.UnitPrice), c.CustomerId, c.FirstName, c.LastName
FROM Artist a
JOIN Album al
ON a.ArtistId = al.ArtistId
JOIN Track t
ON al.AlbumId = t.AlbumId
JOIN InvoiceLine il
ON t.TrackId = il.TrackId
JOIN Invoice i
ON il.InvoiceId = i.InvoiceId
JOIN Customer c
ON i.CustomerId = c.CustomerId
WHERE a.Name = 'Iron Maiden'
GROUP BY 3
ORDER BY 2 DESC;

//zle ale do badan
SELECT COUNT(i.InvoiceId) howmany, c.Country, g.Name, g.GenreId
FROM Genre g
JOIN Track t
ON g.GenreId = t.GenreId
JOIN InvoiceLine il
ON t.TrackId = il.TrackId
JOIN Invoice i
ON il.InvoiceId = i.InvoiceId
JOIN Customer c
ON i.CustomerId = c.CustomerId
GROUP BY 2
ORDER BY 2;
//lepiej ale do badan, dziala ale jest pokrecone
SELECT COUNT(il.Quantity), c.Country Country, g.Name Name, g.GenreId GenreId
FROM Genre g
JOIN Track t
ON g.GenreId = t.GenreId
JOIN InvoiceLine il
ON t.TrackId = il.TrackId
JOIN Invoice i
ON il.InvoiceId = i.InvoiceId
JOIN Customer c
ON i.CustomerId = c.CustomerId
GROUP BY 2,3,4
ORDER BY 2,3,4
//lepiej ale do badan
SELECT t3.Purchases, t3.Country, t3.GenreName, t3.ID
FROM
(SELECT max (Purchases) Purchases, Country, GenreName, ID
FROM
(SELECT Count(G.GenreId) AS Purchases, C.Country AS Country,G.Name As GenreName, G.GenreId AS ID
FROM Customer C
JOIN Invoice I
ON I.CustomerId=C.CustomerId
JOIN InvoiceLine IL
ON IL.InvoiceId=I.InvoiceId
JOIN TRACK T
ON T.TrackId=IL.TrackId
JOIN Genre G
ON G.GenreId=T.GenreId
GROUP BY 2, 3) t1
GROUP by 2) t2
JOIN
(SELECT Count(G.GenreId) AS Purchases, C.Country AS Country,G.Name As GenreName, G.GenreId AS ID
FROM Customer C
JOIN Invoice I
ON I.CustomerId=C.CustomerId
JOIN InvoiceLine IL
ON IL.InvoiceId=I.InvoiceId
JOIN TRACK T
ON T.TrackId=IL.TrackId
JOIN Genre G
ON G.GenreId=T.GenreId
GROUP BY 2, 3) t3
on t3.Country=t2.Country AND t3.Purchases=t2.Purchases
//poszukiwania trwaja

SELECT Name, Milliseconds
FROM Track
WHERE Milliseconds > (SELECT AVG(Milliseconds) FROM Track)
ORDER BY 2 DESC
