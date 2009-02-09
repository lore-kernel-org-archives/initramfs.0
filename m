From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:00 -0800 (PST)
Message-ID: <2fffaa72efb1871cb26d3845611e52d96f2813f0.1234137267.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=UPRUGSNL5tgRer8NfOMFvb/K1sL1ib4oxLb/8Q3WGj0=;
        b=XnOhQeAF3JqeOJm3usonJDTp4laIgQdRXqGsWgCBciiksVv5i0mEFudpjpOqbOkXYO
         U7mWhCHgriWH7dY3HtoEs5ml5BF43vUTFdaws/DNV+bcgMe7HUOs6CASGIEaySs8Gc8q
         NDAs8YL+CwBODCn/ww+Nk8tHZAIXmJW5HPmGY=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Rewrite the mount loop using bash-specific features.

This makes the loop slightly more compact and easier to read.
---
 init |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/init b/init
index 78f962e..2ebf1b0 100755
--- a/init
+++ b/init
@@ -71,13 +71,10 @@ esac
 
 # should we have a timeout?
 tries=0
-while [ ! -e $root ]; do
+until [[ -e $root ]]; do
   echo -n "."
   sleep 1
-  tries=$(($tries + 1))
-  if [ $tries -gt 30 ]; then
-      emergency_shell
-  fi
+  ((tries++ > 30)) && emergency_shell
 done
 echo -e "\n\nMounting rootfs after $tries seconds"
 ln -s "$root" /dev/root    
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
