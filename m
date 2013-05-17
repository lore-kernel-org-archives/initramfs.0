From: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>
Subject: [PATCH 1/2] [40network] Add variable parsing framework for network related variables
Date: Fri, 17 May 2013 18:17:19 +0200
Message-ID: <1368807440-9207-1-git-send-email-devurandom@gmx.net>
References: <1365694762-7806-1-git-send-email-devurandom@gmx.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365694762-7806-1-git-send-email-devurandom-hi6Y0CQ0nG0@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dennis Schridde <devurandom-hi6Y0CQ0nG0@public.gmane.org>

* Provides net_add_parse_vars function to install net_parse_vars hook when an interface comes online
* Provides net_parse_vars function to search and replace network related variables in a string
---
 modules.d/40network/net-lib.sh | 56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
index f9b461b..f006874 100644
--- a/modules.d/40network/net-lib.sh
+++ b/modules.d/40network/net-lib.sh
@@ -366,3 +366,59 @@ linkup() {
      && wait_for_if_up $1 2>/dev/null
 }
 
+# net_parse_vars STRING IFUP
+# parse vars in STRING
+# IFUP may contain the interface that came online, triggering this hook
+net_parse_vars() {
+	local cur="$1" ifup="$2" var val iface
+
+	var="${cur#*%\{}"
+	var="${var%%\}*}"
+
+	while [ "${var}" != "${cur}" ] ; do
+		case "${var}" in
+			mac.*)
+				iface="${var##mac.}"
+				[ "${ifup}" = "${iface}" ] || exit
+				val="$(ip link show dev "${iface}" | sed -nre '/ether/s/^.*ether ([0-9a-f:]*) .*$/\1/' -e 's/://')"
+				;;
+			hostname)
+				val="$(hostname)"
+				[ "${val}" = '(none)' ] && die 'No hostname (yet)'
+				;;
+			*)
+				die "Unsupported cmdline variable '${var}'"
+				;;
+		esac
+
+		cur="$(echo "${cur}" | sed "s/%{${var}}/${val}/")"
+		unset val
+
+		var="${cur#*%\{}"
+		var="${var%%\}*}"
+	done
+
+	echo "${cur}"
+}
+
+# net_add_parse_vars STRING LIB FUNCTION
+# add initqueue/online hook to parse vars in STRING
+# execute FUNCTION from LIB afterwards
+net_add_parse_vars() {
+	local string="$1" lib="$2" func="$3" jobid="$(cat /proc/sys/kernel/random/uuid)"
+
+	cat <<- EOF > "${hookdir}"/initqueue/online/40network.parse."${jobid}".sh
+		. /lib/"${lib}".sh
+
+		string="\$(net_parse_vars "${string}" "\$@")"
+		${func} "\${string}"
+		unset string
+
+		> /tmp/40network.parse.finished."${jobid}"
+	EOF
+
+	cat <<- EOF > "${hookdir}"/initqueue/finished/40network.parse.wait."${jobid}".sh
+		echo "Waiting for nfs_parse_vars (${jobid}) to complete ..."
+		[ -f /tmp/40network.parse.finished."${jobid}" ]
+	EOF
+}
-- 
1.8.2.1
