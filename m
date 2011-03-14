From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=5D=20dracut-logger=3A=20logging=20facility=20module=20for=20build-=20and=20boot-time?=
Date: Mon, 14 Mar 2011 02:00:03 +0100
Message-ID: <1300064403-23298-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

It's dash compatible to be used also at boot-time. For now it's include=
d
by dracut-functions and replaces functions: dinfo(), dwarning() and
derror(). New options are introduced: -L|--stdlog, and -q|--quiet to
control stderr verbosity. Logging to file or syslog may be controlled b=
y
options set in config file.

Note that code is not adjusted to the meaning of the new logging
functions, yet.

Doxygen formatted documentation (as a proposal, by the way) is included
in dracut-logger.
---
 dracut-logger |  266 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 266 insertions(+), 0 deletions(-)
 create mode 100755 dracut-logger

diff --git a/dracut-logger b/dracut-logger
new file mode 100755
index 0000000..a20d6f8
--- /dev/null
+++ b/dracut-logger
@@ -0,0 +1,266 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 et filetype=3Dsh
+#
+# logging faciality module for dracut both at build- and boot-time
+#
+# Copyleft 2010 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
+
+
+## @brief Logging facility module for Dracut both at build- and boot-t=
ime.
+#
+# @section intro Introduction
+#
+# The logger takes a bit from Log4j philosophy. There are defined 6 lo=
gging
+# levels:
+#   - TRACE (1)
+#     The TRACE Level designates finer-grained informational events th=
an the
+#     DEBUG.
+#   - DEBUG (2)
+#     The DEBUG Level designates fine-grained informational events tha=
t are most
+#     useful to debug an application.
+#   - INFO (3)
+#     The INFO level designates informational messages that highlight =
the
+#     progress of the application at coarse-grained level.
+#   - WARN (4)
+#     The WARN level designates potentially harmful situations.
+#   - ERROR (5)
+#     The ERROR level designates error events that might still allow t=
he
+#     application to continue running.
+#   - FATAL (5)
+#     The FATAL level designates very severe error events that will pr=
esumably
+#     lead the application to abort.
+# Descriptions are borrowed from Log4j documentation:
+# http://logging.apache.org/log4j/1.2/apidocs/org/apache/log4j/Level.h=
tml
+#
+# @section usage Usage
+#
+# First of all you have to start with dlog_init() function which initi=
alizes
+# required variables. Don't call any other logging function before tha=
t one!
+# If you're ready with this, you can use following functions which cor=
responds
+# clearly to levels listed in @ref intro Introduction. Here they are:
+#   - dtrace()
+#   - ddebug()
+#   - dinfo()
+#   - dwarn()
+#   - derror()
+#   - dfatal()
+# They take all arguments given as a single message to be logged. See =
dlog()
+# function for details how it works. Note that you shouldn't use dlog(=
) by
+# yourself. It's wrapper with above functions.
+#
+# @see dlog_init() dlog()
+#
+# @section conf Configuration
+#
+# Logging is controlled by following global variables:
+#   - @var stdloglvl - logging level to standard error (console output=
)
+#   - @var sysloglvl - logging level to syslog (by logger command)
+#   - @var fileloglvl - logging level to file
+#   - @var logfile - log file which is used when @var fileloglvl is hi=
gher
+#   than 0
+# and one global internal variable @var _maxloglvl which <b>must not</=
b> be
+# overwritten. @_maxloglvl is set by dlog_init() and holds maximum log=
ging level
+# of those three and indicates that dlog_init() was run.
+#
+# Logging level set by the variable means that messages from this logg=
ing level
+# and above (FATAL is the highest) will be shown. Logging levels may b=
e set
+# independently for each destination (stderr, syslog, file).
+#
+# @see dlog_init()
+
+
+## @brief Initializes Dracut Logger.
+#
+# @retval 1 if something has gone wrong
+# @retval 0 on success.
+#
+# @note This function need to be called before any other from this fil=
e.
+#
+# If any of the variables is not set, this function set it to default:
+#   - @var stdloglvl =3D 4 (info)
+#   - @var sysloglvl =3D 0 (no logging)
+#   - @var fileloglvl is set to 4 when @var logfile is set too, otherw=
ise it's
+#   set to 0
+#
+# @warning Function sets global variable @var _maxloglvl for internal =
use. Don't
+# overwrite it.
+dlog_init() {
+    [ -n "$_maxloglvl" ] && return 0
+    [ -z "$stdloglvl" ] && stdloglvl=3D4
+    [ -z "$sysloglvl" ] && sysloglvl=3D0
+
+    if [ -z "$fileloglvl" ]; then
+        [ -w "$logfile" ] && fileloglvl=3D4 || fileloglvl=3D0
+    elif [ $fileloglvl -gt 0 ]; then
+        ! [ -e "$logfile" ] && >"$logfile"
+        [ -w "$logfile" -a -f "$logfile" ] || {
+            logger -t dracut -p error -s "E: '$logfile' is not writabl=
e file"
+            return 1
+        }
+
+        # Mark new run in the log file
+        echo >>"$logfile"
+        if command -v date >/dev/null; then
+            echo "=3D=3D=3D $(date) =3D=3D=3D" >>"$logfile"
+        else
+            echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D" >>"$logfile"
+        fi
+        echo >>"$logfile"
+    fi
+
+    local lvl
+    _maxloglvl=3D0
+    for lvl in $stdloglvl $sysloglvl $fileloglvl; do
+        [ $lvl -gt $_maxloglvl ] && _maxloglvl=3D$lvl
+    done
+}
+
+## @brief Converts numeric logging level to the first letter of level =
name.
+#
+# @param lvl Numeric logging level in range from 1 to 6.
+# @retval 1 if @a lvl is out of range.
+# @retval 0 if @a lvl is correct.
+# @result Echoes first letter of level name.
+_lvl2char() {
+    case "$1" in
+        1) echo F;;
+        2) echo E;;
+        3) echo W;;
+        4) echo I;;
+        5) echo D;;
+        6) echo T;;
+        *) return 1;;
+    esac
+}
+
+## @brief Converts numeric level to logger priority defined by POSIX.2=
=2E
+#
+# @param lvl Numeric logging level in range from 1 to 6.
+# @retval 1 if @a lvl is out of range.
+# @retval 0 if @a lvl is correct.
+# @result Echoes logger priority.
+_lvl2syslogpri() {
+    case "$1" in
+        1) echo crit;;
+        2) echo error;;
+        3) echo warning;;
+        4) echo info;;
+        5) echo debug;;
+        6) echo debug;;
+        *) return 1;;
+    esac
+}
+
+## @brief Prints or/and writes to file or/and to syslog given message =
with given
+# level (priority).
+#
+# @param lvl Numeric logging level.
+# @param msg Message.
+# @retval 0 It's always returned, even if logging failed.
+#
+# @note This function is not supposed to be called manually. Please us=
e
+# dtrace(), ddebug(), or others instead which wrap this one.
+#
+# This is core logging function which logs given message to standard e=
rror, file
+# and/or syslog (with POSIX shell command <tt>logger</tt>). The format=
 is
