%binbaum(Xb): Xb ist Binbaum
binbaum(empty). %leer
binbaum(node(_,Lb,Rb)) :- binbaum(Lb),binbaum(Rb).

%membertree(X,Xb)  : Baum Xb enthält den Eintrag X. 
membertree(X,node(X,Lb,Rb)) :- binbaum(Lb),binbaum(Rb). %Eintrag X in Root
membertree(X,node(_,Lb,Rb)) :- membertree(X,Lb) , binbaum(Rb). %linken Baum durchsuchen
membertree(X,node(_,Lb,Rb)) :- membertree(X,Rb) , binbaum(Lb). %rechten Baum durchsuchen

% membertree(1,node(1,empty,empty)).  -> root
% membertree(1,node(2,node(1,empty,empty),empty)). -> im linken TB