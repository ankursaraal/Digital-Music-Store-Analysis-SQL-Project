/* Q1: Who is the senior most employee based on job title? */
SELECT title, first_name, last_name, levels
FROM employee
ORDER BY levels DESC
LIMIT 1;

--  Senior General Manager	Mohan	Madan	7.00  --


/* Q2: Which country have the most Invoices? */
select billing_country, count(total) as total
from invoice
group by billing_country
order by total desc
limit 1;

--  USA	 131  --


/* Q3: What are top 3 values of total invoice? */
select total from invoice
order by total desc
limit 3;

/*  23.7600002288818
    19.7999992370605
    19.7999992370605  */


/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

SELECT billing_city,SUM(total) AS InvoiceTotal
FROM invoice
GROUP BY billing_city
ORDER BY InvoiceTotal DESC
LIMIT 1;

-- Prague	273.240000247955  --

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer 
join invoice on
customer.customer_id=invoice.customer_id
group by customer.customer_id
order by total desc
limit 1;

  -- 5 František Wichterlová  144.539998054504  --

  /* Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;

/*
aaronmitchell@yahoo.ca	  Aaron	  Mitchell	Rock
alero@uol.com.br    	 Alexandre	Rocha	Rock
astrid.gruber@apple.at	 Astrid	   Gruber	Rock
bjorn.hansen@yahoo.no	 Bjørn	  Hansen	Rock
camille.bernard@yahoo.fr Camille	Bernard	Rock
+ other records (total 59 records)
*/

/* Q7: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 5;

/*
22	 Led Zeppelin    114  
150	 U2              112 
58	 Deep purple     92
90   Iron maiden     81
118  Pearl jam       54  */


/* Q8: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;
/*
Occupation / Precipice   	   5286953
Through a Looking Glass	       5088838
Greetings from Earth, Pt. 1	   2960293
The Man With Nine Lives	       2956998
Battlestar Galactica, Pt. 2    2956081
+ other records (total 494 records)
*/

