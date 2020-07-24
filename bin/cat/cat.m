%%%-------------------------------------------------------------------
%%%
%%% Copyright (c) 2020 Mathieu Kerjouan <contact@steepath.eu>
%%%
%%% Permission to use, copy, modify,  and distribute this software for
%%% any purpose with  or without fee is hereby  granted, provided that
%%% the above  copyright notice and  this permission notice  appear in
%%% all copies.
%%%
%%% THE  SOFTWARE IS  PROVIDED "AS  IS" AND  THE AUTHOR  DISCLAIMS ALL
%%% WARRANTIES  WITH REGARD  TO  THIS SOFTWARE  INCLUDING ALL  IMPLIED
%%% WARRANTIES OF MERCHANTABILITY  AND FITNESS. IN NO  EVENT SHALL THE
%%% AUTHOR   BE  LIABLE   FOR  ANY   SPECIAL,  DIRECT,   INDIRECT,  OR
%%% CONSEQUENTIAL  DAMAGES OR  ANY DAMAGES  WHATSOEVER RESULTING  FROM
%%% LOSS OF  USE, DATA OR PROFITS,  WHETHER IN AN ACTION  OF CONTRACT,
%%% NEGLIGENCE  OR  OTHER  TORTIOUS  ACTION,  ARISING  OUT  OF  OR  IN
%%% CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
%%%
%%%-------------------------------------------------------------------

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
	% arguments(Args, !IO),

	% create OptionOpts input variable based on
	% option_ops type
	option_ops(short_option, long_option, option_defaults) = OptionOps,

	% parse the command line arguments
	% OptionOps was previously defined
	% Args contains the whole arguments
	% OptionArgs contains the remaining args (e.g. after --)
	% Result contains the parsed arguments based on type
	getopt.process_options(OptionOps, Args, OptionArgs, Result),
	(
		Result = ok(OptionTable),
		map.values(OptionTable, Keys),
		( map.search(OptionTable, dollar_sign, Value),
		 Value = bool(yes) ->
			io.format("yes\n", [], !IO)
		;
			io.format("no\n", [], !IO)
		),
		cat(OptionArgs, !IO)
	;
		Result = error(Error)
	).

% :- pred arguments(list(string)::in, io::di, io::uo) is det.
%
% arguments([], !IO) :-
% 	io.format("", [], !IO).
% arguments([H|T], !IO) :-
%	io.format("%s\n", [s(H)], !IO),
%	arguments(T, !IO).

:- pred cat(list(string)::in, io::di, io::uo) is det.

cat([], !IO) :- 
	io.format("", [], !IO). 
cat([File|Rest], !IO) :-
	io.open_input(File, Stream, !IO),
	( 
		Stream = ok(S),
		read(S, !IO),
		cat(Rest, !IO)
	;
		Stream = error(Error)
	). 

:- pred read(io.text_input_stream::in, io::di, io::uo) is det.

read(Stream, !IO) :-
	io.read_char(Stream, Char, !IO),
	( 
		Char = ok(C),
		io.format("%c", [c(C)], !IO),
		read(Stream, !IO)
	;
		Char = eof,
		io.format("", [], !IO)
	;
		Char = error(Error),
		io.format("error", [], !IO)
	).
