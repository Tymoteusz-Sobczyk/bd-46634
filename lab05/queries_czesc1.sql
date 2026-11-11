-- 1.
CREATE TABLE recenzje(
    id              SERIAL PRIMARY KEY,
    produkt_id      INTEGER REFERENCES produkty(id),
    klient_id       INTEGER REFERENCES klienci(id),
    ocena           INTEGER NOT NULL,
    tresc_recenzji  VARCHAR(1500)
);

-- 2.
ALTER TABLE recenzje ADD CONSTRAINT ocena_zakres CHECK (ocena BETWEEN 1 AND 5);

-- 3.
ALTER TABLE recenzje ADD CONSTRAINT unikalny_klient_opinia UNIQUE (produkt_id, klient_id);

-- 4.
ALTER TABLE recenzje ADD COLUMN data DATE DEFAULT CURRENT_DATE;
ALTER TABLE recenzje ALTER COLUMN tresc_recenzji TYPE VARCHAR(2000);
ALTER TABLE recenzje RENAME COLUMN data TO data_wystawenia;

-- 5.
INSERT INTO recenzje(produkt_id, klient_id, ocena, tresc_recenzji) VALUES
    (1, 5, 3, 'Przykładowa recenzja');
-- Zapytanie przechodzące bez błędu 

INSERT INTO recenzje(produkt_id, klient_id, ocena, tresc_recenzji) VALUES
    (1, 3, 7, 'Przykładowa recenzja z błędną oceną(7)');
-- Tekst błędu dla powyższego zapytania:
-- ERROR:  new row for relation "recenzje" violates check constraint "ocena_zakres"
-- Failing row contains (2, 1, 3, 7, Przykładowa recenzja z błędną oceną(7), 2026-11-11). 
-- SQL state: 23514
-- Detail: Failing row contains (2, 1, 3, 7, Przykładowa recenzja z błędną oceną(7), 2026-11-11).

INSERT INTO recenzje(produkt_id, klient_id, ocena, tresc_recenzji) VALUES
    (1, 5, 4, 'Przykładowa duplikatowa recenzja klienta 5 dla produktu 1');
-- Tekst błędu dla powyższego zapytania:
-- ERROR:  duplicate key value violates unique constraint "unikalny_klient_opinia"
-- Key (produkt_id, klient_id)=(1, 5) already exists. 

-- SQL state: 23505
-- Detail: Key (produkt_id, klient_id)=(1, 5) already exists.    