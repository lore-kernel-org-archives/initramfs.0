From: Florian Feldhaus <florian.feldhaus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] fix =?utf-8?b?Z2V0X3ZpZA==?= to return correct value for vlan ids larger than 255
Date: Wed, 6 Feb 2013 15:47:28 +0000 (UTC)
Message-ID: <loom.20130206T164028-867@post.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The function get_vid in the ifup.sh script in 40network uses the return
statement to return the vlan id, but exit values greater than 255 return an exit
code modulo 256 (see [1]). Thus vlan IDs greater than 255 always fail. The
attached patch fixes the issue.

[1] http://tldp.org/LDP/abs/html/exitcodes.html#AEN23444

[PATCH]
diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 6c3133e..1164af9 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -219,10 +219,10 @@ fi
 get_vid() {
     case "$1" in
     vlan*)
-        return ${1#vlan}
+        echo ${1#vlan}
         ;;
     *.*)
-        return ${1##*.}
+        echo ${1##*.}
         ;;
     esac
 }
@@ -234,7 +234,7 @@ if [ "$netif" = "$vlanname" ] && [ ! -e
/tmp/net.$vlanname.up ]; then
     else
         linkup "$phydevice"
     fi
-    ip link add dev "$vlanname" link "$phydevice" type vlan id "$(get_vid
$vlanname; echo $?)"
+    ip link add dev "$vlanname" link "$phydevice" type vlan id "$(get_vid
$vlanname)"
 fi
 
 # setup nameserver
[END]
