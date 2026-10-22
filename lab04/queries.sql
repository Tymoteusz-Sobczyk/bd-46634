-- 1.
SELECT z.id, z.data_zamowienia, z.status, k.imie, k.nazwisko 
FROM zamowienia z
INNER JOIN klienci k ON z.klient_id = k.id;

-- 2.
SELECT k.nazwa, AVG(p.cena) FROM produkty p
INNER JOIN kategorie k ON k.id=p.kategoria_id
GROUP BY k.nazwa;

-- 3. 
SELECT k.imie, k.nazwisko, SUM(pz.ilosc * pz.cena_jednostkowa) AS laczne_wydatki FROM pozycje_zamowien pz 
LEFT JOIN zamowienia z ON pz.zamowienie_id=z.id
LEFT JOIN klienci k ON k.id = z.klient_id
GROUP BY k.id
ORDER BY laczne_wydatki desc LIMIT 5;

-- 4.
SELECT k.nazwa, COUNT(p.id) FROM kategorie k
INNER JOIN produkty p ON k.id=p.kategoria_id
GROUP BY k.id
HAVING COUNT(p.id) > 5;

-- 5.
SELECT p.nazwa, p.cena FROM produkty p
LEFT JOIN pozycje_zamowien pz ON p.id=pz.produkt_id
WHERE pz.produkt_id IS NULL

-- 6.
SELECT status, COUNT(id) FROM zamowienia
GROUP BY status;  

-- 7.
SELECT p.imie, p.nazwisko, COUNT(z.pracownik_id) AS obsluzone_zamowienia FROM pracownicy p
LEFT JOIN zamowienia z ON z.pracownik_id=p.id 
GROUP BY p.id, p.imie, p.nazwisko
ORDER BY obsluzone_zamowienia DESC 
LIMIT 1;

-- 8.
SELECT k.imie, k.nazwisko, COUNT(z.klient_id) AS ilosc_zamowien FROM klienci k
LEFT JOIN zamowienia z ON k.id=z.klient_id
GROUP BY k.id, k.imie, k.nazwisko
ORDER BY ilosc_zamowien DESC;

-- 9.
SELECT k.nazwa, SUM(pz.ilosc * pz.cena_jednostkowa) AS laczna_wartosc_sprzedazy FROM kategorie k
LEFT JOIN produkty p ON k.id=p.kategoria_id
LEFT JOIN pozycje_zamowien pz ON pz.produkt_id=p.id
GROUP BY k.id, k.nazwa
ORDER BY laczna_wartosc_sprzedazy DESC 
LIMIT 5;

-- 10.
SELECT p.nazwa, p.cena FROM produkty p
WHERE p.cena > (SELECT AVG(p2.cena) FROM produkty p2 WHERE p2.kategoria_id=p.kategoria_id);

-- 11.
SELECT k.imie, k.nazwisko FROM klienci k 
LEFT JOIN zamowienia z ON z.klient_id=k.id 
WHERE z.klient_id IS NULL;

-- 12.
SELECT k.id, k.nazwa, SUM(pz.ilosc) AS laczna_liczba_sprzedanych_sztuk FROM kategorie k
LEFT JOIN produkty p ON k.id=p.kategoria_id
LEFT JOIN pozycje_zamowien pz ON p.id=pz.produkt_id
GROUP BY k.id, k.nazwa 

-- 13.
SELECT p.imie, p.nazwisko, COUNT(z.id) AS ilosc_obsluzonych_zamowien 
FROM pracownicy p
LEFT JOIN zamowienia z ON z.pracownik_id=p.id  
GROUP BY p.id, p.imie, p.nazwisko
HAVING COUNT(z.id) < (
    SELECT AVG(licznosc)
    FROM(
        SELECT COUNT(z2.id) AS licznosc 
        FROM pracownicy p2
        LEFT JOIN zamowienia z2 ON z2.pracownik_id=p2.id 
        GROUP BY p2.id
    ) 
); 


-- 14.
SELECT p.id, p.nazwa, COUNT(pz.produkt_id) AS liczba_wystapien FROM produkty p
LEFT JOIN pozycje_zamowien pz ON pz.produkt_id=p.id 
GROUP BY p.id, p.nazwa
ORDER BY liczba_wystapien DESC
LIMIT 3;