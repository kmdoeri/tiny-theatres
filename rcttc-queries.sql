use tiny_theatres;

-- Find all performances in the last quarter of 2021
select distinct s.show_name, t.theatre_name, tsd.`date` from theatre_show_date tsd
inner join theatre_show ts on tsd.theatre_show_id = ts.theatre_show_id
inner join `show` s on s.show_id = ts.show_id
inner join theatre t on t.theatre_id = ts.theatre_id
where tsd.`date` between '2021-10-1' and '2021-12-31';

-- List customers without duplication
select distinct concat(first_name, ' ', last_name) customer_name from customer;

-- List all customers without a .com email address
select concat(c.first_name, ' ', c.last_name) customer_name, e.email from customer c
inner join email e on c.email_id = e.email_id
where e.email not like '%.com';

-- Find the 3 cheapest shows 
select s.show_name, t.theatre_name, ts.ticket_price from theatre_show_date tsd
inner join theatre_show ts on ts.theatre_show_id = tsd.theatre_show_id
inner join `show` s on s.show_id = ts.show_id
inner join theatre t on t.theatre_id = ts.theatre_id
order by ts.ticket_price limit 3;

-- List customers and the show they're attending without duplication
select distinct concat(c.first_name, ' ', c.last_name) customer_name, s.show_name
from reservation r 
inner join customer c on c.customer_id = r.customer_id
inner join theatre_show_date tsd on tsd.theatre_show_date_id = r.theatre_show_date_id
inner join theatre_show ts on ts.theatre_show_id = tsd.theatre_show_id
inner join `show` s on s.show_id = ts.show_id
order by c.last_name;

-- List customer, show, theatre, and seat number in one query 
select distinct concat(c.first_name, ' ', c.last_name) customer_name, s.show_name, t.theatre_name, seats.seat_number
from reservation r
inner join customer c on c.customer_id = r.customer_id
inner join seats on seats.seat_id = r.seat_id
inner join theatre_show_date tsd on tsd.theatre_show_date_id = r.theatre_show_date_id
inner join theatre_show ts on ts.theatre_show_id = tsd.theatre_show_id
inner join theatre t on ts.theatre_id = t.theatre_id
inner join `show` s on s.show_id = ts.show_id;

-- find customers without an address
select concat(c.first_name, ' ', c.last_name) customer_name, a.address
from customer c 
left outer join address a on c.address_id = a.address_id
where a.address = '';

-- recreate the spreadsheet
select customer_first, customer_last, customer_email, customer_phone, customer_address,
 seat, `show`,  ticket_price, `date`, theater, theater_address, theater_phone, theater_email
 from excel_data;

-- count total tickets purchased per customer
select concat(c.first_name, ' ', c.last_name) customer_name, count(r.seat_id) total_tickets
from reservation r
inner join customer c on c.customer_id = r.customer_id
group by r.customer_id;

-- count total revenue per show based on tickets sold
select s.show_name, count(ts.ticket_price) * ts.ticket_price total_revenue
from reservation r
inner join theatre_show_date tsd on tsd.theatre_show_date_id = r.theatre_show_date_id
inner join theatre_show ts on ts.theatre_show_id = tsd.theatre_show_id
inner join `show` s on s.show_id = ts.show_id
group by s.show_id;

-- count total revenue per theater based on tickets sold
select t.theatre_name, count(ts.ticket_price) * ts.ticket_price total_revenue
from reservation r
inner join theatre_show_date tsd on tsd.theatre_show_date_id = r.theatre_show_date_id
inner join theatre_show ts on ts.theatre_show_id = tsd.theatre_show_id
inner join theatre t on t.theatre_id = ts.theatre_id
group by t.theatre_id;

-- who spent the most money in 2021?
select concat(c.first_name, ' ', c.last_name) customer_name, count(ts.ticket_price) * ts.ticket_price amount_spent
from reservation r
inner join customer c on c.customer_id = r.customer_id
inner join theatre_show_date tsd on tsd.theatre_show_date_id = r.theatre_show_date_id
inner join theatre_show ts on ts.theatre_show_id = tsd.theatre_show_id
group by c.customer_id
order by count(ts.ticket_price) * ts.ticket_price desc;


