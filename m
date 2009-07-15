From: Jon Fairbairn <jon.fairbairn-kDbDZe0LBGWFxr2TtlUqVg@public.gmane.org>
Subject: Re: dracut testing for / on usb via pcmcia adapter
Date: Wed, 15 Jul 2009 20:40:41 +0100
Message-ID: <wfprc1n39i.fsf@calligramme.charmers>
References: <wf3a8xon3g.fsf@calligramme.charmers> <1247682192.3597.3.camel@sentry-no.fnordovax.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
writes:

> On Wed, 2009-07-15 at 18:46 +0100, Jon Fairbairn wrote:
>> Hi. I have a laptop with a slightly peculiar setup that mkinitrd
>> fails. See <https://bugzilla.redhat.com/show_bug.cgi?id=3D506356>

>> ./dracut -l --drivers " yenta_socket rsrc_nonstatic usb_storage ata_=
generic pata_acpi" ...
>
> That is a little bit of an odd setup.=20

Granted.

> Are there any initramfs packages that do the Right Thing without any
> special tweaking for your config?

I don't know. Up until now I've not been interested in initramfs in the
abstract, so I've only ever used the mkinitrd that comes with
redhat/fedora on this setup. As I say in the bug report, it worked in
fedora 9, and it only requires a small change of order of the commands
in the initrd's init to make it work on fedora 11 -- it includes the
right modules. Whether it working on fedora 9 was good management or
good luck, I can't say.

I'm not sure I understand the import of the question. Given that dracut
will produce a working initrd if told what modules to include, isn't it
a matter of picking through /sys and such to find what modules are
involved in driving the devices that constitute /dev/root and then
making sure they are loaded in the initrd?

--=20
J=C3=B3n Fairbairn                                 Jon.Fairbairn-8l9EJsCZxI8@public.gmane.org=
=2Eac.uk


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
