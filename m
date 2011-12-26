From: Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 3/3] ip= server-id should be server-IP
Date: Tue, 27 Dec 2011 09:08:29 +1100
Message-ID: <20111226220903.738439469@samba.org>
References: <20111226220903.564739340@samba.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=fix_server_id.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

 From looking at the code it seems like server-id should really
be named server-IP.

---

Index: dracut/dracut.cmdline.7.xml
===================================================================
--- dracut.orig/dracut.cmdline.7.xml	2011-12-27 09:02:31.321211186 +1100
+++ dracut/dracut.cmdline.7.xml	2011-12-27 09:02:54.261623619 +1100
@@ -453,7 +453,7 @@ with a valid DHCP root-path.</para>
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
--- dracut.orig/modules.d/40network/parse-ip-opts.sh	2011-12-27 09:01:07.000000000 +1100
+++ dracut/modules.d/40network/parse-ip-opts.sh	2011-12-27 09:02:54.261623619 +1100
@@ -7,7 +7,7 @@
 #
 #       ip=<interface>:[dhcp|on|any]
 #
-#       ip=<client-IP-number>:<server-id>:<gateway-IP-number>:<netmask>:<client-hostname>:<interface>:[dhcp|on|any|none|off]
+#       ip=<client-IP-number>:<server-IP-number>:<gateway-IP-number>:<netmask>:<client-hostname>:<interface>:[dhcp|on|any|none|off]
 #
 # When supplying more than only ip= line, <interface> is mandatory and
 # bootdev= must contain the name of the primary interface to use for

