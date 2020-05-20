%prefix(Xs,Ys) : Ys beginnt mit der Liste Xs.  (ÜA 20b)
    % Xs[d,e,f] Ys [d,e,f,a,b,c]
prefix(Xs,Ys) :- append(Xs,_,Ys).

%postfix(Xs,Ys)  : Ys endet mit der Liste Xs. 
    % Xs[d,e,f] Ys [a,b,c,d,e,f] -> postfix 

postfix(Xs,Ys) :- reverse(Ys,R1s), reverse(Xs,R2s), prefix(R2s,R1s).
    %Ys[a,b,c,d,e,f] -> R1s[f,e,d,c,b,a]
    %Xs[d,e,f] -> R2s[f,e,d}-> praefix?

%postfix(Xs,Ys) :- append(_,Xs,Ys). %mit append

?- postfix([d,e,f],[a,b,c,d,e,f]).