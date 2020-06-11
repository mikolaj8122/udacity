SELECT chanel
SELECT gloss_qty + poster_qty AS nonstandard_qty
SELECT gloss_qty/(poster_qty+gloss_qty) + 100
FROM web_events
WHERE name = ''
WHERE name LIKE '%one%'
WHERE name NOT LIKE '%one%'
WHERE name IN ('Walmart', 'Target');
WHERE name NOT IN ('Walmart', 'Target');
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);
WHERE (name LIKE 'C%' OR name LIKE 'W%')
           AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
           AND primary_poc NOT LIKE '%eana%');

ORDER BY DESC
LIMIT 15;
