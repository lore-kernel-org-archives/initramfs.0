From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/6] Move running dhclient on DHCP interfaces into a pre-mount hook.
Date: Wed, 04 Mar 2009 18:56:22 -0800 (PST)
Message-ID: <18dd1a97a9f5902f26ce577932c7ad34c48c8a02.1236221526.git.victor.lowther@gmail.com>
References: <2ffdb552305487acbade501856904918639cc92f.1236221526.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=SCiRUtQl3CiysJY43kj6RZsE5fiGXRbyAgfvrHHiUA8=;
        b=v4E6DWzRlfOw17I5e1icpxKyGE7HBshw1cKeglRqB8p5nsCWLuN5OdB9rjmYmH8LlP
         Eqm45v8Fwtp3kAskpAuDL6k1HQPkvNOFu3/KmaB7CnYiO++1qGEmG6HlmoTM5p7ufuTt
         yPn4pts/d/qRnxBh8qF8ccSKUXU4mxDPOHuNQ=
In-Reply-To: <2ffdb552305487acbade501856904918639cc92f.1236221526.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Static interfaces are still configured on the fly as we add them, but
discussions on the mailing list have suggested that we need to have finer
control over bringing up dhcp interfaces.

The default hook just runs all the requested dhclients in parallel and waits
for them to all return.  If you need something more complicated than this, or
need to have more control over bringing interfaces up, you will probably need
to override some stuff in the 40network hook.
---
 dhclient-script        |    4 +++-
 hooks/run-dhclient.sh  |    7 +++++++
 ifup                   |    5 ++---
 modules/40network.sh   |    1 +
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/dhclient-script b/dhclient-script
index 5a2c66b..dc2d9e1 100755
--- a/dhclient-script
+++ b/dhclient-script
@@ -19,7 +19,9 @@ case $reason in
 	for s in $new_domain_name_servers; do
 	    echo "nameserver $s" >> /etc/resolv.conf
 	done
-	set |grep -e '^new_[a-z_]=' >/net.$interface.dhcpopts
+	set |grep -e '^new_[a-z_]=' |while read line; do
+	    echo "${line%%=*}=\'${line#*=}\'">>/net.$interface.dhcpopts
+	done
 	>/net.$interface.up ;;
     *) ;;
 esac
diff --git a/hooks/kill-dhclient.sh b/hooks/kill-dhclient.sh
old mode 100644
new mode 100755
diff --git a/hooks/run-dhclient.sh b/hooks/run-dhclient.sh
new file mode 100755
index 0000000..fcf890e
--- /dev/null
+++ b/hooks/run-dhclient.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+for i in /net.*.dhcp; do
+    dev=${i#net.}; dev=${i%.dhcp}
+    dhclient -1 -q $dev &
+done
+wait
+    
\ No newline at end of file
diff --git a/ifup b/ifup
index 79607db..83f6522 100755
--- a/ifup
+++ b/ifup
@@ -1,5 +1,4 @@
 #!/bin/sh
->/net.$1
 
 # loopback is always handled the same way
 [ "$1" = "lo" ] && {
@@ -14,13 +13,13 @@ for p in $(cat /proc/cmdline); do
     p=${p#ip=}
     case $p in
 	none|off) exit 0;; # we were told to not configure anything
-	dhcp|on|any) dhclient -nw "$1"; exit 0;; 
+	dhcp|on|any) >/net.$1.dhcp; exit 0;; 
 	bootp|rarp|both) exit 0;; #dunno how to do this
 	*) echo ${ip#ip=} | \
 	    (IFS=':' read client server gw netmask hostname device autoconf
 		if [ -z "$device" -o "$device" = "$1"  ]; then
 		    case $autoconf in
-			dhcp|on|any) dhclient -nw "$1";;
+			dhcp|on|any) >/net.$1.dhcp ;;
 			none|off|'') # do some basic configuration
 			    ip link set $1 up
 			    ip addr add $client/$netmask dev $1
diff --git a/modules/40network.sh b/modules/40network.sh
index 59f523a..cee74b4 100755
--- a/modules/40network.sh
+++ b/modules/40network.sh
@@ -5,3 +5,4 @@ inst "$dsrc/dhclient-script" "/sbin/dhclient-script"
 instmods =drivers/net ecb arc4
 inst_rules 60-net.rules
 inst_hook pre-pivot 10 "$dsrc/hooks/kill-dhclient.sh"
+inst_hook pre-mount 70 "$dsrc/hooks/run-dhclient.sh"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
