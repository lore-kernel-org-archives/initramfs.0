From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 9/9] dracut.conf.5.xml, dracut.8.xml: logging options and -M documented
Date: Fri, 25 Mar 2011 15:56:52 +0100
Message-ID: <1301065012-16356-9-git-send-email-aidecoe@aidecoe.name>
References: <1301065012-16356-1-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-2-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-3-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-4-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-5-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-6-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-7-git-send-email-aidecoe@aidecoe.name>
 <1301065012-16356-8-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301065012-16356-8-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

---
 dracut.8.xml      |   24 +++++++++++++++++++++++-
 dracut.conf.5.xml |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/dracut.8.xml b/dracut.8.xml
index b51004a..f915b7d 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -261,7 +261,18 @@ include in the generic initramfs. This parameter can be specified multiple times
             <option>--verbose</option>
           </term>
           <listitem>
-            <para>verbose output during the build process</para>
+            <para>increase verbosity level (default is info(4))</para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
+            <option>-q</option>
+          </term>
+          <term>
+            <option>--quiet</option>
+          </term>
+          <listitem>
+            <para>decrease verbosity level (default is info(4))</para>
           </listitem>
         </varlistentry>
         <varlistentry>
@@ -413,6 +424,17 @@ TARGET directory in the final initramfs. If SOURCE is a file, it will be install
             <para>List all available dracut modules.</para>
           </listitem>
         </varlistentry>
+        <varlistentry>
+          <term>
+            <option>-M</option>
+          </term>
+          <term>
+            <option>--show-modules</option>
+          </term>
+          <listitem>
+            <para>Print included module's name to standard output during build.</para>
+          </listitem>
+        </varlistentry>
       </variablelist>
     </refsect2>
   </refsect1>
diff --git a/dracut.conf.5.xml b/dracut.conf.5.xml
index df89233..c47e824 100644
--- a/dracut.conf.5.xml
+++ b/dracut.conf.5.xml
@@ -170,6 +170,46 @@ initramfs.</para>
           <para>Do not install kernel drivers and firmware files (default=no)</para>
         </listitem>
       </varlistentry>
+      <varlistentry>
+        <term>
+          <envar>stdloglvl=&quot;<replaceable>{0-6}</replaceable>&quot;</envar>
+        </term>
+        <listitem>
+          <para>Set logging to standard error level.</para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>
+          <envar>sysloglvl=&quot;<replaceable>{0-6}</replaceable>&quot;</envar>
+        </term>
+        <listitem>
+          <para>Set logging to syslog level.</para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>
+          <envar>fileloglvl=&quot;<replaceable>{0-6}</replaceable>&quot;</envar>
+        </term>
+        <listitem>
+          <para>Set logging to file level.</para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>
+          <envar>logfile=&quot;<replaceable>&lt;file&gt;</replaceable>&quot;</envar>
+        </term>
+        <listitem>
+          <para>Path to log file.</para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>
+          <envar>show_modules=&quot;<replaceable>{yes|no}</replaceable>&quot;</envar>
+        </term>
+        <listitem>
+          <para>Print included module's name to standard output during build.</para>
+        </listitem>
+      </varlistentry>
     </variablelist>
   </refsect1>
   <refsect1>
-- 
1.7.4.1
