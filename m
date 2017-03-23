From: olivier.lahaye1-GANU6spQydw@public.gmane.org
Subject: dracut network module uses a primitive dhclient-script.sh that
 doesn't honnor dhclient-enter-hooks and dhclient-exit-hooks. patch provided
Date: Thu, 23 Mar 2017 18:03:46 +0100 (CET)
Message-ID: <1664645363.8827270.1490288626453.JavaMail.root@spooler6-g27.priv.proxad.net>
References: <944691688.8818766.1490288509398.JavaMail.root@spooler6-g27.priv.proxad.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <944691688.8818766.1490288509398.JavaMail.root-NPLbsSYf/7dsFmKuirFwRhh1pbbyJDp15NbjCUgZEJk@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

The network module doesn't honnor the enter and exit hooks.
Thus I'm unable to retrieve specific dhcp fields.
My workaround is to overwrite it with my patched version, but it's ugly.

--- 40network/dhclient-script.sh        2016-11-11 19:27:27.000000000 +0100
+++ 39systemimager/dhclient-script.sh   2017-03-21 17:49:47.000000000 +0100
@@ -7,6 +7,17 @@
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 type ip_to_var >/dev/null 2>&1 || . /lib/net-lib.sh
 
+# Invoke the local dhcp client enter hooks, if they exist.
+if [ -x /etc/dhcp/dhclient-enter-hooks ]; then
+    exit_status=0
+    . /etc/dhclient-enter-hooks
+    # allow the local script to abort processing of this state
+    # local script must set exit_status variable to nonzero.
+    if [ $exit_status -ne 0 ]; then
+        exit $exit_status
+    fi
+fi
+
 # We already need a set netif here
 netif=$interface
 
@@ -239,4 +250,9 @@
     *) echo "dhcp: $reason";;
 esac
 
+# Invokes the local dhcp client exit hooks, if any.
+if [ -x /etc/dhcp/dhclient-exit-hooks ]; then
+  . /etc/dhcp/dhclient-exit-hooks
+fi
+
 exit 0
-- 
   Olivier LAHAYE
