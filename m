From: Andrew Udvare <audvare-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Correct /etc/crypttab; root in linear multi-disk encrypted linear LVM
 volume group not detected properly
Date: Tue, 14 Apr 2015 18:05:41 -0700
Message-ID: <CAJfjkGq0kHGYi74qTWo6s7RDjgya9n+7oXRp9EJGKQ+GX+VNfQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=4+bj+Yo6vvImDmWJOevrnhVgAWOuesltgVIFU+/4v9s=;
        b=bNiVHfPiQF5LJDjVatC6/A3NbwPMoazIuPHWbSt2K8ByhiHaoxTVkR30hW1c3GX8nt
         mKHX8PdRBQtohpv1smWc0JVvvH2MmaAPzq2c4/l2+tHFh5EwVKC+P7ClAqIopM1fVrUw
         K6Gx4oXrjbErR91WQbi873lmpxHdLt9h+1HyCLYP+cVHFh+XbFhWOZeiG3sCXMBRFmpv
         Ju33r2OoChpQytYUZjFGKYY2H85C4XkNG1A9VGUZAnXCtQUhTCgQpSE8HsrddvXKSc5r
         tCgq9aeL9WNp6qIi2wNtPixlXEXkDXo3IgtcskxbEAZmGTasZ1P915KfX4bsDdMtwakt
         cY/Q==
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I had some trouble using Dracut version 041 to generate a proper image
that would use an external device that contained my key with
/etc/crypttab, regardless of how crypttab states to authenticate (none
(password), or file path). First I noticed that /etc/crypttab can have
quotes for the first field but the crypt module would not parse that
properly so I had to remove them. It would create a device
/dev/disk/by-uuid/"UUID in quotes". No big deal but this is not
documented.

My disk layout is 2 disks linear with LVM, with a part of the VG being
root. Because the image's /etc/crypttab was not being generated
properly, I could never get past the early stage boot and would always
end in the emergency console. Luckily you can still boot from that.

I carefully watched the debug output from Dracut and saw there was a
comparison to get 'only what is needed' for /etc/crypttab in the
image. The problem is that this does not take into account that a
volume group can comprise of 2 disks, each of which are individually
encrypted, and that LVM cannot initialise the volume group without
both being decrypted at boot time. That would mean in the image.

I commented out lines 76, 77, and 80 in
/usr/lib/dracut/modules.d/90crypt/module-setup.sh:

  66     if [[ $hostonly ]] && [[ -f /etc/crypttab ]]; then
  67         # filter /etc/crypttab for the devices we need
  68         while read _mapper _dev _rest; do
  69             [[ $_mapper = \#* ]] && continue
  70             [[ $_dev ]] || continue
  71
  72             [[ $_dev == UUID=* ]] && \
  73                 _dev="/dev/disk/by-uuid/${_dev#UUID=}"
  74
  75             for _hdev in "${!host_fs_types[@]}"; do
  76                 #[[ ${host_fs_types[$_hdev]} == "crypto_LUKS" ]]
|| continue
  77                 #if [[ $_hdev -ef $_dev ]] || [[
/dev/block/$_hdev -ef $_dev ]]; then
  78                     echo "$_mapper $_dev $_rest"
  79                     break
  80                 #fi
  81             done
  82         done < /etc/crypttab > $initdir/etc/crypttab

This was the only way I could get both disks to be in the image's
/etc/crypttab without major modifications. What is the proper way to
do this? I obviously do not want to be modifying things installed by
my package manager as the changes will be lost on upgrades.

I have reported my findings and partial solution to 'Boot with a
device with the key plugged in + LUKS + root in LVM VG' here:
https://forums.gentoo.org/viewtopic-p-7732674.html#7732674

Also, unless you know systemd really well, what is unclear is that a
proper /etc/crypttab is *required* for the generator as part of
systemd. http://www.freedesktop.org/software/systemd/man/systemd-cryptsetup-generator.html
When you boot and you start to get to 'Failed to issue method call:
Unit systemd-cryptsetup@luks\x2d...service failed to load: No such
file or directory.'-type messages, it is not clear what the exact
cause is. Is it possible dracut-initqueue could report this as a
possible suspect?

This was all very confusing in many ways, especially if something is
systemd-specific (and not OpenRC or another init) then there is not a
lot of documentation. So I hope I save someone a lot of time.

Andrew
