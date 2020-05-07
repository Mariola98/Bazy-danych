create database cwiczenie_5;
CREATE EXTENSION postgis;
create table obiekty
(
	nazwa VARCHAR(50),
	geometria GEOMETRY
);
insert into obiekty(nazwa, geometria) 
values ('obiekt1', ST_GeomFromText('COMPOUNDCURVE(LINESTRING(0 1, 1 1), CIRCULARSTRING(1 1, 2 0, 3 1), 
CIRCULARSTRING(3 1, 4 2, 5 1), LINESTRING(5 1, 6 1))', -1));
insert into obiekty 
values ('obiekt2', ST_GeomFromText('CURVEPOLYGON(COMPOUNDCURVE(LINESTRING(10 6, 14 6), CIRCULARSTRING(14 6, 16 4, 14 2), 
CIRCULARSTRING(14 2, 12 0, 10 2), LINESTRING(10 2, 10 6)),CIRCULARSTRING(11 2, 12 1, 13 2, 12 3, 11 2))', -1));
insert into obiekty 
values('obiekt3', ST_GeomFromText('POLYGON((7 15, 10 17, 12 13, 7 15))',-1));
insert into obiekty 
values ('obiekt4', ST_GeomFromText('LINESTRING(20 20, 25 25, 27 24, 25 22, 26 21, 22 19, 20.5 19.5)', -1));
insert into obiekty 
values ('obiekt5', ST_GeomFromText('GEOMETRYCOLLECTION(MULTIPOINT(30 30 59 , 38 32 234))', -1));
insert into obiekty 
values ('obiekt6', ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(1 1, 3 2), POINT(4 2))', -1));

SELECT ST_Area(ST_Buffer(ST_ShortestLine(o1.geometria, o2.geometria), 5)) 
FROM obiekty o1, obiekty o2 WHERE o1.nazwa='obiekt3' AND o2.nazwa='obiekt4';

SELECT ST_MakePolygon( ST_AddPoint(foo.open_line, ST_StartPoint(foo.open_line)) )
FROM ( SELECT geometria As open_line from obiekty where nazwa='obiekt4') As foo;

insert INTO obiekty 
values ('obiekt7', ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(7 15, 10 17),LINESTRING(10 17, 12 13),LINESTRING(12 13, 7 15),
LINESTRING(20 20, 25 25),LINESTRING(25 25, 27 24),LINESTRING(27 24, 25 22),
LINESTRING(25 22, 26 21),LINESTRING(26 21, 22 19),LINESTRING(22 19, 20.5 19.5))', -1));

SELECT ST_Area(ST_Buffer(geometria, 5)) 
as Pole FROM obiekty 
where ST_HasArc(geometria)=false;

SELECT SUM(ST_Area(ST_Buffer(geometria,5))) as Calkowite_Pole FROM obiekty where ST_HasArc(geometria)=false;
