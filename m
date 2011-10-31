From: Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] server-id in ip= is not optional
Date: Mon, 31 Oct 2011 22:29:47 +1100
Message-ID: <20111031222947.5ddc60c0@kryten>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


The documentation suggests that server-id is an optional argument
but ip_to_var fails if it is not specified. Fix the documentation.

---

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 7cd7b81..990797e 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -444,9 +444,9 @@ with a valid DHCP root-path.</para>
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
