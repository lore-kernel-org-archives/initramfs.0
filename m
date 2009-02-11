From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/9] Dracut cleanups, part 2
Date: Wed, 11 Feb 2009 03:46:42 -0800 (PST)
Message-ID: <5e2a4dab9d23a3b0f059d5bee4b572441d0ff7d6.1234351770.git.victor.lowther@gmail.com>
References: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=JppP6KWYXCd+n3AQ00x/h0C4bBUsAkjVSPstpO/CpC8=;
        b=HYrE1kL+GYntekEon5xP828xuTUXUe3LdFfw8v3K/gfby+eT/EGueBgfgGYoS2rn5L
         dSoBwYTq4p0pHX0s5Y5OcEUZgDwDoVJhRUx21dxGTa4GW6tti3vr4UchNsJOKmkROa3G
         Xm+TThFXjt5+VY6MMGed43mPUukImwUyBEnhg=
In-Reply-To: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Use inst to install hooks.

This will ensure that pathname mangling is handled correctly, and that
whatever interpreter is handling /bin/sh is installed as /bin/sh
---
 dracut |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/dracut b/dracut
index ecf58dc..aec20c0 100755
--- a/dracut
+++ b/dracut
@@ -37,6 +37,7 @@ initfile=$dsrc/init
 switchroot=$dsrc/switch_root
 rulesdir=$dsrc/rules.d
 echoer=$dsrc/echoer
+hookdirs="pre-udev pre-mount pre-pivot"
 
 initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
