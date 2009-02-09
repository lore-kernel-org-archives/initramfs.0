From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 31/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:37:02 -0800 (PST)
Message-ID: <0e433e06f16267ebcae00d089ea11b1787aa81e9.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=+chIbBv5zo2tXh3uogJv/Apgz5meQNzqmY6ss71Ac6k=;
        b=VG4mE9WzssWRY3j1GBVXW0NZW4FxY/57lVbmNNrNBVnwLtZWVfcvb5M7kYCBmKZ7T0
         2RrViWEPUTK3hsbqjiVwr6ZQWotTgLZGT850KhWADpQakhRHzjcG/FiijpuP/6VnyMtm
         5luTRuCq+Uzn9UTwyZgLcAeK1Bgs/lDtlRFP8=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We no longer require plymouth.  Remove it from the spec.

---
 dracut.spec |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/dracut.spec b/dracut.spec
index c1a1cf9..24f6513 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -21,7 +21,6 @@ Requires: mktemp
 Requires: mount
 Requires: nash
 Requires: bash
-Requires: plymouth >= 0.6.0-2
 Requires: /usr/bin/eu-readelf
 Obsoletes: mkinitrd < 7.0
 Provides: mkinitrd = 7.0
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
