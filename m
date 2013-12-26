From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] crypt: Only write udev rules to unlock when the device is added
Date: Thu, 26 Dec 2013 21:26:23 +0000
Message-ID: <1388093183-19045-2-git-send-email-colin@mageia.org>
References: <1388093183-19045-1-git-send-email-colin@mageia.org>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1388093183-19045-1-git-send-email-colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

It seems that when the device is unlocked, it will trigger a change
event which in turn re-writes the settled job which was diligently
removed after it was run.

Due to the previous fix, this isn't crazy important as the triggered
job should exit, but avoiding this in the first place is still
desirable.
---

Note, I'm not sure if this is wise or not. The previous patch alone
fixes the issue, so this is just an efficiency saving. It might be
that this is needed - e.g. if you have any encrypted volume on top
of some other mapped device such as RAID, so please only apply this
patch if you are sure it will not cause regressions!!



 modules.d/90crypt/parse-crypt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/90crypt/parse-crypt.sh b/modules.d/90crypt/parse-crypt.sh
index a6b5252..cfa6ac9 100755
--- a/modules.d/90crypt/parse-crypt.sh
+++ b/modules.d/90crypt/parse-crypt.sh
@@ -10,7 +10,7 @@ if ! getargbool 1 rd.luks -d -n rd_NO_LUKS; then
 else
     {
         echo 'SUBSYSTEM!="block", GOTO="luks_end"'
-        echo 'ACTION!="add|change", GOTO="luks_end"'
+        echo 'ACTION!="add", GOTO="luks_end"'
     } > /etc/udev/rules.d/70-luks.rules.new
 
     LUKS=$(getargs rd.luks.uuid -d rd_LUKS_UUID)
-- 
1.8.4.5
