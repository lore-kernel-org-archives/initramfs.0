From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Ignore or blacklist a disk from being brought up on boot
Date: Thu, 29 Aug 2013 11:02:55 +0200
Message-ID: <521F0E3F.7000305@redhat.com>
References: <CAHA1JWJisaRVsf2uARPxCN14Fhgu05H9_TxU1zDbyu_3PSbYWA@mail.gmail.com> <CAHA1JWJdqmyoqjs7Cp=HzH9F11xBDqR8bxobi51nPtrPFPir3w@mail.gmail.com> <521AF44D.5030404@redhat.com> <CAHA1JWJ79ODLUM7pbjNyeMgVEfcsWeVeHt0roZizYW=CsRzd8w@mail.gmail.com> <CAHA1JWJpei_FU-2RRZpGdQV7aBCoC=Eud9BgWcFgh=KM0qAcLA@mail.gmail.com> <521C6DC1.1010702@redhat.com> <CAHA1JWL9ZKxxu+ctXA5zcPSz+VKQAFnEW4TNNs6h+J0OiF5ggA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050204060509060509030704"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHA1JWL9ZKxxu+ctXA5zcPSz+VKQAFnEW4TNNs6h+J0OiF5ggA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: Benjamin Kingston <list-ses8GfRmtAZWzAuRflr9/A@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is a multi-part message in MIME format.
--------------050204060509060509030704
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/29/2013 10:35 AM, Benjamin Kingston wrote:
> I'm playing around with fips at the moment and currently have kernel
> fips off, to my knowledge the fips dracut module does nothing unless
> kernel fips is on. Essentially I'm trying to get dracut to ignore the
> boot partition device since all needed information to boot and unlock
> (/etc/cryptab and the keyfile) are embedded in the initramfs. It
> appears that upon dracut generating the initramfs image, it assumes
> that the volume that boot is on is required to boot the system.
> 
> I know the system unlocks the drive because if I allow systemd to
> timeout while waiting for the volume UUID to appear, I can see the
> LUKS volume in /dev/mapper in the dracut shell. Essentially the only
> thing preventing the system from booting is the fact that there is a
> systemd target that is requiring the boot partition to be made active
> (not mounted, as far as I can tell by interrupting dracut pre-pivot
> after unlocking the flash volume the 2nd time).
> 
> I also had it working smoothly in fedora 17 at one point, where it
> would unlock the luks disk according to the embedded crypttab with the
> embedded keyfile and boot the system with out having to unlock the
> flash drive just so systemd can see it. I'm not sure what could have
> changed since fedora 18 since my experience is in systems
> administration rather than software development, so I really
> appreciate you sharing some of your time.
> 


Attached patch for /usr/bin/dracut should help to boot without the /boot device.

The fips module on the other hand _requires_ having /boot and checking vmlinuz.

--------------050204060509060509030704
Content-Type: text/x-patch;
 name="dracut-noboot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dracut-noboot.patch"

diff --git a/dracut.sh b/dracut.sh
index 7481ac0..8ee40a3 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -838,7 +838,7 @@ if [[ $hostonly ]]; then
         "/usr/sbin" \
         "/usr/lib" \
         "/usr/lib64" \
-        "/boot";
+        ;
     do
         mountpoint "$mp" >/dev/null 2>&1 || continue
         push host_devs $(readlink -f "/dev/block/$(find_block_device "$mp")")

--------------050204060509060509030704--
