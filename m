From: Jon Fairbairn <jon.fairbairn-kDbDZe0LBGWFxr2TtlUqVg@public.gmane.org>
Subject: dracut testing for / on usb via pcmcia adapter
Date: Wed, 15 Jul 2009 18:46:59 +0100
Message-ID: <wf3a8xon3g.fsf@calligramme.charmers>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi. I have a laptop with a slightly peculiar setup that mkinitrd
fails. See <https://bugzilla.redhat.com/show_bug.cgi?id=3D506356>

I've tried dracut from the git repo, and it currently (as of
about half an hour ago) doesn't load the right modules without
help. I can get it to make a usable initrd by specifying modules
on the command line:

=2E/dracut -l --drivers " yenta_socket rsrc_nonstatic usb_storage ata_g=
eneric pata_acpi" ...

so it's promising, but not automatic. I'm happy to test changes as
required.

--=20
J=C3=B3n Fairbairn                                 Jon.Fairbairn-8l9EJsCZxI8@public.gmane.org=
=2Eac.uk


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
