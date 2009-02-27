From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Fix instmods recursing indefinitely
Date: Fri, 27 Feb 2009 13:25:38 +0100
Message-ID: <49A7DBC2.8020503@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

the instmod function inside dracut-functions starts to recurses indefinitely
if modprobe --show-depends is used and the output contains module options. 

Example:

#modprobe --show-depends libata
insmod /lib/modules/2.6.27-11-generic/kernel/drivers/acpi/dock.ko 
insmod /lib/modules/2.6.27-11-generic/kernel/drivers/scsi/scsi_mod.ko 
insmod /lib/modules/2.6.27-11-generic/kernel/drivers/ata/libata.ko ignore_hpa=1


This patch fixes this.

--
 dracut-functions |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 852ce36..56b3757 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -177,7 +177,7 @@ instmods() {
 	    =*) instmods $mpargs $(cat "${modcat}.${mod#=}");;
 	    --*) mpargs+=" $mod";;
 	    *) modprobe $mpargs --set-version $kernel --show-depends $mod \
-		2>/dev/null |while read cmd modpath; do
+		2>/dev/null |while read cmd modpath options; do
 		    [[ $cmd = insmod ]] || continue
 		    modname=${modpath##*/}
 		    modname=${modname%.ko}
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
