From: xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [Patch] fix rpm build error after adding ssh-client module
Date: Tue, 10 Jan 2012 22:52:15 +0800
Message-ID: <1326207135-21594-1-git-send-email-xiyou.wangcong@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=meJU/XDfgC4MSYCKUJEEPYJZ8BMkV+DAIuK5Ae6Z+s0=;
        b=FdfuzvVxWGjcEcv5XdIwVXgOmEARDWnGWwZ2BVLOkppFYVe6iuWV7WZIy3U7iseWQ8
         BMLmivgzAIcShtrHBcLgyrmYteJJjaoJgJVbr3Lac9JhokhdWBG8bw1XBsHiagEjwRc5
         euhTpaiDJzJVvFImNsxxA4UR/MePe5yI0MLh4=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

From: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date:   Tue Jan 10 11:42:33 2012 +0800

This patch fixes the following error when building rpm,
    
      error: Installed (but unpackaged) file(s) found:
       /usr/lib/dracut/modules.d/95ssh-client/module-setup.sh
    
Based on my kdump tree.

Signed-off-by: Cong Wang <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 dracut.spec |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/dracut.spec b/dracut.spec
index 1c50f37..697d27c 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -270,6 +270,7 @@ rm -rf $RPM_BUILD_ROOT
 %{dracutlibdir}/modules.d/90livenet
 %{dracutlibdir}/modules.d/95nbd
 %{dracutlibdir}/modules.d/95nfs
+%{dracutlibdir}/modules.d/95ssh-client
 %{dracutlibdir}/modules.d/45ifcfg
 %{dracutlibdir}/modules.d/95znet
 
