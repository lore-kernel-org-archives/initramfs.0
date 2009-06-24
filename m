From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 4/5] Add DAD do dhclient-script
Date: Wed, 24 Jun 2009 20:08:31 +0200
Message-ID: <1245866912-3643-5-git-send-email-philippe.seewer@bfh.ch>
References: <1245866912-3643-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1245866912-3643-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>

The manpage for dhclient-script says:

Before actually configuring the address, dhclient-script should
somehow ARP for it and exit with a nonzero status if it receives a
reply.

By using arping in dracut this is very easy, since arping has a
specific option to do just that.
---
 modules.d/40network/dhclient-script |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 6df630d..3fb8da6 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -64,6 +64,7 @@ case $reason in
 	sleep 1
 	;;
     BOUND)
+	arping -q -D -c 2 -I $netif $new_ip_address || exit 1
 	setup_interface 
 	set | while read line; do
 	    [ "${line#new_}" = "$line" ] && continue
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
