%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  This file is part of Logtalk <http://logtalk.org/>
%  
%  Logtalk is free software. You can redistribute it and/or modify it under
%  the terms of the FSF GNU General Public License 3  (plus some additional
%  terms per section 7).        Consult the `LICENSE.txt` file for details.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(clause_2_test_object).

	:- public(p/1).
	:- dynamic(p/1).

	:- protected(q/2).
	:- dynamic(q/2).

	:- private(r/3).
	:- dynamic(r/3).

	:- public(s/4).

	:- public(t/1).
	:- dynamic(t/1).
	t(1).
	t(2) :- t(1).
	t(3) :- t(1), t(2).

	:- public(ie/1).
	ie(Object) :-
		Object::clause(foo, _).

	:- public(te/0).
	te :-
		Object = 1,
		Object::clause(foo, _).

:- end_object.



:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 1.0,
		author is 'Paulo Moura',
		date is 2014/04/16,
		comment is 'Unit tests for the clause/2 built-in method.'
	]).

	throws(clause_2_1, error(instantiation_error, logtalk(clause_2_test_object::clause(_,_),user))) :-
		{clause_2_test_object::clause(_, _)}.

	throws(clause_2_2, error(type_error(callable, 1), logtalk(clause_2_test_object::clause(1,_),user))) :-
		{clause_2_test_object::clause(1, _)}.

	throws(clause_2_3, error(type_error(callable, 1), logtalk(clause_2_test_object::clause(head,1),user))) :-
		{clause_2_test_object::clause(head, 1)}.

	throws(clause_2_4, error(permission_error(access, protected_predicate, q/2), logtalk(clause_2_test_object::clause(q(_,_),_),user))) :-
		{clause_2_test_object::clause(q(_,_), _)}.

	throws(clause_2_5, error(permission_error(access, private_predicate, r/3), logtalk(clause_2_test_object::clause(r(_,_,_),_),user))) :-
		{clause_2_test_object::clause(r(_,_,_), _)}.

	throws(clause_2_6, error(permission_error(access, static_predicate, s/4), logtalk(clause_2_test_object::clause(s(_,_,_,_),_),user))) :-
		{clause_2_test_object::clause(s(_,_,_,_), _)}.

	throws(clause_2_7, error(existence_error(predicate_declaration, unknown/1), logtalk(clause_2_test_object::clause(unknown(_),_),user))) :-
		{clause_2_test_object::clause(unknown(_), _)}.

	throws(clause_2_8, error(instantiation_error, logtalk(_::clause(foo,_),clause_2_test_object))) :-
		{clause_2_test_object::ie(_)}.

	throws(clause_2_9, error(type_error(object_identifier, 1), logtalk(1::clause(foo,_),clause_2_test_object))) :-
		{clause_2_test_object::te}.

	succeeds(clause_2_10) :-
		clause_2_test_object::clause(t(X), true),
		X == 1,
		clause_2_test_object::clause(t(2), Body1),
		Body1 == t(1),
		clause_2_test_object::clause(t(3), Body2),
		Body2 == (t(1), t(2)).

	succeeds(clause_2_11) :-
		create_object(Object, [], [public(t/1), dynamic(t/1)], [t(1), (t(2) :-t(1)), (t(3) :-t(1),t(2))]),
		Object::clause(t(X), true),
		X == 1,
		Object::clause(t(2), Body1),
		Body1 == t(1),
		Object::clause(t(3), Body2),
		Body2 == (t(1), t(2)),
		abolish_object(Object).

:- end_object.
