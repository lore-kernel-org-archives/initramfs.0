From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] docs: "/conf/conf.d" should be "/etc/conf.d"
Date: Tue, 15 Mar 2011 17:43:11 -0400
Message-ID: <1300225391-22033-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The code actually looks in /etc/conf.d; make the docs reflect that.
---
 dracut.8.xml        |    4 ++--
 dracut.kernel.7.xml |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/dracut.8.xml b/dracut.8.xml
index 05416d1..ad74da0 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -444,10 +444,10 @@ TARGET directory in the final initramfs. If SOURCE is a file, it will be install
       <variablelist>
         <varlistentry>
           <term>
-            <filename>/conf/conf.d/</filename>
+            <filename>/etc/conf.d/</filename>
           </term>
           <listitem>
-            <para>Any files found in <filename>/conf/conf.d/</filename> will be sourced in the initramfs to 
+            <para>Any files found in <filename>/etc/conf.d/</filename> will be sourced in the initramfs to
 set initial values. Command line options will override these values 
 set in the configuration files.</para>
           </listitem>
diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index da4a776..0eba171 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -1196,10 +1196,10 @@ rd.znet=ctc,0.0.0600,0.0.0601,0.0.0602,protocol=bar</programlisting></para>
     <variablelist>
       <varlistentry>
         <term>
-          <filename>/conf/conf.d/</filename>
+          <filename>/etc/conf.d/</filename>
         </term>
         <listitem>
-          <para>Any files found in <filename>/conf/conf.d/</filename> will be sourced in the initramfs to 
+          <para>Any files found in <filename>/etc/conf.d/</filename> will be sourced in the initramfs to
 set initial values. Command line options will override these values 
 set in the configuration files.</para>
         </listitem>
-- 
1.7.4
