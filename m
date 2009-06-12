From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [RFC PATCH 5/5] iscsiroot
Date: Fri, 12 Jun 2009 17:12:13 +0200
Message-ID: <4A32704D.2050402@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

---
 modules.d/95iscsi/iscsi-netroot.sh   |   13 ---
 modules.d/95iscsi/iscsiroot          |  186 ++++++++++++++++++---------------
 modules.d/95iscsi/install            |    1 -
 modules.d/95iscsi/parse-iscsiroot.sh |   93 ++++++++++++-----
 4 files changed, 169 insertions(+), 121 deletions(-)

diff --git a/modules.d/95iscsi/install b/modules.d/95iscsi/install
index cd4a3ca..613c752 100755
--- a/modules.d/95iscsi/install
+++ b/modules.d/95iscsi/install
@@ -4,6 +4,5 @@ inst iscsistart
 inst hostname
 inst iscsi-iname
 inst_hook cmdline 90 "$moddir/parse-iscsiroot.sh"
-inst_hook netroot 90 "$moddir/iscsi-netroot.sh"
 inst "$moddir/iscsiroot" "/sbin/iscsiroot"
 instmods iscsi_tcp crc32c
diff --git a/modules.d/95iscsi/iscsi-netroot.sh b/modules.d/95iscsi/iscsi-netroot.sh
deleted file mode 100755
index 4f02239..0000000
--- a/modules.d/95iscsi/iscsi-netroot.sh
+++ /dev/null
@@ -1,13 +0,0 @@
-if [ "$root" = "dhcp" ]; then
-    if [ -n "$new_root_path" -a -z "${new_root_path%%iscsi:*}" ]; then
-	root="$new_root_path"
-    fi
-fi
-
-if [ -z "${root%iscsi:*}" ]; then
-    handler=/sbin/iscsiroot
-fi
-
-if getarg iscsiroot >/dev/null; then
-    handler=/sbin/iscsiroot
-fi
diff --git a/modules.d/95iscsi/iscsiroot b/modules.d/95iscsi/iscsiroot
index 8e20fda..b042caf 100755
--- a/modules.d/95iscsi/iscsiroot
+++ b/modules.d/95iscsi/iscsiroot
@@ -1,108 +1,124 @@
 #!/bin/sh
+#
+# This implementation is incomplete: Discovery mode is not implemented and
+# the argument handling doesn't follow currently agreed formats. This is mainly
+# because rfc4173 does not say anything about iscsi_initiator but open-iscsi's 
+# iscsistart needs this.
+#
 
 . /lib/dracut-lib
 
 PATH=$PATH:/sbin:/usr/sbin
 
-# XXX needs error handling like ifup/dhclient-script
-
 if getarg rdnetdebug; then
     exec > /tmp/iscsiroot.$1.$$.out
     exec 2>> /tmp/iscsiroot.$1.$$.out
     set -x
 fi
 
