From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/6] Do not run dhclient if the interface is already up.
Date: Wed, 04 Mar 2009 18:56:25 -0800 (PST)
Message-ID: <7cfe0bfc036c2f25345c522186eb1de6b8b80665.1236221526.git.victor.lowther@gmail.com>
References: <2ffdb552305487acbade501856904918639cc92f.1236221526.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=DiKE0otKndsg3KLrEiN+czHR6PZTp1PUWoYSinFC/r4=;
        b=uRPh+slzy/rgc6+Jw5rSfhlxSZ8e2PbUJgLb1ttcIBRNfKDrNLyKJdAHqvGVDpL/sN
         8cqOD48/Dv9K+0ZdO2HFhRICI2LWY6OO3jiAeJjY1afWeATiQAEucBz29BpG8/jw17D6
         Bdhf0bfMvyx+Fxy6mH40A7GMAY1K89q8mMa68=
In-Reply-To: <2ffdb552305487acbade501856904918639cc92f.1236221526.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 hooks/run-dhclient.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/hooks/run-dhclient.sh b/hooks/run-dhclient.sh
index fcf890e..afab037 100755
--- a/hooks/run-dhclient.sh
+++ b/hooks/run-dhclient.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 for i in /net.*.dhcp; do
     dev=${i#net.}; dev=${i%.dhcp}
+    [ -f "/net.$dev.up" ] && continue
     dhclient -1 -q $dev &
 done
 wait
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
