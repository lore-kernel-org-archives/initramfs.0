From: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] update the documentation of '--[no]prefix'
Date: Fri,  7 Oct 2011 15:44:10 +0800
Message-ID: <1317973450-356-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CXiVUGq6/44fm5474IzMC5lHeTOoHf6zvwWJ7LpF+C0=;
        b=FMRFCaSwhkFE6rzKjJUZ464B3ik7hhbHMBG8pNAl2z5JkF6E32xyj7vnhHNxHpLU7x
         PUY//P1Ot0kbuZi9RPUaIPqwoJWhdMO0FISq4XVGunBX39rLUNz6iVztdg5Y/M+ys0Mq
         uZQnCWRua5iIc9uT9zMpKX+ILh3nISvNDU40o=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

In

commit fd786adcf515d9d3ee77eb29fa4c6b60020c7209
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Apr 20 16:47:40 2011 +0200

    dracut: make prefix configurable

Harald changed the meaning of --prefix/--noprefix, but
forgot to update their documentation. This patch
fixes that.

Signed-off-by: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
diff --git a/dracut.8.xml b/dracut.8.xml
index 11ea8c3..709f1a6 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -245,10 +245,10 @@ include in the generic initramfs. This parameter can be specified multiple times
         </varlistentry>
         <varlistentry>
           <term>
-            <option>--prefix</option>
+            <option>--prefix&nbsp;<replaceable>&lt;dir&gt;</replaceable></option>
           </term>
           <listitem>
-            <para>prefix initramfs files with /run/initramfs/</para>
+            <para>prefix initramfs files with the specified directory</para>
           </listitem>
         </varlistentry>
         <varlistentry>
@@ -256,7 +256,7 @@ include in the generic initramfs. This parameter can be specified multiple times
             <option>--noprefix</option>
           </term>
           <listitem>
-            <para>do not prefix initramfs files with /run/initramfs/ (default)</para>
+            <para>do not prefix initramfs files (default)</para>
           </listitem>
         </varlistentry>
         <varlistentry>
