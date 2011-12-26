From: Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 2/3] server-id in ip= is not optional
Date: Tue, 27 Dec 2011 09:08:28 +1100
Message-ID: <20111226220903.656046366@samba.org>
References: <20111226220903.564739340@samba.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=ip_not_optional.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The documentation suggests that server-id is an optional argument
but ip_to_var fails if it is not specified. Fix the documentation.

---

Index: dracut/dracut.cmdline.7.xml
===================================================================
--- dracut.orig/dracut.cmdline.7.xml	2011-12-27 09:02:05.424745613 +1100
+++ dracut/dracut.cmdline.7.xml	2011-12-27 09:02:31.321211186 +1100
@@ -452,9 +452,9 @@ with a valid DHCP root-path.</para>
           </listitem>
         </varlistentry>
         <varlistentry>
-          <term><envar>ip=</envar><replaceable>&lt;client-IP&gt;</replaceable>:<optional>
+          <term><envar>ip=</envar><replaceable>&lt;client-IP&gt;</replaceable>:
               <replaceable>&lt;server-id&gt;</replaceable>
-            </optional>:<replaceable>&lt;gateway-IP&gt;</replaceable>:<replaceable>&lt;netmask&gt;</replaceable>:<replaceable>&lt;client_hostname&gt;</replaceable>:<replaceable>&lt;interface&gt;</replaceable>:<replaceable>{none|off}</replaceable></term>
+            :<replaceable>&lt;gateway-IP&gt;</replaceable>:<replaceable>&lt;netmask&gt;</replaceable>:<replaceable>&lt;client_hostname&gt;</replaceable>:<replaceable>&lt;interface&gt;</replaceable>:<replaceable>{none|off}</replaceable></term>
           <listitem>
             <para>explicit network configuration. If you want do define a IPv6 address, put it in brackets (e.g. [2001:DB8::1]).
 This parameter can be specified multiple times.</para>

