From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 14/18] Minor spacing fixups in dracut-finctions
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <e0dca0e43ca1bc781fc26a3c7a2d48e796d4495a.1250455879.git.victor.lowther@gmail.com>
References: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 dracut-functions |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index c57174c..66e0e20 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -27,11 +27,11 @@ strstr() { [[ ! ${1#*$2*} = $1 ]]; }
 # Log initrd creation.
 if ! [[ $dracutlogfile ]]; then
     [[ $dsrc = /usr/share/dracut ]] && \
-       dracutlogfile=/var/log/dracut.log || \
-       dracutlogfile=/tmp/dracut.log
+	dracutlogfile=/var/log/dracut.log || \
+	dracutlogfile=/tmp/dracut.log
     [[ -w $dracutlogfile ]] || dracutlogfile=/tmp/dracut.log
     >"$dracutlogfile"
- fi
+fi
 
 dwarning() {
     echo "W: $@" >&2
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
