Przejście do 3 postaci nomalnej eliminuje anomalie opisane w 
<a href="https://github.com/kamilpiech97/cwup-resources/blob/main/INF/2026-2027/s3/bd/lab05.md#anomalie">lab05.md</a>.
 Uzasadnienie poszczególnych anomalii:
 <ul>
 <li><span>Aktualizacji</span><br>
 W razie zmiany adresu e-mail przez danego klienta, w tabeli <b>sprzedaze_flat</b> trzeba zmienić jego adres e-mail w wielu wierszach. <br>Jeden klient występuje wiele razy - nie można tak po prostu w części zostawić starego maila.
 <li><span>Wstawiania</span><br>
 Nie ma możliwości dodania danych nowego klienta, bez dodania jego zamówienia. Tak samo dla nowego produktu.
 <li><span>Usuwania</span><br>
 Usuwając konkretne zamówienie z tabeli <b>sprzedaze_flat</b>, możemy przypadkiem pozbyć się danych klienta, lub jakiegoś produktu.
 <br>Dzieje się tak kiedy dane zamówienie jest jedynym zamówieniem daneog klienta, lub ostatnim zamówieniem danego produktu
 </ul>
<br>
Dzieląc tabelę <b>sprzedaz_flat</b> na tabele: <b>klienci</b>, <b>produkty</b>, <b>sprzedaz_fakt</b>, osiągamy 3NF, i pozbywamy się wyżej wymienionych anomalii<br><br>

<aside>Tabelę kategorie dodałem z zamysłem nie wpisywania wiele razy nazwy kategorii, tylko krótkiego id_kategoria</aside>
