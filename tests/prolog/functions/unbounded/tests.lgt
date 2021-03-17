%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This file is part of Logtalk <https://logtalk.org/>
%  Copyright 1998-2021 Paulo Moura <pmoura@logtalk.org>
%  SPDX-License-Identifier: Apache-2.0
%
%  Licensed under the Apache License, Version 2.0 (the "License");
%  you may not use this file except in compliance with the License.
%  You may obtain a copy of the License at
%
%      http://www.apache.org/licenses/LICENSE-2.0
%
%  Unless required by applicable law or agreed to in writing, software
%  distributed under the License is distributed on an "AS IS" BASIS,
%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%  See the License for the specific language governing permissions and
%  limitations under the License.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- object(tests,
	extends(lgtunit)).

	:- info([
		version is 0:1:0,
		author is 'Paulo Moura',
		date is 2021-03-17,
		comment is 'Unit tests for unbounded integer arithmetic.'
	]).

	% tests from the Logtalk portability work

	% (+)/2

	test(lgt_unbounded_addition_01, true(N == 123456789012345678901234567891)) :-
		N is 123456789012345678901234567890 + 1.

	test(lgt_unbounded_addition_02, true(N == 123456789012345678901234567891)) :-
		N is 1 + 123456789012345678901234567890.

	test(lgt_unbounded_addition_03, true(N == 246913578024691357802469135780)) :-
		N is 123456789012345678901234567890 + 123456789012345678901234567890.

	% (-)/2

	test(lgt_unbounded_subtraction_01, true(N == 123456789012345678901234567890)) :-
		N is 123456789012345678901234567891 - 1.

	test(lgt_unbounded_subtraction_02, true(N == -123456789012345678901234567890)) :-
		N is 1 - 123456789012345678901234567891.

	test(lgt_unbounded_subtraction_03, true(N == 123456789012345678901234567890)) :-
		N is 246913578024691357802469135780 - 123456789012345678901234567890.

	test(lgt_unbounded_subtraction_04, true(N == -123456789012345678901234567890)) :-
		N is 123456789012345678901234567890 - 246913578024691357802469135780.

	% (*)/2

	test(lgt_unbounded_multiplication_01, true(N == 370370367037037036703703703670)) :-
		N is 123456789012345678901234567890 * 3.

	test(lgt_unbounded_multiplication_02, true(N == 370370367037037036703703703670)) :-
		N is 3 * 123456789012345678901234567890.

	test(lgt_unbounded_multiplication_03, true(N == 15241578753238836750495351562536198787501905199875019052100)) :-
		N is 123456789012345678901234567890 * 123456789012345678901234567890.

	% (//)/2

	test(lgt_unbounded_division_01, true(N == 41152263004115226300411522630)) :-
		N is 123456789012345678901234567890 // 3.

	test(lgt_unbounded_division_02, true(N == 0)) :-
		N is 3 // 123456789012345678901234567890.

	test(lgt_unbounded_division_03, true(N == 41152263004115226300411522630)) :-
		N is 15241578753238836750495351562536198787501905199875019052100 // 370370367037037036703703703670.

	% (div)/2

	test(lgt_unbounded_div_01, true(N == 17636684144620811271604938270)) :-
		N is 123456789012345678901234567890 div 7.

	test(lgt_unbounded_div_02, true(N == 0)) :-
		N is 7 div 123456789012345678901234567890.

	test(lgt_unbounded_div_03, true(N == 1234567890123456788901234657800000)) :-
		N is 15241578753238836750495351562536198787501905199875019052100 div 12345678901234567891234567.

	% (rem)/2

	test(lgt_unbounded_rem_01, true(N == 117)) :-
		N is 123456789012345678901234567890 rem 123.

	test(lgt_unbounded_rem_02, true(N == 123)) :-
		N is 123 rem 123456789012345678901234567890.

	test(lgt_unbounded_rem_03, true(N == 122443787781019052100)) :-
		N is 15241578753238836750495351562536198787501905199875019052100 rem 1234567890123456789123.

	% (mod)/2

	test(lgt_unbounded_mod_01, true(N == 0)) :-
		N is 123456789012345678901234567890 mod 3.

	test(lgt_unbounded_mod_02, true(N == 3)) :-
		N is 3 mod 123456789012345678901234567890.

	test(lgt_unbounded_mod_03, true(N == 122443787781019052100)) :-
		N is 15241578753238836750495351562536198787501905199875019052100 mod 1234567890123456789123.

	% gcd/2

	test(lgt_unbounded_gcd_01, true(N == 42), [condition((Function = gcd(2,1), catch(_ is Function, _, fail)))]) :-
		GCD = gcd(987654321098765432109876543210, 42),
		N is GCD.

	test(lgt_unbounded_gcd_02, true(N == 42), [condition((Function = gcd(2,1), catch(_ is Function, _, fail)))]) :-
		GCD = gcd(42, 987654321098765432109876543210),
		N is GCD.

	test(lgt_unbounded_gcd_03, true(N == 9000000000900000000090), [condition((Function = gcd(2,1), catch(_ is Function, _, fail)))]) :-
		GCD = gcd(987654321098765432109876543210, 123456789012345678901234567890),
		N is GCD.

	% (^)/2

	test(lgt_unbounded_power_01, true(N == 5846006549323611672814739330865132078623730171904)) :-
		N is 4 ^ 3 ^ 4.

	test(lgt_unbounded_power_02, true(N == 1881676372353657772546715999894626455109783106026821047606410765129148590562263)) :-
		N is 123456789012345678901234567 ^ 3.

	% (<<)/2

	test(lgt_unbounded_left_shift_01, true(N == 2071261215926550121592655012157194240)) :-
		N is 123456789012345678901234567890 << 24.

	% (>>)/2

	test(lgt_unbounded_right_shift_01, true(N == 123456789012345678901234567890)) :-
		N is 2071261215926550121592655012157194240 >> 24.

	% (/\)/2

	test(lgt_unbounded_and_01, true(N == 16)) :-
		N is 123456789012345678901234567890 /\ 24.

	test(lgt_unbounded_and_02, true(N == 16)) :-
		N is 24 /\ 123456789012345678901234567890.

	test(lgt_unbounded_and_03, true(N == 83599684372040429760890210448)) :-
		N is 123456789012345678901234567890 /\ 98765432109876543210987654321.

	% (\/)/2

	test(lgt_unbounded_or_01, true(N == 123456789012345678901234567898)) :-
		N is 123456789012345678901234567890 \/ 24.

	test(lgt_unbounded_or_02, true(N == 123456789012345678901234567898)) :-
		N is 24 \/ 123456789012345678901234567890.

	test(lgt_unbounded_or_03, true(N == 138622536750181792351332011763)) :-
		N is 123456789012345678901234567890 \/ 98765432109876543210987654321.

	% xor/2

	test(lgt_unbounded_xor_01, true(N == 123456789012345678901234567882)) :-
		N is xor(123456789012345678901234567890, 24).

	test(lgt_unbounded_xor_02, true(N == 123456789012345678901234567882)) :-
		N is xor(24, 123456789012345678901234567890).

	test(lgt_unbounded_xor_03, true(N == 55022852378141362590441801315)) :-
		N is xor(123456789012345678901234567890, 98765432109876543210987654321).

	% min/2

	test(lgt_unbounded_min_01, true(N == 24)) :-
		N is min(123456789012345678901234567890, 24).

	test(lgt_unbounded_min_02, true(N == 24)) :-
		N is min(24, 123456789012345678901234567890).

	test(lgt_unbounded_min_03, true(N == 123456789012345678901234567890)) :-
		N is min(123456789012345678901234567890, 987654321098765432109876543210).

	% max/2

	test(lgt_unbounded_max_01, true(N == 123456789012345678901234567890)) :-
		N is max(123456789012345678901234567890, 24).

	test(lgt_unbounded_max_02, true(N == 123456789012345678901234567890)) :-
		N is max(24, 123456789012345678901234567890).

	test(lgt_unbounded_max_03, true(N == 987654321098765432109876543210)) :-
		N is max(123456789012345678901234567890, 987654321098765432109876543210).

	% succ/2

	test(lgt_unbounded_succ_01, true(N == 123456789012345678901234567891), [condition(predicate_property(succ(_,_), built_in))]) :-
		{succ(123456789012345678901234567890, N)}.

	test(lgt_unbounded_succ_02, true(N == 123456789012345678901234567890), [condition(predicate_property(succ(_,_), built_in))]) :-
		{succ(N, 123456789012345678901234567891)}.

	% plus/3

	test(lgt_unbounded_plus_01, true(N == 1111111110111111111011111111100), [condition(predicate_property(plus(_,_,_), built_in))]) :-
		{plus(123456789012345678901234567890, 987654321098765432109876543210, N)}.

	test(lgt_unbounded_plus_02, true(N == 987654321098765432109876543210), [condition(predicate_property(plus(_,_,_), built_in))]) :-
		{plus(123456789012345678901234567890, N, 1111111110111111111011111111100)}.

	test(lgt_unbounded_plus_03, true(N == 123456789012345678901234567890), [condition(predicate_property(plus(_,_,_), built_in))]) :-
		{plus(N, 987654321098765432109876543210, 1111111110111111111011111111100)}.

:- end_object.
