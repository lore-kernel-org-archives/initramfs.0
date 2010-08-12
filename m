From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: =?koi8-r?Q?Re[2]=3A_[PATCH]_Fix_autodetection_of_UNICODE_keymap?=
Date: Thu, 12 Aug 2010 15:48:29 +0400
Message-ID: <E1OjWGr-0004HZ-00.arvidjaar-mail-ru@f169.mail.ru>
References: <4C63D629.4040204@redhat.com>
Reply-To: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C63D629.4040204-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="koi8-r"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org


Thu, 12 Aug 2010 13:08:25 +0200 =D0=C9=D3=D8=CD=CF =CF=D4 Harald Hoyer =
<harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:

> On 08/12/2010 01:05 PM, Harald Hoyer wrote:
> > On 08/11/2010 07:47 PM, Andrey Borzenkov wrote:
> >> +
> >> + # KEYTABLE is a bit special - it defines base keymap name and UN=
ICODE
> >> + # determines whether non-UNICODE or UNICODE version is used
> >> +
> >> + if [[ ${KEYTABLE} ]]; then
> >> + if [[ ${UNICODE} =3D=3D 1 ]]; then
> >> + [[ ${KEYTABLE} =3D~ .*\.uni.* ]] || KEYTABLE=3D${KEYTABLE%.map*}=
=2Euni
> >> + fi
> >> +
> >> + KEYMAP=3D${KEYTABLE}
> >> + fi
> >
> > On Fedora we would end with:
> >
> > KEYTABLE=3D"de-latin1-nodeadkeys"
> >
> > at
> >
> > KEYMAP=3D"de-latin1-nodeadkeys.uni"
> >
> > which does not exist.
>=20

Could you send me your /etc/sysconfig/keyboard (or where these are defi=
ned)?

So, in other words - you have UTF-8 environment but load non-UNICODE ke=
yboard?

> Fedora's console_init calls "loadkeys" with "-u", if its LANG has .UT=
=46-8

It does not help here, unfortunately. Which version of initscripts is i=
t?
