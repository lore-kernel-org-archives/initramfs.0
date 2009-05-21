From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/5] Add comments to make-test-root to explain why it is written the way it is.
Date: Wed, 20 May 2009 19:55:11 -0700 (PDT)
Message-ID: <02bf310509fdac93dcbc88c61915ea9830ab97dc.1242874219.git.victor.lowther@gmail.com>
References: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=NacPHnWr6L5WwOc+JPOO5cVB1F4yOGqbtq0p5I3+9tI=;
        b=KYqlfmdJ5BspOYqrrMr3UpdaLd/yl3oYovRMTdNzUJql9P229nPmppScCASyLYVtr4
         Hb92VVP3y6dt3VW1MHwVr/OTBuMmRENlRdKaKfAmxo8/Wv281JnrFmOhtxoouR38FjOC
         9opV4rAhLz5NU3+GbW+iKzmChCRLqIJYlsRqc=
In-Reply-To: <6c901543151c5a664724b70dda6648e239567377.1242874219.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---
 test/make-test-root |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/test/make-test-root b/test/make-test-root
index 84f2105..e49df50 100755
--- a/test/make-test-root
+++ b/test/make-test-root
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+# This script creates a root filesystem on an encrypted LVM PV
+
 dd if=/dev/zero of=test/root.ext2 bs=1M count=20
 
 initdir=test/mnt
@@ -18,11 +20,16 @@ kernel=$(uname -r)
 targetfs="$initdir"
 unset initdir
 
+# create an initramfs that will create the target root filesystem.
+# We do it this way because creating it directly in the host OS
+# results in cryptsetup not being able to unlock the LVM PV.
+# Probably a bug in cryptsetup, but...
 ./dracut -l -i "$targetfs" /source \
     -m "dash kernel-modules test crypt lvm udev-rules base rootfs-block" \
     -d "ata_piix ext2 sd_mod" \
     -f test/initramfs.makeroot
 
+# Invoke KVM and/or QEMU to actually create the target filesystem.
 test/run-qemu -hda test/root.ext2 -m 512M -nographic -net none \
     -kernel "/boot/vmlinuz-$kernel" \
     -append "root=/dev/dracut/root rw rootfstype=ext2 quiet console=ttyS0,115200n81i" \
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
