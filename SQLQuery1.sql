create database PharmacyDB

use PharmacyDB


create table Pharmacies(
	Id int identity primary key,
	[Name] nvarchar(50) not null,
	City nvarchar(50)
)

insert into Pharmacies
values ('Tallinn Center Pharmacy', 'Tallinn')
		

select * from Pharmacies

create table Departments(
	Id int identity primary key,
	[Name] nvarchar(50) not null,
	PharmacyId int references Pharmacies(Id)
)


select * from Departments

insert into Departments
values ('Optical', 1),
	('General Pharmacy', 1),
	('Cosmetics', 1)
	

create table MedicineTypes(
	Id int identity primary key,
	[Name] nvarchar(50) not null
)

insert into MedicineTypes
values ('Pain killer'),
	('Vitamines'),
	('Drugs')

	select * from Departments

	select * from MedicineTypes

create table DepartmentsMedicineTypes(
	Id int identity primary key,
	DepartmentId int references Departments(Id),
	MedicineTypeId int references MedicineTypes(Id)
)

insert into DepartmentsMedicineTypes
values (2,1),
(2,2),
(3,2)

create table Medicines(
	Id int identity primary key,
	[Name] nvarchar(50) not null,
	Price int,
	MedicineTypeId int references MedicineTypes(Id)
)

insert into Medicines
values ('Spazmalgon', 7, 1),
('Ascorbic acid', 2, 2)

create table Cart(
	Id int identity primary key,
	CartNumber int,
	TotalPrice int,
	SellerId int references Sellers(Id)
)
insert into Cart
values (5, 20, 1)

insert into Cart
values (6, 14, 2)

create table MedicineCart(
	Id int identity primary key,
	MedicineId int references Medicines(Id),
	CartId int references Cart(Id)
)
insert into MedicineCart
values (2,1)

create table Sellers(
	Id int identity primary key,
	[Name] nvarchar(50) not null,
	Surname nvarchar(50),
	DepartmentId int references Departments(Id)
)

insert into Sellers
values ('Farid', 'Mamedov', 2)
		
insert into Sellers
values ('Narmin', 'Aslanova', 1)

select * from Sellers

select * from Pharmacies ph
join Departments dp
on ph.Id=dp.PharmacyId

create view PharmacyReport
as
select c.CartNumber, c.TotalPrice, c.SellerId 'SellerId', s.Name 'Seller Name', s.Surname 'Seller Surname', dp.Name 'Department Name', ph.Name 'Pharmacy Name',
ph.City from Cart c
join Sellers s
on c.SellerId=s.Id
join Departments dp
on dp.Id=s.DepartmentId	
join Pharmacies ph
on dp.PharmacyId=ph.Id

--drop view PharmacyReport
select * from PharmacyReport

create procedure usp_PharmacyReportById @sellerId int
as
select * from PharmacyReport
where SellerId=@sellerId

exec usp_PharmacyReportById 2