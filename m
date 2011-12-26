From: Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 1/3] Handle upper case MAC addresses in ifname option
Date: Tue, 27 Dec 2011 09:08:27 +1100
Message-ID: <20111226220903.564739340@samba.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=udev_mac_lowercase.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

While the documentation states that ifname MAC addresses must be
lower case, we silently accept upper case ones and fail later on
when udev doesn't rename the device.

Instead of adding sanity checking on the MAC address just convert
it to lower case and remove the requirement completely.

---

Index: dracut/modules.d/40network/parse-ifname.sh
===================================================================
--- dracut.orig/modules.d/40network/parse-ifname.sh	2011-12-27 09:01:08.000000000 +1100
+++ dracut/modules.d/40network/parse-ifname.sh	2011-12-27 09:02:05.420745541 +1100
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
Index: dracut/dracut.cmdline.7.xml
===================================================================
--- dracut.orig/dracut.cmdline.7.xml	2011-12-27 09:01:11.507776290 +1100
+++ dracut/dracut.cmdline.7.xml	2011-12-27 09:02:05.424745613 +1100
@@ -464,7 +464,6 @@ This parameter can be specified multiple
           <term><envar>ifname=</envar><replaceable>&lt;interface&gt;</replaceable>:<replaceable>&lt;MAC&gt;</replaceable></term>
           <listitem>
             <para>Assign network device name &lt;interface&gt; (ie eth0) to the NIC with MAC &lt;MAC&gt;.
-Note letters in the MAC-address must be lowercase!
 <remark>Note: If you use this option you <emphasis remap="B">must</emphasis> specify an ifname= argument for all interfaces used in ip= or fcoe= arguments.</remark>
 This parameter can be specified multiple times.</para>
           </listitem>

