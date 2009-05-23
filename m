From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: [RFC PATCH 2/5] dracut: fix fallback to default configuration file
Date: Fri, 22 May 2009 22:16:00 -0400
Message-ID: <c91e73eba2e504711092262e328a50c2c8f0ee98.1243053563.git.dave@thedillows.org>
References: <cover.1243053563.git.dave@thedillows.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1243053563.git.dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 

Need to do the fallback in a list rather than a subshell, or we never
actually set $conffile.

Signed-off-by: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 0170fbb..0cf00c6 100755
--- a/dracut
+++ b/dracut
@@ -57,7 +57,7 @@ while (($# > 0)); do
     shift
 done
 
-[[ -f $conffile ]] || ( [[ -f /etc/dracut.conf ]] && conffile="/etc/dracut.conf" )
+[[ -f $conffile ]] || { [[ -f /etc/dracut.conf ]] && conffile="/etc/dracut.conf" }
 [[ -f $conffile ]] && . "$conffile"
 [[ $dracutmodules_l ]] && dracutmodules=$dracutmodules_l
 [[ $omit_dracutmodules_l ]] && omit_dracutmodules=$omit_dracutmodules_l
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
