-- KdG email :          YOUR_KDG_EMAIL      <-- FILL IN !
-- OS in use :          Windows/Linux/MAC   <-- FILL IN !
-- Date  :                                  <-- FILL IN !
-- Period :             Period x examen    <-- FILL IN !


-- =========================================================
-- THREE OPEN QUESTIONS
-- All code should run. If your code doesn't run -2pt/question
-- =========================================================

--  Run below command to check if your database is correctly loaded.

SELECT name FROM track ORDER BY trackid DESC FETCH NEXT 4 ROWS ONLY;
/*
name
-------
Koyaanisqatsi
Quintet for Horn, Violin, 2 Violas, and Cello in E Flat Major, K. 407/386c: III. Allegro
L'orfeo, Act 3, Sinfonia (Orchestra)
String Quartet No. 12 in C Minor, D. 703 ""Quartettsatz"": II. Andante - Allegro assai

(4 rows)

----------------
-- QUESTION 1 --
----------------
Provide the total revenue for the TOP 3 albums that reached the highest revenue. 
Take below conditions into a count.
- Shared seats of the TOP 3 ranking are also displayed.
- Calculate total revenue by multiplying price and quantity for each row of an invoice.
- Only provide the revenue for artists containing the letter 'o' in their name.


OUTPUT
------

title                   | revenue
------------------------+-----------------
The Office, Season 3    | 31.84
Minha Historia          | 26.73
Lost, Season 2          | 25.87
Heroes, Season 1        | 25.87

----------------------
-- ANSWER QUESTION 1 --
----------------------
 */
SELECT a.title, sum(i.quantity*i.unitprice) as revenue
FROM album a
JOIN track t ON (t.albumid = a.albumid)
JOIN invoiceline i ON (i.trackid = t.trackid)
JOIN artist ar ON (ar.artistid = a.artistid)
WHERE lower(ar.name) LIKE '%o%'
GROUP BY a.title
ORDER BY revenue DESC
FETCH NEXT 3 ROWS WITH TIES;


----------------
-- QUESTION 2 --
----------------

/*
Show a list with all album titles, longer than 60 characters,
that contain tracks, that appear on a playlist, and have never been sold.

Provide the exact outcome.

OUTPUT
------

long movie titles
------------------------------------------------------------------------------
Radio Brasil (O Som da Jovem Vanguarda) - Seleccao de Henrique Amaro
Pure Cult: The Best Of The Cult (For Rockers, Ravers, Lovers & Sinners) [UK]
Locatelli: Concertos for Violin, Strings and Continuo, Vol. 3
Knocking at Your Back Door: The Best Of Deep Purple in the 80's
Instant Karma: The Amnesty International Campaign to Save Darfur
Handel: Music for the Royal Fireworks (Original Version 1749)
Great Recordings of the Century - Shubert: Schwanengesang, 4 Lieder
Great Recordings of the Century - Mahler: Das Lied von der Erde
Great Performances - Barber's Adagio and Other Romantic Favorites for Strings
20th Century Masters - The Millennium Collection: The Best of Scorpions

(10 rows)
*/

----------------------
-- ANSWER QUESTION 2 -- 
----------------------




SELECT a.title as "long movie titles"
FROM playlist p
JOIN playlisttrack pt ON (p.playlistid = pt.playlistid)
JOIN track t ON (t.trackid = pt.trackid)
JOIN album a ON (a.albumid = t.albumid)
WHERE length(a.title) > 60

INTERSECT

SELECT a.title as "long movie titles"
FROM album a
JOIN track t ON (t.albumid = a.albumid)
JOIN invoiceline il ON (t.trackid <> il.trackid)

ORDER BY "long movie titles" DESC;











----------------
-- QUESTION 3 --
----------------
/*
Compare the customers with the most purchases:
- Customers living in France (the first line)
- Customers helped by employees older than 60 years (the second line)

Show the next analysis, if the amount exceeds 500, show '> 500', otherwise '<= 500'

OUTPUT
------

type_of_customer                                           | total_purchases   | analysis
-----------------------------------------------------------+-------------------+----------------
customers living in France                                 | 195.1             | <= 500
customers who were helped by employees older then 60 years | 775.4             | > 500

(2 rows)
*/

----------------------
-- ANSWER QUESTION 3 -- 
----------------------
SELECT 'customers living in France' AS type_of_customer, sum(i.total) AS total_purchases,
    CASE
    WHEN sum(i.total) > 500 THEN '> 500'
    ELSE '<= 500'
END analysis
FROM customer c
JOIN invoice i ON (i.customerid = c.customerid)
WHERE lower(c.country) = 'france'

UNION

SELECT 'customers who were helped by employees older then 60 years' AS type_of_customer, sum(i.total) AS total_purchases,
CASE
    WHEN sum(i.total) > 500 THEN '> 500'
    ELSE '<= 500'
END analysis
FROM customer c
JOIN employee e ON(e.employeeid = c.supportrepid)
JOIN invoice i ON (i.customerid = c.customerid)
WHERE birthdate < current_date - 60*365
GROUP BY type_of_customer;