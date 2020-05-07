

add(o,Y,Y).
add(s(X),Y,s(E)):- add(X,Y,E).


%binbaum wie in der Uebung
binbaum(nil).
binbaum(baum(X,Lb,Rb)) :- binbaum(Lb), binbaum(Rb).

%construct: construct(Root,Lb,Rb,Xneub)
construct(X,Lb,Rb,baum(X,Lb,Rb)).

%knotenanz(Xb,N): N ist die Konotenanzahl der Liste Xb
%Basisfall: Null Knoten Anzahl null. 
%Rekursion durch linken Teilbum bis zum Ende von dort jeweils der Rechte Baum
knotenanz(nil,o).
knotenanz(baum(X,Lb,Rb),s(N)) :- knotenanz(Lb,H1),knotenanz(Rb,H2),add(H1,H2,N).