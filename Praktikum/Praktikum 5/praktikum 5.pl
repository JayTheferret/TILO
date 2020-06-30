% Aufgabe: (PDA-Interpreter)
% Zur Überprüfung, ob Ihre PDAs wirklich das machen, was sie machen sollen, setzen wir die formalen
% Definitionen der von einem PDA erkannten Sprache in ein Prolog-Programm um.

    %a) PDA (sechs Relationen für Komponenten, nur Fakten keine Variablen)

%z0=Einlesen und Speichern/ z1=Vergleiche/Abgleichen 2. Haelfte mit PD Inhalt
zustand(z0).
zustand(z1).

    %Sigma -> Eingabealphabet
% sigma(X) :- X ist im Alphabet
sigma(0).
sigma(1).

%Gamma -> Kelleralphabet
gamma(#).
gamma(0).
gamma(1).

%start(X) :- X ist Startzustand
start(z0). %z0 Anfangszustand

    %ende nicht benötigt wegen keller

%# unterstes Symbol im Keller -> Keller leer (sozusagen Endzustand)
boden(#). %-> kellerdeterminiert

%delta Transitionsrelation 
%Erkennung gerader Palindrome

%M=(Z,Σ,Γ,Δ,Z*,Γ*(#))
%delta(Zustand, Eingabesymbol, oberstes Kellersymbol, neuer Zustand, [eingabe, oberstes Kellersymbol(/boden)])

%1. Hälfte : reinschreiben (oberstes Zeichen->links) -> lesen
    %(Eingabesymbol auf Keller)
delta(z0,0,#,z0,[0,#]).
delta(z0,1,0,z0,[1,0]).
delta(z0,0,0,z0,[0,0]).
delta(z0,1,#,z0,[1,#]).
delta(z0,1,1,z0,[1,1]).
delta(z0,0,1,z0,[0,1]).

%mitte erreicht -> wechsel in zweite hälfte
    %2.Hälfte ohne lesen 
delta(z0,nix,#,z1,[#]). %leeres Wort
delta(z0,nix,0,z1,[0]).
delta(z0,nix,1,z1,[1]).

%2.Hälfte : (Vergleich Eingabe und Keller) -> und abgleichen und löschen
    %Vergleich Eingabe und Keller
delta(z1,  0,0,z1,[]).
delta(z1,  1,1,z1,[]).
delta(z1,nix,#,z1,[]). %keller geleert -> Wort in Sprache drin (stopp)

    %b)

% es(Zustand, [Eingabe|Rest],[Oberstes|StackRest],ZusandNeu,Rest,StackNeu)
    % - es für die Einzelschrittrelation
es(Z, [X|Ws], [Top|Stack], Zn, Ws, Stack_n) :- delta(Z,   X, Top, Zn, StackAdd), append(StackAdd, Stack, Stack_n), X\== nix. %eine  Eingabe
es(Z,    Ws , [Top|Stack], Zn, Ws, Stack_n) :- delta(Z, nix, Top, Zn, StackAdd), append(StackAdd, Stack, Stack_n). %keine Eingabe

%es_plus
    % - es_plus für den transitiven Abschluss der Einzelschrittrelation ganzes Wort einlesen
es_plus(Z, Ws, Stack, Zn, Ws_n, Stack_n) :- es(Z, Ws, Stack, Zn, Ws_n, Stack_n).
es_plus(Z, Ws, Stack, Zn, Ws_n, Stack_n) :- es(Z, Ws, Stack, Z_1, Ws_1, Stack_1), es_plus(Z_1, Ws_1, Stack_1, Zn, Ws_n, Stack_n). %sich selbst aufrufen bis ende 

%sigma_stern(Ws)
    % sigma_stern(X) :- X Wörter die dem Alphabet der Grammatik entsprechen
sigma_stern([]).
sigma_stern([X|Ws]) :- sigma(X), sigma_stern(Ws).

%lvonM(Wort)
    % entspricht, die von dem in a) definierten PDA erkannt wird.
lvonM(Ws) :- sigma_stern(Ws), es_plus(Z0, Ws, [X], _, [],[]), start(Z0), boden(X).  %Sprache erkannt, wenn Wort komplett gelesen und PD Inhalt leer
    
%%%%%

%Testpalindrome: 110011, 0110, 101101, 001100, etc. -> nur gerade Palindrome
?- lvonM([1,0,0,1]).
?- lvonM([0,0]).
%Falsch: 11111, 0000, 011100, etc.
?- lvonM([0,0,0]).
?- lvonM([0,1,0]).

%lvonM([1,Z]). -> Z = 1