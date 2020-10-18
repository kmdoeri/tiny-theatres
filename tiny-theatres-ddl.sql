drop database if exists tiny_theatres;
create database tiny_theatres;
use tiny_theatres;

create table address (
address_id int primary key auto_increment, 
address varchar(300) not null,
constraint uq_address_address
	unique (address)
);

create table email (
email_id int primary key auto_increment,
email varchar(50) not null,
constraint uq_email_email
	unique (email)
);

create table phone (
phone_id int primary key auto_increment,
phone_number varchar(25) not null
);

create table customer (
customer_id int primary key auto_increment,
first_name varchar(45) not null,
last_name varchar(45) not null,
email_id int not null,
address_id int not null,
phone_id int not null,
constraint fk_customer_email_id
	foreign key (email_id)
    references email(email_id),
constraint fk_customer_address_id
	foreign key (address_id)
    references address(address_id),
constraint fk_customer_phone_id
	foreign key (phone_id)
    references phone(phone_id)
);

create table theatre (
theatre_id int primary key auto_increment,
theatre_name varchar(45) not null default '',
address_id int not null default 0,
phone_id int not null default 0,
email_id int not null default 0,
constraint fk_theatre_address_id
	foreign key (address_id)
    references address(address_id),
constraint fk_theatre_phone_id
	foreign key (phone_id)
    references phone(phone_id),
constraint fk_theatre_email_id
	foreign key (email_id)
    references email(email_id)
    
);

create table seats (
seat_id int primary key auto_increment,
theatre_id int not null,
seat_number varchar(5) not null,
constraint fk_seats_theatre_id
	foreign key (theatre_id)
    references theatre (theatre_id)
);

create table `show` (
show_id int primary key auto_increment,
show_name varchar(50) not null
);

create table theatre_show (
theatre_show_id int primary key auto_increment,
theatre_id int not null,
show_id int not null,
ticket_price dec(5,2) not null,
constraint fk_theatre_show_theatre_id
	foreign key (theatre_id)
    references theatre(theatre_id),
constraint fk_theatre_show_show_id
	foreign key (show_id)
    references `show`(show_id)
);

create table theatre_show_date (
theatre_show_date_id int primary key auto_increment,
theatre_show_id int not null,
`date` date not null,
constraint fk_theatre_show_date_theatre_show_id
	foreign key (theatre_show_id)
    references theatre_show(theatre_show_id)
);

create table reservation (
reservation_id int primary key auto_increment,
customer_id int not null,
seat_id int not null,
theatre_show_date_id int not null,
constraint fk_reservation_customer_id 
	foreign key (customer_id)
    references customer(customer_id),
constraint fk_references_seat_id
	foreign key (seat_id)
    references seats(seat_id),
constraint fk_references_theatre_show_date_id
	foreign key (theatre_show_date_id)
    references theatre_show_date(theatre_show_date_id),
constraint uq_reservation_customer_id_seat_id_theatre_show_date_id
	unique(customer_id, seat_id, theatre_show_date_id)
);

create table excel_data (
customer_first varchar(45) not null,
customer_last varchar(45) not null,
customer_email varchar(30) not null,
customer_phone varchar(25) not null,
customer_address varchar(70) not null,
seat varchar(5) not null,
`show` varchar(45) not null,
ticket_price dec(5,2) not null,
`date` date not null,
theater varchar(45) not null,
theater_address varchar(200) not null,
theater_phone varchar(25) not null,
theater_email varchar(45) not null
);



    

