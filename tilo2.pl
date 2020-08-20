sublist(Xs,Ys) :- app(H1s,H2s,Ys), app(H3s,Xs,H1s)
sublist(Xs,Ys) :- equ(Xs,Ys). 

