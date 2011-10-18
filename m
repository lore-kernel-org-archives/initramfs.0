From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [PATCH 10/10] optional shell job control - add documentation
Date: Tue, 18 Oct 2011 20:33:26 +0200
Message-ID: <1318962806-24000-11-git-send-email-soltys@ziu.info>
References: <1318962806-24000-1-git-send-email-soltys@ziu.info>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318962806-24000-1-git-send-email-soltys-R61QfzASbfY@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Signed-off-by: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
---
 dracut.8.xml        |    9 +++++++++
 dracut.kernel.7.xml |   14 ++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/dracut.8.xml b/dracut.8.xml
index d4689ee..8947780 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -297,6 +297,15 @@ include in the generic initramfs. This parameter can be specified multiple times
         </varlistentry>
         <varlistentry>
           <term>
+            <option>--ctty</option>
+          </term>
+          <listitem>
+            <para>if possible, try to spawn an emergency shell on a terminal
+              with job control</para>
+          </listitem>
+        </varlistentry>
+        <varlistentry>
+          <term>
             <option>-h</option>
           </term>
           <term>
diff --git a/dracut.kernel.7.xml b/dracut.kernel.7.xml
index 0571031..08f1838 100644
--- a/dracut.kernel.7.xml
+++ b/dracut.kernel.7.xml
@@ -109,6 +109,20 @@ This parameter can be specified multiple times.</para>
 	    <para>force loading kernel module &lt;drivername&gt; after all automatic loading modules have been loaded. This parameter can be specified multiple times.</para>
           </listitem>
         </varlistentry>
+        <varlistentry>
+          <term>
+            <envar>rd.ctty=<replaceable>&lt;terminal&gt;</replaceable></envar>
+          </term>
+          <listitem>
+            <para>
+              if the dracut image was generated with --ctty option, try to
+              spawn an emergency shell on the specified terminal; if
+              <envar>rd.ctty</envar> is specified without a value or not
+              provided at all, the default is /dev/tty1. The '/dev' prefix
+              can be omitted.
+            </para>
+          </listitem>
+        </varlistentry>
       </variablelist>
     </refsect2>
     <refsect2 id="dracut-kernel-debug">
-- 
1.7.5.3
