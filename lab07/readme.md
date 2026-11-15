Wybrałem rozszerzenie bazy danych o opinie oraz ewentualne odpowiedzi pracowników na nie.<br>
W ramach tego dodałem 2 nowe tabele - <b>opinie</b> oraz <b>odpowiedzi_pracownikow</b>.
<h3>Opinie</h3>
Ta tabela posiada dwa klucze obce - <i>produkt_id</i> oraz <i>klient_id</i> 
(oba, są w kardynalności 1:N patrząc z perspektyw tabel <b>produkty</b> oraz <b>klienci</b>).<br>
Objąłem te atrybuty w parze ograniczeniem <b>UNIQUE</b>, aby wykluczyć sytuację jednego klienta wystawiającego wiele opinii dla jednego produktu.<br>
Natomiast jak najbardziej możliwe jest by jeden klient wystawił opinie wielu różnym produktom, jak i aby jeden produkt miał opinie wystawione przez wielu klientów (związek N:M).
<h3>Odpowiedzi_pracownikow</h3>
Owa tabela posiada również dwa klucze obce <i>pracownik_id</i> oraz <i>opinia_id</i>
(kolejno są w kardynalności 1:N oraz 1:1 patrząc z perspektyw tabel <b>pracownicy</b> oraz <b>opinie</b>).
Tym sposobem, każda opinia może mieć tylko jedną odpowiedź pracownika, ale jeden pracownik może odpowiadać na wiele różnych opinii.

<br><a href="https://dbdiagram.io/d/6af9ac2a4e0bad6598bc23a6">link do diagramu</a>