From: Major Hayden <major-rCS72UCksqc@public.gmane.org>
Subject: Live boots without dm snapshots
Date: Fri, 1 Aug 2014 07:33:52 -0500
Message-ID: <FEAE2E5C-F6FD-41D8-BB66-D3688E0FA271@mhtx.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mhtx.net; s=default;
	t=1406896399; bh=TurfPE6dB4ppuZXV9Qodztgu4+RZUPp64rBnREn97UE=;
	h=From:Subject:Date:To;
	b=e6XsVjU5bn7/pEv3BVnF0qosaZK+ok8tdm3mhWeM5TKy40G5UbefR3C6aQdXPEyln
	 jtTsRD7lA/MomFCFX7aa+kd2Jt1tTuq3dkaYzCRYxtjvk+1tXVgFRXonpu07FpWxEp
	 PA7GVMraIzeYc8ktroy8pOnHEO42FiKHIfMKglDhX/g3MngDFg4VqulK6sRm4Kr6xw
	 60uDI+Z0cf/at87jst0aVk6UTXfKyWd/7M5e3ZpqJASgGOlwOrfhViFA5Np/ZhAIDx
	 wzhJb1/gGDQL8ET/3lALC6gB/FGLmTo8YqRFi94BMtB5D9lTZo2k/Insz3em6ibsAp
	 cVzUs6x0Brzfw==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello there,

I'm working with a large environment where one of our design goals is to live boot systems from images we generate within our company.  We've been stuffing a filesystem image into a squashfs so far (following Fedora documentation) and dracut handles it well.  However, when the device mapper snapshot fills, we're stuck with a server that needs a hard reboot.  I've tried a direct filesystem image boot and that works but I'm still stuck with a snapshot.

Through some awful shell hacking last night, I disabled do_live_from_base_loop and set up the loopback device as writeable:

diff --git a/modules.d/90dmsquash-live/dmsquash-live-root.sh b/modules.d/90dmsquash-live/dmsquash-live-root.sh
index 5705e8d..38d20e0 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-root.sh
@@ -182,5 +182,5 @@ if [ -n "$FSIMG" ] ; then
     BASE_LOOPDEV=$( losetup -f )
-    losetup -r $BASE_LOOPDEV $FSIMG
+    losetup $BASE_LOOPDEV $FSIMG

-    do_live_from_base_loop
+    #do_live_from_base_loop
 fi

I was then able to boot the filesystem image as read/write and that system has been running well overnight.

Obviously, this hack is ugly and needs significant work.  I'm interested to know if the direction I'm going makes sense or if I'm totally off base.  Ideally, I'd like to use a union filesystem or btrfs seed device to handle the read-only volume and COW, but that will take a lot more work.

Thanks in advance for any input you can provide!

--
Major Hayden
