/*
	Kylee Bowers
	z5304138
	Assignment2 - Inductive Logic Programming
	04/23/2021
*/

:- op(300, xfx, <-).

% 2.1
/* 
	intra_construction() takes in two clauses with the same head, keeping the intersection 
	and adding a new predicate that distributes the difference to two new clauses
*/

intra_construction(C1 <- B1, C1 <- B2, C1 <- B, Z <- Z1, Z <- Z2):-
    C1 == C1, % make sure two clauses gave the same head
    intersection(B1, B2, Z11), 
    gensym(z, Z), 
    subtract(B1, Z11, Z1),
    subtract(B2, Z11, Z2),
    append(Z11, [Z], B).


% 2.2
/* 
	absorption() takes in two clauses with different heads and checks to see if the body 
    of one clause is a subset of the other. If it is, the common elements can be removed 
    from the larger clause and replaced by the head of the smaller one.
*/

absorption(C1 <- B1, C2 <- B2, C1 <- B1Z, C2 <- B2Z) :-
    C1 \= C2,
    %subtract(B2, B1, B),
    (   subset(B2, B1)
    ->  subtract(B1, B2, Z),
    	append([C2], Z, B1Z),
        B2Z = B2
    ;   false).


% 2.3
/* 
	identification() takes in two clauses with with the same head and  take the intersection out of each clause 
    and if there is exactly one symbol left in one of the clauses, we identify it with the set of symbols from 
    the other clause.
*/

identification(C1 <- B1, C2 <- B2, Z1 <- B1Z, Z2 <- B2Z) :-
    C1 == C2,
    subtract(B2, B1, B),
    subtract(B1, B2, D),
    intersection(B1, B2, Z),
    (   length(B, 1)
    ->  B = [X1 | _],
        Z1 = C1,
        Z2 = X1, 
        B1Z = B2,
        subtract(B1, Z, B2Z)
    ;   length(D, 1)
    ->  D = [X2 | _],
        Z1 = X2,
        B2Z = B1,
        Z2 = C1,
        subtract(B2, Z, B1Z)
    ;   false).
   

% 2.4
/* 
	dichotomisation() performs similar to a decision tree
*/

dichotomisation(C1 <- B1, C2 <- B2, C1 <- B11, C2 <- B22, Z <- Z1, not(Z) <- Z2) :-
    C1 \= C2,
    gensym(z, Z), 
    intersection(B1, B2, C),
    append(C, [Z], B11),
    append(C, [not(Z)], B22),
    subtract(B1, C, Z1),
    subtract(B2, C, Z2).



% 2.5
/* 
	truncation() takes clauses with the same head and drop the differences
*/

truncation(C1 <- B1, C1 <- B2, C1 <- B3) :-
    C1 == C1,
    intersection(B1, B2, B3).
    
