-- CWICZENIA 1

-- ZAD1

create database s299649;

-- ZAD2

CREATE SCHEMA firma;

-- ZAD3
CREATE ROLE ksiegowosc;
GRANT USAGE ON SCHEMA firma TO ksiegowosc;
GRANT SELECT on all tables in SCHEMA "firma" TO ksiegowosc;

-- ZAD4

CREATE TABLE firma.pracownicy (
    id_pracownika SERIAL,
    imie varchar(20)  NOT NULL,
    nazwisko varchar(40)  NOT NULL,
    adres varchar(60)  NOT NULL,
    telefon varchar(20)  NOT NULL,
    CONSTRAINT pracownicy_pk PRIMARY KEY (id_pracownika)
);


CREATE INDEX id_index ON firma.pracownicy (nazwisko);

CREATE TABLE firma.godziny (
    id_godziny SERIAL,
    data date  NOT NULL,
    liczba_godzin int  NOT NULL,
    id_pracownika int  NOT NULL,
    CONSTRAINT godziny_pk PRIMARY KEY (id_godziny)
);

ALTER TABLE firma.godziny ADD CONSTRAINT godziny_pracownicy
    FOREIGN KEY (id_pracownika)
    REFERENCES firma.pracownicy (id_pracownika)  
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

CREATE TABLE firma.pensja_stanowisko (
    id_pensji serial  NOT NULL,
    stanowisko varchar(30)  NOT NULL,
    kwota decimal(6,2)  NOT NULL,
    CONSTRAINT pensja_stanowisko_pk PRIMARY KEY (id_pensji)
);

CREATE TABLE firma.premia (
    id_premii serial  NOT NULL,
    rodzaj varchar(30)  NOT NULL,
    kwota decimal(6,2)  NOT NULL,
    CONSTRAINT premia_pk PRIMARY KEY (id_premii)
);

CREATE TABLE firma.wynagrodzenie (
    id_wynagrodzenia serial  NOT NULL,
    data date  NOT NULL,
    id_pracownika int  NOT NULL,
    id_godziny int  NOT NULL,
    id_pensji int  NOT NULL,
    id_premii int  NOT NULL,
    CONSTRAINT wynagrodzenie_pk PRIMARY KEY (id_wynagrodzenia)
);

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_godziny
    FOREIGN KEY (id_godziny)
    REFERENCES firma.godziny (id_godziny)  
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_pensja_stanowisko
    FOREIGN KEY (id_pensji)
    REFERENCES firma.pensja_stanowisko (id_pensji)  
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_pracownicy
    FOREIGN KEY (id_pracownika)
    REFERENCES firma.pracownicy (id_pracownika)  
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE firma.wynagrodzenie ADD CONSTRAINT wynagrodzenie_premia
    FOREIGN KEY (id_premii)
    REFERENCES firma.premia (id_premii)  
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

COMMENT ON TABLE firma.godziny
   IS 'tabela przechowuje liczbe przepracowanych godzin przez pracownika'

COMMENT ON TABLE firma.pensja_stanowisko 
   IS 'tablica przechowuje podstawową pensję pracownika na danym stanowisku'

COMMENT ON TABLE firma.pracownicy
   IS 'tabela przechowuje informacje o pracownikach
COMMENT ON TABLE firma.premia
   IS 'tabela przechowuje informacje o premii pracownika'
COMMENT ON TABLE firma.wynagrodzenie 
   IS 'tabela przechowuje informacje o końcowym wynagrodzeniu pracownika'
