From: WANG Chao <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: how to debug shutdown hooks
Date: Mon, 30 Jun 2014 17:04:53 +0800
Message-ID: <20140630090453.GB15615@dhcp-17-89.nay.redhat.com>
References: <53B0CBAD.5010600@cs2c.com.cn>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53B0CBAD.5010600-TJRtMXcVgQTM1kAEIRd3EQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: =?utf-8?B?5aSP56OK?= <lei.xia-TJRtMXcVgQTM1kAEIRd3EQ@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 06/30/14 at 10:30am, =E5=A4=8F=E7=A3=8A wrote:
> Hello, All
>=20
> I place a 99eject.sh (eject /dev/sr0) to the
> /run/initramfs/usr/lib/dracut/hooks/shutdwon/,
>=20
> and I run reboot command, but the CD/DVD is not be ejected.
>=20
> How I to debug this problem.

Append "rd.debug" to kernel cmdline?
