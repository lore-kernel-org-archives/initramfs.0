From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: build initramfs: logging is slow
Date: Tue, 06 Sep 2011 09:55:50 -0700
Message-ID: <4E665096.3080308@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Commenting out this line from inst_simple:
    ddebug "Installing $_src"
saves me about 10% real time (not counting final gzip) in build initramfs.

The low-level culprit is the extra _process_ [fork or clone] for $(_lvl2char ...) in:
----- dracut-logger
_do_dlog() {
    [ -z "$maxloglvl" ] && return 0
    local lvl="$1"; shift
    local lvlc=$(_lvl2char "$lvl") || return 0    ### SLOW!

    [ $lvl -le $maxloglvl ] || return 0
-----

Instead, the level translation should be done using an indexed array
(after an arithmetic check for index-out-of-range.)

Even better, the level comparison should be hoisted into the definition
of ddebug and dtrace, such as:
-----
ddebug() {
    [ 5 -le $maxloglvl ] || return 0
    set +x
    dlog 5 "$@"
}
-----

If bash could conditionally re-define a function, then dlog_init might:
    [ 5 -le $maxloglvl ]  ||  eval "function ddebug() {}"
but that did not work for me.

-- 
