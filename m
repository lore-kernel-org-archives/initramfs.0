From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Patches, Patches, Patches ...
Date: Mon, 18 Jan 2010 10:11:18 +0100
Message-ID: <4B5425B6.6010602@redhat.com>
References: <20091229125447.GA5522@maude.comedia.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091229125447.GA5522-hdG+WfPrfN2JmafXlB/IVQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12/29/2009 01:54 PM, Luca Berra wrote:
> Hello,
> I am trying to integrate dracut into Mandriva, so far it looks good but
> I had to do some modifications in order to have it working.
> - dracut-003-kbd.patch: we have kbd data in /usr/lib, so this patch will
> search for /lib/kbd and /usr/lib/kbd and use the existing one
> - dracut-003-terminfo.patch: same applies to terminfo database
> - dracut-003-kogz.patch: we use compressed kernel modules, this adds
> support for those. I actually don't like very much the
> uncompressing/nm/delete thinghy and I think we should put uncompressed
> modules in the initrd, which is alreeady compressed, but I did not come
> up with a clean patch yet
> - dracut-003-selinux.patch: we dont' use selinux, so it makes no sense to
> force load policy if selinux is not installed at all.
>
> While testing it I also found some issue which I worked around:
> - dracut-003-umount.patch: some modules call umount, but don't install it.
> - dracut-003-rdshell.patch: for some unknown reason the emergency shell
> starts with stderr closed, at first I even tought it was not working at
> all, then I came up with this hack, which seems to work properly. I also
> change the prompt to remind which step are we breaking to.
>
> and added a feature:
> - dracut-003-addmod.patch: this makes dracut load kernel module
> specified in add-drivers even if building an host-only mkinitrd, it is
> useful in cases where we might change some storage drivers and still
> don't want to build an enormous initrd (e.g. ahci/ata_piix)
>
> latest is a wrapper around dracut with the syntax from mkinitrd, could
> help transition to dracut.
> mkinitrd-dracut.sh
>
> patches are attached.
>
> btw i am unable to git clone from sourceforge:
> $ git clone -v git://dracut.git.sourceforge.net/gitroot/dracut
> Initialized empty Git repository in /home/bluca/GIT/dracut/.git/
> fatal: The remote end hung up unexpectedly
>
> Regards,
> L.
>

Pushed most of it.
