From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 13/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:36 -0800 (PST)
Message-ID: <605ac4581ad0c08a131346c83be55037e2eb7b77.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=q6SVZ5Rie9yZZv4dqlZ3CF6RB/mExBwAOU17RyjJnrw=;
        b=ihgYHTTwkY8oZFjgU67lNiPdFD6tzcCEVdeiS2ch/J2SlIUR0yq7QEuLp37kKC486R
         dS5Km8QO0Ij7B+mtxDp0DRsP/0447dqFv1QKRHmmhr1arrkP3VAQLt3ObRxlqG3KYq0y
         UQ5l3S0iitfvkun0H2p3sVhyIRqKdbFKAK1ZY=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Missed an instance of $initdir not being quoted.

---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index c333173..9de5bea 100755
--- a/dracut
+++ b/dracut
@@ -57,7 +57,7 @@ done
 # FIXME: would be nice if we didn't have to know which rules to grab....
 # ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
 # of the rules we want so that we just copy those in would be best
-mkdir -p $initdir/lib/udev/rules.d
+mkdir -p "$initdir/lib/udev/rules.d"
 for rule in /lib/udev/rules.d/10-console* /lib/udev/rules.d/40-redhat* /lib/udev/rules.d/50* /lib/udev/rules.d/60-persistent-storage.rules /lib/udev/rules.d/61*edd* /lib/udev/rules.d/64* /lib/udev/rules.d/80* /lib/udev/rules.d/95* $rulesdir/*.rules ; do
   cp "$rule" "$initdir/lib/udev/rules.d"
 done
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
