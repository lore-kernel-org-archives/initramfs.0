From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/5] Update scripts to make things a little easier to read
Date: Wed, 25 Feb 2009 18:42:07 -0800 (PST)
Message-ID: <9d5f39ec1bf08727bae5b1165238878d4fbd15a1.1235615754.git.victor.lowther@gmail.com>
References: <cd38313900d1086b09e2d4279e2fed2df5bf46ec.1235615754.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=NomxB3+Rgf5YnnWMhKY3M1pgkTgHti93e8t5nj6ivyw=;
        b=KlV8aa+SGSWmi9yxGfTgThkPuoeUR2YatZQ1Jrv8TJxifgh8OBNr5WUIx+P1RzTemE
         m0bOdrRs2b73bixhmnEre7IFdW1g491kEtij+tmKz5eD5AF6Lm7TQ8BBykqmw3t/qIaG
         /iqwhYS/7c1evhnfk+bfuEqJClfh4hfj5jwb8=
In-Reply-To: <cd38313900d1086b09e2d4279e2fed2df5bf46ec.1235615754.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dhclient-script |    8 ++++----
 ifup            |   26 ++++++++++++++++++++------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/dhclient-script b/dhclient-script
index 0db5921..dce9878 100755
--- a/dhclient-script
+++ b/dhclient-script
@@ -16,9 +16,9 @@ case $reason in
 	elif [ "$new_domain_name" ]; then
 	    echo "search $new_domain_name" >> /etc/resolv.conf
 	fi
-	(   IFS=",";
-	    for s in $new_domain_name_servers; do
-		echo "nameserver $s" >> /etc/resolv.conf
-	    done ) ;;
+	for s in $new_domain_name_servers; do
+	    echo "nameserver $s" >> /etc/resolv.conf
+	done
+	>/net.$interface.up ;;
     *) ;;
 esac
diff --git a/ifup b/ifup
index cf5828c..79607db 100755
--- a/ifup
+++ b/ifup
@@ -1,5 +1,5 @@
 #!/bin/sh
-echo "$*" >>/dev/net-interfaces-found
+>/net.$1
 
 # loopback is always handled the same way
 [ "$1" = "lo" ] && {
@@ -9,12 +9,26 @@ echo "$*" >>/dev/net-interfaces-found
 }
 
 # spin through the kernel command line, looking for ip= lines
-while read p; do
+for p in $(cat /proc/cmdline); do
+    [ "${p%ip=*}" ] || continue
+    p=${p#ip=}
     case $p in
-	'ip=none'|'ip=off') exit 0;; # we were told to not configure anything
-	'ip=dhcp'|'ip=on'|'ip=any') dhclient -nw "$1"; exit 0;; 
-	'ip=bootp'|'ip=rarp'|'ip=both') exit 0;; #dunno how to do this
-	ip=*) exit 0;; #to be written
+	none|off) exit 0;; # we were told to not configure anything
+	dhcp|on|any) dhclient -nw "$1"; exit 0;; 
+	bootp|rarp|both) exit 0;; #dunno how to do this
+	*) echo ${ip#ip=} | \
+	    (IFS=':' read client server gw netmask hostname device autoconf
+		if [ -z "$device" -o "$device" = "$1"  ]; then
+		    case $autoconf in
+			dhcp|on|any) dhclient -nw "$1";;
+			none|off|'') # do some basic configuration
+			    ip link set $1 up
+			    ip addr add $client/$netmask dev $1
+			    [ "$gw" ] && ip route add default via $gw dev $1
+			    >/net.$1.up ;;
+		    esac
+		fi
+		) ;;
 	*) continue;;
     esac
 done
\ No newline at end of file
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
