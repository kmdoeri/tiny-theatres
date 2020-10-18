use tiny_theatres;

-- update 1
select theatre_show_date_id, `date` from theatre_show_date tsd
inner join theatre_show ts on ts.theatre_show_id = tsd.theatre_show_id
inner join theatre t on t.theatre_id = ts.theatre_id
inner join `show` s on s.show_id = ts.show_id
where theatre_name = 'Little Fitz' and s.show_name = 'The Sky Lit Up';-- want theatre_show_date_id 5

insert into theatre_show (theatre_show_id, theatre_id, show_id, ticket_price)
values (10, 2, 4, 22.25);

select * from theatre_show; -- verify the insert

update theatre_show_date set theatre_show_id = 10
where theatre_show_date_id = 5;

select ticket_price from theatre_show ts
inner join theatre_show_date tsd on tsd.theatre_show_id = ts.theatre_show_id
where theatre_show_date_id = 5; -- verify the change worked 

select ticket_price from theatre_show ts
inner join theatre_show_date tsd on tsd.theatre_show_id = ts.theatre_show_id
where theatre_show_date_id = 6; -- verify the change did not affect the other performance

-- update 2
select * from customer
where last_name = 'Bedburrow' or last_name = 'Guirau'; -- pooh customer id is 37, cullen customer id is 38

select * from reservation where theatre_show_date_id = 5; -- seat id for pooh: 29, 30, 31, 32. seat id for cullen: 33, 34
-- other taken seat ids: 26, 27, 28, 35, 36, 37

select * from seats where theatre_id = 2; -- 29-32 = A4, B1, B2, B3. 33-34 = B4, C1
-- other taken seats: A1, A2, A3, C2, C3, C4

-- Plan: move customer 37 in seat 29 (reservation 91) to seat 33,
-- move customer 38 in seat 33 to seat 35 (reservation 95), 
-- move customer 39 in seat 35 to seat 29 (reservation 97)

delete from reservation where reservation_id = 95;

update reservation set seat_id = 33 
where reservation_id = 91;

update reservation set seat_id = 29
where reservation_id = 97;

insert into reservation (reservation_id, customer_id, seat_id, theatre_show_date_id)
values (95, 38, 35, 5);

select customer_id, seat_number from reservation r
inner join seats s on s.seat_id = r.seat_id
where theatre_show_date_id = 5
order by s.seat_number; -- verify the change is correct 

-- update 3

update phone set phone_number = '1-801-EAT-CAKE'
where phone_id in (select phone_id from customer where first_name = 'Jammie' and last_name = 'Swindles');

select concat(c.first_name, c.last_name) customer_name, p.phone_number from customer c
inner join phone p on p.phone_id = c.phone_id
where p.phone_id = 41;

-- delete 1 
select * from theatre; -- theatre_id = 1

select * from theatre_show where theatre_id = 1; -- theatre_show_id 1,2,3

select * from theatre_show_date where theatre_show_id = 1 or theatre_show_id = 2 or theatre_show_id = 3; -- theatre_show_date_id = 1,2,3,4

select * from reservation 
where theatre_show_date_id = 1 or theatre_show_date_id = 2 or theatre_show_date_id = 3 or theatre_show_date_id = 4
order by reservation_id;
-- single-ticket reservations (by reservation number): 20, 21, 24, 36, 45, 46, 54, 62, 65 

delete from reservation 
where reservation_id in (20, 21, 24, 36, 45, 46, 54, 62, 65);

select * from reservation where theatre_show_date_id in (1,2,3,4)
order by reservation_id;

-- delete 2

delete from reservation 
where customer_id = (select customer_id from customer c where c.first_name = 'Liv' and c.last_name = 'Egle of Germany');

select * from reservation r
inner join customer c on c.customer_id = r.customer_id
where c.first_name = 'Liv' and c.last_name = 'Egle of Germany'; -- nothing shown

select * from customer 
where first_name = 'Liv' and last_name = 'Egle of Germany'; -- email id 68, address id 60, phone id 52, customer id is 65

delete from customer where customer_id = 65;

delete from email where email_id = 68;

delete from address where address_id = 60;

delete from phone where phone_id = 52;




