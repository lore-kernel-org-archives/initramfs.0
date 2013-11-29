From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 12/13] Fixup script permissions
Date: Fri, 29 Nov 2013 13:13:53 +0100
Message-ID: <1385727234-5001-13-git-send-email-hare@suse.de>
References: <1385727234-5001-1-git-send-email-hare@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385727234-5001-1-git-send-email-hare-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

Scripts with a shebang should be marked as executable.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/03modsign/load-modsign-keys.sh | 0
 modules.d/03modsign/module-setup.sh      | 0
 modules.d/40network/net-lib.sh           | 0
 modules.d/40network/parse-vlan.sh        | 0
 modules.d/50drm/module-setup.sh          | 0
 modules.d/91crypt-loop/crypt-loop-lib.sh | 0
 modules.d/98pollcdrom/pollcdrom.sh       | 0
 7 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 modules.d/03modsign/load-modsign-keys.sh
 mode change 100644 => 100755 modules.d/03modsign/module-setup.sh
 mode change 100644 => 100755 modules.d/40network/net-lib.sh
 mode change 100644 => 100755 modules.d/40network/parse-vlan.sh
 mode change 100644 => 100755 modules.d/50drm/module-setup.sh
 mode change 100644 => 100755 modules.d/91crypt-loop/crypt-loop-lib.sh
 mode change 100644 => 100755 modules.d/98pollcdrom/pollcdrom.sh

diff --git a/modules.d/03modsign/load-modsign-keys.sh b/modules.d/03modsign/load-modsign-keys.sh
old mode 100644
new mode 100755
diff --git a/modules.d/03modsign/module-setup.sh b/modules.d/03modsign/module-setup.sh
old mode 100644
new mode 100755
diff --git a/modules.d/40network/net-lib.sh b/modules.d/40network/net-lib.sh
old mode 100644
new mode 100755
diff --git a/modules.d/40network/parse-vlan.sh b/modules.d/40network/parse-vlan.sh
old mode 100644
new mode 100755
diff --git a/modules.d/50drm/module-setup.sh b/modules.d/50drm/module-setup.sh
old mode 100644
new mode 100755
diff --git a/modules.d/91crypt-loop/crypt-loop-lib.sh b/modules.d/91crypt-loop/crypt-loop-lib.sh
old mode 100644
new mode 100755
diff --git a/modules.d/98pollcdrom/pollcdrom.sh b/modules.d/98pollcdrom/pollcdrom.sh
old mode 100644
new mode 100755
-- 
1.8.1.4
