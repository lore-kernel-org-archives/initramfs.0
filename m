From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dracut.conf.5.xml: tag mismatch fix
Date: Tue, 11 Oct 2011 11:26:54 +0800
Message-ID: <20111011032653.GA29342@darkstar>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

build failed with:
xsltproc -o dracut.conf.5 -nonet http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl dracut.conf.5.xml
dracut.conf.5.xml:169: parser error : Opening and ending tag mismatch: para line 168 and listitem
        </listitem>

Fix it by change to </para> at the end

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.conf.5.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut.conf.5.xml b/dracut.conf.5.xml
index 6909a4a..169e11b 100644
--- a/dracut.conf.5.xml
+++ b/dracut.conf.5.xml
@@ -165,7 +165,7 @@ initramfs.</para>
             /sbin/fsck* xfs_db xfs_check xfs_repair e2fsck jfs_fsck
             reiserfsck btrfsck</replaceable>&quot;
           </para>
-          <para>The installation is opportunistic (non-existing tools are ignored).<para>
+          <para>The installation is opportunistic (non-existing tools are ignored).</para>
         </listitem>
       </varlistentry>
       <varlistentry>
