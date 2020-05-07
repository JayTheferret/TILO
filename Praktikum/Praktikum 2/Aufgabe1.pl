%app(Xs,Ys,Rs) : Liste Rs durch anhängen von Liste Ys, an die Liste Xs
app(nil,Ys,Ys).                                 %nix anhängen-> bleibt gleich
app(list(X,Xs),Ys,list(X,Rs)) :- app(Xs,Ys,Rs). % Ys an Liste anhängen an Liste Xs = Liste Rs(mehr)

%linListe(Xs): Xs ist eine gültige Liste.
linListe(nil).              %leere Liste
linListe(list(Y,Xs)) :- linListe(Xs). %anhang vorhanden, xs gilt als Liste(Leer oder Anhang)

%->gültiger beitrag: list(a,list(b,nil)).

%member(X,Ys) : Ys enthält das Element X.
member(X,list(X,Xs)).                       %erstes element der Liste
member(X,list(Y,Xs)) :- member(X,Xs).       %hinten suchen      

%infix(Xs,Ys) : Ys enthält die Liste Xs.
infix(Xs,Ys) :- Xs == Ys.                   %wenns gleich ist

%Xs is infix von Ys (also vorhanden) wennliste existiert wo xs angehangen wird = Ys (mit beliebig anhang)

infix(Xs,Ys) :- app(Xs,_,Ys).               %Xs am Ende
infix(Xs,Ys) :- app(_,Xs,Ys).               %Xs am Anfang
infix(Xs,list(Y,Ys)) :- infix(Xs,Ys).       %Xs in der Mitte -> member für Listen

%attach(Xs,X,Ys) : Ys ist Xs verlängert um das Element X.
attach(Xs,nil,Xs).                          %nichts anfügen
attach(nil,Xs,Xs).                          % an nichts anfügen

attach(Xs,X,Ys) :- app(Xs,list(X,nil),Ys), linListe(Ys), linListe(Xs).


%rev(Xs,Ys) : Ys ist das gespiegelte Xs. 
rev(nil,nil).                                                                   %nix da zum spiegeln
rev((list(X,nil),list(X,nil)).                                                  %nur ein Element -> bleibt gleich
rev(list(X,Xs),Ys) :- rev(Xs,R), attach(R,X,Ys), linListe(Ys), linListe(Xs).    %rest anhängen, aufbauen (bsp 1,2,3 -> 1rest(2,3) ->->2rest 3, -> 32,1)



%Bäume
binbaum(nil). %leer
binbaum(node(_,Lb,Rb)) :- binbaum(Lb), binbaum(Rb).

%construct(Root,Lb,Rb,Xneub) : Xneub ist der Baum mit Wurzel(Root),Lb,Rb
%construct(root,Lb,Rb,Xneub) : Root mit Lb und Rb ergeneben Xneub(= neuer Baum)
construct(Root,Lb,Rb,node(Root,Lb,Rb)) :- binbaum(Lb), binbaum(Rb).


natSymb(o).
natSymb(s(X)) :- natSymb(X).

%add(X,Y,X1) : addiert X zu Y und gibt Ergebnis in Z
%add(X,Y,X1) : X1 = X+Y
add(o,X,X).                         %addierst X auf nichts = X
add(s(X),Y,s(H)) :- add(X,Y,H).     % X+Y = H

%knotenanz(Xb,N) : N (nat. Zahl in symbolischer Darstellung) ist die Anzahl der Knoten des Baumes Xb.
knotenanz(node(nil,nil,nil),o).                           %Baum leer
knotenanz(node(_,Lb,Rb),s(N)) :- knotenanz(Lb,N1), knotenanz(Rb,N2), add(N1,N2,N).