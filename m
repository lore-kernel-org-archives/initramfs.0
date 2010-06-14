From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] console_init.c in i18n module
Date: Mon, 14 Jun 2010 08:46:01 +0200
Message-ID: <4C15D029.6040906@redhat.com>
References: <20100614083102.16f35a59@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100614083102.16f35a59-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/14/2010 08:31 AM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Hello everyone,
>
> I'm trying to find a way to make i18n distro independent or at least
> more flexible.
>
> Module 10redhat-i18n depends on two programs from RH initscripts
> package: console_init and console_check.  Those tools are called by u=
dev
> and if we deliver just keymaps and few things like loadkey we're fine=
=2E
> But=E2=80=A6 console_* are RH specific stuff (included in initscript =
package).
> I see two easy approaches:
>
>      * Putting its sources into Dracut tree beside switch_root.c.
>        They don't depend on any library, so it should be easy.
>      * Rewrite as a shell script (but it's redundant work if the firs=
t
>        way is OK).
>
> Moreover console_check isn't installed by Dracut at all, but it's in
> default =E2=80=9C10-console.rules=E2=80=9D rule.  This tool just setu=
p speed for serial
> console which we do by kernel params, so I guess we can skip it.  In
> that case modified 10-console.rules should be delivered inside i18n
> module.
>
> What do you think about it?
>
>
> Cheers,
> Amadeusz =C5=BBo=C5=82nowski
>

I would be happy, if we had a shell replacement, or a small rewrite wit=
hout the=20
libglib (huge lib only referenced by console_init).
