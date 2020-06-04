    % a)
    
% sigma(X) :- X ist im Alphabet
sigma(h).
sigma(a).
sigma(!).

% start(X) :- X ist Startzustand
start(q0).

% ende(X) :- X ist Endzustand
ende(q3).

% zustand(X) :- X ist in Zustandsmenge Z (-> endlich)
zustand(q0).
zustand(q1).
zustand(q2).
zustand(q3).

    %(delta() :- wort entspricht regeln)
% delta(Zustand, Eingabe, ZustandNeu):- zustände und übergang
delta(q0,h,q0).
delta(q0,h,q1).
delta(q1,a,q2).
delta(q2,h,q1).
delta(q2,!,q3).

    % b)

% lvonN(Ws) :- Ws ist gueltiges Wort in Sprache
lvonN(Ws) :- start(Q), sigma_stern(Ws), ende(Qn), delta_stern(Q,Ws,Qn). % überpruft anfang, ende und zwischenschritte

% sigma_stern(X) :- X Wörter die dem Alphabet der Grammatik entsprechen
sigma_stern([]).
sigma_stern([X|Ws]) :- sigma(X), sigma_stern(Ws).

% delta_regeln(Zustand,[Eingabe|Rest],NeuerZustand) :- Übergangsfunktion (Zustand Q + Eingabe X = Zustand neu (Qn))
delta_stern(Q,[X|Xs],Qn) :- delta(Q, X, Qtmp), delta_stern(Qtmp, Xs, Qn).   % neuer Zustand bis Endzustand erreicht
delta_stern(Q,[],Q).                                                        % kein neuer Zustand


    %Abfragen
%ungueltig
?- lvonN([a,h,a,h,a,h,a,!]).
%gueltig.
?- lvonN([h,h,h,a,h,a,h,a,h,a,!]).
?- lvonN([h,a,h,a,h,a,!]).

%online CMD: https://askuri.github.io/PrologBFS/wasm/
    %(! durch u ersetzen)