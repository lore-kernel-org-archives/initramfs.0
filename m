From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/4] Add #!/bin/bash for consistency.
Date: Wed, 25 Nov 2009 10:25:50 -0500
Message-ID: <1259162752-22372-3-git-send-email-pjones@redhat.com>
References: <4B0D4A9F.1090606@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B0D4A9F.1090606-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Most install scripts seem to have it there, may as well make this one
like the rest...
---
 modules.d/90multipath/install |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/modules.d/90multipath/install b/modules.d/90multipath/install
index 4890825..499f7c9 100755
--- a/modules.d/90multipath/install
+++ b/modules.d/90multipath/install
@@ -1,3 +1,5 @@
+#!/bin/bash
+
 if [[ $hostonly ]]; then
     inst /etc/multipath.conf
 fi
-- 
1.6.5.2
