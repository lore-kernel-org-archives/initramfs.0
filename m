From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 13/13] Remove shebang from shell-completion files
Date: Fri, 29 Nov 2013 13:13:54 +0100
Message-ID: <1385727234-5001-14-git-send-email-hare@suse.de>
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

Shell-completion files are meant to be sourced, not executed.
So they shouldn't have a shebang at the start.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
---
 dracut-bash-completion.sh   | 2 +-
 lsinitrd-bash-completion.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut-bash-completion.sh b/dracut-bash-completion.sh
index d796c35..9f359c6 100644
--- a/dracut-bash-completion.sh
+++ b/dracut-bash-completion.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 #
diff --git a/lsinitrd-bash-completion.sh b/lsinitrd-bash-completion.sh
index 78ab165..3df2965 100644
--- a/lsinitrd-bash-completion.sh
+++ b/lsinitrd-bash-completion.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
 #
-- 
1.8.1.4
