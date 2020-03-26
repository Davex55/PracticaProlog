%Nuestros datos
%alumno_prode(Alvarez,Benavente,Alejandro,Y160319). %PORTAVOZ
%alumno_prode(Aparicio,Doncel,Alberto,Y160364).   
%alumno_prode(Tsai,Lin,Alvin,Y160267).
%-------------------------------------------

% practica1.pl

% Números de Peano

% nat/1(num_peano) true si N es un número de peano
nat(0).
nat(s(N)) :-
    nat(N).

%grt_eq/2(num_peano1,num_peano2) true si N>=M
grt_eq(_, 0).				% 0 es el número de peano más pequeño
grt_eq(s(N), s(M)):-				% a > b => (a + 1) > (b + 1)
	grt_eq(N, M).

%grt/2(num_peano1,num_peano2) true si N>M
grt(N, 0):-	N \= 0.				% 0 es el número de peano más pequeño
grt(s(N), s(M)):-				% a > b => (a + 1) > (b + 1)
	grt(N, M), N \= M.

%lst_eq/2(num_peano1,num_peano2) true si N<M
lst_eq(0, _).					    % 0 es el número de peano más pequeño
lst_eq(s(N), s(M)):-				% a < b => (a + 1) < (b + 1)
	lst_eq(N, M).

%lst/2(num_peano1,num_peano2) true si N<=M
lst(0, N):- N \= 0.  			% 0 es el número de peano más pequeño
lst(s(N), s(M)):-				% a < b => (a + 1) < (b + 1)
	lst(N, M), N \= M.

%sum/3(num_peano1,num_peano2,num_peano3)
%true si todos son números de peano
%suma A y B y lo pone en C
sum(0, A, A).
sum(s(A), B, s(C)) :-
    sum(A, B, C).

%my_member/2(elemento,lista)
%implementacion personal de la función built-in member de prolog
%true si X es miembro del segundo argumento, siendo esta una lista, si no es lista también falla
my_member(X, [X|_]).
my_member(X, [_|Ys]) :-
    my_member(X, Ys).

%my_append/3(lista1,lista2,lista3)
%implementacion personal de la funcion built-in append de prolog
%true si todos los argumentos son listas
%junta las dos primeras listas y almacena el resultado en L3 (L1|L2)->L3
my_append([], L, L).
my_append([H|T], L2, [H|L3]) :-
    my_append(T, L2, L3).

%memberlistas/2(lista1,lista2)
%true si todos los miembros del primer argumento lista son miembros de la lista segundo argumento
memberlistas([], _).
memberlistas([X|Xs], Y) :-
    my_member(X, Y),
    memberlistas(Xs, Y).

%basic_building/1 (lista)
%true si es un edificio basico con al menos un nivel y una vivienda por nivel
basic_building([]).       
basic_building([A|X]) :-
    checkLevel(A),
    basic_building(X).

%checkLevel/1 (lista)
%predicado auxiliar que comprueba que cada elemento de la lista (nivel) es un numero de peano
% true si es un nivel del edificio con al menos una vivienda
checkLevel([]).
checkLevel([A|X]) :-
    nat(A),
    checkLevel(X).

%building/1 (lista edificio)
%predicado que devuelve true si todos los pisos del edificio tienen el mismo numero de viviendas
building([]).
building([X,Y]):-
    comp_n_viv(X,Y).
building([X,Y|Z]):-
    building(Y|Z),
    comp_n_viv(X,Y).

%comp_n_viv/2 (lista nivel1, lista nivel2)
%predicado auxiliar que devuelve true si los dos niveles tienen el mismo numero de viviendas
comp_n_viv([],[]).
comp_n_viv([X|Ys],[Z|Ts]):-
    nat(X),
    nat(Z),
    comp_n_viv(Ys,Ts).


%level/3 (Lista1, nº de peano, Lista2)
%true si C es el nivel N-ésimo del edificio X (la lista con todas las viviendasde ese nivel)
level(X,N,C):-
    basic_building(X),
    getLevel(X,N,C).

%getLevel/3 (Lista1, nº de peano, Lista2)
%predicado auxiliar
% true si C es el nivel N-ésimo del edificio X (la lista con todas las viviendasde ese nivel)
getLevel([X|_],s(0),X).
getLevel([_|Ys],s(N),C) :-
    getLevel(Ys,N, C).

%column/3 (Edificio, num vivienda (peano), Lista Resultante)
%C es la lista formada por las viviendas N-ésimas de todos los niveles del edificio X.
column([],_,[]).
column([X|Y],N,C):-
    column(Y,N,T),
    append_vivienda(X,N,Z),
    my_append(Z,T,C).

%append_vivienda/3 (Nivel(lista), num vivienda(peano), vivienda resultante)
%devuelve true si se consigue extraer la vivienda n del nivel correspondiente
append_vivienda([X|_],s(0),[X]).
append_vivienda([_|X],s(N),C):-
    append_vivienda(X,N,C).

%columns/3 (Edificio(lista), Columnas(lista))
%devuelve true si C es la lista de columnas de X
columns([],_).
columns([X|Y],C):-
    cont_viv(X,0,N),
    rec_col([X|Y],s(0),C,N).

%cont_viv/3 (Nivel(lista), numero viv(numero peano), numero de viviendas(numero de peano))
%devuelve true si N es el numero de viviendas de Nivel
cont_viv([],S,S).
cont_viv([_|Y],S,N):-
    cont_viv(Y,s(S),N).

%rec_col/4(Edificio(lista), numero viv(numero de peano),
%lista columnas(lista), n viviendas por recorrer(numero peano))
%devuelve true si L es la lista con las columnas de X, siendo T numero de viviendas por nivel de X
rec_col(_,_,_,0).
rec_col(X,N,L,s(T)):-
    rec_col(X, s(N),Y,T),
    column(X,N,C),
    my_append([C|Y],[],L).
rec_col(X,N,L,s(0)):-
    rec_col(X, s(N),_,0),
    column(X,N,C),
    my_append(C,[],L).


%%%a
total_people([],0).
total_people([X|Ys],F) :-
    total_people2(X, Z),
    sum(Z,T,F),
    total_people(Ys,T).

total_people2([],0).
total_people2([X|Ys], F) :-
    sum(X, T, F),
    total_people2(Ys, T).   

total_building([],0).
total_building([X|Ys],F) :-
    total_building2(X, Z),
    sum(Z,T,F),
    total_building(Ys,T).


total_building2([],0).
total_building2([_|Ys], s(F)) :-
    total_building2(Ys, F).   
%%

average(X,T) :-
    total_people(X, Y),
    total_building(X, Z),
    div(Y, Z, T).

%div(_N, zero, _Q) :- !.			% division with 0 not defined
div(0, s(_D), 0).				% 0 / a = 0
div(A, B, s(C)) :- 				% If d = a - b and d / b = c then a / b = c + 1
	diff(A, B, D),				% => (a - b)/b = c => a/b - b/b = c 
    comp(D, B, E),
	div(E, B, C).				% => a/b - 1 = c => a/b = c + 1


diff(A, 0, A).				
diff(A, s(B), C) :- 				
	diff(A, B, s(C)).				


grt_less(_, 0 ,0).				% 0 es el número de peano más pequeño
grt_less(0, _, s(0)).
grt_less(s(N), s(M),Z):-				% a > b => (a + 1) > (b + 1)
	grt_less(N, M,Z).


comp(A,B,C) :-
    grt_less(A,B,D),
    comp2(A,D,C).

comp2(_,  s(0), 0).
comp2(A,  0, A).
    