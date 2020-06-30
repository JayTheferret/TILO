%6-Tupel --> Z = endliche Zustandmenge; Sigma = Eingansalphabet; Gamma = Kelleralphabet; Delta = Programm/Transitionsrelation ; z0 = Anfangszustand; # = unterste Symbol auf dem Keller 
%endlicher Automat mit Kellerspeicher (Stack)

%z0=Schreibe 1.Haelfte auf PD/ z1=Vergleiche 2. Haelfte mit PD Inhalt
zustand(z0).
zustand(z1).

%Sigma=Eingabealphabet/mögliche Eingaben
sigma(0).
sigma(1).

%Gamma=Kelleralphabet
gamma(#).
gamma(0).
gamma(1).

%S=Startzustand
start(z0).


%kein Endzustand, sondern leerer Keller
boden(#).

%Delta=Transitionsrelation(Zustandmenge,oberstes Kellersymbol/nix,Gamma/Kellerbodensymbol | NeuerZustand, [Kellerinhalt]/[oberstes,Boden])
%Erkennung gerader Palindrome
%#=Sharp --> am anfang, damit keller nicht sofort leer
%1. Hälfte (Eingabesymbol auf Keller)
delta(z0,0,#,z0,[0,#]).
delta(z0,0,0,z0,[0,0]).
delta(z0,0,1,z0,[0,1]).
delta(z0,1,#,z0,[1,#]).
delta(z0,1,0,z0,[1,0]).
delta(z0,1,1,z0,[1,1]).
%Übergang 1. Haelfte --> 2. Haelfte ohne Lesen
delta(z0,nix,#,z1,[#]).
delta(z0,nix,0,z1,[0]).
delta(z0,nix,1,z1,[1]).
%2. Hälfte (Vergleich Eingabe und Keller)
delta(z1,0,0,z1,[]).
delta(z1,1,1,z1,[]).
delta(z1,nix,#,z1,[]).

%sigma_stern=Menge aller möglichen Wörter, die aus dem Alphabet gebildet werden können
sigma_stern([]).
sigma_stern([W|Ws]) :- sigma(W), sigma_stern(Ws).

%es=Einzelschrittrelation/ein oder kein Buchstabe
es(Z, [W|Ws], [Top|Stack], Zneu, Ws, StackNeu) :- delta(Z, W, Top, Zneu, StackAdd), append(StackAdd, Stack, StackNeu).
es(Z, Ws, [Top|Stack], Zneu, Ws, StackNeu) :- delta(Z, nix, Top, Zneu, StackAdd), append(StackAdd, Stack, StackNeu).

%es_plus=transitiver Abschluss der Einzelschrittrelation/ganzes Wort einlesen
es_plus(Z, Ws, Stack, Z_n, Ws_n, Stack_n) :- es(Z, Ws, Stack, Z_n, Ws_n, Stack_n).
es_plus(Z, Ws, Stack, Z_n, Ws_n, Stack_n) :- es(Z, Ws, Stack, Z_1, Ws_1, Stack_1),  es_plus(Z_1, Ws_1, Stack_1, Z_n, Ws_n, Stack_n).

%LvonM=Sprache, Ws ist in L(M)
lvonM(Ws) :- sigma_stern(Ws), es_plus(z0, Ws, [#], _, [], []). %Sprache erkannt, wenn Wort komplett gelesen und PD Inhalt leer