+# following:
+#
+# <tt>X: some message</tt>
+#
+# where @c X is the first letter of logging level. See module descript=
ion for
+# details on that.
+#
+# Message to syslog is sent with tag @c dracut. Priorities are mapped =
as
+# following:
+#   - @c FATAL to @c crit
+#   - @c ERROR to @c error
+#   - @c WARN to @c warning
+#   - @c INFO to @c info
+#   - @c DEBUG and @c TRACE both to @c debug
+dlog() {
+    [ -z "$_maxloglvl" ] && return 0
+    local lvl=3D"$1"; shift
+    local lvlc=3D$(_lvl2char "$lvl") || return 0
+
+    [ $lvl -le $_maxloglvl ] || return 0
+
+    local msg=3D"$lvlc: $*"
+
+    [ $lvl -le $stdloglvl ] && echo "$msg" >&2
+    if [ $lvl -le $sysloglvl ]; then
+        logger -t dracut -p $(_lvl2syslogpri $lvl) "$msg"
+    fi
+    if [ $lvl -le $fileloglvl -a -w "$logfile" -a -f "$logfile" ]; the=
n
+        echo "$msg" >>"$logfile"
+    fi
+}
+
+## @brief Logs message at TRACE level (6)
+#
+# @param msg Message.
+# @retval 0 It's always returned, even if logging failed.
+dtrace() {
+    dlog 6 "$*"
+}
+
+## @brief Logs message at DEBUG level (5)
+#
+# @param msg Message.
+# @retval 0 It's always returned, even if logging failed.
+ddebug() {
+    dlog 5 "$*"
+}
+
+## @brief Logs message at INFO level (4)
+#
+# @param msg Message.
+# @retval 0 It's always returned, even if logging failed.
+dinfo() {
+    dlog 4 "$*"
+}
+
+## @brief Logs message at WARN level (3)
+#
+# @param msg Message.
+# @retval 0 It's always returned, even if logging failed.
+dwarn() {
+    dlog 3 "$*"
+}
+
+## @brief It's an alias to dwarn() function.
+#
+# @param msg Message.
+# @retval 0 It's always returned, even if logging failed.
+dwarning() {
+    dwarn "$*"
+}
+
+## @brief Logs message at ERROR level (2)
+#
+# @param msg Message.
+# @retval 0 It's always returned, even if logging failed.
+derror() {
+    dlog 2 "$*"
+}
+
+## @brief Logs message at FATAL level (1)
+#
+# @param msg Message.
+# @retval 0 It's always returned, even if logging failed.
+dfatal() {
+    dlog 1 "$*"
+}
--=20
1.7.4.1