-# read static conf settings
-for conf in conf/conf.d/*; do
-	[ -f ${conf} ] && . ${conf}
-done
+# Huh? Empty $1?
+[ -z "$1" ] && exit 1
+
+# Huh? Empty $2?
+[ -z "$2" ] && exit 1
 
 # root is in the form root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+# or root=iscsi:iscsi_firmware
 netif="$1"
 root="$2"
 
+# read static conf settings
+# XXX Where are these from?
+for conf in conf/conf.d/*; do
+        [ -f ${conf} ] && . ${conf}
+done
+
+# If it's not iscsi we don't continue
+[ "${root%%:*}" = "iscsi" ] || exit 1
+
+# XXX modprobe crc32c should go in the cmdline parser, but I haven't yet
+# figured out a way how to check whether this is built-in or not
+modprobe crc32c
 
-if [ $root = ${root#iscsi:} ]; then
-	iroot=$(getarg iscsiroot)
-else
-	iroot=${root#iscsi:}
+if getarg iscsi_firmware ; then
+    echo iscsistart -b 
+    exit 0
 fi
 
-if getarg iscsi_firmware >/dev/null; then
-	modprobe iscsi_tcp
-	modprobe crc32c
-	iscsistart -b
-else
-	# override conf settings by command line options
-	arg=$(getarg iscsi_initiator)
-	[ -n "$arg" ] && iscsi_initiator=$arg
-	arg=$(getarg iscsi_initiator)
-	[ -n "$arg" ] && iscsi_target_name=$arg
-	arg=$(getarg iscsi_target_ip)
-	[ -n "$arg" ] && iscsi_target_ip=$arg
-	arg=$(getarg iscsi_target_port)
-	[ -n "$arg" ] && iscsi_target_port=$arg
-	arg=$(getarg iscsi_target_group)
-	[ -n "$arg" ] && iscsi_target_group=$arg
-	arg=$(getarg iscsi_username)
-	[ -n "$arg" ] && iscsi_username=$arg
-	arg=$(getarg iscsi_password)
-	[ -n "$arg" ] && iscsi_password=$arg
-	arg=$(getarg iscsi_in_username)
-	[ -n "$arg" ] && iscsi_in_username=$arg
-	arg=$(getarg iscsi_in_password)
-	[ -n "$arg" ] && iscsi_in_password=$arg
-
-
-	# override conf/commandline options by dhcp root_path
-	OLDIFS="$IFS"
-	IFS=:
-	set $iroot
-	iscsi_target_ip=$1; shift
-	iscsi_protocol=$1; shift # ignored
-	iscsi_target_port=$1; shift
-	iscsi_lun=$1; shift
-	iscsi_target_name=$*
-	IFS="$OLDIFS"
-
-	getarg ro && iscsirw=ro
-	getarg rw && iscsirw=rw
-	fsopts=${fsopts+$fsopts,}${iscsirw}
-
-	modprobe iscsi_tcp
-	modprobe crc32c
-
-	if [ -z $iscsi_initiator ]; then
-		[ -f /etc/initiatorname.iscsi ] && . /etc/initiatorname.iscsi
-		[ -f /etc/iscsi/initiatorname.iscsi ] && . /etc/iscsi/initiatorname.iscsi
-		iscsi_initiator=$InitiatorName
-	fi
-
-	if [ -z $iscsi_target_port ]; then
-		iscsi_target_port=3260
-	fi
-
-	if [ -z $iscsi_target_group ]; then
-		iscsi_target_group=1
-	fi
-
-	if [ -z $iscsi_initiator ]; then
-		iscsi_initiator=$(iscsi-iname)
-	fi
-
-	echo "InitiatorName='$iscsi_initiator'" > /dev/.initiatorname.iscsi
-
-	# FIXME $iscsi_lun?? $iscsi_protocol??
-
-	iscsistart -i $iscsi_initiator -t $iscsi_target_name	\
-		   -g $iscsi_target_group -a $iscsi_target_ip	\
-		   -p $iscsi_target_port \
-		   ${iscsi_username+-u $iscsi_username} \
-	           ${iscsi_password+-w $iscsi_password} \
-	           ${iscsi_in_username+-U $iscsi_in_username} \
-	           ${iscsi_in_password+-W $iscsi_in_password}
-	# now we have a root filesystem somewhere in /dev/sda*
-	# let the normal block handler handle root=
+# override conf settings by command line options
+arg=$(getarg iscsi_initiator)
+[ -n "$arg" ] && iscsi_initiator=$arg
+arg=$(getarg iscsi_target_name)
+[ -n "$arg" ] && iscsi_target_name=$arg
+arg=$(getarg iscsi_target_ip)
+[ -n "$arg" ] && iscsi_target_ip=$arg
+arg=$(getarg iscsi_target_port)
+[ -n "$arg" ] && iscsi_target_port=$arg
+arg=$(getarg iscsi_target_group)
+[ -n "$arg" ] && iscsi_target_group=$arg
+arg=$(getarg iscsi_username)
+[ -n "$arg" ] && iscsi_username=$arg
+arg=$(getarg iscsi_password)
+[ -n "$arg" ] && iscsi_password=$arg
+arg=$(getarg iscsi_in_username)
+[ -n "$arg" ] && iscsi_in_username=$arg
+arg=$(getarg iscsi_in_password)
+[ -n "$arg" ] && iscsi_in_password=$arg
+
+# override conf/commandline options by dhcp root_path
+# FIXME this assumes that all values have been provided
+iroot=$root
+OLDIFS="$IFS"
+IFS=:
+set $iroot
+iscsi_target_ip=$1; shift
+iscsi_protocol=$1; shift # ignored
+iscsi_target_port=$1; shift
+iscsi_lun=$1; shift
+iscsi_target_name=$*
+IFS="$OLDIFS"
+
+# XXX is this needed?
+getarg ro && iscsirw=ro
+getarg rw && iscsirw=rw
+fsopts=${fsopts+$fsopts,}${iscsirw}
+	
+if [ -z $iscsi_initiator ]; then
+    # XXX Where are these from?
+    [ -f /etc/initiatorname.iscsi ] && . /etc/initiatorname.iscsi
+    [ -f /etc/iscsi/initiatorname.iscsi ] && . /etc/iscsi/initiatorname.iscsi
+    iscsi_initiator=$InitiatorName
+
+    # XXX rfc3720 says 'SCSI Initiator Name: The iSCSI Initiator Name specifies
+    # the worldwide unique name of the initiator.' Could we use hostname/ip
+    # if missing?
 fi
 
+if [ -z $iscsi_target_port ]; then
+    iscsi_target_port=3260
+fi
+
+if [ -z $iscsi_target_group ]; then
+    iscsi_target_group=1
+fi
+
+if [ -z $iscsi_initiator ]; then
+    # XXX is this correct?
+    iscsi_initiator=$(iscsi-iname)
+fi
+
+echo "InitiatorName='$iscsi_initiator'" > /dev/.initiatorname.iscsi
+
+# FIXME $iscsi_lun?? $iscsi_protocol??
+
+iscsistart -i $iscsi_initiator -t $iscsi_target_name	\
+    -g $iscsi_target_group -a $iscsi_target_ip	\
+    -p $iscsi_target_port \
+    ${iscsi_username+-u $iscsi_username} \
+    ${iscsi_password+-w $iscsi_password} \
+    ${iscsi_in_username+-U $iscsi_in_username} \
+    ${iscsi_in_password+-W $iscsi_in_password}
+
+# now we have a root filesystem somewhere in /dev/sda*
+# let the normal block handlers should mount root
 exit 0
diff --git a/modules.d/95iscsi/parse-iscsiroot.sh b/modules.d/95iscsi/parse-iscsiroot.sh
index 4115248..1ba4277 100755
--- a/modules.d/95iscsi/parse-iscsiroot.sh
+++ b/modules.d/95iscsi/parse-iscsiroot.sh
@@ -1,32 +1,75 @@
-# XXX actually we could, if we move to root=XXX and netroot=XXX, then
-# you could do root=LABEL=/ iscsiroot=XXX, or netroot=iscsi:XXX
-#
+#!/bin/sh
 #
 # Preferred format:
-#       root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+#	root=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+#	[root=*] netroot=iscsi:[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
 #
 # Legacy formats:
-#       iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
-#	root=dhcp iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
-#	root=iscsi iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
-#       root=??? iscsi_initiator= iscsi_target_name= iscsi_target_ip= iscsi_target_port= iscsi_target_group= iscsi_username= iscsi_password= iscsi_in_username= iscsi_in_password=
-#       root=??? iscsi_firmware
-
-case "$root" in
-    iscsi|dhcp|'')
-	if getarg iscsiroot= > /dev/null; then
-	    root=iscsi:$(getarg iscsiroot=)
-	fi
-	;;
-esac
-
-if [ "${root%%:*}" = "iscsi" ]; then
-    # XXX validate options here?
-    # XXX generate udev rules?
-    rootok=1
-    netroot=iscsi
+#	[net]root=[iscsi] iscsiroot=[<servername>]:[<protocol>]:[<port>]:[<LUN>]:<targetname>
+# 	[net]root=[iscsi] iscsi_firmware
+#
+# root= takes precedence over netroot= if root=iscsi[...]
+#
+
+# Don't continue if root is ok
+[ -n "$rootok" ] && return
+
+# This script is sourced, so root should be set. But let's be paranoid
+[ -z "$root" ] && root=$(getarg root=)
+[ -z "$netroot" ] && netroot=$(getarg netroot=)
+[ -z "$iscsiroot" ] && iscsiroot=$(getarg iscsiroot=)
+[ -z "$iscsi_firmware" ] && getarg iscsi_firmware && iscsi_firmware="1"
+
+[ -n "$iscsiroot" ] && [ -n "$iscsi_firmware" ] && die "Mixing iscsiroot and iscsi_firmware is dangerous"
+
+# Root takes precedence over netroot
+if [ "${root%%:*}" = "iscsi" ] ; then
+    if [ -n "$netroot" ] ; then
+	echo "Warning: root takes precedence over netroot. Ignoring netroot"
+
+    fi
+    netroot=$root
+fi
+
+# If it's not empty or iscsi we don't continue
+[ -z "$netroot" ] || [ "${netroot%%:*}" = "iscsi" ] || return
+
+if [ -n "$iscsiroot" ] ; then
+    [ -z "$netroot" ]  && netroot=$root
+
+    # @deprecated
+    echo "Warning: Argument isciroot is deprecated and might be removed in a future"
+    echo "release. See http://apps.sourceforge.net/trac/dracut/wiki/commandline for"
+    echo "more information."
+
+    # Accept iscsiroot argument?
+    [ -z "$netroot" ] || [ "$netroot" = "iscsi" ] || \
+	die "Argument iscsiroot only accepted for empty root= or [net]root=iscsi"
+
+    # Override root with iscsiroot content?
+    [ -z "$netroot" ] || [ "$netroot" = "iscsi" ] && netroot=iscsi:$iscsiroot
+fi
+
+# iscsi_firmware does not need argument checking
+if [ -n "$iscsi_firmware" ] ; then
+    netroot=${netroot:-iscsi}
 fi
 
-if getarg iscsiroot; then
-	netroot=iscsi
+# If it's not iscsi we don't continue
+[ "${netroot%%:*}" = "iscsi" ] || return
+
+# Check required arguments. there's only one, but it's at the end
+if [ -z "$iscsi_firmware" ] ; then
+    case "${netroot##iscsi:*:*:*:*:}" in
+	$netroot|'') die "Argument targetname for iscsiroot is missing";;
+    esac
 fi
+
+# ISCSI actually supported?
+[ -e /sys/devices/virtual/iscsi_transport ] || modprobe iscsi_tcp || die "iscsiroot requested but kernel/initrd does not support iscsi"
+
+# Done, all good!
+rootok=1
+
+# Shut up init error check
+[ -z "$root" ] && root="iscsi"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
