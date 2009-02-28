From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dracut and ubuntu 8.10
Date: Fri, 27 Feb 2009 21:20:36 -0600
Message-ID: <1235791236.6445.25.camel@sentry-no.fnordovax.org>
References: <49A8602D.7020708@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=KlnW7JPM7/XRUDJpV1VeB7nhiahz8SPnFDsd+jhcwt8=;
        b=kYeBllG1UU+bFkCQ9rJ38vO0IRBHW1S5rVRYytOWNTkw856mVFoaBjE1awDvmH21ri
         FfIQRI8Lr1Og8yuuHBcyP+OKyaob7QDNQt8ZRnU7WXjE0GgmsT7wswwGEHE4PBPDIN4z
         qlkIhP7VwTmBAIMSpOp/NqFSY09QaPuxXk6xI=
In-Reply-To: <49A8602D.7020708-omB+W0Dpw2o@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, 2009-02-27 at 22:50 +0100, Seewer Philippe wrote:
> Hello all
> 
> Today I actually just wanted to give Victor Lowther's network patches a go and see how far they can go. But first I thought why not try and get dracut running on my own system. Well, it didn't go straightforward, hence my series of patches this day. (Sorry Victor, testing network stuff will have to wait until next Friday)
> 
> But at last: success! Dracut now boots my notebook!

Excellent! 

> Here's how:
> 
> 0) Get dracut ;-)
> 
> 1) Apply the patches I sent today
> 
> 2) Depending on whether or not you need cryptsetup and/or lvm chmod -x 90crypt.sh and/or 90lvm.sh inside dracut/modules
> 
> 3) Apply the patch below to get the correct ubuntu udev stuff
> 
> 4) If you're on a x86-64 system (ubuntu amd64 install) make sure /lib64 does point to just 'lib' not '/lib':
> 
> $ sudo bash
> $ cd /
> $ rm /lib64
> $ /lib/ld-linux.so.2 /bin/ln -s lib lib64

Any idea why this is required?  That looks like it could break all sorts
of things come upgrade time, especially if you actually have a mixed
32/64 bit environment.

> 5) create /etc/dracut.conf and add the required drivers for your root-disk. And don't forget to add sd_mod (and sg just out of paranoia). Otherwise there's no disks at all.
> 
> 6) Run dracut, build your image, add it to grub, reboot and hopefully enjoy! (Yes, there's no splash screen etc. But hey! It boots!)

Splash screens are for wussies anyways.  Real Linux Users run without
ever touching a framebuffer, and have the output of the kernel boot
sequence on every machine they have ever used memorized. :)

> Regards,
> Philippe
> 
> ---
>  modules/95udev-rules.sh |   34 ++++++++++++++++++++++++----------
>  1 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/modules/95udev-rules.sh b/modules/95udev-rules.sh
> index 5951e18..f4067dd 100755
> --- a/modules/95udev-rules.sh
> +++ b/modules/95udev-rules.sh
> @@ -1,11 +1,25 @@
>  #!/bin/bash
> -# FIXME: would be nice if we didn't have to know which rules to grab....
> -# ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
> -# of the rules we want so that we just copy those in would be best
> -mkdir -p "$initdir/lib/udev/rules.d"
> -#/lib/udev/console_*
> -dracut_install udevd udevadm /lib/udev/*_id 
> -inst_rules /lib/udev/rules.d/10-console* /lib/udev/rules.d/40-redhat* \
> -    /lib/udev/rules.d/50* /lib/udev/rules.d/60-persistent-storage.rules \
> -    /lib/udev/rules.d/61*edd* /lib/udev/rules.d/64* /lib/udev/rules.d/80* \
> -    /lib/udev/rules.d/95*
> \ No newline at end of file
> +# udev rules for ubuntu 8.10
> +# content from /usr/share/initramfs-tools/hooks/udev
> +mkdir -p "$initdir/etc/udev/rules.d"
> +mkdir -p "$initdir/var/run"
> +
> +dracut_install udevd udevadm pkill
> +dracut_install /etc/udev/udev.conf
> +
> +for rules in 05-options.rules 20-names.rules 40-basic-permissions.rules 60-persistent-storage.rules 61-persistent-storage-edd.rules 80-programs.rules 90-modprobe.rules 95-udev-late.rules; do
> +    dracut_install /etc/udev/rules.d/$rules 
> +done

You can use inst_rules to do the same thing without the for loop.

I should probably patch it to look in ., /lib/udev/rules.d,
and /etc/udev/rules.d if passed a filename without a path, though --
that would make things easier to read and maintain.

> +dracut_install /lib/udev/dvb_device_name 
> +dracut_install /lib/udev/usb_device_name 
> +dracut_install /lib/udev/ata_id 
> +dracut_install /lib/udev/usb_id 
> +dracut_install /lib/udev/vol_id 
> +dracut_install /lib/udev/scsi_id 
> +dracut_install /lib/udev/path_id 
> +dracut_install /lib/udev/edd_id 
> +dracut_install /lib/udev/firmware_helper 
> +dracut_install /lib/udev/ide_media 
> +dracut_install /lib/udev/vio_type 
> +dracut_install /lib/udev/watershed

dracut_install does take multiple arguments. :)

dracut_install /lib/udev/*_device_name /lib/udev/*_id /lib/udev/firmware_helper \
/lib/udev/ide_media /lib/udev/vio_type /lib/udev/watershed

>  
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
