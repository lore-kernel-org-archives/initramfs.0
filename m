From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 03/11] add target "check"
Date: Fri, 15 May 2009 14:39:17 +0200
Message-ID: <4A0D6275.9070509@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020900000305040705030705"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------020900000305040705030705
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


add dash syntax checking
---
  Makefile |    5 +++++
  1 files changed, 5 insertions(+), 0 deletions(-)



--------------020900000305040705030705
Content-Type: text/x-patch;
 name="5cb6c761c14147c54b63ccfc83b899f1c2964c65.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="5cb6c761c14147c54b63ccfc83b899f1c2964c65.diff"

diff --git a/Makefile b/Makefile
index 0474ede..ef264eb 100644
--- a/Makefile
+++ b/Makefile
@@ -38,6 +38,11 @@ test: test/root.ext2 all
 test/root.ext2: test/test-init test/make-test-root
 	sudo test/make-test-root
 
+check:
+	@ret=0;for i in modules.d/99base/init modules.d/*/*.sh; do \
+		dash -n "$$i" ; ret=$$(($$ret+$$?)); \
+	done;exit $$ret
+
 testimage: all
 	./dracut -l -f test-$(shell uname -r).img $(shell uname -r)
 	@echo wrote  test-$(shell uname -r).img 


--------------020900000305040705030705--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
