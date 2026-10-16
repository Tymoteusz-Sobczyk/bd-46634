-- 1.
SELECT nazwa, cena FROM produkty WHERE cena > 200 ORDER BY cena DESC;

-- 2.
SELECT imie, nazwisko, miasto FROM klienci WHERE miasto LIKE 'Wroclaw' OR miasto LIKE 'Poznan';

-- 3.
SELECT nazwa, cena FROM produkty ORDER BY cena ASC LIMIT 10;

-- 4.
SELECT * FROM zamowienia WHERE status LIKE 'anulowane' ORDER BY data_zamowienia DESC;

-- 5.
SELECT * FROM produkty WHERE nazwa LIKE 'P%';

-- 6.
SELECT * FROM produkty WHERE ilosc_magazyn < 5;

-- 7.
SELECT * FROM klienci WHERE data_rejestracji > CURRENT_DATE - INTERVAL '500 days';

-- 8.
SELECT * FROM produkty ORDER BY cena DESC LIMIT 5;
SELECT * FROM produkty ORDER BY cena ASC LIMIT 5;

-- 9.
SELECT * FROM produkty WHERE data_dodania >= CURRENT_DATE - INTERVAL '30 days';

-- 10.
SELECT DISTINCT miasto FROM klienci;

-- 11.
SELECT nazwisko, UPPER(nazwisko) as nazwisko_drukowanymi FROM klienci;

-- 12.
SELECT * FROM produkty WHERE ROUND(cena) BETWEEN 90 AND 110;

-- 13.
SELECT * FROM klienci WHERE nazwisko LIKE '%ski' OR nazwisko LIKE 'A%'

-- 14.
SELECT * FROM zamowienia ORDER BY data_zamowienia ASC LIMIT 5;

-- 15.
SELECT * FROM produkty WHERE cena NOT BETWEEN 100 AND 300;

-- 16.
SELECT nazwa, CURRENT_DATE - data_dodania FROM produkty ORDER BY CURRENT_DATE - data_dodania DESC;