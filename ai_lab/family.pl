% Program:  family.pl
% Source:   Prolog
%
% Purpose:  This is the sample program for the Prolog Lab in COMP9414/9814/3411.
%           It is a simple Prolog program to demonstrate how prolog works.
%           See lab.html for a full description.
%
% History:  Original code by Barry Drake


% parent(Parent, Child)
%
parent(albert, jim).
parent(albert, peter).
parent(jim, brian).
parent(john, darren).
parent(peter, lee).
parent(peter, sandra).
parent(peter, james).
parent(peter, kate).
parent(peter, kyle).
parent(brian, jenny).
parent(irene, jim).
parent(irene, peter).
parent(pat, brian).
parent(pat, darren).
parent(amanda, jenny).


% female(Person)
%
female(irene).
female(pat).
female(lee).
female(sandra).
female(jenny).
female(amanda).
female(kate).

% male(Person)
%
male(albert).
male(jim).
male(peter).
male(brian).
male(john).
male(darren).
male(james).
male(kyle).


% yearOfBirth(Person, Year).
%
yearOfBirth(irene, 1923).
yearOfBirth(pat, 1954).
yearOfBirth(lee, 1970).
yearOfBirth(sandra, 1973).
yearOfBirth(jenny, 2004).
yearOfBirth(amanda, 1979).
yearOfBirth(albert, 1926).
yearOfBirth(jim, 1949).
yearOfBirth(peter, 1945).
yearOfBirth(brian, 1974).
yearOfBirth(john, 1955).
yearOfBirth(darren, 1976).
yearOfBirth(james, 1969).
yearOfBirth(kate, 1975).
yearOfBirth(kyle, 1976).

grandparent(Grandparent, Grandchild):-
	parent(Grandparent, Child),
	parent(Child, Grandchild).

% older(Person1, Person2) :- Person1 is older than Person2
%
older(Person1, Person2) :-
        yearOfBirth(Person1, Year1),
        yearOfBirth(Person2, Year2),
        Year1 < Year2.

%Siblings
siblings(Child1, Child2):-
	parent(Person, Child1),
	parent(Person,Child2),
	Child1 \= Child2.

sibling_list(Child, Siblings):-
	findall(X, siblings(Child,X), Siblings).	

%olderBrother
olderBrother(Child1, Child2):-
	parent(Person, Child1),
	parent(Person, Child2),
	yearOfBirth(Child1, Year1),
	yearOfBirth(Child2, Year2),
	Year1 < Year2.

%descendant recursive

descendant(Person, Descendant) :-
        parent(Person, Descendant).

descendant(Person, Descendant) :-
        parent(Person, Child),
        descendant(Child, Descendant).

%ancestor recursive

ancestor(Person, Ancestor):-
	parent(Ancestor, Person).

ancestor(Person, Ancestor):-
	parent(Parent, Person),
	ancestor(Parent, Ancestor).

%Children
children(Parent,ChildList):-
	findall(X, parent(Parent,X), ChildList).

%lists
is_a_list([]).                                 

is_a_list(.(Head,Tail)):-                     
%ancestor recursive
        is_a_list(Tail).   

%listCount
%Note the use of 2 different counters.
listCount([], 0).
listCount([A|B], Count):-
	listCount(B, CountBuf),
	Count is CountBuf + 1.

deepListCount([],0).
deepListCount(A,1):-
	A \= [],
	A \= [_|_].
deepListCount([A|B], Count):-
	deepListCount(A,CountA),
	deepListCount(B,CountB),
	Count is CountA + CountB.

		
	
countDescendants(Person, Count):-
	findall(X, descendant(Person,X), DescendantList),
	listCount(DescendantList,Count).
