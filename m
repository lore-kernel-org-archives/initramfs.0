From: Philippe Seewer <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH 5/8] Add DAD to dhclient-script
Date: Thu, 17 Sep 2009 17:16:46 +0200
Message-ID: <1253200609-31629-6-git-send-email-philippe.seewer@bfh.ch>
References: <1253200609-31629-1-git-send-email-philippe.seewer@bfh.ch>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1253200609-31629-1-git-send-email-philippe.seewer-omB+W0Dpw2o@public.gmane.org>
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
 modules.d/40network/dhclient-script |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 013c8f1..b03cf1c 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -64,6 +64,10 @@ case $reason in
 	sleep 1
 	;;
     BOUND)
+	if ! arping -q -D -c 2 -I $netif $new_ip_address ; then
+	    warn "Duplicate address detected for $new_ip_address while doing dhcp. retrying"
+	    exit 1
+	fi
 	setup_interface 
 	set | while read line; do
 	    [ "${line#new_}" = "$line" ] && continue
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
