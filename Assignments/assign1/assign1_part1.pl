/*
   Kylee Bowers
   z5304138
   Assignment1 - Prolog and Search
   03/17/2021
*/


% 1.1
/*
 * sumsq_even(Numbers, Sum) sums the squares of even numbers in a list.
 * Example: 
 * ?- sumsq_even([1,3,5,2,-4,6,8,-7], Sum).
 * Sum = 120
*/

sumsq_even([], 0).
sumsq_even([H | T], S0) :-
    sumsq_even(T, S1),
    (  0 is H mod 2  % if H is an even number then sqaures H and add to the sum
    ->  S0 is S1 + (H * H)
    ;   S0 is S1).


% 1.2
% helper function for eliza to replce all ocurrences
elizas_helper([], []).
elizas_helper([X | Y], [X1 | Y1]) :-
    elizas_helper(Y, Y1),
    replace(X, X1).


replace(you, i).
replace(me, you).
replace(my, your).
replace(X, X).
eliza_pairs(eliza1, [what, makes, you, say]).
eliza_pairs(eliza2, [what, makes, you, think]).



/*
 * eliza1(A, B) takes in a list of words and replaces 
 * "you" with "i"
 * "me" with "you"
 * "my" with "your"
 * 
 * Example:
 * ?- eliza1([you,do,not,like,me], X).
 * X = [what,makes,you,say,i,do,not,like,you]
*/

eliza1(A, B) :-
    elizas_helper(A, B1),
    eliza_pairs(eliza1, E),
    append(E, B1, B).
    
  
% 1.3
/*
 * eliza2(A, B) takes in a list of words and return a new list that skips the words before "you" and after "me"
 * and add "what makes you think" in the front of the new list
 * 
 * Example:
 * ?- eliza2([i,wonder,if,you,would,help,me,learn,prolog], X).
 * X = [what,makes,you,think,i,would,help,you]
*/

eliza2(A, B) :-
    append(B1, [you | _], A), % B1 = words before you
    append(B1, B2, A), % B2 = [you, .....]
    append(B3, [me | _], B2), % B3 = [you, ....words before me]
    append(B3, [me], C), % B = [you,..., me]
	elizas_helper(C, B4),
    eliza_pairs(eliza2, E),
    append(E, B4, B).
    
    


% 1.4
/* 
 * eval(A, B) takes in an expression in prefix format and evaluate it
 * 
 * Examples:
 * ?- eval(add(1, mul(2, 3)), V).
 * V = 7
 * ?- eval(div(add(1, mul(2, 3)), 2), V).
 * V = 3.5
*/

% if A is a number
eval(A, V) :-
    number(A),
    V = A.

% if A = add(A, B)
eval(add(A, B), V) :-
    eval(A, V1),
    eval(B, V2),
    V is V1 + V2. % V = A + B

% if A = sub(A, B)
eval(sub(A, B), V) :-
    eval(A, V1),
    eval(B, V2),
    V is V1 - V2. % V = A - B

% if A = mul(A, B)
eval(mul(A, B), V) :-
    eval(A, V1),
    eval(B, V2),
    V is V1 * V2. % V = A * B

% if A = div(A, B)
eval(div(A, B), V) :-
    eval(A, V1),
    eval(B, V2),
    V is V1 / V2. % V = A / B