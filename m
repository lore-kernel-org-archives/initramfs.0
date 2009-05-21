From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] Remove generated test initramfs'es when cleaning up
Date: Wed, 20 May 2009 19:55:08 -0700 (PDT)
Message-ID: <1a8fba98cf415d5ad7f68d5e4636bdcd3f0b7af3.1242874219.git.victor.lowther@gmail.com>
References: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=aR1YjTgoZ8NGhR2E0xQpLnQ+UTqyKlKnscF9k5Vqp6E=;
        b=SM8lJxHGx1slSSDiL2oDFJxSvqB/H8wLCfyTIBpVm8xBieKsEOmipHwyA4APYcJTgd
         vePzXFepGY22RaS0whfBEueJdt4shVHuMn7vF9g1Og9xgbaqkjGbshEjgMXY/Y7Ne6bH
         W5EU5ChA7SV9WDcmTnBh3rarlz7TrJURD2nGc=
In-Reply-To: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index a4dfd92..bd57c96 100644
--- a/Makefile
+++ b/Makefile
@@ -22,6 +22,7 @@ clean:
 	rm -f *~
 	rm -f modules.d/99base/switch_root
 	rm -f test-*.img
+	rm -f test/initramfs.*
 
 archive: dracut-$(VERSION)-$(GITVERSION).tar.bz2
 
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
