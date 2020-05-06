%knoten mit linkem und rechtem Teilbaum
node(data,lb,rb).

%Bäume
binbaum(nil). %leer
binbaum(node(_,Lb,Rb)) :- binbaum(Lb), binbaum(Rb).

root(node(X,Lb,Rb),X)   :- binbaum(Lb), binbaum(Rb).

construct(root,Lb,Rb, node(X,Lb,Rb)) :- construct(X,Lb,Rb)




-------------------------------------------------------------
left(node(_,Lb,Rb),Lb)  :- binbaum(Lb), binbaum(Rb).
right(node(_,Lb,Rb),Rb) :- binbaum(Rb).

construct(root,Lb,Rb,Xneub).
/*- construct(Root,Lb,Rb,Xneub) 
    : Xneub ist der Baum mit
     - Wurzelbeschriftung Root,
    - linkem Teilbaum Lb und
    - rechtem Teilbaum Rb.
- knotenanz(Xb,N) : N (nat. Zahl in symbolischer Darstellung) ist die
    Anzahl der Knoten des Baumes Xb.*/


%contruct erstellt neuen Baum
construct(Root,Left,Right,node(Root,Left,Right)) :- tree(Left),tree(Right).


%symbolische addition aus �bung
add(o,X,X).
add(s(X),Y,s(R)) :- add(X,Y,R).

%knotenanz von left and right nehmen und addieren (mittels symbolischer darstellung)
knotenanz(empty,o).
knotenanz(node(_,Left,Right),s(N)) :- knotenanz(Left,NL), knotenanz(Right,NR), add(NL,NR,N).