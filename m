From: Claudio Clemens <asturio-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: cryptsetup + lvm order and crypt name
Date: Thu, 07 Aug 2014 22:47:53 +0200
Message-ID: <53E3E5F9.4040507@gmx.net>
References: <53E15A01.9040604@gmx.net> <871tsuks7j.fsf@freja.aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <871tsuks7j.fsf-txNSArhcdoZACdk+e2mhCEEMvNT87kid@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: 
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am 06.08.2014 09:11, schrieb Amadeusz =C5=BBo=C5=82nowski:
> Hi Claudio!
>=20
> Have you tried setting target vg or lv with dracut kernel params?
> Something like: rd.vg=3Dmy-vg

Hi Amadeusz,

I have tried some options, but I think I configured then in the wrong
file. So I have many boot Options, like rd.auto and rd.lvm.vg. But I
wrote then in the file /etc/dracut.conf.d/20-local.conf

In which file should I write this Options, and how should the line look
like? I tried also in /etc/conf.d/ and /etc/cmdline.d/, but I can't get
away with the feeling, that they are not read.

And after setting the file correctly, what should I run? dracut, to
build the initrd again, or grub-update, to put the options in the boot
parameter?

Sorry for the noob questions, but I read all the docs, and couldn't
figure it out.

Cheers,

Claudio
--=20
+- .''`. ---| Dipl.-Inf. Univ. Claudio Clemens |-------| wheezy |-----+
| : :' :      asturio at gmx (.) net           GNU/Linux User #79942  |
| `. `'       http://asturio.gmxhome.de/begin.html                    |
|   `-        "YE GODS, I HAVE FEET??!"         <- Userfriendly       |
O c=C3=BAmulo da rebeldia =C3=A9 morar sozinho e fugir de casa!
