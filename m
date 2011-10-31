From: Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] Handle upper case MAC addresses in ifname option
Date: Mon, 31 Oct 2011 22:28:58 +1100
Message-ID: <20111031222858.63cdc814@kryten>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


While the documentation states that ifname MAC addresses must be
lower case, we silently accept upper case ones and fail later on
when udev doesn't rename the device.

Instead of adding sanity checking on the MAC address just convert
it to lower case and remove the requirement completely.

---

Index: dracut/modules.d/40network/parse-ifname.sh
===================================================================
--- dracut.orig/modules.d/40network/parse-ifname.sh	2011-10-31 21:35:17.107601600 +1100
+++ dracut/modules.d/40network/parse-ifname.sh	2011-10-31 21:35:18.199621240 +1100
@@ -25,7 +25,8 @@ parse_ifname_opts() {
     case $# in
         7)
             ifname_if=$1
-            ifname_mac=$2:$3:$4:$5:$6:$7
+            # udev requires MAC addresses to be lower case
+            ifname_mac=`echo $2:$3:$4:$5:$6:$7 | tr '[:upper:]' '[:lower:]'`
             ;;
         *)
             die "Invalid arguments for ifname="
Index: dracut/dracut.kernel.7.xml
===================================================================
--- dracut.orig/dracut.kernel.7.xml	2011-10-31 21:58:49.353246994 +1100
+++ dracut/dracut.kernel.7.xml	2011-10-31 22:05:47.840887387 +1100
@@ -456,7 +456,6 @@ This parameter can be specified multiple
           <term><envar>ifname=</envar><replaceable>&lt;interface&gt;</replaceable>:<replaceable>&lt;MAC&gt;</replaceable></term>
           <listitem>
             <para>Assign network device name &lt;interface&gt; (ie eth0) to the NIC with MAC &lt;MAC&gt;.
-Note letters in the MAC-address must be lowercase!
 <remark>Note: If you use this option you <emphasis remap="B">must</emphasis> specify an ifname= argument for all interfaces used in ip= or fcoe= arguments.</remark>
 This parameter can be specified multiple times.</para>
           </listitem>
