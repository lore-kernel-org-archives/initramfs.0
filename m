From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] dracut-initramfs-restore: make mount error nonfatal
Date: Tue, 28 Jul 2015 14:55:59 +0300
Message-ID: <E1ZK3hi-0000SN-Lt@puleglot.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=mymail;
	h=Message-Id:To:Subject:Date:From; bh=nN8p9Yl8ikpynX5Y6P5LCsDKA/qq/SU4chSnR9fruZo=;
	b=U3oq8v5giRqj2RHZXAS3qSmqxx9jDnJwhyIGTpNbgbzfPnKA4V+F+bW3oowlbXk/20eeqYwy5ded06yEQoaU+VhSeKe3H2jjhm3nMTgbFJXR5xyoj+41xS3XHhwQcGdYVy7jek5cO382147U7cEKNLfelpcEDfobOc/FowGjhoU=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Script enables errexit option (set -e). So if /boot is not a mount point
or is already mounted, then script dies after unsuccessful mount
command. Fix this by always returning successful result.
---
 dracut-initramfs-restore.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut-initramfs-restore.sh b/dracut-initramfs-restore.sh
index 0e6a1a8..0c41a59 100644
--- a/dracut-initramfs-restore.sh
+++ b/dracut-initramfs-restore.sh
@@ -14,7 +14,7 @@ SKIP="$dracutbasedir/skipcpio"
 
 [[ -f /etc/machine-id ]] && read MACHINE_ID < /etc/machine-id
 
-mount -o ro /boot &>/dev/null
+mount -o ro /boot &>/dev/null || true
 
 if [[ $MACHINE_ID ]] && [[ -d /boot/${MACHINE_ID} || -L /boot/${MACHINE_ID} ]] ; then
     IMG="/boot/${MACHINE_ID}/${KERNEL_VERSION}/initrd"
-- 
2.3.6
