From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into its
 own series of hooks.
Date: Mon, 23 Feb 2009 15:07:27 -0500
Message-ID: <49A301FF.2090303@redhat.com>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Victor,

I didn't test this patch yet, but I need this kind of structure in orde=
r=20
to implement different kinds of netboot.

root=3Ddhcp is a kernel cmdline given by the bootloader (syslinux, grub=
,=20
pxelinux, etc.) which directs the initrd during runtime to bring up eth=
0=20
and do DHCP.  It then mounts the rootfs depending on options given by=20
the DHCP server.  Fedora 10 mkinitrd implements the following two types=
=20
of mounts with root=3Ddhcp.

         option root-path "172.31.100.254:/path/to/target_root";
         option root-path "nbd:172.31.100.254:2000:squashfs:ro";

An existing RFC specifies syntax for iscsi that could be implemented as=
=20
well.  (Although iscsi is problematic because some types require=20
authentication.)  Arbitrary types of root=3Ddhcp rootfs mounts can be=20
implemented with hooks made possible with your patch.

Generation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=E2=88=98 read mode from dracut.conf i.e. MODE=3Dnetwork
=E2=88=98 if network
	=E2=80=A3 install network modules
	=E2=80=A3 install tools (mount.nfs, nbd, etc.)
	=E2=80=A3 install squashfs.ko
	=E2=80=A3 install custom udev rules to handle network

Boot (contents of udev rule)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
=E2=88=98 if root=3Ddhcp (or later hard coded network)
	=E2=80=A3 ifup eth0
	=E2=80=A3 dhclient
	=E2=80=A3 parse root-path
	=E2=80=A3 if nbd
		=E2=80=A2 modprobe nbd
		=E2=80=A2 nbd-client with parameters
		=E2=80=A2 (mount rootfs)
	=E2=80=A3 if nfs
		=E2=80=A2 (mount rootfs)

Warren Togami
wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
