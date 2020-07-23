%%% copyright (c) Mathieu Kerjouan

:- module cat.
:- interface.
:- import_module io.
:- import_module getopt.
:- import_module char.

:- pred main(io::di, io::uo) is det.
:- pred option_defaults(option::out, option_data::out) is nondet.
:- pred option_default(option::out, option_data::out) is multidet.
:- pred short_option(char::in, option::out) is semidet.
:- pred long_option(string::in, option::out) is semidet.

% define the different kind of option we have.
:- type option 
   ---> line_number_no_blank
   ;    dollar_sign
   ;    line_number
   ;    squeeze_multi_empty_line
   ;    print_tab
   ;    unbuffered_output
   ;    non_printing_char.

:- implementation.
:- import_module list.
:- import_module string.
:- import_module bool.
:- import_module map.

option_defaults(Option, Default) :-
	semidet_succeed,
	option_default(Option, Default).

% define the default option value
option_default(line_number_no_blank, bool(no)).
option_default(dollar_sign, bool(no)).
option_default(line_number, bool(no)).
option_default(squeeze_multi_empty_line, bool(no)).
option_default(unbuffered_output, bool(no)).
option_default(non_printing_char, bool(no)).

% define the long_option linked to a type
long_option("unbuf", unbuffered_output).

% define short option linked to a type
short_option('b', line_number_no_blank).
short_option('e', dollar_sign).
short_option('n', line_number).
short_option('s', squeeze_multi_empty_line).
short_option('t', print_tab).
short_option('u', unbuffered_output).
short_option('v', non_printing_char).

main(!IO) :-
	% get arguments from command line
	io.command_line_arguments(Args, !IO),

	% print them
	arguments(Args, !IO),

	% create OptionOpts input variable based on
	% option_ops type
	option_ops(short_option, long_option, option_defaults) = OptionOps,

	% parse the command line arguments
	getopt.process_options(OptionOps, Args, OptionArgs, Result),
	(
		Result = ok(OptionTable),
		map.values(OptionTable, Keys)
	;
		Result = error(Error)
	).
	

:- pred arguments(list(string)::in, io::di, io::uo) is det.

arguments([], !IO) :-
	io.format("", [], !IO).
arguments([H|T], !IO) :-
	io.format("%s\n", [s(H)], !IO),
	arguments(T, !IO).
