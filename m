From: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [Patch] remove extra semicolons in dracut.8.xml
Date: Tue, 10 Jan 2012 22:49:03 +0800
Message-ID: <1326206943-21256-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=WON6zNhLLepnJbP9cTgsrktGUraauBIm1X18b+kFJGQ=;
        b=F8gqKgvo8KBX+KB+L6FPNIk6eXXzozfju5A+7EgXR3aXot4F3tCsjA+LoJzDoAi0N0
         5CjiC7bvnL9VkvAzaoI/g0/PrZf3O0kQgN/KmKlZMXHM8Wk6FPJM8eSej/YY4V2t1WQU
         SY6bKL8190K/IkqggE8LkcnwsOsP4V2/1mSIQ=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

 
Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut.8.xml |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut.8.xml b/dracut.8.xml
index ba8ab07..221ad2e 100644
--- a/dracut.8.xml
+++ b/dracut.8.xml
@@ -398,7 +398,7 @@ the local host instead of a generic host.
         </varlistentry>
 	<varlistentry>
 	  <term>
-	    <option>--add_fstab;&nbsp;<replaceable>&lt;filename&gt;</replaceable>&nbsp;</option>
+	    <option>--add_fstab&nbsp;<replaceable>&lt;filename&gt;</replaceable>&nbsp;</option>
 	  </term>
 	  <listitem>
 	    <para>Add entries of <replaceable>&lt;filename&gt;</replaceable> to the initramfs /etc/fstab.</para>
@@ -406,7 +406,7 @@ the local host instead of a generic host.
 	  </varlistentry>
 	<varlistentry>
 	  <term>
-	    <option>--mount;&nbsp;&quot;<replaceable>&lt;device&gt;</replaceable> <replaceable>&lt;mountpoint&gt;</replaceable> <replaceable>&lt;filesystem type&gt;</replaceable> <replaceable>&lt;filesystem options&gt;</replaceable>&quot;</option>
+	    <option>--mount&nbsp;&quot;<replaceable>&lt;device&gt;</replaceable> <replaceable>&lt;mountpoint&gt;</replaceable> <replaceable>&lt;filesystem type&gt;</replaceable> <replaceable>&lt;filesystem options&gt;</replaceable>&quot;</option>
 	  </term>
 	  <listitem>
 	    <para>Add entries of <replaceable>&lt;filename&gt;</replaceable> to the initramfs /etc/fstab.</para>
