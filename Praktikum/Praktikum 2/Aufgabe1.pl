%app(Xs,Ys,Rs) : Liste Rs durch anhängen von Liste Ys, an die Liste Xs
app(nil,Ys,Ys).                                 %Liste leer-> bleibt gleich
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

infix(Xs,Ys) :- app(Xs,_,Ys).               %Xs am Anfang
infix(Xs,Ys) :- app(_,Xs,Ys).               %Xs am Ende
infix(Xs,list(Y,Ys)) :- infix(Xs,Ys).       %Xs in der Mitte -> member für Listen

%doppelte ausgabe vermeiden mit Hilfsliste möglich (append)

%attach(Xs,X,Ys) : Ys ist Xs verlängert um das Element X.
%attach(Xs,nil,Xs).                          %nichts anfügen        
%attach(nil,Xs,Xs).                          % an nichts anfügen

attach(Xs,X,Ys) :- app(Xs,list(X,nil),Ys), linListe(Ys), linListe(Xs).


%rev(Xs,Ys) : Ys ist das gespiegelte Xs. 
rev(nil,nil).                                                                   %nix da zum spiegeln
%rev((list(X,nil),list(X,nil)).                                                 %nur ein Element -> bleibt gleich       --> "unötig"
rev(list(X,Xs),Ys) :- rev(Xs,Rs), attach(Rs,X,Ys), linListe(Ys), linListe(Xs).    %rest anhängen, aufbauen (bsp 1,2,3 -> 1rest(2,3) ->->2rest 3, -> 32,1)

%Xs (Listenkonvention)