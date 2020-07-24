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

:- module openbsd.pledge.
:- interface.

:- import_module list.

:- type promise ---> 
	  null
	; stdio
	; rpath
	; wpath
	; cpath
	; dpath
	; tmppath
	; inet
	; mcast
	; fattr
	; chown
	; flock
	; unix
	; dns
	; getpw
	; sendfd
	; recvfd
	; tape
	; tty
	; proc
	; exec
	; prot_exec
	; settime
	; ps
	; vminfo
	; id
	; pf
	; audio
	; video
	; bpf
	; unveil
	; error.

:- type promises ---> [promise].

:- pred pledge(promise::in, promises::out) is det.

:- implementation.
:- import_module string.

:- pred pledge_to_string(promise::in, string::out) is det.
pledge_to_string(null, "").
pledge_to_string(stdio, "stdio").
pledge_to_string(rpath, "rpath").
pledge_to_string(wpath, "wpath").
pledge_to_string(cpath, "cpath").
pledge_to_string(dpath, "dpath").
pledge_to_string(tmppath, "tmppath").
pledge_to_string(inet, "inet").
pledge_to_string(mcast, "mcast").
pledge_to_string(fattr, "fattr").
pledge_to_string(chown, "chown").
pledge_to_string(flock, "flock").
pledge_to_string(unix, "unix").
pledge_to_string(dns, "dns").
pledge_to_string(getpw, "getpw").
pledge_to_string(sendfd, "sendfd").
pledge_to_string(recvfd, "recvfd").
pledge_to_string(tape, "tape").
pledge_to_string(tty, "tty").
pledge_to_string(proc, "proc").
pledge_to_string(exec, "exec").
pledge_to_string(prot_exec, "prot_exec").
pledge_to_string(settime, "settime").
pledge_to_string(ps, "ps").
pledge_to_string(vminfo, "vminfo").
pledge_to_string(id, "id").
pledge_to_string(pf, "pf").
pledge_to_string(audio, "audio").
pledge_to_string(video, "video").
pledge_to_string(bpf, "bpf").
pledge_to_string(unveil, "unveil").
pledge_to_string(error, "error").

%
% need to work on that
%
pledge(Promises, ExecPromises, Return, !IO).

%
% need to test the implementation
% 
:- pred pledge0(promises::in, promises::in, int::out, io::di, io::uo) is det.
:- pragma foreign_proc("C",
	pledge0(Promises::in, ExecPromises::in, Return::out, _IO0::di, _IO::uo),
	[promise_pure, will_not_call_mercury, thread_safe, tabled_for_io],
"
	Return = pledge(Promises, ExecPromises);
").
