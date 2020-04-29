--4 
create table tableB as select f_codedesc as liczba_budynkow from popp p, majrivers m where Contains(Buffer(m.Geometry, 100000), p.Geometry);

select * from tableB;

--5 
create table airportsNew as
	select NAME, Geometry, ELEV from airports;
	
--na zachód
select * from airportsNew 
order by MbrMinY(Geometry) asc limit 1;
--na wschód
select * from airportsNew 
order by MbrMaxY(Geometry) desc limit 1;

--
select avg(ELEV) from airportsNew
where NAME="NIKOLSKI AS" or NAME="NOATAK";

--
select 0.5*Distance 
((SELECT Geometry FROM airportsNew 
WHERE NAME='NOATAK'),(SELECT Geometry FROM airportsNew 
WHERE NAME='NIKOLSKI AS') 
)
as "odleglosc";

--
insert into airportsNew(NAME, Geometry, ELEV) 
	values ('airportB', (0.5*Distance 
((SELECT Geometry FROM airportsNew 
WHERE NAME='NOATAK'),(SELECT Geometry FROM airportsNew 
WHERE NAME='NIKOLSKI AS') 
)), (select avg(ELEV) from airportsNew
where NAME="NIKOLSKI AS" or NAME="NOATAK"));

--
select * from airportsNew where NAME="airportB";

--6
SELECT Area(Buffer(ShortestLine(lakes.Geometry, airports.Geometry)), 1000) 
FROM airports, lakes WHERE airports.NAME='AMBLER' AND lakes.NAMES='Iliamna Lake';

--7
select SUM(Area(Intersection(tundra.Geometry, trees.Geometry))) as "Tundra",
	SUM(Area(Intersection(swamp.Geometry, trees.Geometry))) as "Bagna", VEGDESC
from swamp, trees, tundra
group by VEGDESC;

