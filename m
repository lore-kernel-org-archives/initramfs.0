From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] Harden check for used modules in hostonly mode
Date: Sun, 09 May 2010 22:23:58 +0400
Message-ID: <20100509182358.3768.89142.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Make sure that we do not accept module name which is substring of
some other module name. This resulted in piix being mistakenly loaded
together with ata_piix. It completely broke DVD access here.

Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 dracut-functions |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index fdcfb7e..ebf09c0 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -502,7 +502,7 @@ instmods() {
 	        [[ -f $initdir/$1 ]] && { shift; continue; }
 		# If we are building a host-specific initramfs and this
 		# module is not already loaded, move on to the next one.
-		[[ $hostonly ]] && ! grep -q "${mod//-/_}" /proc/modules && \
+		[[ $hostonly ]] && ! grep -qe "\<${mod//-/_}\>" /proc/modules && \
 	        ! echo $add_drivers | grep -qe "\<${mod}\>" &&	{
 		    shift; continue; 
 		}
