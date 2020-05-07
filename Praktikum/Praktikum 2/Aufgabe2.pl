%Neuer Teilbaum(Knoten) mit linkem und rechtem Teilbaum
%node(_,Lb,Rb) :- binbaum(Lb), binbaum(Rb).

%Bäume
binbaum(nil). %leer
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
knotenanz(nil,o).                        %Baum leer
knotenanz(node(_,Lb,Rb),s(N)) :- knotenanz(Lb,N1), knotenanz(Rb,N2), add(N1,N2,N).

%Beispieleingabe Baum mit 6 knoten und root
    %knotenanz(node(a,node(b,node(d,nil,nil),node(e,nil,nil)),node(c,nil,node(f,node(g,nil,nil),nil))),N).
%Beispiel Baum aus Aufgabenstellung
    %knotenanz(node(a,node(b,nil,nil),node(nil,nil,nil)),X).
