From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCHv2=5D=20dracut-logger=3A=20logging=20facility=20module=20for=20build-=20and=20boot-time?=
Date: Tue, 15 Mar 2011 18:50:53 +0100
Message-ID: <1300211453-7394-1-git-send-email-aidecoe@aidecoe.name>
References: <1300064403-23298-1-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300064403-23298-1-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
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
 dracut           |   22 ++++-
 dracut-functions |   30 +-----
 dracut-logger    |  293 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 dracut.conf      |    4 +
 4 files changed, 322 insertions(+), 27 deletions(-)
 create mode 100755 dracut-logger

diff --git a/dracut b/dracut
index 4c3394c..f60b854 100755
--- a/dracut
+++ b/dracut
@@ -59,7 +59,16 @@ Creates initial ramdisk images for preloading module=
s
   --nolvmconf           Do not include local /etc/lvm/lvm.conf
   -h, --help            This message
   --debug               Output debug information of the build process
-  -v, --verbose         Verbose output during the build process
+  -L, --stdlog [0-6]    Specify logging level (to standard error)
+                         0 - suppress any messages
+                         1 - only fatal errors
+                         2 - all errors
+                         3 - warnings
+                         4 - info (default)
+                         5 - debug info (here starts lots of output)
+                         6 - trace info (and even more)
+  -v, --verbose         Verbose output during the build process (info =
level)
+  -q, --quiet           Display only errors and fatal errors during bu=
ild
   -c, --conf [FILE]     Specify configuration file to use.
                          Default: /etc/dracut.conf
   --confdir [DIR]       Specify configuration directory to use *.conf =
files=20
@@ -184,6 +193,7 @@ while (($# > 0)); do
         -k|--kmoddir)  read_arg drivers_dir_l        "$@" || shift;;
         -c|--conf)     read_arg conffile             "$@" || shift;;
         --confdir)     read_arg confdir              "$@" || shift;;
+        -L|--stdlog)   read_arg stdloglvl_l          "$@" || shift;;
         -f|--force)    force=3Dyes;;
         --kernel-only) kernel_only=3D"yes"; no_kernel=3D"no";;
         --no-kernel)   kernel_only=3D"no"; no_kernel=3D"yes";;
@@ -195,6 +205,7 @@ while (($# > 0)); do
         --nolvmconf)   lvmconf_l=3D"no";;
         --debug)       debug=3D"yes";;
         -v|--verbose)  beverbose=3D"yes";;
+        -q|--quiet)    bequiet=3D"yes";;
         -l|--local)    allowlocal=3D"yes" ;;
         -H|--hostonly) hostonly_l=3D"yes" ;;
         --fstab)       use_fstab_l=3D"yes" ;;
@@ -236,6 +247,12 @@ export PATH
     set -x
 }
=20
+# For compatibility with -v behaviour. Set to info level.
+[[ $beverbose ]] && (( $stdloglvl_l < 4 )) && stdloglvl_l=3D4
+
+# When quiet, display only errors and fatal errors.
+[[ $bequiet ]] && (( $stdloglvl_l > 2 )) && stdloglvl_l=3D2
+
 [[ $dracutbasedir ]] || dracutbasedir=3D/usr/share/dracut
=20
 [[ $allowlocal && -f "$(readlink -f ${0%/*})/dracut-functions" ]] && \
