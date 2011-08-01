From: Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] add documentation for --force-add
Date: Mon,  1 Aug 2011 10:01:24 +0800
Message-ID: <1312164084-11496-2-git-send-email-amwang@redhat.com>
References: <1312164084-11496-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1312164084-11496-1-git-send-email-amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Add documentation in man page.

Signed-off-by: Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.8.xml |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/dracut.8.xml b/dracut.8.xml
index 4cdfe4b..11ea8c3 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -138,6 +138,15 @@ Modules are located in
         </varlistentry>
         <varlistentry>
           <term>
+            <option>--force-add&nbsp;<replaceable>&lt;list of dracut modules&gt;</replaceable></option>
+          </term>
+          <listitem>
+            <para>force to add a space-separated list of dracut modules to the default set of modules, when -H is specified. This parameter can be specified multiple times.</para>
+          </listitem>
+        </varlistentry>
+
+        <varlistentry>
+          <term>
             <option>-d</option>
           </term>
           <term>
-- 
1.7.4.4
