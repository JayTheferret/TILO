% a)

gueltigesWort(Xs) :- start(Q), gueltigesWort(Xs,Q).                 %muss gueltig anfangen
gueltigesWort([X|Xs],Q) :- regeln(Q,X,Qn), gueltigesWort(Xs,Qn).    %muss gueltig sein für naechsten zustand
gueltigesWort([],Q) :- ende(Q).                                     %leeres Wort

% alphabet
sigma(h).
sigma(a).
sigma(!).

% startvariable
start(q0).

% endvariable
ende(q3).

% regeln (zustände und übergang)
regeln(q0,h,q0).
regeln(q0,h,q1).
regeln(q1,a,q2).
regeln(q2,h,q1).
regeln(q2,!,q3).

%ungueltig
?- gueltigesWort([a,h,a,h,a,h,a,!]).
%gueltig.
?- gueltigesWort([h,h,h,a,h,a,h,a,h,a,!]).
?- gueltigesWort([h,a,h,a,h,a,!]).

% b) 
%Implementieren Sie eine Relation lvonN(Ws), die allgemein der Sprache entspricht,
% von dem in a) definierten NEA erkannt wird. 
 %Implementierung der Relationen  
 %- delta_stern(Zalt,Ws,Zneu) für die Erweiterung der Transitionsrelation   delta(Zalt,A,Zneu) und  
 %- sigma_stern(Ws) der Menge der Wörter über Sigma benötigt. (formalen Definitionen wurden in Übungsaufgabe 88 formuliert.) 

 %Setzen Sie die Formalismen der Vorlesung bzw. Übung wieder 1 zu 1 in Prolog um! 

%sigma_stern(Ws). :- Endzustand
sigma_stern([]).
sigma_stern([X,Ws]).

%redrel_plus :- in endlichen schritten erreichbar



%redrel(Alpha, Beta) :-  append(A1, L, Zwi1), append(Zwi1, A2, Alpha), append(A1, R, Zwi2), append(Zwi2, A2, Beta), regel(L, R).
%redrel_plus(Alpha, Beta):- redrel(Alpha, Beta).
%redrel_plus(Alpha, Beta):- redrel(Alpha, Zwisches), redrel_plus(Zwisches, Beta).

lvonN(Ws).
lvonW(Ws) :- sigma_stern(Ws) , start(S), redrel_plus(S,Ws).
% lvonG(Ws) :- sigma_stern(Ws), start(S), redrel_plus([S],Ws).

%lvong(Ws):- start(vS), redrel_plus([vS], Ws), sigma_stern(Ws).


% delta(Xalt,A,Xneu).
delta_stern(Xalt,Ws,Xneu).