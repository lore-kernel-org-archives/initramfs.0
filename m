From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] Move actually mounting the root filesystem into
 its own series of hooks.
Date: Mon, 23 Feb 2009 18:07:36 -0600
Message-ID: <1235434056.28090.28.camel@sentry-no.fnordovax.org>
References: <3188506a1f06de54ee7874fc45261f5c2faf9e79.1235283966.git.victor.lowther@gmail.com>
	 <49A301FF.2090303@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=SQD8HqN3ocFgvH1+6ZYpz4eS26yFJxwJGAstHftDrOE=;
        b=VBHUBvrlIkJMiH2pVLvUNbyay2sGnJalYnjNKJGAWEqBhAs1oFsmDjBmD33UakXdyz
         Os2KIB+sdlt9R/RDQLn/8O2DbZAxu64WGihPdsxd9VzsTr7cc3hwkZ3lN24MxFlUfwks
         3j81pY70TV4Ep0cnEyQkxHGmi2zK0zE6jiejg=
In-Reply-To: <49A301FF.2090303-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 2009-02-23 at 15:07 -0500, Warren Togami wrote:
> Hi Victor,
>=20
> I didn't test this patch yet, but I need this kind of structure in or=
der=20
> to implement different kinds of netboot.

I fugured it would be needed, and I certainly don't want to bloat up th=
e
main init script with code that will not be needed on most systems. :)=20

> root=3Ddhcp is a kernel cmdline given by the bootloader (syslinux, gr=
ub,=20
> pxelinux, etc.) which directs the initrd during runtime to bring up e=
th0=20
> and do DHCP.  It then mounts the rootfs depending on options given by=
=20
> the DHCP server.  Fedora 10 mkinitrd implements the following two typ=
es=20
> of mounts with root=3Ddhcp.
>=20
>          option root-path "172.31.100.254:/path/to/target_root";
>          option root-path "nbd:172.31.100.254:2000:squashfs:ro";

Interesting -- I have been working on implementing code to detect and
configure network interfaces according to the netboot.txt kernel
document. The code I have written so far is browseable at
http://git.fnordovax.org/dracut/log/?h=3Dnetwork-configurability
(and it even works some of the time), and I would appreciate input from
someone who actually uses that functionality on a daily basis.
 =20
> An existing RFC specifies syntax for iscsi that could be implemented =
as=20
> well.  (Although iscsi is problematic because some types require=20
> authentication.) =20

Yeah, I was thinking of what sort of structure would be needed to let
someone else write code to handle multipath iscsi over teamed nics
without having to patch the main init script.

> Arbitrary types of root=3Ddhcp rootfs mounts can be=20
> implemented with hooks made possible with your patch.
>=20
> Generation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =E2=88=98 read mode from dracut.conf i.e. MODE=3Dnetwork
> =E2=88=98 if network
> 	=E2=80=A3 install network modules
> 	=E2=80=A3 install tools (mount.nfs, nbd, etc.)
> 	=E2=80=A3 install squashfs.ko
> 	=E2=80=A3 install custom udev rules to handle network

Not a problem -- I have not gotten to the nfs stuff yet, but the above
branch already works well enough let udev bring network interfaces up
according to what is passed on the kernel command line (assuming I did
not break it again, and assuming you are using dhcp or statically
configuring your interfaces -- I have no plans for adding bootp or rarp
support, but patches to do so are happily accepted).

> Boot (contents of udev rule)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> =E2=88=98 if root=3Ddhcp (or later hard coded network)
> 	=E2=80=A3 ifup eth0
> 	=E2=80=A3 dhclient

The above branch already knows how to do this stuff.=20

> 	=E2=80=A3 parse root-path

Probably cannot do this in udev, but easily doable from a mount hook.

> 	=E2=80=A3 if nbd
> 		=E2=80=A2 modprobe nbd
> 		=E2=80=A2 nbd-client with parameters
> 		=E2=80=A2 (mount rootfs)
> 	=E2=80=A3 if nfs
> 		=E2=80=A2 (mount rootfs)


I was planning to handle nfsroot in a mount hook as well, extending it
to handle nbd should not be a problem.


> Warren Togami
> wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> --
> To unsubscribe from this list: send the line "unsubscribe initramfs" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
Victor Lowther
RHCE# 805008539634727
LPIC-2# LPI000140019

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