-- ZAD5
-- a)
ALTER TABLE firma.godziny ADD miesiac int4 NOT NULL;
ALTER TABLE firma.godziny ADD tydzien int4 NOT NULL;
-- b)
ALTER TABLE firma.wynagrodzenie ALTER COLUMN "data" TYPE varchar(20) USING "data"::varchar;
-- c)
ALTER TABLE firma.premia ALTER COLUMN rodzaj DROP NOT NULL;
ALTER TABLE firma.wynagrodzenie ALTER COLUMN id_premii DROP NOT NULL;
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Katarzyna', 'Mostowiak', 'Kusocińskiego 4, 32-800 Brzesko', '123456789');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Anna', 'Mazurska', 'Okocimska 35, 332-800 Brzesko', '502546987');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Agata', 'Kałamarnica', 'Browarna 3/4, 32-800 Brzesko', '652348927');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Karolina', 'Mazur', 'Kwiatowa 43, 32-800 Brzesko', '597284635');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Marek', 'Ciaciek', 'Jana Pawła 135, 30-072 Krakow', '978254631');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Hanna', 'Kapusta', 'Czarnowiejska 26, 32-800 Brzesko', '697254682');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Jan', 'Kornalski', 'Kwiatowa 25, 32-800 Brzesko', '964584325');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Amelia', 'Holik', 'Browarna 15, 32-800 Brzesko', '555986555');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Bartłomiej', 'Więcek', 'Wrocławska 365, 30-072 Krakow', '146685785');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Agata', 'Nowak', 'Kowali 123, 31-263 Krakow', '986572894');
INSERT INTO firma.pracownicy (imie, nazwisko, adres, telefon) VALUES('Iwona', 'Nowak', 'Berka Joselewicza 24, 32-800 Brzesko', '697854365');
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-01', 140, 1, extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-08', 144, 4, extract(month from DATE '2020-02-08'), extract(week from DATE '2020-02-08'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-01', 150, 2, extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-08', 149, 3, extract(month from DATE '2020-02-08'), extract(week from DATE '2020-02-08'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-01', 148, 5, extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-08', 140, 6, extract(month from DATE '2020-02-08'), extract(week from DATE '2020-02-08'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-01', 143, 7, extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-15', 144, 8, extract(month from DATE '2020-02-15'), extract(week from DATE '2020-02-15'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-01', 142, 9, extract(month from DATE '2020-02-01'), extract(week from DATE '2020-02-01'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-15', 140, 2, extract(month from DATE '2020-02-15'), extract(week from DATE '2020-02-15'));
INSERT INTO firma.godziny ("data", liczba_godzin, id_pracownika, miesiac, tydzien) VALUES('2020-02-15', 145, 10, extract(month from DATE '2020-02-15'), extract(week from DATE '2020-02-15'));
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Pracownik Sezonowy', 2500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Pracownik Linii', 2700);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Mlodszy magazynier', 3000);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Kierownik zmiany', 5000);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Informatyk', 3400);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Starszy magazynier', 3500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Starszy wykrawacz płyt', 3500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Dyrektor działu Fotolito', 5500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Pracownik działu HR', 3500);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Dyrektor działu HR', 6000);
INSERT INTO firma.pensja_stanowisko (stanowisko, kwota) VALUES('Prezes', 15000);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Dodatek za sezon', 200);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Wyrobienie normy', 100);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Ponadprzeciętne wyniki', 100);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Kwartalna', 300);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Dodatek nocny ', 150);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Dodatek zmianowy', 250);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Dodatek z linii', 300);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Roczna', 700);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Dodatek wyjazdowy', 1500);
INSERT INTO firma.premia (rodzaj, kwota) VALUES('Delegacja', 2500);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-10', 1, 1, 1, 1);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-10', 9, 9, 10, 10);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-02-10', 2, 3, 8, 9);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-02-10', 3, 4, 4, 2);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-10', 4, 2, 9, 4);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-10', 6, 6, 5, 1);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-02-10', 5, 5, 6, 5);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-10', 10, 11, 2, 5);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-02-10', 8, 8, 3, 6);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-03-10', 7, 7, 4, 2);
INSERT INTO firma.wynagrodzenie ("data", id_pracownika, id_godziny, id_pensji, id_premii) VALUES('2020-04-10', 10, 11, 1, 1);
-- ZAD6
-- a)
SELECT id_pracownika, nazwisko FROM firma.pracownicy;
-- b)
select firma.wynagrodzenie.id_pracownika from firma.wynagrodzenie join firma.pensja_stanowisko on firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji join firma.premia on firma.premia.id_premii = firma.wynagrodzenie.id_premii where firma.premia.kwota+firma.pensja_stanowisko.kwota >1000;
-- c)
select firma.wynagrodzenie.id_pracownika from firma.wynagrodzenie join firma.pensja_stanowisko on firma.pensja_stanowisko.id_pensji = firma.wynagrodzenie.id_pensji join firma.premia on firma.premia.id_premii = firma.wynagrodzenie.id_premii where firma.premia.kwota = 0 and firma.pensja_stanowisko.kwota > 2000;
-- d)
select imie from firma.pracownicy where imie like 'J%';
-- e)
select * from firma.pracownicy where nazwisko like '%n%' or nazwisko like '%N%' and imie like '%a';
-- f)
select prac.imie, prac.nazwisko , case when god.liczba_godzin<160 then 0 else god.liczba_godzin-160 end as "nadgodziny" from firma.pracownicy prac join firma.godziny god on prac.id_pracownika = god.id_pracownika;
-- g)
select prac.imie, prac.nazwisko from firma.pracownicy prac join firma.wynagrodzenie wyn on wyn.id_pracownika = prac.id_pracownika join firma.pensja_stanowisko pensja on wyn.id_pensji = pensja.id_pensji where pensja.kwota >= 1500 and pensja.kwota <= 3000;
-- h)
select prac.imie, prac.nazwisko from firma.pracownicy prac join firma.godziny god on prac.id_pracownika = god.id_pracownika join firma.wynagrodzenie wyn on prac.id_pracownika = wyn.id_pracownika join firma.premia premia on wyn.id_premii = premia.id_premii where premia.kwota = 0 and god.liczba_godzin > 160;
-- ZAD7
-- a)
select prac.*, pensja.kwota from firma.pracownicy prac join firma.wynagrodzenie wyn on prac.id_pracownika = wyn.id_pracownika join firma.pensja_stanowisko pensja on pensja.id_pensji = wyn.id_pensji order by pensja.kwota;
-- b)
select prac.*, pen.kwota+pre.kwota as "wyplata" from firma.pracownicy prac join firma.wynagrodzenie wyn on prac.id_pracownika = wyn.id_pracownika join firma.pensja_stanowisko pen on pen.id_pensji = wyn.id_pensji join firma.premia pre on pre.id_premii = wyn.id_premiiorder by pen.kwota+pre.kwota desc;
-- c)
select pen.stanowisko, count(pen.stanowisko) from firma.pensja_stanowisko pen join firma.wynagrodzenie wyn on pen.id_pensji = wyn.id_pensji join firma.pracownicy prac on prac.id_pracownika = wyn.id_pracownika group by pen.stanowisko;
-- d)
select pen.stanowisko, avg(pen.kwota+pre.kwota), min(pen.kwota+pre.kwota), max(pen.kwota+pre.kwota) from firma.pensja_stanowisko pen join firma.wynagrodzenie wyn on pen.id_pensji = wyn.id_pensji join firma.premia pre on pre.id_premii = wyn.id_premii where pen.stanowisko = 'Prezes' group by pen.stanowisko;
-- e)
select sum(pen.kwota+pre.kwota) as "Suma wynagrodzeń" from firma.wynagrodzenie wyn join firma.pensja_stanowisko pen on wyn.id_pensji = pen.id_pensji join firma.premia pre on wyn.id_premii = pre.id_premii;
-- f)
select pen.stanowisko, sum(pen.kwota+pre.kwota) as "Suma wynagrodzeń" from firma.wynagrodzenie wyn join firma.pensja_stanowisko pen on wyn.id_pensji = pen.id_pensji join firma.premia pre on wyn.id_premii = pre.id_premii group by pen.stanowisko;
-- g)
select pen.stanowisko, count(pre.kwota>0) as "Liczba premii" from firma.pensja_stanowisko pen join firma.wynagrodzenie wyn on pen.id_pensji = wyn.id_pensji join firma.premia pre on pre.id_premii = wyn.id_premii where pre.kwota > 0 group by pen.stanowisko;
-- h)
delete from firma.pracownicy prac using firma.wynagrodzenie wyn, firma.pensja_stanowisko pen where prac.id_pracownika = wyn.id_pracownika and pen.id_pensji = wyn.id_pensji and pen.kwota < 1200;
-- ZAD8
-- a)
UPDATE firma.pracownicy SET telefon=CONCAT('(+48) ', telefon);
-- b)
UPDATE firma.pracownicy SET telefon=CONCAT(SUBSTRING(telefon, 1, 9), '-', substring(telefon, 10, 3), '-', substring(telefon, 13, 3));
-- c)
select imie, upper(nazwisko) as "nazwisko", adres, telefon from firma.pracownicy where length(nazwisko) = (select max(length(nazwisko)) from firma.pracownicy);
-- d)
select md5(prac.imie) as "imie", md5(prac.nazwisko) as "nazwisko", md5(prac.adres) as "adres", md5(prac.telefon) as "telefon", md5(cast(pen.kwota as varchar(20))) as "pensja" from firma.pracownicy prac join firma.wynagrodzenie wyn on wyn.id_pracownika = prac.id_pracownika join firma.pensja_stanowisko pen on pen.id_pensji = wyn.id_pensji;
-- ZAD9
select concat('Pracownik ', prac.imie, ' ', prac.nazwisko, ', w dniu ', wyn."data", ' otrzymał pensję całkowitą na kwotę ', pen.kwota+pre.kwota,'zł, gdzie wynagrodzenie zasadnicze wynosiło: ', pen.kwota, 'zł, premia: ', pre.kwota, 'zł. Liczba nadgodzin: ') as "raport" from firma.pracownicy prac join firma.wynagrodzenie wyn on prac.id_pracownika = wyn.id_pracownika join firma.pensja_stanowisko pen on pen.id_pensji = wyn.id_pensji join firma.premia pre on pre.id_premii = wyn.id_premii;