@@ -311,6 +328,7 @@ if [[ ${#fw_dir_l[@]} ]]; then
     done
 fi
=20
+[[ $stdloglvl_l ]] && stdloglvl=3D$stdloglvl_l
 [[ $drivers_dir_l ]] && drivers_dir=3D$drivers_dir_l
 [[ $do_strip_l ]] && do_strip=3D$do_strip_l
 [[ $hostonly_l ]] && hostonly=3D$hostonly_l
@@ -411,7 +429,7 @@ trap 'exit 1;' SIGINT
 chmod 755 "$initdir"
=20
 export initdir hookdirs dracutbasedir dracutmodules drivers \
-    fw_dir drivers_dir debug beverbose no_kernel kernel_only \
+    fw_dir drivers_dir debug no_kernel kernel_only \
     add_drivers mdadmconf lvmconf filesystems \
     use_fstab libdir usrlibdir
=20
diff --git a/dracut-functions b/dracut-functions
index e321dc9..915124a 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -20,6 +20,11 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>=
=2E
 #
=20
+if [[ ! $__DRACUT_LOGGER__ ]]; then
+    . "$dracutbasedir/dracut-logger"
+    dlog_init
+fi
+
 IF_RTLD=3D""
 IF_dynamic=3D""
=20
@@ -61,31 +66,6 @@ is_func() {
     [[ $(type -t $1) =3D "function" ]]=20
 }
=20
-# Log initrd creation.
-if ! [[ $dracutlogfile ]]; then
-    [[ $dracutbasedir =3D /usr/share/dracut ]] && \
-	dracutlogfile=3D/var/log/dracut.log || \
-	dracutlogfile=3D$HOME/dracut.log
-    if [[ -w ${dracutlogfile%/*} ]]; then
-        >>"$dracutlogfile"
-    fi
-fi
-
-dwarning() {
-    echo "W: $@" >&2
-    [[ -w $dracutlogfile ]] && echo $(date) "Warn:" $@ >>"$dracutlogfi=
le"
-}
-
-dinfo() {
-    [[ $beverbose ]] && echo "I: $@" >&2
-    [[ -w $dracutlogfile ]] && echo $(date) "Info:" $@ >>"$dracutlogfi=
le"
-}
-
-derror() {
-    echo "E: $@" >&2
-    [[ -w $dracutlogfile ]] && echo $(date) "Err:" $@ >>"$dracutlogfil=
e"
-}
-
 # Function prints global variables in format name=3Dvalue line by line=
=2E
 # $@ =3D list of global variables' name
 print_vars() {
diff --git a/dracut-logger b/dracut-logger
new file mode 100755
index 0000000..f7ea1b4
--- /dev/null
+++ b/dracut-logger
@@ -0,0 +1,293 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -=
*-
+# ex: ts=3D8 sw=3D4 et filetype=3Dsh
+#
+# logging faciality module for dracut both at build- and boot-time
+#
+# Copyright 2010 Amadeusz =C5=BBo=C5=82nowski <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
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
+__DRACUT_LOGGER__=3D1
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
+#   - TRACE (6)
+#     The TRACE Level designates finer-grained informational events th=
an the
+#     DEBUG.
+#   - DEBUG (5)
+#     The DEBUG Level designates fine-grained informational events tha=
t are most
+#     useful to debug an application.
+#   - INFO (4)
+#     The INFO level designates informational messages that highlight =
the
+#     progress of the application at coarse-grained level.
+#   - WARN (3)
+#     The WARN level designates potentially harmful situations.
+#   - ERROR (2)
+#     The ERROR level designates error events that might still allow t=
he
+#     application to continue running.
+#   - FATAL (1)
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
+# yourself. It's wrapped with above functions.
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
+#   - @var kmsgloglvl - logging level to /dev/kmsg (only for boot-time=
)
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
+# independently for each destination (stderr, syslog, file, kmsg).
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
+#   - @var kmsgloglvl =3D 0 (no logging)
+#   set to 0
+#
+# @warning Function sets global variable @var _maxloglvl for internal =
use. Don't
+# overwrite it.
+dlog_init() {
+    # Skip initialization if it's already done.
+    [ -n "$_maxloglvl" ] && return 0
+
+    local ret=3D0; local errmsg
+
+    [ -z "$stdloglvl" ] && stdloglvl=3D4
+    [ -z "$sysloglvl" ] && sysloglvl=3D0
+    [ -z "$kmsgloglvl" ] && kmsgloglvl=3D0
+
+    if [ -z "$fileloglvl" ]; then
+        [ -w "$logfile" ] && fileloglvl=3D4 || fileloglvl=3D0
+    elif [ $fileloglvl -gt 0 ]; then
+        ! [ -e "$logfile" ] && >"$logfile"
+        if [ -w "$logfile" -a -f "$logfile" ]; then
+            # Mark new run in the log file
+            echo >>"$logfile"
+            if command -v date >/dev/null; then
+                echo "=3D=3D=3D $(date) =3D=3D=3D" >>"$logfile"
+            else
+                echo "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D" >>"$logfile"
+            fi
+            echo >>"$logfile"
+        else
+            # We cannot log to file, so turn this facility off.
+            fileloglvl=3D0
+            ret=3D1
+            errmsg=3D"'$logfile' is not a writable file"
+        fi
+    fi
+
+    if [ $sysloglvl -gt 0 ]; then
+        if ! [ -c /dev/log -a -w /dev/log ] || ! command -v logger >/d=
ev/null
+        then
+            # We cannot log to syslog, so turn this facility off.
+            sysloglvl=3D0
+            ret=3D1
+            errmsg=3D"No '/dev/log' or 'logger' not included for syslo=
g logging"
+        fi
+    fi
+
+    local lvl
+    _maxloglvl=3D0
+    for lvl in $stdloglvl $sysloglvl $fileloglvl; do
+        [ $lvl -gt $_maxloglvl ] && _maxloglvl=3D$lvl
+    done
+
+    [ -n "$errmsg" ] && derror "$errmsg"
+
+    return $ret
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
+## @brief Prints to stderr and/or writes to file, to syslog and/or /de=
v/kmsg
+# given message with given level (priority).
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
+# and/or syslog (with POSIX shell command <tt>logger</tt>) and/or to /=
dev/kmsg.
+# The format is following:
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
+        logger -t "dracut[$$]" -p $(_lvl2syslogpri $lvl) "$msg"
+    fi
+    if [ $lvl -le $fileloglvl -a -w "$logfile" -a -f "$logfile" ]; the=
n
+        echo "$msg" >>"$logfile"
+    fi
+    [ $lvl -le $kmsgloglvl ] && echo "[dracut[$$]] $msg" >/dev/kmsg
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
diff --git a/dracut.conf b/dracut.conf
index c921a00..cca7359 100644
--- a/dracut.conf
+++ b/dracut.conf
@@ -1,5 +1,9 @@
 # Sample dracut config file
=20
+logfile=3D/var/log/dracut.log
+fileloglvl=3D6
+stdloglvl=3D3
+
 # Specific list of dracut modules to use
 #dracutmodules+=3D""
=20
--=20
1.7.4.1
