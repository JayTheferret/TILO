%binbaum(Xb): Xb ist Binbaum
binbaum(empty). %leer
binbaum(node(_,Lb,Rb)) :- binbaum(Lb),binbaum(Rb).

%preorder(Xb,Ys)  :  Ys ist die Liste der Knotenbeschriftungen des Binärbaumes Xb in Präorder.
    %(R,LB,RB)
preorder(empty,[]). %leerer Baum -> leere Liste
preorder(node(X,Lb,Rb),[X|Ys]) :-   preorder(Lb,L1s), preorder(Rb,L2s), append(L1s,L2s,Ys), %[X|Ys] -> zuerst Wurzel dann rest anhängen
                                    binbaum(Lb),binbaum(Rb).

%preorder(node(a, node(b, node(c, empty, empty), empty), node(d, empty, empty)), [a, b, c, d])

%postorder(Xb,Ys)  :  Ys ist die Liste der Knotenbeschriftungen des Binärbaumes Xb in Postorder. 
 %(Lb,Rb,R)
postorder(empty,[]). %leerer Baum -> leere Liste
postorder(node(X,Lb,Rb),Ys) :-      postorder(Lb,L1s), postorder(Rb,L2s) ,append(L1s,L2s,Y1s), append(Y1s,[X],Ys), %[X] -> als Liste anhängen
                                    binbaum(Lb),binbaum(Rb).

%postorder(node(a, node(b, node(c, empty, empty), empty), node(d, empty, empty)), [c,b,d,a]).

%roots(Xbs,Ys)  :   Xbs ist eine Liste von Binärbäumen (geschachtelte Induktion). 
roots([],[]).
roots([empty|Xbs],Ys) :- roots(Xbs,Ys).
roots([node(X,Lb,Rb)|Xbs],[X|Ys]) :- roots(Xbs,Ys), binbaum(Lb),binbaum(Rb).

%Beispiele:
    %Fall1
        %roots([node(a, empty, empty), node(b, node(c, empty, empty), empty), node(d, empty, empty)], [a, b, d]).
    %Fall2: erster Baum leer
        %roots([empty, node(a, node(c, empty, empty), empty), node(d, empty, empty)], [a,d]).


%Test cases   (false auskommentiert)

     %Fall2: erster Baum leer
%?- roots([empty, node(a, node(c, empty, empty), empty), node(d, empty, empty)], [a,b]). 
?- roots([empty, node(a, node(c, empty, empty), empty), node(d, empty, empty)], [a,d]).