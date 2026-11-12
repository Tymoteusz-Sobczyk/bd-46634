-- 1.
UPDATE produkty SET ilosc_magazyn = ilosc_magazyn + 50 WHERE kategoria_id = 5; 
-- Wynik zapytania:
-- UPDATE 6

-- Query returned successfully in 54 msec.

-- 2.
DELETE FROM pozycje_zamowien pz
USING zamowienia z 
WHERE pz.ilosc = 1 AND z.data_zamowienia < CURRENT_DATE - INTERVAL '180 days';
-- Wynik zapytania:
-- DELETE 0

-- Query returned successfully in 31 msec.
-- (Delete 0, ponieważ za pierwszym wywowałniem zapomniałem skopiować wynik)

-- 3.
BEGIN;

INSERT INTO zamowienia(klient_id, pracownik_id) VALUES
(10, 15);

INSERT INTO pozycje_zamowien(zamowienie_id, produkt_id, ilosc, cena_jednostkowa) VALUES
((SELECT id FROM zamowienia ORDER BY id DESC LIMIT 1), 5, 3, 20.43),
((SELECT id FROM zamowienia ORDER BY id DESC LIMIT 1), 2, 10, 317.86);

COMMIT;
-- Obserwacje
-- Transkacje w bardzo prosty i efektywny sposób zabezpieczają bazę danych przed nieprawidłowościami przy modyfikacji danych
-- Zastanawiam się tylko jak automatyzuje się ten proces w bazie danych w prawdziwym backendzie - kto wpisuje ROLLBACK w razie błędu?

-- 4.
SELECT k.id, k.imie FROM klienci k
RIGHT JOIN zamowienia z ON z.klient_id = k.id; 

DELETE FROM klienci k 
WHERE k.id = 36;
-- Wynik zapytania:
-- ERROR:  update or delete on table "klienci" violates foreign key constraint "zamowienia_klient_id_fkey" on table "zamowienia"
-- Key (id)=(36) is still referenced from table "zamowienia". 

-- SQL state: 23503
-- Detail: Key (id)=(36) is still referenced from table "zamowienia".

-- Ten wynik wszystko tłumaczy, ale tak swoimi słowami - jeżeli usunelibyśmy klienta, to każde zamówienie które w kolumnie klient_id wskazuje na tego
-- już usuniętego delikwenta, naruszałoby nagle integralność referencyjną (klient_id = 36 wskazuje na nic, totalny bez sens)

-- 5.
CREATE TABLE produkty(
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(50) 
);

CREATE TABLE wlasciciel1(
    id SERIAL PRIMARY KEY,
    produkt_id INTEGER REFERENCES produkty(id) ON DELETE CASCADE
);

CREATE TABLE wlasciciel2(
    id SERIAL PRIMARY KEY,
    produkt_id INTEGER REFERENCES produkty(id) ON DELETE SET NULL
);

INSERT INTO produkty(nazwa) VALUES
    ('produkt_wlasciciela1'),
    ('produkt_wlasciciela2');

INSERT INTO wlasciciel1(produkt_id) VALUES
    (1);

INSERT INTO wlasciciel2(produkt_id) VALUES
    (2);

DELETE FROM produkty;

-- Dołączone przeze mnie zrzuty ekranu dokładnie uwidaczniają różnicę pomiędzy ON DELETE CASCADE a SET NULL
-- Przy jednym cały rekord danych przepada (dobre kiedy np. usuniemy zamówienie, i jego pozycje przestają mieć sens)
-- A przy drugim, w miejsce klucza obcego wstawiane jest NULL (dobre kiedy np. usuniemy klienta, jego przeszłe zamówienia dalej mają sens, jedynie nie mają teraz właściciela)

-- 6.
UPDATE zamowienia SET status = 'w realizacji'
WHERE status = 'nowe' AND data_zamowienia < CURRENT_DATE - INTERVAL '7 days';
-- Wynik zapytania:
-- UPDATE 190

-- Query returned successfully in 40 msec.

-- 7.
-- Usuwanie historii sprzedaży moim zdaniem NIGDY nie jest dobrym pomysłem, sprzedanego produktu nie wyczarujemy spowrotem
-- i musiałoby coś generować koszmar w inwentaryzacji produktów