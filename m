From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut.kernel.7: crypto LUKS - info about gpg-encrypted keys
Date: Tue, 10 May 2011 19:44:57 +0200
Message-ID: <1305049497-31701-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.kernel.7.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 1de4df1..a277c74 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -317,7 +317,7 @@ This parameter can be specified multiple times.</para>
             <envar>rd.luks.key=</envar><replaceable>&lt;keypath&gt;:&lt;keydev&gt;:&lt;luksdev&gt;</replaceable>
           </term>
           <listitem>
-            <para><replaceable>keypath</replaceable> is a path to key file to look for. It&apos;s REQUIRED.</para>
+            <para><replaceable>keypath</replaceable> is a path to key file to look for. It&apos;s REQUIRED. When <replaceable>keypath</replaceable> ends with '.gpg' it's considered to be key encrypted symmetrically with GPG. You will be prompted for password on boot. GPG support comes with 'crypt-gpg' module which needs to be added explicitly.</para>
             <para><replaceable>keydev</replaceable> is a device on which key file resides. It might be kernel name of devices (should start with &quot;/dev/&quot;), UUID (prefixed with &quot;UUID=&quot;) or label (prefix with &quot;LABEL=&quot;).  You don&apos;t have to specify full UUID. Just its beginning will suffice, even if its ambiguous. All matching devices will be probed. This parameter is recommended, but not required. If not present, all block devices will be probed, which may significantly increase boot time.</para>
             <para>If <replaceable>luksdev</replaceable> is given, the specified key will only be applied for that LUKS device. Possible values are the same as for <replaceable>keydev</replaceable>. Unless you have several LUKS devices, you don&apos;t have to specify this parameter.</para>
             <para>The simplest usage is:</para>
-- 
1.7.5.rc3
