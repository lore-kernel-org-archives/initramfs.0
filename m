From: "Mike Edenfield" <kutulu-UbsDJllyuGkdnm+yROfE0A@public.gmane.org>
Subject: dracut: fstab-sys included with --fstab but not --add-fstab
Date: Tue, 27 Mar 2012 16:14:59 -0400
Message-ID: <004501cd0c56$49a05ee0$dce11ca0$@kutulu.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-us
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

I'm using dracut-016 to build an initramfs and I am using --add-fstab to
include some additional mount points. I notice that the fstab-sys module did
not get included in the image by default, but it does if I use --mount to
include the fstab entries one at a time.

From looking at the module, it is checking for this:

95fstab-sys/module-setup.sh: 
  check() {
      test -f /etc/fstab.sys || [[ -n $use_fstab  ||  -n $fstab_lines ]]
  }

I think I must be confused about something, but should that $use_fstab be
$add_fstab instead?

My understanding is that --use-fstab is used to change where dracut searches
for the device and file system information for my mount points, to determine
which kernel modules to include; it has nothing to do with the fstab file on
the actual initramfs image that gets produced. Whereas --add-fstab actually
generates an /etc/fstab on the image, and thus it would need the script from
fstab-sys to be included so those file systems get mounted.

Is that right, and this is just a mistake in the script, or do I have
something backwards?

--Mike
