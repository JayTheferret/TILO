/*
Mögliche Anfragen:

x   ?- vater(ZVater,ZKind).
x   ?- mutter(ZMutter,ZKind).
x   ?- sohn(ZSohn,ZElter).
x   ?- tochter(ZTochter,ZElter).
x   ?- bruder(ZBruder,ZGeschwister).
x   ?- schwester(ZSchwester,ZGeschwister).
x   ?- onkel(ZOnkel, ZNichteNeffe).
x   ?- cousine(ZCousine, ZCousin).
x   ?- großvater(ZGroßvater, ZEnkel).

Maximal drei Relationen durch Fakten*/

% elternteil(X, Y): X ist Elternteil (Vater oder Mutter) von Y
   
elternteil(gertrud,stephan).
elternteil(gertrud,thomas).
elternteil(gertrud,wolfgang).
elternteil(gertrud,uli).
elternteil(gertrud,uta).
elternteil(heinz,stephan).
elternteil(heinz,thomas).
elternteil(heinz,wolfgang).
elternteil(heinz,uli).
elternteil(heinz,uta).

elternteil(thomas,pascal).
elternteil(thomas,ela).
elternteil(bigi,pascal).
elternteil(bigi,ela).
elternteil(stephan,jason).
elternteil(stephan,tamara).
elternteil(uli,georgia).
elternteil(dana,georgia).

elternteil(hildegard,gabriele).
   
elternteil(gabriele,bettina).
elternteil(herrmann,bettina).

elternteil(bettina,jason).
elternteil(bettina,tamara).


% weiblich(x): x ist weiblich

weiblich(gertrud).
weiblich(gabriele).
weiblich(uta).
weiblich(bigi).
weiblich(bettina).
weiblich(georgia).
weiblich(tamara).
weiblich(ela).

% maennlich(x): x ist männlich

maennlich(heinz).
maennlich(herrmann).
maennlich(stephan).
maennlich(thomas).
maennlich(wolfgang).
maennlich(uli).
maennlich(pascal).
maennlich(jason).


% ZVater ist Vater von ZKind
vater(ZVater,ZKind) :- elternteil(ZVater, ZKind) , maennlich(ZVater).

% ZMutter ist Mutter von ZKind
mutter(ZMutter,ZKind) :- elternteil(ZMutter, ZKind) , weiblich(ZMutter).


% ZSohn ist Sohn von ZEltern
sohn(ZSohn,ZEltern) :- maennlich(ZSohn), elternteil(ZEltern, ZSohn).

% ZTochter ist Tochter von ZEltern
tochter(ZTochter,ZEltern) :- weiblich(ZTochter), elternteil(ZEltern, ZTochter).


% ZBruder ist Bruder von ZGeschwister
bruder(ZBruder,ZGeschwister) :- 
    maennlich(ZBruder),                                      %ZBruder ist männlich
    mutter(ZMutter, ZBruder) ,mutter(ZMutter, ZGeschwister), %Mutter von ZBruder und ZGeschwister ist gleich
    vater(ZVater,ZBruder), vater(ZVater,ZGeschwister),       %Vater von ZBruder und ZGeschwister ist gleich
    ZBruder\==ZGeschwister.                                   % ZBruder ist nicht sein eigenes Geschwisterkind


% ZSchwester ist Schwester von ZGeschwister
schwester(ZSchwester,ZGeschwister) :- 
    weiblich(ZSchwester),                                       %ZSchwester ist männlich
    mutter(ZMutter, ZSchwester) ,mutter(ZMutter, ZGeschwister), %Mutter von ZSchwester und ZGeschwister ist gleich
    vater(ZVater,ZSchwester), vater(ZVater,ZGeschwister),       %Vater von ZSchwester und ZGeschwister ist gleich
    ZSchwester\==ZGeschwister.                                   % ZSchwester ist nicht sein eigenes Geschwisterkind


% ZOnkel ist Onkel von ZNichteNeffe (Elternteil von ZNichteneffe = Bruder von ZEltern)
onkel(ZOnkel, ZNichteNeffe) :- bruder(ZOnkel, ZEltern), elternteil(ZEltern, ZNichteNeffe).

% ZCousine ist Cousine von ZCousin
cousine(ZCousine, ZCousin) :- 
    weiblich(ZCousine),                                         %ZCousine ist weiblich
    maennlich(ZCousin),                                         %ZCousin ist männlich
    elternteil(ZOnkel, ZCousin), onkel(ZOnkel, ZCousine).       %Onkel von Cousine ist Elternteil von Cousin


% ZGrossvater ist Großvater von ZEnkel
grossvater(ZGrossvater, ZEnkel) :- vater(ZGrossvater,ZEltern), elternteil(ZEltern,ZEnkel). %Vater von Elternteil von ZEnkel
