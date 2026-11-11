-- 1, 2, 3
CREATE TABLE klienci(
    id          SERIAL PRIMARY KEY,
    imie        VARCHAR(50),
    nazwisko    VARCHAR(50),
    email       VARCHAR(100),
    miasto      VARCHAR(50)
);

ALTER TABLE klienci ADD CONSTRAINT unikalny_klient UNIQUE(imie, nazwisko, email, miasto);

CREATE TABLE kategorie(
    id      SERIAL PRIMARY KEY,
    nazwa   VARCHAR(50)
);

CREATE TABLE produkty(
    id              SERIAL PRIMARY KEY,
    nazwa           VARCHAR(50),
    kategoria_id    INTEGER REFERENCES kategorie(id) NOT NULL,
    cena            DECIMAL(20,2)
);

ALTER TABLE produkty ADD CONSTRAINT unikalny_produkt UNIQUE(nazwa, kategoria_id);

CREATE TABLE sprzedaz_fakt(
    id              SERIAL PRIMARY KEY,
    produkt_id      INTEGER REFERENCES produkty(id) NOT NULL,
    klient_id       INTEGER REFERENCES klienci(id) NOT NULL,
    ilosc           INTEGER,
    data_sprzedazy  DATE NOT NULL
);

-- 4.
INSERT INTO klienci(imie, nazwisko, email, miasto)
SELECT DISTINCT klient_imie, klient_nazwisko, klient_email, klient_miasto
FROM sprzedaz_flat;  

INSERT INTO kategorie(nazwa)
SELECT DISTINCT produkt_kategoria 
FROM sprzedaz_flat;

INSERT INTO produkty(nazwa, kategoria_id, cena)
SELECT DISTINCT sf.produkt_nazwa, k.id, sf.produkt_cena
FROM sprzedaz_flat sf
JOIN kategorie k ON sf.produkt_kategoria = k.nazwa;

INSERT INTO sprzedaz_fakt(produkt_id, klient_id, data_sprzedazy, ilosc)
SELECT p.id, k.id, sf.data_sprzedazy, sf.ilosc
FROM sprzedaz_flat sf
JOIN produkty p ON p.nazwa = sf.produkt_nazwa 
JOIN klienci k ON k.imie = sf.klient_imie AND k.nazwisko = sf.klient_nazwisko AND k.email = sf.klient_email AND k.miasto = sf.klient_miasto
