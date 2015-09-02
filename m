From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Timeout failure with rd.live.image boot option.
Date: Wed, 2 Sep 2015 13:02:08 +0200
Message-ID: <55E6D730.5090805@redhat.com>
References: <CAFO=TmXxiYjsnkB3_=PUij4on8kJu+CcE-HU9pzkVvjvyjwSvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFO=TmXxiYjsnkB3_=PUij4on8kJu+CcE-HU9pzkVvjvyjwSvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: "Ali H. Caliskan" <ali.h.caliskan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 12.07.2015 13:22, Ali H. Caliskan wrote:
> While dracut version 041 boots fine, dracut 042/043 or the latest git
> version doesn't boot at all. Systemd complains about:
>=20
> localhost systemd[1]: dev-mapper-live\x2drw.device: Job
> dev-mapper-live\x2drw.device/start failed with result 'timeout'.
>=20
> Here is the entire rdsosreport.txt:
>=20
> + cat /lib/dracut/dracut-043-42-gee44f62
> dracut-043-42-gee44f62
> + cat /proc/cmdline
> BOOT_IMAGE=3Dboot/vmlinuz rd.live.image rd.live.overlay.size=3D1024
> root=3DLABEL=3DGNURAMALINUX_201507 initrd=3Dboot/initramfs
[=E2=80=A6]
> [    3.135257] localhost systemd[1]: Starting Remote File Systems.
> [   14.086475] localhost kernel: random: nonblocking pool is initiali=
zed
> [   91.008636] localhost systemd[1]: dev-mapper-live\x2drw.device: Jo=
b
> dev-mapper-live\x2drw.device/start timed out.
> [   91.008875] localhost systemd[1]: Timed out waiting for device
> dev-mapper-live\x2drw.device.
[=E2=80=A6]

Would be nice to have a rdsosreport.txt with "rd.debug" added to the ke=
rnel
command line.

