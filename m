From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] Make cryptroot handling act as a real producer/consumer.
Date: Sat, 21 Feb 2009 08:24:39 -0800 (PST)
Message-ID: <defe067eb37529f2a4844eded3e188e04928230a.1235233199.git.victor.lowther@gmail.com>
References: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=E6Qm/MFVbpr5mID87URF071hx3vGbn4tpYCtOOHDnPo=;
        b=vngMOxHnSIoIAFSf0VMRikw6enmn19GPgz6XGL1tZH73Eht45vOa9AKrm5jpLRCNnH
         h87NKgxGG6hzz9owIAmDevwImskB9BeKl2sdAgar2q0H40Il9tpr7Z/k+xOFkwYhY16Q
         7tGiGL63lXfsHSBh+5BkL4M15MLmzb1lLNGaE=
In-Reply-To: <68c572a7f9fd38b23b15f8f022be29026f0d9485.1235233199.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This should handle the case of having more than one encrypted
block device on the system as best we can right now.

---
 hooks/cryptroot.sh    |   11 +++++++----
 rules.d/63-luks.rules |    2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hooks/cryptroot.sh b/hooks/cryptroot.sh
index 0664f24..739f5d3 100755
--- a/hooks/cryptroot.sh
+++ b/hooks/cryptroot.sh
@@ -1,7 +1,10 @@
 #!/bin/sh
-[ -f /cryptroot ] && { 
-    echo "Encrypted root detected."
-    read cryptopts </cryptroot
-    /sbin/cryptsetup luksOpen $cryptopts || emergency_shell
+[ -s /cryptroot ] && { 
+    udevadm control --stop_exec_queue
+    while read cryptopts; do
+	/sbin/cryptsetup luksOpen $cryptopts
+    done </cryptroot
+    >/cryptroot
+    udevadm control --start_exec_queue
     udevadm settle --timeout=30
 }
diff --git a/rules.d/63-luks.rules b/rules.d/63-luks.rules
index 4d6a379..802ea06 100644
--- a/rules.d/63-luks.rules
+++ b/rules.d/63-luks.rules
@@ -8,6 +8,6 @@ SUBSYSTEM!="block", GOTO="luks_end"
 ACTION!="add|change", GOTO="luks_end"
 
 KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
-ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/bin/sh -c 'echo $env{DEVNAME} luks-$env{ID_FS_UUID} >/cryptroot'"
+ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/bin/sh -c 'echo $env{DEVNAME} luks-$env{ID_FS_UUID} >>/cryptroot'"
 
 LABEL="luks_end"
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
