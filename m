From: Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] ip= server-id should be server-IP
Date: Mon, 31 Oct 2011 22:30:55 +1100
Message-ID: <20111031223055.42fb2d6f@kryten>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


From looking at the code it seems like server-id should really
be named server-IP.

---

Index: dracut/dracut.kernel.7.xml
===================================================================
--- dracut.orig/dracut.kernel.7.xml	2011-10-31 21:12:55.371535209 +1100
+++ dracut/dracut.kernel.7.xml	2011-10-31 21:13:32.100192208 +1100
@@ -445,7 +445,7 @@ with a valid DHCP root-path.</para>
         </varlistentry>
         <varlistentry>
           <term><envar>ip=</envar><replaceable>&lt;client-IP&gt;</replaceable>:
-              <replaceable>&lt;server-id&gt;</replaceable>
+              <replaceable>&lt;server-IP&gt;</replaceable>
             :<replaceable>&lt;gateway-IP&gt;</replaceable>:<replaceable>&lt;netmask&gt;</replaceable>:<replaceable>&lt;client_hostname&gt;</replaceable>:<replaceable>&lt;interface&gt;</replaceable>:<replaceable>{none|off}</replaceable></term>
           <listitem>
             <para>explicit network configuration. If you want do define a IPv6 address, put it in brackets (e.g. [2001:DB8::1]).
Index: dracut/modules.d/40network/parse-ip-opts.sh
===================================================================
--- dracut.orig/modules.d/40network/parse-ip-opts.sh	2011-10-31 21:12:59.875615777 +1100
+++ dracut/modules.d/40network/parse-ip-opts.sh	2011-10-31 21:13:38.132300111 +1100
@@ -7,7 +7,7 @@
 #
 #       ip=<interface>:[dhcp|on|any]
 #
-#       ip=<client-IP-number>:<server-id>:<gateway-IP-number>:<netmask>:<client-hostname>:<interface>:[dhcp|on|any|none|off]
+#       ip=<client-IP-number>:<server-IP-number>:<gateway-IP-number>:<netmask>:<client-hostname>:<interface>:[dhcp|on|any|none|off]
 #
 # When supplying more than only ip= line, <interface> is mandatory and
 # bootdev= must contain the name of the primary interface to use for
