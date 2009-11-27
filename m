From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 1/6] initqueue: Remove trailing ;
Date: Fri, 27 Nov 2009 11:57:11 +0100
Message-ID: <1259319436-14925-2-git-send-email-philippe.seewer@bfh.ch>
References: <1259319436-14925-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259319436-14925-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

dash -n complains about the trailing ';' and somehow I think this
really isn't needed.
---
 modules.d/99base/initqueue |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/modules.d/99base/initqueue b/modules.d/99base/initqueue
index e5246ee..cc6e7a8 100755
--- a/modules.d/99base/initqueue
+++ b/modules.d/99base/initqueue
@@ -37,5 +37,4 @@ fi
 
 mv -f "/tmp/$$-${job}.sh" "/initqueue${settled}/${job}.sh"
 [ -z "$settled" ] && >> /initqueue/work
-;
 
-- 
1.6.5.3
