From: Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>
Subject: Re: merged dracut git
Date: Fri, 6 Mar 2009 16:30:32 +0100
Message-ID: <ac3eb2510903060730x7f16a16fg537c62734f840f34@mail.gmail.com>
References: <49AEBDE6.2080902@redhat.com> <49AFD4B6.5010609@redhat.com>
	 <49AFFE1A.3040606@redhat.com> <49B01C8E.4050600@redhat.com>
	 <ac3eb2510903051124s7140abb7o250b08c2053864d6@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ac3eb2510903051124s7140abb7o250b08c2053864d6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Mar 5, 2009 at 20:24, Kay Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org> wrote:
> On Thu, Mar 5, 2009 at 19:40, Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

>> added lots of cleanups.
>> rpm now build correctly.
>
> With this repo, and:
> =C2=A0dracutmodules=3D"kernel-modules udev-rules base"
> in:
> =C2=A0/etc/dracut.conf
>
> and:
> =C2=A0"sd_mod"
> which was missing, manually added to:
> =C2=A0/usr/lib/dracut/modules.d/90kernel-modules/install
>
> and:
> =C2=A0install ata_piix /sbin/modprobe ahci 2>&1 |:; /sbin/modprobe
> --ignore-install ata_piix
> which prevents the module from being included, removed from:
> =C2=A0/etc/modprobe.conf
>
> I can boot a SUSE box. :)

All solved in Harald's current repo now. I'm writing this from a SUSE
box, with stock distro kernel, and an initramfs created by dracut.

Thanks,
Kay
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
