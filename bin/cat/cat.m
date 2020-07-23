%%% copyright (c) Mathieu Kerjouan

:- module cat.
:- interface.

:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module list.
:- import_module string.
:- import_module getopt.
:- import_module bool.
:- import_module char.

:- type option 
   ---> line_number_no_blank
   ;    dollar_sign
   ;    line_number
   ;    squeeze_multi_empty_line
   ;    print_tab
   ;    unbuffered_output
   ;    non_printing_char.

:- pred short_option(char::in, option::out) is semidet.

short_option('b', line_number_no_blank).
short_option('e', dollar_sign).
short_option('n', line_number).
short_option('s', squeeze_multi_empty_line).
short_option('t', print_tab).
short_option('u', unbuffered_output).
short_option('v', non_printing_char).

main(!IO) :-
	io.command_line_arguments(Args, !IO),
	arguments(Args, !IO).

:- pred arguments(list(string)::in, io::di, io::uo) is det.

arguments([], !IO) :-
	io.format("", [], !IO).
arguments([H|T], !IO) :-
	io.format("%s\n", [s(H)], !IO),
	arguments(T, !IO).
