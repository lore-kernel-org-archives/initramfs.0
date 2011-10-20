From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] make livenet module optional
Date: Thu, 20 Oct 2011 13:57:24 -0400
Message-ID: <1319133444-27980-2-git-send-email-wwoods@redhat.com>
References: <1319133444-27980-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1319133444-27980-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The livenet module was intended to be optional, so its check() function
in module-setup.sh should return 255, not 0.

This was causing systems without 'wget' to fail to build initramfs, as
in RHBZ#747632.
---
 modules.d/90livenet/module-setup.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90livenet/module-setup.sh b/modules.d/90livenet/module-setup.sh
index 3ee7521..613a225 100755
--- a/modules.d/90livenet/module-setup.sh
+++ b/modules.d/90livenet/module-setup.sh
@@ -5,7 +5,7 @@ check() {
     # a live, host-only image doesn't really make a lot of sense
     [[ $hostonly ]] && return 1
     command -v wget || return 1
-    return 0
+    return 255
 }
 
 depends() {
-- 
1.7.6.4
