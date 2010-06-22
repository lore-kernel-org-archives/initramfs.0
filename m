From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] Generic I18N module - install script
Date: Tue, 22 Jun 2010 11:22:32 +0200
Message-ID: <4C2080D8.6040400@redhat.com>
References: <20100620185919.19b9c83a@etiriah.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100620185919.19b9c83a-YdJE6FOikKfe60hTmSeVGxfX6IwIUJvj@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/20/2010 06:59 PM, Amadeusz =C5=BBo=C5=82nowski wrote:
> Hello everyone,
>
> I'd like to present a draft of install script of new generic i18n
> module.
>
>
> ~ Abstract ~
>
> Different distros have variables holding keyboard settings, fonts and=
 so
> in different files and even under different names.  Sometimes it's
> =E2=80=9CSYSFONT=E2=80=9D in /etc/sysconfig/i18n, sometimes it's =E2=80=
=9Cconsolefont=E2=80=9D in
> /etc/conf.d/consolefont.  I came up with idea to hold mappings in
> configuration file (dracut.conf or dracut.conf.d/=C2=ABdistro=C2=BB.c=
onf). The
> script gathers variables and prepares two =E2=80=9Cunified=E2=80=9D f=
iles inside
> Dracut overlay.
>
> The rest of the script is quite the same as redhat-i18n but some twea=
ks.
> Dracut uses console_init written in C included in initscripts RPM, bu=
t
> I'm gonna rewrite it in bash and then i18n module will be fully gener=
ic.
>
>
> Please post here any doubts, questions, suggestions, insults=E2=80=A6=
 ;-)


>
> # $@ =3D list in format specified below (BNF notation)
> #
> #<list>  ::=3D<element>  |<element>  " "<list>
> #<element>  ::=3D<conf-file-name>  ":"<map-list>
> #<map-list>  ::=3D<mapping>  |<mapping>  ","<map-list>
> #<mapping>  ::=3D<src-var>  "-"<dst-var>  |<src-var>
> #
> # We assume no whitespace are allowed between symbols.
> #<conf-file-name>  is a file holding<src-var>  in your system.
> #<src-var>  is a variable holding value of meaning the same as<dst-va=
r>.
> #<dst-var>  is a variable which will be set up inside initramfs.
> # If<dst-var>  has the same name as<src-var>  we can omit<dst-var>.
> #
> # Hope it's clear. ;-)

Hmm, what about varnames with a "-" ? You might want to use "@".
