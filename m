From: Christian Heinz <christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] fix installation of `modules.builtin.bin'
Date: Fri, 26 Nov 2010 03:21:17 +0100
Message-ID: <1290738077-17335-1-git-send-email-christian.ch.heinz@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=gHILrMMJMQ7vOvwkLfENEX1V55UtQBdB7mnTpHZBdgo=;
        b=VyfutYTx+slDAWr5H6bMApxduug4c0LnX1pInB2Gut07l0RTN6++ZImjvXrph71eqe
         6SqQh3FzwVDhyBJd0cQDq40In/cRnxHhGyVBFB0JmEofss8wzvibhTCHTSLpkIj+1Dfo
         BupQXBHRJKn4XVLlR40u0wOlhcNNxgra3AGd0=
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Christian Heinz <christian.ch.heinz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

`modules.builtin.bin' is installed like a regular file, thereby ending
up in the wrong place when `--kmoddir' is in effect. Fix this by
specifying the installation destination.
---
 modules.d/90kernel-modules/install |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90kernel-modules/install b/modules.d/90kernel-modules/install
index 863ffac..b635216 100755
--- a/modules.d/90kernel-modules/install
+++ b/modules.d/90kernel-modules/install
@@ -4,4 +4,4 @@
 [ -f /etc/modprobe.conf ] && dracut_install /etc/modprobe.conf
 dracut_install $(find /etc/modprobe.d/ -type f -name '*.conf')
 inst_hook cmdline 01 "$moddir/parse-kernel.sh"
-inst "$srcmods/modules.builtin.bin"
+inst "$srcmods/modules.builtin.bin" "/lib/modules/$kernel/modules.builtin.bin"
-- 
1.7.3.2
