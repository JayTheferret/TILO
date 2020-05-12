%Neuer Teilbaum(Knoten) mit linkem und rechtem Teilbaum
%node(_,Lb,Rb) :- binbaum(Lb), binbaum(Rb).

%Bäume
binbaum(empty). %leer
binbaum(node(_,Lb,Rb)) :- binbaum(Lb), binbaum(Rb).

%construct(Root,Lb,Rb,Xneub) : Xneub ist der Baum mit Wurzel(Root),Lb,Rb
%construct(root,Lb,Rb,Xneub) : Root mit Lb und Rb ergeneben Xneub(= neuer Baum)
construct(Root,Lb,Rb,node(Root,Lb,Rb)) :- binbaum(Lb), binbaum(Rb).

%natSymb(o).
%natSymb(s(X)) :- natSymb(X).

%add(X,Y,X1) : addiert X zu Y und gibt Ergebnis in Z
%add(X,Y,X1) : X1 = X+Y
add(o,X,X).                         %addierst X auf nichts = X
add(s(X),Y,s(H)) :- add(X,Y,H).     % X+Y = H

%knotenanz(Xb,N) : N (nat. Zahl in symbolischer Darstellung) ist die Anzahl der Knoten des Baumes Xb.
knotenanz(empty,o).                        %Baum leer
knotenanz(node(_,Lb,Rb),s(N)) :- knotenanz(Lb,N1), knotenanz(Rb,N2), add(N1,N2,N).

%Beispieleingabe Baum mit 6 knoten und root
    %knotenanz(node(a,node(b,node(d,empty,empty),node(e,empty,empty)),node(c,empty,node(f,node(g,empty,empty),empty))),N).
%Beispiel Baum aus Aufgabenstellung
    %knotenanz(node(a,node(b,empty,empty),node(empty,empty,empty)),X).


%abfragen fangen mit Z an