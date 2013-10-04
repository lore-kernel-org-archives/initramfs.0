From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] Install dracut-install into libexec dir instead of
 lib dir
Date: Fri, 04 Oct 2013 13:07:00 +0200
Message-ID: <524EA154.7040408@redhat.com>
References: <1380747630-555-1-git-send-email-aidecoe@aidecoe.name> <1380747630-555-2-git-send-email-aidecoe@aidecoe.name>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380747630-555-2-git-send-email-aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/02/2013 11:00 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> dracut-install script is the only thing ABI specific atm.
>=20
> See https://bugs.gentoo.org/show_bug.cgi?id=3D485218 for details on t=
he
> problem.


Well, there is no point to install dracut-install in /usr/lib64 or /usr=
/libexec.
/usr/lib/dracut is _the_ single directory.

Same goes for /usr/lib/systemd and /usr/lib/udev.

We don't have /bin64 /sbin64 /usr/bin64 or /usr/sbin64 either!
