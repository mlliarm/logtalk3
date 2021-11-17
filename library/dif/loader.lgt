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


:- if((
	current_logtalk_flag(prolog_dialect, Dialect),
	(	Dialect == b; Dialect == eclipse; Dialect == sicstus;
		Dialect == scryer; Dialect == swi; Dialect == yap
	)
)).

	:- if(current_logtalk_flag(prolog_dialect, eclipse)).
	    :- ensure_loaded(library(sicstus)).
	:- elif(current_logtalk_flag(prolog_dialect, scryer)).
		:- use_module(library(dif)).
	:- elif(current_logtalk_flag(prolog_dialect, swi)).
		:- use_module(library(dif), []).
	:- endif.

	:- initialization((
		logtalk_load(dif, [optimize(on)])
	)).

:- else.

	:- initialization((write('(not available for the used backend Prolog compiler)'), nl)).

:- endif.
