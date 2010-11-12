From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 3/3] dracut.kernel.7: updated to latest changes in 90crypt
Date: Fri, 12 Nov 2010 10:21:50 +0100
Message-ID: <1289553710-7568-3-git-send-email-aidecoe@aidecoe.name>
References: <1289553710-7568-1-git-send-email-aidecoe@aidecoe.name>
 <1289553710-7568-2-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1289553710-7568-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.kernel.7.xml |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 7f54e9e..bf517ea 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -318,25 +318,20 @@ This parameter can be specified multiple times.</para>
       </variablelist>
     </refsect2>
     <refsect2>
-      <title>crypt LUKS - experimental removable keys support</title>
-      <para>works only when plymouth module is not included</para>
+      <title>crypto LUKS - key on removable device support</title>
       <variablelist>
         <varlistentry>
           <term>
-            <envar>rd.luks.keypath=</envar>
-            <replaceable>&lt;path to keyfile&gt;</replaceable>
+            <envar>rd.luks.key=</envar>
+	    <replaceable>&lt;keypath&gt;:&lt;keydev&gt;:&lt;luksdev&gt;</replaceable>
           </term>
           <listitem>
-            <para>path to keyfile inside remove device filesystem</para>
-          </listitem>
-        </varlistentry>
-        <varlistentry>
-          <term>
-            <envar>rd.luks.keydev.uuid=</envar>
-            <replaceable>&lt;rem. device uuid&gt;</replaceable>
-          </term>
-          <listitem>
-            <para>UUID of removalbe device storing keyfile; UUID doesn&apos;t have to be exact just like for <envar>rd.luks.uuid</envar></para>
+		  <para><replaceable>keypath</replaceable> is a path to key file to look for. It's REQUIRED.</para>
+		  <para><replaceable>keydev</replaceable> is a device on which key file resides. It might be kernel name of devices (should start with "/dev/"), UUID (prefixed with "UUID=") or label (prefix with "LABEL=").  You don't have to specify full UUID. Just its beginning will suffice, even if its ambiguous. All matching devices will be probed. This parameter is recommended, but not required. If not present, all block devices will be probed, which may significantly increase boot time.</para>
+		  <para>If <replaceable>luksdev</replaceable> is given, the specified key will only be applied for that LUKS device. Possible values are the same as for <replaceable>keydev</replaceable>. Unless you have several LUKS devices, you don't have to specify this parameter.</para>
+		  <para>The simplest usage is:</para>
+		  <programlisting>rd.luks.key=/foo/bar.key</programlisting>
+		  <para>As you see, you can skip colons in such case.</para>
           </listitem>
         </varlistentry>
       </variablelist>
-- 
1.7.3.2
