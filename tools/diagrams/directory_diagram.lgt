
:- category(directory_diagram(Format),
	extends(diagram(Format))).

	:- info([
		version is 1.0,
		author is 'Paulo Moura',
		date is 2019/04/07,
		comment is 'Common predicates for generating directory diagrams.',
		parnames is ['Format']
	]).

	:- uses(list, [member/2, memberchk/2]).

	:- protected(add_directory_documentation_url/4).
	:- mode(add_directory_documentation_url(+atom, +list(compound), +atom, -list(compound)), one).
	:- info(add_directory_documentation_url/4, [
		comment is 'Adds a documentation URL when using the option url_prefixes/2.',
		argnames is ['Kind', 'Options', 'Directory', 'NodeOptions']
	]).

	:- protected(remember_included_directory/1).
	:- protected(remember_referenced_logtalk_directory/1).
	:- protected(remember_referenced_prolog_directory/1).

	:- private(included_directory_/1).
	:- dynamic(included_directory_/1).

	:- private(referenced_logtalk_directory_/1).
	:- dynamic(referenced_logtalk_directory_/1).

	:- private(referenced_prolog_directory_/1).
	:- dynamic(referenced_prolog_directory_/1).

	files(Project, Files, UserOptions) :-
		files_directories(Files, Directories),
		::directories(Project, Directories, UserOptions).

	files_directories(Files, Directories) :-
		files_directories_bag(Files, Directories0),
		sort(Directories0, Directories).

	files_directories_bag([], []).
	files_directories_bag([File| Files], [Directory| Directories]) :-
		^^locate_file(File, _, _, Directory, _),
		files_directories_bag(Files, Directories).

	remember_included_directory(Path) :-
		(	::included_directory_(Path) ->
			true
		;	::assertz(included_directory_(Path))
		).

	remember_referenced_logtalk_directory(Path) :-
		(	::referenced_logtalk_directory_(Path) ->
			true
		;	::assertz(referenced_logtalk_directory_(Path))
		).

	remember_referenced_prolog_directory(Path) :-
		(	::referenced_prolog_directory_(Path) ->
			true
		;	::assertz(referenced_prolog_directory_(Path))
		).

	reset :-
		^^reset,
		::retractall(included_directory_(_)),
		::retractall(referenced_logtalk_directory_(_)),
		::retractall(referenced_prolog_directory_(_)).

	output_externals(_Options) :-
		::retract(included_directory_(Path)),
		::retractall(referenced_logtalk_directory_(Path)),
		::retractall(referenced_prolog_directory_(Path)),
		fail.
	output_externals(Options) :-
		^^format_object(Format),
		Format::graph_header(diagram_output_file, other, '(external libraries)', external, [urls('',''), tooltip('(external libraries)')| Options]),
		::retract(referenced_logtalk_directory_(Directory)),
		^^add_link_options(Directory, Options, LinkingOptions),
		^^omit_path_prefix(Directory, Options, Relative),
		add_directory_documentation_url(logtalk, LinkingOptions, Relative, NodeOptions),
		(	memberchk(directory_paths(true), Options) ->
			^^output_node(Relative, Relative, directory, [Relative], external_directory, NodeOptions)
		;	^^output_node(Relative, Relative, directory, [], external_directory, NodeOptions)
		),
		fail.
	output_externals(Options) :-
		::retract(referenced_prolog_directory_(Directory)),
		^^add_link_options(Directory, Options, LinkingOptions),
		^^omit_path_prefix(Directory, Options, Relative),
		add_directory_documentation_url(prolog, LinkingOptions, Relative, NodeOptions),
		(	memberchk(directory_paths(true), Options) ->
			^^output_node(Relative, Relative, directory, [Relative], external_directory, NodeOptions)
		;	^^output_node(Relative, Relative, directory, [], external_directory, NodeOptions)
		),
		fail.
	output_externals(Options) :-
		^^format_object(Format),
		Format::graph_footer(diagram_output_file, other, '(external directories)', external, [urls('',''), tooltip('(external libraries)')| Options]).

	add_directory_documentation_url(logtalk, Options, Directory, NodeOptions) :-
		(	member(urls(CodePrefix, DocPrefix), Options) ->
			memberchk(entity_url_suffix_target(Suffix, Target), Options),
			atom_concat(DocPrefix, Suffix, URL0),
			atom_concat(URL0, Target, URL1),
			atom_concat(URL1, Directory, URL),
			NodeOptions = [urls(CodePrefix, URL)| Options]
		;	NodeOptions = Options
		).
	% tbd
	add_directory_documentation_url(prolog, NodeOptions, _, NodeOptions).

:- end_category.