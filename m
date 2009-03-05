From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/6] Do not try to bring an already-up inferface back up.
Date: Wed, 04 Mar 2009 18:56:27 -0800 (PST)
Message-ID: <b37ec5d90a5829b8cc14442782f463a53da5736d.1236221526.git.victor.lowther@gmail.com>
References: <2ffdb552305487acbade501856904918639cc92f.1236221526.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=WSVXzzob+CbHYLJXUJMkrpsDEmPmfh7ZUURv7XrvCpA=;
        b=csXWu5nnfwSf01riHKHEOy8eVQvdgMEGSw277Ux0OwYYl6mlQQJrkhNmsgtCIrbOTD
         c3C4C4YFWt54qWGVFb9EzZQZ8oS3sEtA549jn6ZGk7y89DY321ojgIdaKsnhd40mk0eW
         S85MTD/VGrd/XvJLPA/wK/VwOE32cxRzpfIY0=
In-Reply-To: <2ffdb552305487acbade501856904918639cc92f.1236221526.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 ifup |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/ifup b/ifup
index 83f6522..3878c41 100755
--- a/ifup
+++ b/ifup
@@ -1,5 +1,8 @@
 #!/bin/sh
 
+# bail immediatly if the interface is already up
+[ -f "/net.$1.up" ] && exit 0
+
 # loopback is always handled the same way
 [ "$1" = "lo" ] && {
     ip link set lo up
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
