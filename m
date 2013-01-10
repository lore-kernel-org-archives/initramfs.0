From: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
Subject: [patch dracut] fix teamd exec in case config does not include devname
Date: Thu, 10 Jan 2013 14:24:18 +0100
Message-ID: <1357824258-908-1-git-send-email-jiri@resnulli.us>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

In case that configuration file did not include name of team device,
teamd would not start. Fix this by adding "-t" parameter.

Signed-off-by: Jiri Pirko <jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org>
---
 modules.d/40network/ifup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/40network/ifup.sh b/modules.d/40network/ifup.sh
index 216b1e3..1e271da 100755
--- a/modules.d/40network/ifup.sh
+++ b/modules.d/40network/ifup.sh
@@ -187,7 +187,7 @@ if [ -e /tmp/team.info ]; then
             fi
         done
         # Do not add slaves now
-        teamd -d -U -n -f /etc/teamd/$teammaster.conf
+        teamd -d -U -n -f -t $teammaster /etc/teamd/$teammaster.conf
         for slave in $working_slaves; do
             # team requires the slaves to be down before joining team
             ip link set $slave down
-- 
1.8.1
