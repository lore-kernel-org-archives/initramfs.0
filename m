From: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [systemd-devel] [RFC] iscsid / systemd / dracut integration
 effort
Date: Tue, 11 Dec 2012 15:26:46 -0800
Message-ID: <20121211232646.GC5307@straylight.hirudinean.org>
References: <1355177316-25803-1-git-send-email-cleech@redhat.com>
 <50C67697.7020208@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50C67697.7020208-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?iso-8859-1?B?IkrzaGFubiBCLiBHdfBtdW5kc3NvbiI=?= <johannbg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, systemd-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agrover-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

On Mon, Dec 10, 2012 at 11:56:07PM +0000, "J=F3hann B. Gu=F0mundsson" w=
rote:
> On 12/10/2012 10:08 PM, Chris Leech wrote:
> >
> >2) Proper ordering of the iscsi.service for non-root filesystems.
> >
> >Any and all feedback and/or help welcome.
> >
>=20
> Looking the unit file for iscsid I do believe I missed this (
> basically the same as multipath unit ) since you know it's early
> boot special, root and all that ;)
>=20
> [Unit]
>=20
> # Before or After lvm2-activation-early.service
> DefaultDependencies=3Dno
> Conflicts=3Dshutdown.target
>=20
> [Install]
> WantedBy=3Dsysinit.target

Thanks, this got me going in the right direction.  These unit files
seems to be working much better for me, with the startup and shutdown
ordering between iscsi, iscsid, and remote-fs mounts sorted out.  I'm
not sure about the tgtd/targetcli stuff, not sure what the original nee=
d
there was.

My non-root test install with /home on iSCSI also has a swap partition
on it, and that's still causing me all sorts of trouble if I don't
comment it out in fstab.  Trying to order all this before swap.target
blew up in my face pretty good.

- Chris

--- iscsi.service ---

[Unit]
Description=3DLogin and scanning of iSCSI devices
Documentation=3Dman:iscsiadm(8) man:iscsid(8)
DefaultDependencies=3Dno
Conflicts=3Dshutdown.target
After=3Dsystemd-remount-fs.service network.target iscsid.service iscsiu=
io.service
Before=3Dremote-fs.target
ConditionPathExists=3D/etc/iscsi/initiatorname.iscsi

[Service]
Type=3Doneshot
ExecStart=3D/usr/libexec/iscsi_mark_root_nodes
ExecStart=3D/sbin/iscsiadm -m node --loginall=3Dautomatic
ExecStop=3D/bin/sync
ExecStop=3D/sbin/iscsiadm -m node --logoutall=3Dautomatic
RemainAfterExit=3Dtrue

[Install]
WantedBy=3Dsysinit.target

--- iscsid.service ---

[Unit]
Description=3DOpen-iSCSI
Documentation=3Dman:iscsid(8) man:iscsiadm(8)
DefaultDependencies=3Dno
Conflicts=3Dshutdown.target
After=3Dnetwork.target tgtd.service targetcli.service
Before=3Dremote-fs-pre.target

[Service]
Type=3Dsimple
ExecStart=3D/usr/sbin/iscsid -f -n
ExecStop=3D/sbin/iscsiadm -k 0 2

--- iscsid.socket ---

[Unit]
Description=3DOpen-iSCSI iscsid Socket
Documentation=3Dman:iscsid(8) man:iscsiadm(8)

[Socket]
ListenStream=3D@ISCSIADM_ABSTRACT_NAMESPACE

[Install]
WantedBy=3Dsockets.target

