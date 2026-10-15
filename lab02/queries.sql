CREATE TABLE klienci (
    id              SERIAL PRIMARY KEY,
    imie            VARCHAR(50),
    nazwisko        VARCHAR(50) NOT NULL,
    numer_telefonu  VARCHAR(30) NOT NULL
);

CREATE TABLE rezerwacje (
    id          SERIAL PRIMARY KEY,
    stolik      INTEGER NOT NULL,
    data        DATE NOT NULL,
    godzina     TIME NOT NULL,
    id_klienta  INTEGER REFERENCES klienci(id) NOT NULL,
    ile_osob    INTEGER NOT NULL,
    uczulenia   VARCHAR(50)
);

INSERT INTO klienci (imie, nazwisko, numer_telefonu) VALUES
    ('Geralt', 'z Rivii', '892 172 182'),           -- 1
    ('Julian', 'Pankratz', '111 222 333'),          -- 2
    ('Stefan', 'Skellen', '333 222 111'),           -- 3
    ('Borch', 'Trzy Kawki', '222 111 333'),         -- 4
    (NULL, 'Vilgefortz', '111 333 222'),            -- 5 
    ('Vernon', 'Roche', '666 666 666'),             -- 6
    ('Emiel', 'Regis', '777 777 777'),              -- 7
    ('Yennefer', 'z Vengerbergu', '888 888 888'),   -- 8
    ('Triss', 'Merigold', '999 999 999'),           -- 9
    ('Fringilla', 'Vigo', '101 101 101');           -- 10

INSERT INTO rezerwacje (stolik, data, godzina, id_klienta, ile_osob, uczulenia) VALUES
    (5, '2026-10-18', '18:30:00', 1, 3, 'Portale'), -- 1
    (3, '2026-10-23', '16:00:00', 10, 2, NULL),     -- 2
    (5, '2026-10-18', '16:30:00', 2, 2, NULL),      -- 3
    (4, '2026-10-19', '15:00:00', 9, 5, 'Eliksiry'),-- 4
    (2, '2026-10-25', '20:45:00', 3, 2, NULL),      -- 5
    (4, '2026-10-18', '18:30:00', 8, 1, NULL),      -- 6
    (1, '2026-10-22', '17:30:00', 4, 3, NULL),      -- 7
    (2, '2027-01-05', '13:20:00', 7, 1, 'Krew'),    -- 8
    (1, '2026-10-25', '20:45:00', 5, 1, NULL),      -- 9
    (3, '2026-10-27', '19:00:00', 6, 4, 'Elfy');    -- 10

