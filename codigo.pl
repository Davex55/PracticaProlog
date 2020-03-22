%Nuestros datos
alumno_prode(Alvarez,Benavente,Alejandro,Y160319). %PORTAVOZ
alumno_prode(Aparicio,Doncel,Alberto,Y160364).   
alumno_prode(Tsai,Lin,Alvin,Y160267).
%-------------------------------------------

% practica1.pl

% Números de Peano

% nat/1(num_peano) true si N es un número de peano
nat(0).
nat(s(N)) :-
    nat(s(N)).

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