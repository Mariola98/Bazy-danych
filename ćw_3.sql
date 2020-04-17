--ćwiczenia nr 3
create database cw_3_gis;

CREATE EXTENSION postgis;
--tworzenie tabel
create table budynki
(
	id_budynku INTEGER,
	nazwa VARCHAR(50),
	wysokosc FLOAT,
	geometria GEOMETRY
);

create table drogi
(
	id_drogi INTEGER,
	nazwa_d VARCHAR(50),
	geometria_d GEOMETRY
);

create table pktinfo 
(
	id_pktinfo INTEGER,
	nazwa_pkt VARCHAR(50),
	liczprac_pkt INTEGER,
	geometria_pkt GEOMETRY
);
--uzupelnianie danych

insert into drogi(id_drogi,nazwa_d,geometria_d) values 
(1, 'RoadX', ST_GeomFromText('Linestring(0 4.5, 12 4.5)', -1)), 
(2, 'RoadY', ST_GeomFromText('Linestring(7.5 10.5, 7.5 0)', -1));

insert into budynki(id_budynku,nazwa,wysokosc,geometria) values 
(1, 'BuildingA', '10', ST_GeomFromText('Polygon((8 4, 10.5 4, 10.5 1.5, 8 1.5, 8 4))', -1)),
(2, 'BuildingB', '25', ST_GeomFromText('Polygon((4 7, 6 7, 6 5, 4 5, 4 7))', -1)),
(3, 'BuildingC', '15', ST_GeomFromText('Polygon((3 8 , 5 8, 5 6, 3 6, 3 8))', -1)),
(4, 'BuildingD', '5', ST_GeomFromText('Polygon((9 9 , 10 9, 10 8, 9 8, 9 9))', -1)),
(5, 'BuildingF', '30', ST_GeomFromText('Polygon((1 2, 2 2, 2 1, 1 1, 1 2))', -1));

insert into pktinfo(id_pktinfo, nazwa_pkt, liczprac_pkt, geometria_pkt) values 
(1, 'G', '2', ST_GeomFromText('Point(1 3.5)', -1)), 
(2, 'H', '1', ST_GeomFromText('Point(5.5 1.5)', -1)),
(3, 'I', '5', ST_GeomFromText('Point(9.5 6)', -1)),
(4, 'J', '7', ST_GeomFromText('Point(6.5 6)', -1)), 
(5, 'K', '9', ST_GeomFromText('Point(6 9.5)', -1));
--podpunkty

--1
select sum(ST_Length(geometria_d)) as "Calkowita dlugosc drog" from drogi;
--2
select geometria as "Geometria", ST_Area(geometria) as "Pole", ST_Perimeter(geometria) as "Obwod"
from budynki 
where budynki.nazwa='BuildingA';
--3
select nazwa as "Budynek", ST_Area(geometria) as "Powierzchnia"
from budynki
order by nazwa ASC;
--4
select nazwa as "Budynek",ST_Perimeter(geometria) as "Obwod", ST_Area(geometria) as "Pole"
from budynki
order by ST_Area(geometria) desc 
limit 2;
--5
SELECT ST_Length(ST_ShortestLine(geometria, geometria_pkt)) 
AS "Najkrotsza odl" FROM budynki, pktinfo WHERE budynki.nazwa='BuildingC' AND pktinfo.nazwa_pkt='G';
--6
SELECT ST_Area(ST_Difference(u1.geometria, ST_Intersection(u1.geometria, ST_Buffer(u2.geometria, 0.5, 'join=mitre')))) 
FROM budynki u1, budynki u2 
WHERE u1.nazwa ='BuildingB' 
AND u2.nazwa ='BuildingC';
--7
select budynki.* 
from budynki, drogi
where drogi.nazwa_d='RoadX'
and ST_Centroid(budynki.geometria) |>> drogi.geometria_d;
--8
SELECT ST_Area(ST_SymDifference(budynki.geometria, ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))',-1))) 
FROM budynki WHERE budynki.nazwa ='BuildingC';
