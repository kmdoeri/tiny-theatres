use tiny_theatres;

insert into address (address)
select distinct theater_address from excel_data;

insert into address (address)
select distinct customer_address from excel_data;

-- select * from address order by address_id;

insert into phone (phone_number)
values ('(651) 555-5555');

insert into phone (phone_number)
select distinct customer_phone from excel_data;

-- select * from phone order by phone_id;

insert into email (email)
select distinct theater_email from excel_data;

insert into email (email)
select distinct customer_email from excel_data;

-- select * from email order by email_id;

insert into customer (first_name, last_name, email_id, address_id, phone_id)
select distinct ex.customer_first, ex.customer_last, e.email_id, a.address_id, p.phone_id
from excel_data ex
inner join email e on ex.customer_email = e.email
inner join address a on ex.customer_address = a.address
inner join phone p on ex.customer_phone = p.phone_number;

-- select * from customer order by customer_id;

insert into theatre (theatre_name, address_id, phone_id, email_id)
select distinct ex.theater, a.address_id, p.phone_id, e.email_id
from excel_data ex
inner join address a on a.address = ex.theater_address
inner join phone p on p.phone_number = ex.theater_phone
inner join email e on e.email = ex.theater_email;

-- select * from theatre order by theatre_id;

insert into `show` (show_name)
select distinct `show` from excel_data;

insert into `show` (show_id, show_name)
values (10, 'High School Musical'),
	   (11, 'Ocean'),
       (12, 'Wen');

-- select * from `show` order by show_id;

insert into seats (theatre_id, seat_number)
values (1, 'A1'), (1, 'A2'), (1, 'A3'), (1, 'A4'), (1, 'A5'),
       (1, 'B1'), (1, 'B2'), (1, 'B3'), (1, 'B4'), (1, 'B5'),
       (1, 'C1'), (1, 'C2'), (1, 'C3'), (1, 'C4'), (1, 'C5'),
       (1, 'D1'), (1, 'D2'), (1, 'D3'), (1, 'D4'), (1, 'D5'),
       (1, 'E1'), (1, 'E2'), (1, 'E3'), (1, 'E4'), (1, 'E5'),
       
       (2, 'A1'), (2, 'A2'), (2, 'A3'), (2, 'A4'),
       (2, 'B1'), (2, 'B2'), (2, 'B3'), (2, 'B4'),
       (2, 'C1'), (2, 'C2'), (2, 'C3'), (2, 'C4'),
       
       (3, 'A1'), (3, 'A2'), (3, 'A3'), (3, 'A4'), (3, 'A5'), (3, 'A6'), (3, 'A7'), (3, 'A8'),
       (3, 'B1'), (3, 'B2'), (3, 'B3'), (3, 'B4'), (3, 'B5'), (3, 'B6'), (3, 'B7'), (3, 'B8');
       
-- select * from seats order by seat_id;

insert into theatre_show (ticket_price, theatre_id, show_id)
select distinct ticket_price, theatre_id, show_id
from excel_data ex
inner join theatre t on t.theatre_name = ex.theater
inner join `show` s on s.show_name = ex.`show`;

-- select * from theatre_show order by theatre_show_id;

insert into theatre_show_date (`date`, theatre_show_id)
select distinct ex.`date`, ts.theatre_show_id
from excel_data ex
inner join `show` s on s.show_name= ex.`show`
inner join theatre_show ts on s.show_id = ts.show_id;

-- select * from theatre_show_date order by theatre_show_date_id;

insert into reservation (customer_id, theatre_show_date_id, seat_id)
with 
	seats_with_theatre as ( -- common table expressions
    select s.seat_id, s.seat_number, t.theatre_id, t.theatre_name 
    from theatre t
    inner join seats s on s.theatre_id = t.theatre_id),
    customer_with_email as (
    select c.customer_id, e.email 
    from customer c 
    inner join email e on e.email_id = c.email_id)
select cwe.customer_id, tsd.theatre_show_date_id, swt.seat_id
from excel_data ex
inner join seats_with_theatre swt on swt.seat_number = ex.seat and swt.theatre_name = ex.theater
inner join customer_with_email cwe on cwe.email = ex.customer_email
inner join theatre_show ts on ts.theatre_id = swt.theatre_id
inner join theatre_show_date tsd on tsd.theatre_show_id = ts.theatre_show_id and tsd.`date` = ex.`date`
order by tsd.theatre_show_date_id, cwe.customer_id, swt.seat_id;


-- select * from reservation order by reservation_id;



